import { Component, computed, inject, OnDestroy, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { GastosService } from '../../core/services/gastos.service';
import { GastoFormComponent } from './gasto-form.component';
import { Gasto, GastoInput } from './gasto.model';

@Component({
  selector: 'app-gasto-list',
  standalone: true,
  imports: [CommonModule, FormsModule, GastoFormComponent],
  template: `
    <div class="p-6 max-w-7xl mx-auto">
      <header class="flex flex-col md:flex-row md:items-center md:justify-between gap-3 mb-6">
        <div>
          <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Gastos</h2>
          <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
            Egresos operativos · {{ gastosFiltrados().length }} de {{ gastos().length }} visibles
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
          + Registrar Nuevo Gasto
        </button>
      </header>

      @if (error()) {
        <div class="mb-4 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

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

      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm overflow-hidden">
        @if (loading() && gastos().length === 0) {
          <div class="p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            Cargando gastos...
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs">
                <tr>
                  <th class="px-4 py-3 text-left font-medium">Fecha</th>
                  <th class="px-4 py-3 text-left font-medium">Categoría</th>
                  <th class="px-4 py-3 text-right font-medium">Monto</th>
                  <th class="px-4 py-3 text-left font-medium">Descripción</th>
                  <th class="px-4 py-3 text-right font-medium">Acciones</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (g of gastosFiltrados(); track g.id) {
                  <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/30 transition">
                    <td class="px-4 py-3 text-gray-700 dark:text-gray-300 whitespace-nowrap">{{ g.fecha | date:'dd/MM/yyyy' }}</td>
                    <td class="px-4 py-3">
                      <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-brand-50 dark:bg-brand-900/20 text-brand-700 dark:text-brand-300">
                        {{ nombreCategoria(g.categoria_gasto_id) }}
                      </span>
                    </td>
                    <td class="px-4 py-3 text-right font-semibold text-gray-900 dark:text-white tabular-nums">S/ {{ g.monto.toFixed(2) }}</td>
                    <td class="px-4 py-3 text-gray-600 dark:text-gray-300">{{ g.descripcion || '—' }}</td>
                    <td class="px-4 py-3 text-right">
                      <button (click)="editar(g)"
                        class="px-2.5 py-1 text-xs font-medium bg-amber-50 dark:bg-amber-900/20 text-amber-700 dark:text-amber-300 hover:bg-amber-100 dark:hover:bg-amber-900/40 rounded mr-1.5">
                        Editar
                      </button>
                      <button (click)="anular(g)"
                        class="px-2.5 py-1 text-xs font-medium bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-300 hover:bg-red-100 dark:hover:bg-red-900/40 rounded">
                        Anular
                      </button>
                    </td>
                  </tr>
                } @empty {
                  <tr>
                    <td colspan="5" class="px-4 py-12 text-center text-gray-500 dark:text-gray-400">
                      No hay gastos que coincidan con los filtros.
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        }
      </div>

      @if (showForm()) {
        <app-gasto-form
          [gasto]="gastoEnEdicion()"
          [categorias]="categorias()"
          (save)="onSave($event)"
          (cancel)="cerrarForm()" />
      }
    </div>
  `,
})
export class GastoListComponent implements OnInit, OnDestroy {
  private readonly svc = inject(GastosService);

  readonly gastos = this.svc.gastos;
  readonly categorias = this.svc.categorias;
  readonly loading = this.svc.loading;
  readonly error = this.svc.error;

  readonly fInicio = signal<string>('');
  readonly fFin = signal<string>('');
  readonly categoriaFiltro = signal<string>('');

  readonly showForm = signal(false);
  readonly gastoEnEdicion = signal<Gasto | null>(null);
  readonly realtimeActivo = signal(false);

  readonly gastosFiltrados = computed(() => {
    const inicio = this.fInicio();
    const fin = this.fFin();
    const cat = this.categoriaFiltro();
    const start = inicio ? new Date(inicio + 'T00:00:00') : null;
    const end = fin ? new Date(fin + 'T23:59:59') : null;
    return this.gastos().filter(g => {
      const fecha = new Date(g.fecha);
      const inRange = (!start || fecha >= start) && (!end || fecha <= end);
      const inCat = !cat || g.categoria_gasto_id === Number(cat);
      return inRange && inCat;
    });
  });

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
      // El error ya fue capturado en el signal `error` del servicio.
    }
  }

  async anular(g: Gasto): Promise<void> {
    const motivo = window.prompt(
      `Anular el gasto de S/ ${g.monto.toFixed(2)} del ${g.fecha}.\n` +
      `Motivo de anulación (obligatorio):`
    );
    if (!motivo || !motivo.trim()) return;
    try {
      await this.svc.anular(g.id, motivo.trim());
    } catch {
      // Error ya reflejado en el signal del servicio.
    }
  }
}
