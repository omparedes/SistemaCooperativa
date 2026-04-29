import { Component, computed, inject, OnDestroy, OnInit, signal } from '@angular/core';
import { DatePipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { GastosService } from '../../core/services/gastos.service';
import { GastoFormComponent } from './gasto-form.component';
import { Gasto, GastoInput } from './gasto.model';

@Component({
  selector: 'app-gasto-list',
  standalone: true,
  imports: [FormsModule, DatePipe, GastoFormComponent],
  template: `
    <div class="p-6 max-w-7xl mx-auto">

      <!-- Cabecera -->
      <header class="flex flex-col md:flex-row md:items-center md:justify-between gap-3 mb-6">
        <div>
          <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Egresos</h2>
          <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
            {{ gastosFiltrados().length }} de {{ gastos().length }} registros visibles
            @if (realtimeActivo()) {
              <span class="ml-2 inline-flex items-center gap-1 text-emerald-600 dark:text-emerald-400">
                <span class="h-1.5 w-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                en vivo
              </span>
            }
          </p>
        </div>
        <button (click)="nuevo()"
          class="inline-flex items-center gap-2 px-4 py-2 bg-brand-600 hover:bg-brand-700 text-white rounded-lg shadow-sm font-medium transition">
          + Registrar Egreso
        </button>
      </header>

      <!-- Error -->
      @if (error()) {
        <div class="mb-4 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- Filtros -->
      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-4 mb-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Fecha inicio</label>
            <input type="date" [ngModel]="fInicio()" (ngModelChange)="fInicio.set($event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Fecha fin</label>
            <input type="date" [ngModel]="fFin()" (ngModelChange)="fFin.set($event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Categoría</label>
            <select [ngModel]="categoriaFiltro()" (ngModelChange)="categoriaFiltro.set($event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
              <option value="">Todas</option>
              @for (c of categorias(); track c.id) {
                <option [value]="c.id">{{ c.nombre }}</option>
              }
            </select>
          </div>
        </div>
      </div>

      <!-- Tabla -->
      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm overflow-hidden">
        @if (loading() && gastos().length === 0) {
          <div class="p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            Cargando egresos...
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs tracking-wider">
                <tr>
                  <th class="px-4 py-3 text-left font-semibold">Responsable</th>
                  <th class="px-4 py-3 text-left font-semibold">Comprobante</th>
                  <th class="px-4 py-3 text-left font-semibold">Detalle</th>
                  <th class="px-4 py-3 text-right font-semibold">Total</th>
                  <th class="px-4 py-3 text-right font-semibold">Acciones</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (g of gastosFiltrados(); track g.id) {
                  <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/30 transition">

                    <!-- RESPONSABLE -->
                    <td class="px-4 py-3 font-medium text-gray-900 dark:text-white whitespace-nowrap">
                      {{ g.responsable || '—' }}
                    </td>

                    <!-- COMPROBANTE -->
                    <td class="px-4 py-3 font-mono text-xs text-gray-500 dark:text-gray-400 whitespace-nowrap">
                      {{ g.comprobante_ref || '—' }}
                    </td>

                    <!-- DETALLE: descripción + categoría + fecha -->
                    <td class="px-4 py-3">
                      <p class="text-gray-800 dark:text-gray-200">{{ g.descripcion || '—' }}</p>
                      <div class="flex items-center gap-2 mt-1">
                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-brand-50 dark:bg-brand-900/20 text-brand-700 dark:text-brand-300">
                          {{ nombreCategoria(g.categoria_gasto_id) }}
                        </span>
                        <span class="text-xs text-gray-400 dark:text-gray-500">{{ g.fecha | date:'dd/MM/yyyy' }}</span>
                      </div>
                    </td>

                    <!-- TOTAL -->
                    <td class="px-4 py-3 text-right font-semibold text-gray-900 dark:text-white tabular-nums whitespace-nowrap">
                      S/ {{ g.monto.toFixed(2) }}
                    </td>

                    <!-- ACCIONES -->
                    <td class="px-4 py-3 text-right whitespace-nowrap">
                      <button (click)="editar(g)"
                        class="px-2.5 py-1 text-xs font-medium bg-amber-50 dark:bg-amber-900/20 text-amber-700 dark:text-amber-300 hover:bg-amber-100 dark:hover:bg-amber-900/40 rounded mr-1.5 transition">
                        Editar
                      </button>
                      <button (click)="iniciarAnular(g)"
                        class="px-2.5 py-1 text-xs font-medium bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-300 hover:bg-red-100 dark:hover:bg-red-900/40 rounded transition">
                        Anular
                      </button>
                    </td>
                  </tr>
                } @empty {
                  <tr>
                    <td colspan="5" class="px-4 py-12 text-center text-gray-500 dark:text-gray-400">
                      No hay egresos que coincidan con los filtros.
                    </td>
                  </tr>
                }
              </tbody>

              <!-- FOOTER: Total de Egresos -->
              @if (gastosFiltrados().length > 0) {
                <tfoot>
                  <tr class="bg-gray-100 dark:bg-gray-900/80 border-t-2 border-gray-300 dark:border-gray-600">
                    <td colspan="3" class="px-4 py-3 text-right font-bold text-gray-700 dark:text-gray-200 uppercase tracking-wider text-sm">
                      Total de Egresos
                    </td>
                    <td class="px-4 py-3 text-right font-bold text-gray-900 dark:text-white tabular-nums text-base whitespace-nowrap">
                      S/ {{ totalEgresos().toFixed(2) }}
                    </td>
                    <td></td>
                  </tr>
                </tfoot>
              }

            </table>
          </div>
        }
      </div>

    </div>

    <!-- Modal de formulario nuevo/editar -->
    @if (showForm()) {
      <app-gasto-form
        [gasto]="gastoEnEdicion()"
        [categorias]="categorias()"
        (save)="onSave($event)"
        (cancel)="cerrarForm()" />
    }

    <!-- Modal de anulación -->
    @if (showAnularModal()) {
      <div class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
        <div class="bg-white dark:bg-gray-800 rounded-xl shadow-2xl w-full max-w-md p-6 border border-gray-200 dark:border-gray-700">
          <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-1">Anular Egreso</h3>
          @if (gastoParaAnular(); as g) {
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-4">
              S/ {{ g.monto.toFixed(2) }} · {{ g.fecha | date:'dd/MM/yyyy' }}
              @if (g.responsable) { <span>· {{ g.responsable }}</span> }
            </p>
          }
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Motivo de anulación <span class="text-red-500">*</span>
            </label>
            <textarea rows="3"
              [value]="motivoAnulacion()"
              (input)="motivoAnulacion.set($any($event.target).value)"
              placeholder="Describe el motivo..."
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500"></textarea>
            @if (!motivoAnulacion().trim()) {
              <p class="text-xs text-red-500 mt-1">El motivo es obligatorio.</p>
            }
          </div>
          <div class="mt-4 flex justify-end gap-2">
            <button (click)="cancelarAnulacion()"
              class="px-4 py-2 bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-800 dark:text-gray-200 rounded-lg text-sm transition">
              Cancelar
            </button>
            <button (click)="confirmarAnulacion()"
              [disabled]="!motivoAnulacion().trim()"
              class="px-4 py-2 bg-red-600 hover:bg-red-700 disabled:opacity-50 disabled:cursor-not-allowed text-white rounded-lg text-sm font-medium transition">
              Confirmar Anulación
            </button>
          </div>
        </div>
      </div>
    }
  `,
})
export class GastoListComponent implements OnInit, OnDestroy {
  private readonly svc = inject(GastosService);

  readonly gastos       = this.svc.gastos;
  readonly categorias   = this.svc.categorias;
  readonly loading      = this.svc.loading;
  readonly error        = this.svc.error;

  readonly fInicio         = signal<string>('');
  readonly fFin            = signal<string>('');
  readonly categoriaFiltro = signal<string>('');
  readonly showForm        = signal(false);
  readonly gastoEnEdicion  = signal<Gasto | null>(null);
  readonly realtimeActivo  = signal(false);

  // Anulación
  readonly showAnularModal  = signal(false);
  readonly gastoParaAnular  = signal<Gasto | null>(null);
  readonly motivoAnulacion  = signal('');

  readonly gastosFiltrados = computed(() => {
    const inicio = this.fInicio();
    const fin    = this.fFin();
    const cat    = this.categoriaFiltro();
    const start  = inicio ? new Date(inicio + 'T00:00:00') : null;
    const end    = fin    ? new Date(fin   + 'T23:59:59') : null;
    return this.gastos().filter(g => {
      const fecha   = new Date(g.fecha);
      const inRange = (!start || fecha >= start) && (!end || fecha <= end);
      const inCat   = !cat || g.categoria_gasto_id === Number(cat);
      return inRange && inCat;
    });
  });

  readonly totalEgresos = computed(() =>
    this.gastosFiltrados().reduce((s, g) => s + g.monto, 0)
  );

  ngOnInit(): void {
    void this.svc.cargarTodo();
    this.svc.conectarRealtime();
    this.realtimeActivo.set(true);
  }

  ngOnDestroy(): void {
    this.svc.desconectarRealtime();
    this.realtimeActivo.set(false);
  }

  nombreCategoria(id: number): string {
    return this.svc.nombreCategoria(id);
  }

  nuevo(): void {
    this.gastoEnEdicion.set(null);
    this.showForm.set(true);
  }

  editar(g: Gasto): void {
    this.gastoEnEdicion.set(g);
    this.showForm.set(true);
  }

  cerrarForm(): void {
    this.showForm.set(false);
    this.gastoEnEdicion.set(null);
  }

  async onSave(ev: { id: number | null; input: GastoInput }): Promise<void> {
    try {
      if (ev.id) {
        await this.svc.actualizar(ev.id, ev.input);
      } else {
        await this.svc.crear(ev.input);
      }
      this.cerrarForm();
    } catch {
      // Error ya capturado en el signal `error` del servicio.
    }
  }

  iniciarAnular(g: Gasto): void {
    this.gastoParaAnular.set(g);
    this.motivoAnulacion.set('');
    this.showAnularModal.set(true);
  }

  cancelarAnulacion(): void {
    this.showAnularModal.set(false);
    this.gastoParaAnular.set(null);
    this.motivoAnulacion.set('');
  }

  async confirmarAnulacion(): Promise<void> {
    const motivo = this.motivoAnulacion().trim();
    const g      = this.gastoParaAnular();
    if (!motivo || !g) return;
    try {
      await this.svc.anular(g.id, motivo);
      this.cancelarAnulacion();
    } catch {
      // Error reflejado en el signal del servicio.
    }
  }
}
