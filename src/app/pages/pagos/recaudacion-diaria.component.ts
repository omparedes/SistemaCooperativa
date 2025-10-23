import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

interface SocioMini {
  socio_id: number;
  tienda?: string;
  nombres: string;
  apellidos: string;
}

interface Recaudacion {
  id: number;
  socio_id: number;
  socio_nombre: string;
  fecha: string; // ISO
  monto: number;
}

@Component({
  selector: 'app-recaudacion-diaria',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  template: `
  <div class="p-6">
    <div class="flex items-center justify-between mb-4">
      <h2 class="text-2xl font-semibold">Recaudación Diaria (Simulado)</h2>
      <div class="text-right">
        <div class="text-sm text-gray-500">Total Recaudado</div>
        <div class="text-xl font-bold">S/ {{ totalRecaudado.toFixed(2) }}</div>
      </div>
    </div>

    <div class="bg-white p-4 rounded shadow max-w-lg">
      <label class="block text-sm font-medium text-gray-700">Buscar Socio</label>
      <input type="text" [(ngModel)]="termino" (input)="filtrar()" placeholder="Nombre, Apellido o Tienda"
             class="mt-1 block w-full border rounded px-3 py-2 mb-3" />

      <div class="max-h-40 overflow-auto mb-3 border rounded">
        <button *ngFor="let s of sociosFiltrados" (click)="seleccionar(s)" class="w-full text-left px-3 py-2 hover:bg-gray-50">
          {{ s.nombres }} {{ s.apellidos }} <span class="text-sm text-gray-400">({{ s.socio_id }})</span>
        </button>
        <div *ngIf="sociosFiltrados.length === 0" class="p-3 text-gray-500">No hay resultados.</div>
      </div>

      <div *ngIf="socioSeleccionado" class="mb-3">
        <p><strong>Socio seleccionado:</strong> {{ socioSeleccionado.nombres }} {{ socioSeleccionado.apellidos }}</p>
      </div>

      <label class="block text-sm font-medium text-gray-700">Monto (S/)</label>
      <input type="number" [(ngModel)]="monto" class="mt-1 block w-full border rounded px-3 py-2 mb-3" />

      <div class="flex space-x-2">
        <button (click)="registrar()" class="px-4 py-2 bg-blue-600 text-white rounded">Registrar Pago Diario</button>
        <button (click)="guardarCambios()" *ngIf="editando" class="px-4 py-2 bg-yellow-500 text-white rounded">Guardar</button>
        <button (click)="cancelarEdicion()" *ngIf="editando" class="px-4 py-2 bg-gray-300 text-gray-800 rounded">Cancelar</button>
      </div>

      <div *ngIf="mensaje" class="mt-4 p-3 bg-green-50 text-green-700 rounded">{{ mensaje }}</div>
    </div>

    <div class="mt-6 max-w-2xl">
      <h3 class="text-lg font-medium mb-2">Recaudaciones Registradas</h3>
      <div *ngIf="recaudaciones.length === 0" class="text-gray-500">No se han registrado recaudaciones.</div>
      <ul class="space-y-2">
        <li *ngFor="let r of recaudaciones" class="flex items-center justify-between p-3 border rounded">
          <div>
            <div class="font-medium">{{ r.socio_nombre }} <span class="text-sm text-gray-400">({{ r.socio_id }})</span></div>
            <div class="text-sm text-gray-500">{{ r.fecha | date:'dd/MM/yyyy HH:mm' }} — S/ {{ r.monto.toFixed(2) }}</div>
          </div>
          <div class="flex items-center space-x-2">
            <button (click)="editar(r)" class="px-3 py-1 bg-yellow-100 text-yellow-800 rounded">Editar</button>
            <button (click)="eliminar(r.id)" class="px-3 py-1 bg-red-100 text-red-800 rounded">Eliminar</button>
          </div>
        </li>
      </ul>
    </div>
  </div>
  `
})
export class RecaudacionDiariaComponent implements OnInit {
  termino: string = '';
  sociosFiltrados: SocioMini[] = [];
  socioSeleccionado: SocioMini | null = null;
  monto: number = 0;
  mensaje: string | null = null;
  recaudaciones: Recaudacion[] = [];
  editando: boolean = false;
  editId: number | null = null;

  get totalRecaudado() {
    return this.recaudaciones.reduce((s, r) => s + r.monto, 0);
  }

  // small mock reuse (a subset)
  socios: SocioMini[] = [
    { socio_id: 1001, nombres: 'Donatila', apellidos: 'Huamani' },
    { socio_id: 1003, nombres: 'Juana', apellidos: 'Romero' },
    { socio_id: 1005, nombres: 'Vicenta', apellidos: 'Medina' },
    { socio_id: 1076, nombres: 'Luis', apellidos: 'Calderon' },
  ];

  ngOnInit(): void {
    this.sociosFiltrados = [...this.socios];
    this.cargarRecaudaciones();
  }

  filtrar() {
    const t = this.termino.trim().toLowerCase();
    if (!t) {
      this.sociosFiltrados = [...this.socios];
      return;
    }
    this.sociosFiltrados = this.socios.filter(s => (`${s.nombres} ${s.apellidos}`.toLowerCase().includes(t) || (s.tienda || '').toLowerCase().includes(t)));
  }

  seleccionar(s: SocioMini) {
    this.socioSeleccionado = s;
    this.mensaje = null;
  }

  registrar() {
    if (!this.socioSeleccionado || !this.monto || this.monto <= 0) {
      this.mensaje = 'Seleccione un socio y un monto válido.';
      return;
    }
    if (this.editando && this.editId !== null) {
      // actualizar existente
      const idx = this.recaudaciones.findIndex(r => r.id === this.editId);
      if (idx >= 0) {
        this.recaudaciones[idx].socio_id = this.socioSeleccionado.socio_id;
        this.recaudaciones[idx].socio_nombre = `${this.socioSeleccionado.nombres} ${this.socioSeleccionado.apellidos}`;
        this.recaudaciones[idx].monto = this.monto;
        this.recaudaciones[idx].fecha = new Date().toISOString();
        this.mensaje = 'Recaudación actualizada.';
        this.guardarLocalStorage();
      }
      this.editando = false;
      this.editId = null;
    } else {
      // nuevo
      const nueva: Recaudacion = {
        id: Date.now(),
        socio_id: this.socioSeleccionado.socio_id,
        socio_nombre: `${this.socioSeleccionado.nombres} ${this.socioSeleccionado.apellidos}`,
        fecha: new Date().toISOString(),
        monto: this.monto,
      };
      this.recaudaciones.unshift(nueva);
      this.guardarLocalStorage();
      this.mensaje = `Pago diario de S/ ${this.monto.toFixed(2)} registrado para ${this.socioSeleccionado.nombres} ${this.socioSeleccionado.apellidos}.`;
    }

    // reset
    this.socioSeleccionado = null;
    this.monto = 0;
    this.termino = '';
    this.sociosFiltrados = [...this.socios];
  }

  editar(r: Recaudacion) {
    this.editando = true;
    this.editId = r.id;
    this.socioSeleccionado = { socio_id: r.socio_id, nombres: r.socio_nombre.split(' ')[0] || '', apellidos: r.socio_nombre.split(' ').slice(1).join(' ') || '' };
    this.monto = r.monto;
    this.mensaje = null;
  }

  cancelarEdicion() {
    this.editando = false;
    this.editId = null;
    this.socioSeleccionado = null;
    this.monto = 0;
  }

  eliminar(id: number) {
    if (!confirm('¿Eliminar esta recaudación?')) return;
    this.recaudaciones = this.recaudaciones.filter(r => r.id !== id);
    this.guardarLocalStorage();
    this.mensaje = 'Recaudación eliminada.';
  }

  cargarRecaudaciones() {
    try {
      const raw = localStorage.getItem('recaudaciones_diarias');
      if (raw) {
        this.recaudaciones = JSON.parse(raw) as Recaudacion[];
      }
    } catch (e) {
      this.recaudaciones = [];
    }
  }

  guardarLocalStorage() {
    localStorage.setItem('recaudaciones_diarias', JSON.stringify(this.recaudaciones));
  }

  guardarCambios() {
    // alias para el botón guardar cuando se edita
    this.registrar();
  }
}
