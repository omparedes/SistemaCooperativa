import { Component, computed, EventEmitter, Input, Output, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CategoriaGasto, Gasto, GastoInput, gastoInputVacio } from './gasto.model';

@Component({
  selector: 'app-gasto-form',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-2xl w-full max-w-lg p-6 border border-gray-200 dark:border-gray-700">
        <h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-5">
          {{ esEdicion() ? 'Editar Gasto' : 'Nuevo Gasto' }}
        </h3>

        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Categoría</label>
            <select
              [ngModel]="modelo().categoria_gasto_id"
              (ngModelChange)="actualizar('categoria_gasto_id', $event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
              <option [ngValue]="0" disabled>— Selecciona —</option>
              @for (c of categorias; track c.id) {
                <option [ngValue]="c.id">{{ c.nombre }}</option>
              }
            </select>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Fecha</label>
            <input type="date"
              [ngModel]="modelo().fecha"
              (ngModelChange)="actualizar('fecha', $event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Monto (S/)</label>
            <input type="number" step="0.01" min="0.01"
              [ngModel]="modelo().monto"
              (ngModelChange)="actualizar('monto', +$event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Descripción</label>
            <textarea rows="3"
              [ngModel]="modelo().descripcion"
              (ngModelChange)="actualizar('descripcion', $event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500"></textarea>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Comprobante (referencia)</label>
            <input type="text"
              [ngModel]="modelo().comprobante_ref"
              (ngModelChange)="actualizar('comprobante_ref', $event)"
              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>

          @if (errorValidacion()) {
            <p class="text-sm text-red-600 dark:text-red-400">{{ errorValidacion() }}</p>
          }
        </div>

        <div class="mt-6 flex justify-end gap-2">
          <button type="button" (click)="cancel.emit()"
            class="px-4 py-2 bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-800 dark:text-gray-200 rounded-lg">
            Cancelar
          </button>
          <button type="button" (click)="onSave()"
            class="px-4 py-2 bg-brand-600 hover:bg-brand-700 text-white rounded-lg shadow-sm">
            Guardar
          </button>
        </div>
      </div>
    </div>
  `,
})
export class GastoFormComponent {
  @Input() set gasto(g: Gasto | null) {
    if (g) {
      this._esEdicion.set(true);
      this._editId.set(g.id);
      this._modelo.set({
        categoria_gasto_id: g.categoria_gasto_id,
        fecha: g.fecha,
        monto: Number(g.monto),
        descripcion: g.descripcion,
        comprobante_ref: g.comprobante_ref,
      });
    } else {
      this._esEdicion.set(false);
      this._editId.set(null);
      this._modelo.set(gastoInputVacio());
    }
  }
  @Input() categorias: CategoriaGasto[] = [];

  @Output() save = new EventEmitter<{ id: number | null; input: GastoInput }>();
  @Output() cancel = new EventEmitter<void>();

  private readonly _modelo = signal<GastoInput>(gastoInputVacio());
  private readonly _esEdicion = signal(false);
  private readonly _editId = signal<number | null>(null);
  readonly modelo = this._modelo.asReadonly();
  readonly esEdicion = this._esEdicion.asReadonly();

  readonly errorValidacion = computed(() => {
    const m = this._modelo();
    if (!m.fecha) return 'La fecha es obligatoria.';
    if (!m.monto || m.monto <= 0) return 'El monto debe ser mayor a 0.';
    if (!m.categoria_gasto_id) return 'Selecciona una categoría.';
    return null;
  });

  actualizar<K extends keyof GastoInput>(key: K, value: GastoInput[K]): void {
    this._modelo.update(m => ({ ...m, [key]: value }));
  }

  onSave(): void {
    if (this.errorValidacion()) return;
    this.save.emit({ id: this._editId(), input: this._modelo() });
  }
}
