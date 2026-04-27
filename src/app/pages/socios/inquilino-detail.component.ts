import { Component, computed, effect, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { toSignal } from '@angular/core/rxjs-interop';
import { InquilinosService } from '../../core/services/inquilinos.service';
import { InquilinoDetalle } from './inquilino.model';
import { DNI_INSTITUCIONAL } from './socio.model';

type Tab = 'arriendos' | 'pagos';

@Component({
  selector: 'app-inquilino-detail',
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
          Cargando detalle del inquilino...
        </div>
      } @else if (error()) {
        <div class="p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
          <strong>Error:</strong> {{ error() }}
        </div>
      } @else if (d) {
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <!-- ============ TARJETA IZQUIERDA: PERFIL ============ -->
          <aside class="lg:col-span-1 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-6">
            <div class="flex flex-col items-center text-center mb-6">
              <div class="w-20 h-20 rounded-full bg-amber-100 dark:bg-amber-900/30 flex items-center justify-center text-2xl font-semibold text-amber-700 dark:text-amber-300 mb-3">
                {{ iniciales() }}
              </div>
              <h2 class="text-xl font-semibold text-gray-900 dark:text-white">
                {{ d.apellidos }}
              </h2>
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
                  <div class="text-xs text-gray-500 dark:text-gray-400">
                    Desde {{ av.fecha_inicio | date:'dd/MM/yyyy' }}
                  </div>
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

            <button (click)="registrarPago()"
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

          <!-- ============ TARJETA DERECHA: TABS ============ -->
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
                  Historial de Pagos y Deudas
                </button>
              </nav>
            </div>

            <div class="p-4">
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
                            <td class="px-3 py-2.5 text-gray-700 dark:text-gray-300 whitespace-nowrap">
                              {{ a.fecha_inicio | date:'dd/MM/yyyy' }}
                            </td>
                            <td class="px-3 py-2.5 text-gray-700 dark:text-gray-300 whitespace-nowrap">
                              {{ a.fecha_fin ? (a.fecha_fin | date:'dd/MM/yyyy') : '—' }}
                            </td>
                            <td class="px-3 py-2.5 text-gray-600 dark:text-gray-400 text-xs">
                              {{ a.motivo_termino || '—' }}
                            </td>
                            <td class="px-3 py-2.5 text-center">
                              @if (a.vigente) {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300">
                                  Vigente
                                </span>
                              } @else {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
                                  Cerrado
                                </span>
                              }
                            </td>
                          </tr>
                        }
                      </tbody>
                    </table>
                  </div>
                }
              } @else {
                <div class="py-16 flex flex-col items-center text-center text-gray-500 dark:text-gray-400">
                  <div class="text-4xl mb-3 opacity-40">📋</div>
                  <p class="font-medium text-gray-700 dark:text-gray-300">Historial de pagos</p>
                  <p class="text-sm mt-1">Disponible en el siguiente módulo (Pagos).</p>
                </div>
              }
            </div>
          </section>
        </div>
      } @else {
        <p class="text-gray-500 dark:text-gray-400">Selecciona un inquilino.</p>
      }
    </div>
  `,
})
export class InquilinoDetailComponent {
  private readonly route = inject(ActivatedRoute);
  private readonly svc = inject(InquilinosService);

  readonly DNI_COOP = DNI_INSTITUCIONAL;

  private readonly idParam = toSignal(this.route.paramMap, { initialValue: null });
  readonly inquilinoId = computed<number | null>(() => {
    const p = this.idParam();
    if (!p) return null;
    const raw = p.get('id');
    const n = raw ? Number(raw) : NaN;
    return Number.isFinite(n) ? n : null;
  });

  readonly detalle = signal<InquilinoDetalle | null>(null);
  readonly loading = signal(false);
  readonly error = signal<string | null>(null);
  readonly tab = signal<Tab>('arriendos');

  readonly iniciales = computed(() => {
    const d = this.detalle();
    if (!d) return '?';
    const nombre = `${d.apellidos} ${d.nombres}`.trim();
    return nombre
      .split(/\s+/)
      .filter(p => p.length > 0)
      .slice(0, 2)
      .map(p => p[0].toUpperCase())
      .join('') || '?';
  });

  constructor() {
    effect(() => {
      const id = this.inquilinoId();
      if (id !== null) void this.cargar(id);
    });
  }

  private async cargar(id: number): Promise<void> {
    this.loading.set(true);
    this.detalle.set(null);
    this.error.set(null);
    this.tab.set('arriendos');
    try {
      const d = await this.svc.cargarDetalle(id);
      this.detalle.set(d);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el detalle');
    } finally {
      this.loading.set(false);
    }
  }

  registrarPago(): void {
    const d = this.detalle();
    if (!d) return;
    console.log(`Navegar a pagos del inquilino ${d.id} (${d.apellidos} - puesto ${d.arriendo_vigente?.puesto.codigo})`);
  }
}
