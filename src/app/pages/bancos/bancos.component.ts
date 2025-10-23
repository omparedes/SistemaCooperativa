import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

export interface MovimientoBanco {
  id: number;
  fecha: string; // YYYY-MM-DD
  descripcion: string;
  cargo: number; // salida
  abono: number; // entrada
}

@Component({
  selector: 'app-bancos',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="p-6">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-2xl font-semibold">Movimientos Bancarios</h2>
        <div class="space-x-2">
          <button class="px-3 py-2 bg-gray-200 rounded">Importar CSV</button>
        </div>
      </div>

      <div class="bg-white p-4 rounded shadow mb-4">
        <form class="grid grid-cols-1 md:grid-cols-4 gap-3 items-end" (ngSubmit)="agregar()">
          <div>
            <label class="block text-sm">Fecha</label>
            <input type="date" [(ngModel)]="form.fecha" name="fecha" class="border rounded px-3 py-2 w-full" />
          </div>
          <div>
            <label class="block text-sm">Descripción</label>
            <input type="text" [(ngModel)]="form.descripcion" name="descripcion" class="border rounded px-3 py-2 w-full" />
          </div>
          <div>
            <label class="block text-sm">Cargo</label>
            <input type="number" min="0" step="0.01" [(ngModel)]="form.cargo" name="cargo" class="border rounded px-3 py-2 w-full" />
          </div>
          <div>
            <label class="block text-sm">Abono</label>
            <input type="number" min="0" step="0.01" [(ngModel)]="form.abono" name="abono" class="border rounded px-3 py-2 w-full" />
          </div>

          <div class="md:col-span-4 text-right mt-2">
            <button type="button" (click)="resetForm()" class="px-3 py-2 bg-gray-300 rounded mr-2">Limpiar</button>
            <button type="button" (click)="agregar()" class="px-3 py-2 bg-blue-600 text-white rounded">Agregar Movimiento</button>
          </div>
        </form>
      </div>

      <div class="bg-white p-4 rounded shadow">
        <table class="w-full text-sm">
          <thead>
            <tr class="text-left text-gray-600 border-b">
              <th>Fecha</th>
              <th>Descripción</th>
              <th class="text-right">Cargo</th>
              <th class="text-right">Abono</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr *ngFor="let m of movimientos">
              <td class="py-2">{{ m.fecha }}</td>
              <td class="py-2">{{ m.descripcion }}</td>
              <td class="py-2 text-right">{{ m.cargo | number:'1.2-2' }}</td>
              <td class="py-2 text-right">{{ m.abono | number:'1.2-2' }}</td>
              <td class="py-2">
                <button (click)="eliminar(m.id)" class="px-2 py-1 bg-red-100 text-red-800 rounded">Eliminar</button>
              </td>
            </tr>
            <tr *ngIf="movimientos.length === 0">
              <td colspan="5" class="py-4 text-center text-gray-500">No hay movimientos registrados.</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  `
})
export class BancosComponent implements OnInit {
  movimientos: MovimientoBanco[] = [];
  form: Partial<MovimientoBanco> = { fecha: new Date().toISOString().slice(0,10), descripcion: '', cargo: 0, abono: 0 };

  ngOnInit(): void {
    this.cargar();
  }

  cargar() {
    try {
      const raw = localStorage.getItem('movimientos_bancarios');
      this.movimientos = raw ? JSON.parse(raw) as MovimientoBanco[] : [];
    } catch {
      this.movimientos = [];
    }
  }

  guardar() {
    localStorage.setItem('movimientos_bancarios', JSON.stringify(this.movimientos));
  }

  agregar() {
    if (!this.form.fecha) return alert('Fecha requerida');
    const id = Date.now();
    const m: MovimientoBanco = {
      id,
      fecha: String(this.form.fecha),
      descripcion: String(this.form.descripcion || ''),
      cargo: Number(this.form.cargo || 0),
      abono: Number(this.form.abono || 0),
    };
    this.movimientos.unshift(m);
    this.guardar();
    this.resetForm();
  }

  eliminar(id: number) {
    if (!confirm('Eliminar movimiento?')) return;
    this.movimientos = this.movimientos.filter(x => x.id !== id);
    this.guardar();
  }

  resetForm() {
    this.form = { fecha: new Date().toISOString().slice(0,10), descripcion: '', cargo: 0, abono: 0 };
  }
}
