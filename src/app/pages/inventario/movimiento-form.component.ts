import { Component, computed, EventEmitter, Input, OnChanges, Output, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgClass } from '@angular/common';
import {
  InventarioProducto,
  MovimientoInput,
  TipoMovimiento,
  movimientoInputVacio,
} from '../../core/services/inventario.service';

@Component({
  selector: 'app-movimiento-form',
  standalone: true,
  imports: [FormsModule, NgClass],
  template: `
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4"
      (click)="cancel.emit()">
      <div class="w-full max-w-md rounded-2xl border border-gray-200 bg-white shadow-2xl dark:border-gray-700 dark:bg-gray-800 p-6"
        (click)="$event.stopPropagation()">

        <!-- Cabecera -->
        <div class="mb-5">
          <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Registrar Movimiento</h3>
          @if (producto) {
            <div class="mt-2 flex items-center gap-3 rounded-xl bg-gray-50 dark:bg-gray-700/50 px-4 py-2.5">
              <div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg"
                [ngClass]="producto.stock_actual <= producto.stock_minimo
                  ? 'bg-red-100 dark:bg-red-900/40'
                  : 'bg-brand-50 dark:bg-brand-900/20'">
                <svg class="h-4 w-4" [ngClass]="producto.stock_actual <= producto.stock_minimo ? 'text-red-600' : 'text-brand-600'" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 10V7m0 10l-8-4"/>
                </svg>
              </div>
              <div class="min-w-0">
                <p class="text-sm font-semibold text-gray-800 dark:text-white truncate">{{ producto.nombre }}</p>
                <p class="text-xs text-gray-400 dark:text-gray-500">
                  {{ producto.codigo }} · Stock: <strong [ngClass]="producto.stock_actual <= producto.stock_minimo ? 'text-red-600 dark:text-red-400' : 'text-gray-700 dark:text-gray-300'">{{ producto.stock_actual }} {{ producto.unidad_medida }}</strong>
                </p>
              </div>
            </div>
          }
        </div>

        <div class="space-y-4">

          <!-- Tipo: toggle buttons -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">Tipo de movimiento</label>
            <div class="grid grid-cols-2 gap-2">
              <button type="button"
                (click)="setTipo('Entrada')"
                [ngClass]="formInput().tipo_movimiento === 'Entrada'
                  ? 'bg-green-600 text-white shadow-sm'
                  : 'bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'"
                class="flex items-center justify-center gap-2 rounded-xl px-4 py-2.5 text-sm font-semibold transition">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
                </svg>
                Entrada
              </button>
              <button type="button"
                (click)="setTipo('Salida')"
                [ngClass]="formInput().tipo_movimiento === 'Salida'
                  ? 'bg-red-600 text-white shadow-sm'
                  : 'bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'"
                class="flex items-center justify-center gap-2 rounded-xl px-4 py-2.5 text-sm font-semibold transition">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M20 12H4"/>
                </svg>
                Salida
              </button>
            </div>
          </div>

          <!-- Cantidad + Fecha -->
          <div class="grid grid-cols-2 gap-3">
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Cantidad</label>
              <input type="number" min="0.001" step="0.001"
                [ngModel]="formInput().cantidad"
                (ngModelChange)="actualizar('cantidad', +$event)"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Fecha</label>
              <input type="date"
                [ngModel]="formInput().fecha"
                (ngModelChange)="actualizar('fecha', $event)"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
            </div>
          </div>

          <!-- Responsable -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Responsable</label>
            <input type="text"
              placeholder="Nombre de quien entrega o recibe"
              [ngModel]="formInput().responsable"
              (ngModelChange)="actualizar('responsable', $event || null)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>

          <!-- Observación -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Observación</label>
            <textarea rows="2"
              [ngModel]="formInput().observacion"
              (ngModelChange)="actualizar('observacion', $event || null)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500 resize-none"></textarea>
          </div>

          @if (errorValidacion()) {
            <p class="text-sm text-red-600 dark:text-red-400">{{ errorValidacion() }}</p>
          }
        </div>

        <div class="mt-5 flex justify-end gap-2">
          <button type="button" (click)="cancel.emit()"
            class="rounded-lg bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-800 dark:text-gray-200 px-4 py-2 text-sm transition">
            Cancelar
          </button>
          <button type="button" (click)="onSave()"
            [disabled]="!!errorValidacion()"
            [ngClass]="formInput().tipo_movimiento === 'Entrada'
              ? 'bg-green-600 hover:bg-green-700'
              : 'bg-red-600 hover:bg-red-700'"
            class="rounded-lg disabled:opacity-50 disabled:cursor-not-allowed text-white px-4 py-2 text-sm font-semibold shadow-sm transition">
            Confirmar {{ formInput().tipo_movimiento }}
          </button>
        </div>
      </div>
    </div>
  `,
})
export class MovimientoFormComponent implements OnChanges {
  @Input() producto: InventarioProducto | null = null;
  @Output() readonly save   = new EventEmitter<MovimientoInput>();
  @Output() readonly cancel = new EventEmitter<void>();

  readonly formInput = signal<MovimientoInput>(movimientoInputVacio());

  ngOnChanges(): void {
    if (this.producto) {
      this.formInput.set(movimientoInputVacio(this.producto.id));
    }
  }

  readonly errorValidacion = computed(() => {
    const f = this.formInput();
    if (!f.producto_id)            return 'No hay producto seleccionado.';
    if (!f.fecha)                  return 'La fecha es obligatoria.';
    if (!f.cantidad || f.cantidad <= 0) return 'La cantidad debe ser mayor a 0.';
    if (f.tipo_movimiento === 'Salida' && this.producto) {
      if (f.cantidad > this.producto.stock_actual) {
        return `Stock insuficiente: solo hay ${this.producto.stock_actual} ${this.producto.unidad_medida} disponibles.`;
      }
    }
    return null;
  });

  setTipo(tipo: TipoMovimiento): void {
    this.formInput.update(f => ({ ...f, tipo_movimiento: tipo }));
  }

  actualizar<K extends keyof MovimientoInput>(key: K, value: MovimientoInput[K]): void {
    this.formInput.update(f => ({ ...f, [key]: value }));
  }

  onSave(): void {
    if (this.errorValidacion()) return;
    this.save.emit(this.formInput());
  }
}
