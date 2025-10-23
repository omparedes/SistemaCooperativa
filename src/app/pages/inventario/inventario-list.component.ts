import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MovimientoFormComponent, Movimiento } from './movimiento-form.component';

export interface ProductoAlmacen {
  id: number;
  nombre: string;
  stock_actual: number;
  stock_minimo: number;
}

@Component({
  selector: 'app-inventario-list',
  standalone: true,
  imports: [CommonModule, FormsModule, MovimientoFormComponent],
  template: `
    <div class="p-6">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-2xl font-semibold">Inventario - Almacén Interno</h2>
        <div>
          <button (click)="showCreate = true" class="px-3 py-2 bg-blue-600 text-white rounded">+ Agregar Item</button>
        </div>
      </div>

      <div class="bg-white p-4 rounded shadow mb-4">
        <table class="w-full text-sm">
          <thead>
            <tr class="text-left text-gray-600 border-b">
              <th>Producto</th>
              <th>Stock Actual</th>
              <th>Stock Mínimo</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr *ngFor="let p of productos" [ngClass]="{'bg-red-50': p.stock_actual <= p.stock_minimo}">
              <td class="py-2">{{ p.nombre }}</td>
              <td class="py-2"><span [ngClass]="{'text-red-600 font-semibold': p.stock_actual <= p.stock_minimo}">{{ p.stock_actual }}</span></td>
              <td class="py-2">{{ p.stock_minimo }}</td>
              <td class="py-2">
                <button (click)="abrirMovimiento(p, 'entrada')" class="px-2 py-1 bg-green-100 text-green-800 rounded mr-2">Registrar Entrada</button>
                <button (click)="abrirMovimiento(p, 'salida')" class="px-2 py-1 bg-yellow-100 text-yellow-800 rounded">Registrar Salida</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <ng-container *ngIf="showForm">
        <app-movimiento-form [productos]="productosSimple" [model]="movModel" (save)="onSave($event)" (cancel)="onCancel()"></app-movimiento-form>
      </ng-container>

      <ng-container *ngIf="showCreate">
        <div class="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
          <div class="bg-white rounded-lg w-full max-w-lg p-6">
            <h3 class="text-lg font-semibold mb-4">Nuevo Producto</h3>
            <div class="grid grid-cols-1 gap-3">
              <label class="block text-sm">Nombre</label>
              <input type="text" [(ngModel)]="newProducto.nombre" class="border rounded px-3 py-2" />

              <label class="block text-sm">Stock Inicial</label>
              <input type="number" min="0" [(ngModel)]="newProducto.stock_actual" class="border rounded px-3 py-2" />

              <label class="block text-sm">Stock Mínimo</label>
              <input type="number" min="0" [(ngModel)]="newProducto.stock_minimo" class="border rounded px-3 py-2" />
            </div>

            <div class="mt-4 flex justify-end gap-2">
              <button (click)="showCreate = false" class="px-4 py-2 bg-gray-200 rounded">Cancelar</button>
              <button (click)="crearProducto()" class="px-4 py-2 bg-blue-600 text-white rounded">Crear</button>
            </div>
          </div>
        </div>
      </ng-container>
    </div>
  `
})
export class InventarioListComponent implements OnInit {
  productos: ProductoAlmacen[] = [];
  showForm = false;
  movModel: Movimiento = { producto_id: 0, tipo_movimiento: 'entrada', cantidad: 1 };
  showCreate = false;
  newProducto: Partial<ProductoAlmacen> = { nombre: '', stock_actual: 0, stock_minimo: 0 };

  ngOnInit(): void {
    this.cargar();
  }

  get productosSimple() {
    return this.productos.map(p => ({ id: p.id, nombre: p.nombre }));
  }

  cargar() {
    try {
      const raw = localStorage.getItem('productos_almacen');
      this.productos = raw ? JSON.parse(raw) as ProductoAlmacen[] : this.mockProductos();
    } catch {
      this.productos = this.mockProductos();
    }
  }

  guardar() {
    localStorage.setItem('productos_almacen', JSON.stringify(this.productos));
  }

  mockProductos(): ProductoAlmacen[] {
    return [
      { id: 1, nombre: 'Tornillos 1/4"', stock_actual: 120, stock_minimo: 50 },
      { id: 2, nombre: 'Aceite Lubricante 1L', stock_actual: 8, stock_minimo: 10 },
      { id: 3, nombre: 'Filtro de Aire', stock_actual: 20, stock_minimo: 5 },
    ];
  }

  abrirMovimiento(p: ProductoAlmacen, tipo: 'entrada' | 'salida') {
    this.movModel = { producto_id: p.id, tipo_movimiento: tipo, cantidad: 1 };
    this.showForm = true;
  }

  onSave(m: Movimiento) {
    const prod = this.productos.find(p => p.id === Number(m.producto_id));
    if (!prod) return alert('Producto no encontrado');
    if (m.tipo_movimiento === 'entrada') {
      prod.stock_actual += Number(m.cantidad);
    } else {
      prod.stock_actual -= Number(m.cantidad);
      if (prod.stock_actual < 0) prod.stock_actual = 0;
    }
    this.guardar();
    this.showForm = false;
  }

  onCancel() {
    this.showForm = false;
  }

  crearProducto() {
    if (!this.newProducto || !this.newProducto.nombre) return alert('Nombre requerido');
    const id = Date.now();
    const p: ProductoAlmacen = {
      id,
      nombre: String(this.newProducto.nombre),
      stock_actual: Number(this.newProducto.stock_actual || 0),
      stock_minimo: Number(this.newProducto.stock_minimo || 0)
    };
    this.productos.unshift(p);
    this.guardar();
    this.showCreate = false;
    this.newProducto = { nombre: '', stock_actual: 0, stock_minimo: 0 };
  }
}
