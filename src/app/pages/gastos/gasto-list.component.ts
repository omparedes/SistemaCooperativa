import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { GastoFormComponent, Gasto } from './gasto-form.component';

@Component({
  selector: 'app-gasto-list',
  standalone: true,
  imports: [CommonModule, FormsModule, GastoFormComponent],
  template: `
    <div class="p-6">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-2xl font-semibold">Gastos</h2>
        <button (click)="nuevo()" class="px-4 py-2 bg-blue-600 text-white rounded">Registrar Nuevo Gasto</button>
      </div>

      <div class="bg-white p-4 rounded shadow mb-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
          <div>
            <label class="text-sm">Fecha inicio</label>
            <input type="date" [(ngModel)]="fInicio" (change)="aplicarFiltro()" class="mt-1 border rounded px-3 py-2 w-full" />
          </div>
          <div>
            <label class="text-sm">Fecha fin</label>
            <input type="date" [(ngModel)]="fFin" (change)="aplicarFiltro()" class="mt-1 border rounded px-3 py-2 w-full" />
          </div>
          <div>
            <label class="text-sm">Categoría</label>
            <select [(ngModel)]="categoriaFiltro" (change)="aplicarFiltro()" class="mt-1 border rounded px-3 py-2 w-full">
              <option value="">Todas</option>
              <option *ngFor="let c of categorias" [value]="c.id">{{ c.nombre }}</option>
            </select>
          </div>
        </div>
      </div>

      <div class="bg-white p-4 rounded shadow">
        <table class="w-full text-sm">
          <thead>
            <tr class="text-left text-gray-600 border-b">
              <th>Fecha</th>
              <th>Categoría</th>
              <th class="text-right">Monto</th>
              <th>Descripción</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr *ngFor="let g of gastosFiltrados" class="border-b">
              <td class="py-2">{{ g.fecha | date:'dd/MM/yyyy' }}</td>
              <td class="py-2">{{ g.categoria_nombre }}</td>
              <td class="py-2 text-right">S/ {{ g.monto.toFixed(2) }}</td>
              <td class="py-2">{{ g.descripcion }}</td>
              <td class="py-2">
                <button (click)="editar(g)" class="px-2 py-1 bg-yellow-100 text-yellow-800 rounded mr-2">Editar</button>
                <button (click)="eliminar(g.id)" class="px-2 py-1 bg-red-100 text-red-800 rounded">Eliminar</button>
              </td>
            </tr>
            <tr *ngIf="gastosFiltrados.length === 0">
              <td colspan="5" class="py-4 text-center text-gray-500">No se encontraron gastos.</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Modal form -->
      <ng-container *ngIf="showForm">
        <app-gasto-form [gasto]="formModel" [categorias]="categorias" (save)="onSave($event)" (cancel)="onCancel()"></app-gasto-form>
      </ng-container>
    </div>
  `
})
export class GastoListComponent implements OnInit {
  gastos: Gasto[] = [];
  gastosFiltrados: Gasto[] = [];

  categorias = [
    { id: 1, nombre: 'Operativo' },
    { id: 2, nombre: 'Mantenimiento' },
    { id: 3, nombre: 'Servicios' },
  ];

  fInicio: string | null = null;
  fFin: string | null = null;
  categoriaFiltro: string = '';

  showForm = false;
  formModel: Gasto = { id: 0, categoria_gasto_id: 1, fecha: new Date().toISOString().slice(0,10), monto: 0 };

  ngOnInit(): void {
    this.cargar();
    this.aplicarFiltro();
  }

  cargar() {
    try {
      const raw = localStorage.getItem('gastos');
      this.gastos = raw ? JSON.parse(raw) as Gasto[] : [];
    } catch (e) {
      this.gastos = [];
    }
    this.gastosFiltrados = [...this.gastos];
  }

  guardar() {
    localStorage.setItem('gastos', JSON.stringify(this.gastos));
    this.aplicarFiltro();
  }

  aplicarFiltro() {
    const start = this.fInicio ? new Date(this.fInicio + 'T00:00:00') : null;
    const end = this.fFin ? new Date(this.fFin + 'T23:59:59') : null;

    this.gastosFiltrados = this.gastos.filter(g => {
      const fecha = new Date(g.fecha);
      const inRange = (!start || fecha >= start) && (!end || fecha <= end);
      const inCat = !this.categoriaFiltro || g.categoria_gasto_id === Number(this.categoriaFiltro);
      return inRange && inCat;
    });
  }

  nuevo() {
    this.formModel = { id: 0, categoria_gasto_id: 1, fecha: new Date().toISOString().slice(0,10), monto: 0 };
    this.showForm = true;
  }

  editar(g: Gasto) {
    this.formModel = { ...g };
    this.showForm = true;
  }

  eliminar(id: number) {
    if (!confirm('¿Eliminar gasto?')) return;
    this.gastos = this.gastos.filter(x => x.id !== id);
    this.guardar();
  }

  onSave(g: Gasto) {
    if (g.id && g.id > 0) {
      const idx = this.gastos.findIndex(x => x.id === g.id);
      if (idx >= 0) this.gastos[idx] = { ...g };
    } else {
      g.id = Date.now();
      const cat = this.categorias.find(c => c.id === g.categoria_gasto_id);
      g.categoria_nombre = cat ? cat.nombre : '';
      this.gastos.unshift(g);
    }
    this.guardar();
    this.showForm = false;
  }

  onCancel() {
    this.showForm = false;
  }
}
