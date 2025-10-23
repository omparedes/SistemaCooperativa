import { Component, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

export interface Movimiento {
  producto_id: number;
  tipo_movimiento: 'entrada' | 'salida';
  cantidad: number;
  gasto_id?: number | null;
}

@Component({
  selector: 'app-movimiento-form',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg w-full max-w-md p-6">
        <h3 class="text-lg font-semibold mb-4">Registrar Movimiento</h3>

        <div class="space-y-3">
          <label class="block text-sm">Producto</label>
          <select [(ngModel)]="model.producto_id" class="w-full border rounded px-3 py-2">
            <option *ngFor="let p of productos" [value]="p.id">{{ p.nombre }}</option>
          </select>

          <label class="block text-sm">Tipo</label>
          <div class="flex items-center gap-4">
            <label class="inline-flex items-center"><input type="radio" name="tipo" [(ngModel)]="model.tipo_movimiento" value="entrada" /> <span class="ml-2">Entrada</span></label>
            <label class="inline-flex items-center"><input type="radio" name="tipo" [(ngModel)]="model.tipo_movimiento" value="salida" /> <span class="ml-2">Salida</span></label>
          </div>

          <label class="block text-sm">Cantidad</label>
          <input type="number" min="1" [(ngModel)]="model.cantidad" class="w-full border rounded px-3 py-2" />

          <div *ngIf="model.tipo_movimiento === 'entrada'">
            <label class="block text-sm">Gasto ID (opcional)</label>
            <input type="number" min="0" [(ngModel)]="model.gasto_id" class="w-full border rounded px-3 py-2" />
          </div>
        </div>

        <div class="mt-4 flex justify-end gap-2">
          <button (click)="onCancel()" class="px-4 py-2 bg-gray-200 rounded">Cancelar</button>
          <button (click)="onSave()" class="px-4 py-2 bg-blue-600 text-white rounded">Registrar</button>
        </div>
      </div>
    </div>
  `
})
export class MovimientoFormComponent {
  @Input() productos: { id: number; nombre: string }[] = [];
  @Input() model: Movimiento = { producto_id: 0, tipo_movimiento: 'entrada', cantidad: 1 };
  @Output() save = new EventEmitter<Movimiento>();
  @Output() cancel = new EventEmitter<void>();

  onSave() {
    if (!this.model.producto_id || !this.model.cantidad || this.model.cantidad <= 0) return alert('Seleccione producto y cantidad válida');
    this.save.emit(this.model);
  }

  onCancel() {
    this.cancel.emit();
  }
}
