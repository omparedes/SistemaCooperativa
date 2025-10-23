import { Component, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

export interface Gasto {
  id: number;
  categoria_gasto_id: number;
  categoria_nombre?: string;
  fecha: string; // YYYY-MM-DD
  monto: number;
  descripcion?: string;
  comprobante_ref?: string;
}

@Component({
  selector: 'app-gasto-form',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg w-full max-w-lg p-6">
        <h3 class="text-lg font-semibold mb-4">{{ gasto.id ? 'Editar Gasto' : 'Nuevo Gasto' }}</h3>

        <div class="grid grid-cols-1 gap-3">
          <label class="block text-sm">Categoría</label>
          <select [(ngModel)]="gasto.categoria_gasto_id" class="border rounded px-3 py-2">
            <option *ngFor="let c of categorias" [value]="c.id">{{ c.nombre }}</option>
          </select>

          <label class="block text-sm">Fecha</label>
          <input type="date" [(ngModel)]="gasto.fecha" class="border rounded px-3 py-2" />

          <label class="block text-sm">Monto</label>
          <input type="number" [(ngModel)]="gasto.monto" class="border rounded px-3 py-2" />

          <label class="block text-sm">Descripción</label>
          <textarea [(ngModel)]="gasto.descripcion" class="border rounded px-3 py-2" rows="3"></textarea>

          <label class="block text-sm">Comprobante (ref)</label>
          <input type="text" [(ngModel)]="gasto.comprobante_ref" class="border rounded px-3 py-2" />
        </div>

        <div class="mt-4 flex justify-end space-x-2">
          <button (click)="onCancel()" class="px-4 py-2 bg-gray-200 rounded">Cancelar</button>
          <button (click)="onSave()" class="px-4 py-2 bg-blue-600 text-white rounded">Guardar</button>
        </div>
      </div>
    </div>
  `
})
export class GastoFormComponent {
  @Input() gasto: Gasto = { id: 0, categoria_gasto_id: 1, fecha: new Date().toISOString().slice(0,10), monto: 0 };
  @Input() categorias: { id: number; nombre: string }[] = [
    { id: 1, nombre: 'Operativo' },
    { id: 2, nombre: 'Mantenimiento' },
    { id: 3, nombre: 'Servicios' },
  ];
  @Output() save = new EventEmitter<Gasto>();
  @Output() cancel = new EventEmitter<void>();

  onSave() {
    if (!this.gasto.fecha || !this.gasto.monto) return alert('Fecha y monto son requeridos');
    const cat = this.categorias.find(c => c.id === this.gasto.categoria_gasto_id);
    this.gasto.categoria_nombre = cat ? cat.nombre : '';
    this.save.emit(this.gasto);
  }

  onCancel() {
    this.cancel.emit();
  }
}
