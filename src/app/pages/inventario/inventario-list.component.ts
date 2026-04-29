import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';
import {
  InventarioProducto,
  InventarioService,
  MovimientoInput,
  ProductoInput,
} from '../../core/services/inventario.service';
import { MovimientoFormComponent } from './movimiento-form.component';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
function fmtFecha(yyyymmdd: string): string {
  const [y, m, d] = yyyymmdd.split('-').map(Number);
  return `${String(d).padStart(2, '0')}/${String(m).padStart(2, '0')}/${y}`;
}

function fmtCantidad(n: number): string {
  return Number.isInteger(n) ? String(n) : n.toFixed(3).replace(/\.?0+$/, '');
}

const productoInputVacio = (): ProductoInput => ({
  codigo:        '',
  nombre:        '',
  categoria:     null,
  unidad_medida: 'Unidad',
  stock_actual:  0,
  stock_minimo:  0,
});

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-inventario-list',
  standalone: true,
  imports: [NgClass, FormsModule, MovimientoFormComponent],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6">

      <!-- ── Encabezado ─────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Almacén Interno</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            {{ productosActivos().length }} producto{{ productosActivos().length !== 1 ? 's' : '' }} activo{{ productosActivos().length !== 1 ? 's' : '' }}
          </p>
        </div>
        @if (auth.esAdmin()) {
          <button (click)="abrirNuevoProducto()"
            class="inline-flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-brand-700 transition">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
            </svg>
            Agregar Producto
          </button>
        }
      </div>

      <!-- ── Error ──────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Alertas de Stock Bajo ──────────────────────────────────────── -->
      @if (alertas().length > 0) {
        <div class="mb-6 rounded-2xl border border-orange-200 bg-orange-50 p-5 dark:border-orange-800 dark:bg-orange-900/10">
          <div class="flex items-start gap-3">
            <div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-xl bg-orange-100 dark:bg-orange-900/40">
              <svg class="h-5 w-5 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
              </svg>
            </div>
            <div class="flex-1">
              <p class="text-sm font-semibold text-orange-800 dark:text-orange-300">
                {{ alertas().length }} producto{{ alertas().length !== 1 ? 's' : '' }} con Stock Bajo
              </p>
              <p class="mt-0.5 text-xs text-orange-600 dark:text-orange-400 mb-3">
                Requieren reposición urgente (stock actual ≤ stock mínimo)
              </p>
              <div class="grid grid-cols-1 gap-2 sm:grid-cols-2 lg:grid-cols-3">
                @for (p of alertas(); track p.id) {
                  <div class="flex items-center justify-between rounded-xl border border-orange-200 bg-white dark:border-orange-800 dark:bg-gray-800/60 px-3 py-2">
                    <div class="min-w-0">
                      <p class="text-xs font-semibold text-gray-800 dark:text-white truncate">{{ p.nombre }}</p>
                      <p class="text-xs font-mono text-gray-400 dark:text-gray-500">{{ p.codigo }}</p>
                    </div>
                    <div class="ml-3 text-right shrink-0">
                      <p class="text-sm font-bold text-red-600 dark:text-red-400">{{ fmtCantidad(p.stock_actual) }}</p>
                      <p class="text-xs text-orange-500 dark:text-orange-400">mín: {{ fmtCantidad(p.stock_minimo) }}</p>
                    </div>
                  </div>
                }
              </div>
            </div>
          </div>
        </div>
      }

      <!-- ── Tabla de productos ─────────────────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden mb-6">
        <div class="flex items-center justify-between border-b border-gray-200 px-5 py-4 dark:border-gray-700">
          <h3 class="text-sm font-semibold text-gray-800 dark:text-white">Catálogo de productos</h3>
          @if (loading()) {
            <svg class="h-4 w-4 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
            </svg>
          }
        </div>

        @if (loading() && productos().length === 0) {
          <div class="p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            Cargando catálogo…
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-700/40">
                <tr>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Código</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Nombre</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Categoría</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Stock Actual</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Stock Mín.</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Estado</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Movimiento</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (p of productos(); track p.id) {
                  <tr [ngClass]="p.stock_actual <= p.stock_minimo && p.estado === 'Activo'
                      ? 'bg-red-50/50 dark:bg-red-900/10 hover:bg-red-50 dark:hover:bg-red-900/20'
                      : 'hover:bg-gray-50 dark:hover:bg-gray-700/30'"
                    class="transition">

                    <!-- Código -->
                    <td class="px-4 py-3 font-mono text-xs text-gray-500 dark:text-gray-400 whitespace-nowrap">
                      {{ p.codigo }}
                    </td>

                    <!-- Nombre -->
                    <td class="px-4 py-3">
                      <p class="font-medium text-gray-800 dark:text-white leading-tight">{{ p.nombre }}</p>
                      <p class="text-xs text-gray-400 dark:text-gray-500 mt-0.5">{{ p.unidad_medida }}</p>
                    </td>

                    <!-- Categoría -->
                    <td class="px-4 py-3">
                      @if (p.categoria) {
                        <span class="inline-flex items-center rounded-full bg-gray-100 dark:bg-gray-700 px-2 py-0.5 text-xs text-gray-600 dark:text-gray-300">
                          {{ p.categoria }}
                        </span>
                      } @else {
                        <span class="text-xs text-gray-300 dark:text-gray-600">—</span>
                      }
                    </td>

                    <!-- Stock Actual -->
                    <td class="px-4 py-3 text-center">
                      <div class="flex flex-col items-center gap-1">
                        <span class="text-base font-bold tabular-nums"
                          [ngClass]="p.stock_actual <= p.stock_minimo
                            ? 'text-red-600 dark:text-red-400'
                            : p.stock_actual <= p.stock_minimo * 1.5
                              ? 'text-amber-600 dark:text-amber-400'
                              : 'text-green-600 dark:text-green-400'">
                          {{ fmtCantidad(p.stock_actual) }}
                        </span>
                        <!-- Mini barra de stock -->
                        @if (p.stock_minimo > 0) {
                          <div class="h-1 w-16 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                            <div class="h-full rounded-full transition-all"
                              [ngClass]="p.stock_actual <= p.stock_minimo
                                ? 'bg-red-500'
                                : p.stock_actual <= p.stock_minimo * 1.5
                                  ? 'bg-amber-500'
                                  : 'bg-green-500'"
                              [style.width.%]="Math.min((p.stock_actual / (p.stock_minimo * 2)) * 100, 100)">
                            </div>
                          </div>
                        }
                      </div>
                    </td>

                    <!-- Stock Mínimo -->
                    <td class="px-4 py-3 text-center text-sm text-gray-500 dark:text-gray-400 tabular-nums">
                      {{ fmtCantidad(p.stock_minimo) }}
                    </td>

                    <!-- Estado -->
                    <td class="px-4 py-3 text-center">
                      <span class="inline-flex items-center rounded-full px-2 py-0.5 text-xs font-semibold"
                        [ngClass]="p.estado === 'Activo'
                          ? 'bg-green-50 text-green-700 dark:bg-green-900/30 dark:text-green-400'
                          : 'bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-400'">
                        {{ p.estado }}
                      </span>
                    </td>

                    <!-- Movimiento In/Out -->
                    <td class="px-4 py-3 text-center whitespace-nowrap">
                      @if (p.estado === 'Activo') {
                        <button (click)="abrirMovimiento(p)"
                          class="inline-flex items-center gap-1.5 rounded-lg border border-gray-300 dark:border-gray-600 px-3 py-1.5 text-xs font-medium text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition">
                          <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"/>
                          </svg>
                          In / Out
                        </button>
                      } @else {
                        <span class="text-xs text-gray-300 dark:text-gray-600">Inactivo</span>
                      }
                    </td>
                  </tr>
                } @empty {
                  <tr>
                    <td colspan="7" class="px-4 py-14 text-center">
                      <div class="flex flex-col items-center gap-2 text-gray-400 dark:text-gray-500">
                        <svg class="h-10 w-10 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 10V7m0 10l-8-4"/>
                        </svg>
                        <p class="text-sm">Sin productos en el catálogo.</p>
                      </div>
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        }
      </div>

      <!-- ── Historial reciente de movimientos ─────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
        <div class="border-b border-gray-200 px-5 py-4 dark:border-gray-700">
          <h3 class="text-sm font-semibold text-gray-800 dark:text-white">Últimos movimientos</h3>
          <p class="mt-0.5 text-xs text-gray-400 dark:text-gray-500">
            {{ movimientos().length }} registros recientes
          </p>
        </div>

        @if (movimientos().length === 0 && !loading()) {
          <div class="flex flex-col items-center gap-2 py-12 text-gray-400 dark:text-gray-500">
            <svg class="h-8 w-8 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 21L3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 3M21 7.5H7.5"/>
            </svg>
            <p class="text-sm">Sin movimientos registrados.</p>
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-700/40">
                <tr>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Fecha</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Producto</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Tipo</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Cantidad</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Responsable</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Observación</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (m of movimientos(); track m.id) {
                  <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 transition">
                    <td class="px-4 py-3 text-xs whitespace-nowrap text-gray-500 dark:text-gray-400">
                      {{ fmtFecha(m.fecha) }}
                    </td>
                    <td class="px-4 py-3">
                      <p class="font-medium text-gray-800 dark:text-white leading-tight">{{ m.producto_nombre }}</p>
                      <p class="text-xs font-mono text-gray-400 dark:text-gray-500 mt-0.5">{{ m.producto_codigo }}</p>
                    </td>
                    <td class="px-4 py-3 text-center">
                      <span class="inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-xs font-semibold"
                        [ngClass]="m.tipo_movimiento === 'Entrada'
                          ? 'bg-green-50 text-green-700 dark:bg-green-900/30 dark:text-green-400'
                          : 'bg-red-50 text-red-700 dark:bg-red-900/30 dark:text-red-400'">
                        <span class="h-1.5 w-1.5 rounded-full"
                          [ngClass]="m.tipo_movimiento === 'Entrada' ? 'bg-green-500' : 'bg-red-500'">
                        </span>
                        {{ m.tipo_movimiento }}
                      </span>
                    </td>
                    <td class="px-4 py-3 text-center font-bold tabular-nums"
                      [ngClass]="m.tipo_movimiento === 'Entrada'
                        ? 'text-green-600 dark:text-green-400'
                        : 'text-red-600 dark:text-red-400'">
                      {{ m.tipo_movimiento === 'Entrada' ? '+' : '−' }} {{ fmtCantidad(m.cantidad) }}
                    </td>
                    <td class="px-4 py-3 text-gray-600 dark:text-gray-300 whitespace-nowrap">
                      {{ m.responsable || '—' }}
                    </td>
                    <td class="px-4 py-3 text-gray-500 dark:text-gray-400 max-w-xs truncate">
                      {{ m.observacion || '—' }}
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        }
      </div>

    </div>

    <!-- ── Modal: Registrar Movimiento ─────────────────────────────────── -->
    @if (showMovForm() && productoSeleccionado()) {
      <app-movimiento-form
        [producto]="productoSeleccionado()!"
        (save)="onGuardarMovimiento($event)"
        (cancel)="cerrarMovForm()" />
    }

    <!-- ── Modal: Agregar Producto ────────────────────────────────────── -->
    @if (showNuevoForm()) {
      <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4"
        (click)="cerrarNuevoProducto()">
        <div class="w-full max-w-md rounded-2xl border border-gray-200 bg-white shadow-2xl dark:border-gray-700 dark:bg-gray-800 p-6"
          (click)="$event.stopPropagation()">
          <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-5">Agregar Producto</h3>

          <div class="space-y-4">
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Código <span class="text-red-500">*</span></label>
                <input type="text" placeholder="LMP-001"
                  [ngModel]="nuevoProducto().codigo"
                  (ngModelChange)="actualizarNuevo('codigo', $event)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Unidad</label>
                <select
                  [ngModel]="nuevoProducto().unidad_medida"
                  (ngModelChange)="actualizarNuevo('unidad_medida', $event)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                  @for (u of unidades; track u) { <option [value]="u">{{ u }}</option> }
                </select>
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Nombre <span class="text-red-500">*</span></label>
              <input type="text"
                [ngModel]="nuevoProducto().nombre"
                (ngModelChange)="actualizarNuevo('nombre', $event)"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Categoría</label>
              <select
                [ngModel]="nuevoProducto().categoria"
                (ngModelChange)="actualizarNuevo('categoria', $event || null)"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                <option value="">— Sin categoría —</option>
                @for (c of categorias; track c) { <option [value]="c">{{ c }}</option> }
              </select>
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Stock inicial</label>
                <input type="number" min="0" step="0.001"
                  [ngModel]="nuevoProducto().stock_actual"
                  (ngModelChange)="actualizarNuevo('stock_actual', +$event)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Stock mínimo</label>
                <input type="number" min="0" step="0.001"
                  [ngModel]="nuevoProducto().stock_minimo"
                  (ngModelChange)="actualizarNuevo('stock_minimo', +$event)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
            </div>
            @if (errorNuevoProducto()) {
              <p class="text-sm text-red-600 dark:text-red-400">{{ errorNuevoProducto() }}</p>
            }
          </div>

          <div class="mt-5 flex justify-end gap-2">
            <button type="button" (click)="cerrarNuevoProducto()"
              class="rounded-lg bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-800 dark:text-gray-200 px-4 py-2 text-sm transition">
              Cancelar
            </button>
            <button type="button" (click)="guardarNuevoProducto()"
              [disabled]="!!errorNuevoProducto() || guardandoProducto()"
              class="rounded-lg bg-brand-600 hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed text-white px-4 py-2 text-sm font-semibold shadow-sm transition flex items-center gap-2">
              @if (guardandoProducto()) {
                <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Guardando…
              } @else {
                Crear Producto
              }
            </button>
          </div>
        </div>
      </div>
    }
  `,
})
export class InventarioListComponent implements OnInit {
  private readonly svc  = inject(InventarioService);
  protected readonly auth = inject(AuthService);

  readonly productos   = this.svc.productos;
  readonly movimientos = this.svc.movimientos;
  readonly loading     = this.svc.loading;
  readonly error       = this.svc.error;
  readonly alertas     = this.svc.alertasStockBajo;

  // Helpers expuestos al template
  protected readonly fmtFecha    = fmtFecha;
  protected readonly fmtCantidad = fmtCantidad;
  protected readonly Math        = Math;

  // Catálogos estáticos
  readonly unidades   = ['Unidad', 'Kg', 'Gramo', 'Litro', 'Metro', 'Caja', 'Resma', 'Paquete', 'Docena'] as const;
  readonly categorias = ['Limpieza', 'Papelería', 'Ferretería', 'Eléctrico', 'Informática', 'Otros'] as const;

  // Estado modal movimiento
  readonly showMovForm          = signal(false);
  readonly productoSeleccionado = signal<InventarioProducto | null>(null);
  readonly guardandoMovimiento  = signal(false);

  // Estado modal nuevo producto
  readonly showNuevoForm       = signal(false);
  readonly nuevoProducto       = signal<ProductoInput>(productoInputVacio());
  readonly guardandoProducto   = signal(false);

  readonly productosActivos = computed(() =>
    this.productos().filter(p => p.estado === 'Activo'),
  );

  readonly errorNuevoProducto = computed(() => {
    const f = this.nuevoProducto();
    if (!f.codigo?.trim()) return 'El código es obligatorio.';
    if (!f.nombre?.trim()) return 'El nombre es obligatorio.';
    return null;
  });

  ngOnInit(): void {
    void this.svc.cargarTodo();
  }

  // ── Movimiento ────────────────────────────────────────────────────────────

  abrirMovimiento(p: InventarioProducto): void {
    this.productoSeleccionado.set(p);
    this.showMovForm.set(true);
  }

  cerrarMovForm(): void {
    this.showMovForm.set(false);
    this.productoSeleccionado.set(null);
  }

  async onGuardarMovimiento(input: MovimientoInput): Promise<void> {
    this.guardandoMovimiento.set(true);
    try {
      await this.svc.crearMovimiento(input);
      this.cerrarMovForm();
    } catch {
      // Error ya reflejado en el signal del servicio.
    } finally {
      this.guardandoMovimiento.set(false);
    }
  }

  // ── Nuevo Producto ────────────────────────────────────────────────────────

  abrirNuevoProducto(): void {
    this.nuevoProducto.set(productoInputVacio());
    this.showNuevoForm.set(true);
  }

  cerrarNuevoProducto(): void {
    this.showNuevoForm.set(false);
  }

  actualizarNuevo<K extends keyof ProductoInput>(key: K, value: ProductoInput[K]): void {
    this.nuevoProducto.update(f => ({ ...f, [key]: value }));
  }

  async guardarNuevoProducto(): Promise<void> {
    if (this.errorNuevoProducto() || this.guardandoProducto()) return;
    this.guardandoProducto.set(true);
    try {
      await this.svc.crearProducto(this.nuevoProducto());
      this.cerrarNuevoProducto();
    } catch {
      // Error ya reflejado en el signal del servicio.
    } finally {
      this.guardandoProducto.set(false);
    }
  }
}
