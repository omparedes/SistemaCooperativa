import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

export interface Socio {
  socio_id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  direccion: string;
  telefono: string;
  fecha_ingreso: string; // ISO string
  estado: 'Activo' | 'Inactivo';
  habilitado: 'Hábil' | 'Inhábil';
}

export interface MontoPorCobrar {
  monto_id: number;
  concepto: string;
  periodo_mes: number;
  periodo_anio: number;
  monto: number;
  estado: 'Pendiente' | 'Pagado' | 'Cancelado';
}

export interface Pago {
  pago_id: number;
  fecha_pago: string; // ISO string
  monto_total: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  comprobante: string;
}

@Component({
  selector: 'app-socio-detail',
  standalone: true,
  imports: [CommonModule, RouterModule],
  template: `
  <div class="bg-gray-100 p-6 min-h-screen">
    <a routerLink="/socios" class="text-blue-600 hover:underline mb-4 inline-block">&larr; Volver a la lista</a>

    <!-- Tarjeta 1: Información del Socio -->
    <div class="bg-white shadow-md rounded-lg p-6">
      <h2 class="text-2xl font-semibold mb-4">Información del Socio</h2>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <h3 class="text-sm text-gray-500">DNI</h3>
          <p class="text-lg font-medium">{{ socio.dni }}</p>
        </div>
        <div>
          <h3 class="text-sm text-gray-500">Nombres</h3>
          <p class="text-lg font-medium">{{ socio.nombres }}</p>
        </div>
        <div>
          <h3 class="text-sm text-gray-500">Apellidos</h3>
          <p class="text-lg font-medium">{{ socio.apellidos }}</p>
        </div>

        <div>
          <h3 class="text-sm text-gray-500">Teléfono</h3>
          <p class="text-lg font-medium">{{ socio.telefono }}</p>
        </div>
        <div class="md:col-span-2">
          <h3 class="text-sm text-gray-500">Dirección</h3>
          <p class="text-lg font-medium">{{ socio.direccion }}</p>
        </div>

        <div>
          <h3 class="text-sm text-gray-500">Fecha de Ingreso</h3>
          <p class="text-lg font-medium">{{ socio.fecha_ingreso | date:'dd/MM/yyyy' }}</p>
        </div>

        <div>
          <h3 class="text-sm text-gray-500">Estado</h3>
          <p>
            <span [ngClass]="socio.estado === 'Activo' ? 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800' : 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800'">
              {{ socio.estado }}
            </span>
          </p>
        </div>

        <div>
          <h3 class="text-sm text-gray-500">Habilitado</h3>
          <p>
            <span [ngClass]="socio.habilitado === 'Hábil' ? 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800' : 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800'">
              {{ socio.habilitado }}
            </span>
          </p>
        </div>
      </div>
    </div>

    <!-- Tarjeta 2: Pagos Pendientes -->
    <div class="bg-white shadow-md rounded-lg p-6 mt-6">
      <h2 class="text-xl font-semibold mb-4">Pagos Pendientes (Morosidad)</h2>

      <div *ngIf="pagosPendientes.length > 0; else noPendientes">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Concepto</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Periodo (Mes/Año)</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Monto</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Estado</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr *ngFor="let item of pagosPendientes">
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ item.concepto }}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ item.periodo_mes }}/{{ item.periodo_anio }}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ item.monto | currency:'S/' }}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm">
                <span [ngClass]="item.estado === 'Pendiente' ? 'text-red-600 font-medium' : 'text-green-600 font-medium'">{{ item.estado }}</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <ng-template #noPendientes>
        <p class="text-gray-500">No hay pagos pendientes.</p>
      </ng-template>
    </div>

    <!-- Tarjeta 3: Historial de Pagos -->
    <div class="bg-white shadow-md rounded-lg p-6 mt-6">
      <h2 class="text-xl font-semibold mb-4">Historial de Pagos</h2>

      <div *ngIf="historialPagos.length > 0; else noHistorial">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fecha de Pago</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Monto Total</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Método de Pago</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Comprobante</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr *ngFor="let pago of historialPagos">
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ pago.fecha_pago | date:'dd/MM/yyyy HH:mm' }}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ pago.monto_total | currency:'S/' }}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ pago.metodo_pago }}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ pago.comprobante }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <ng-template #noHistorial>
        <p class="text-gray-500">No hay historial de pagos.</p>
      </ng-template>
    </div>
  </div>
  `,
})
export class SocioDetailComponent implements OnInit {
  socio!: Socio;
  pagosPendientes: MontoPorCobrar[] = [];
  historialPagos: Pago[] = [];

  ngOnInit(): void {
    // Datos estáticos de ejemplo
    this.socio = {
      socio_id: 1,
      dni: '12345678',
      nombres: 'María Fernanda',
      apellidos: 'García López',
      direccion: 'Calle Falsa 123, Lima',
      telefono: '+51 987 654 321',
      fecha_ingreso: '2021-05-12T09:30:00Z',
      estado: 'Activo',
      habilitado: 'Hábil',
    };

    this.pagosPendientes = [
      {
        monto_id: 1,
        concepto: 'Luz',
        periodo_mes: 8,
        periodo_anio: 2025,
        monto: 120.5,
        estado: 'Pendiente',
      },
      {
        monto_id: 2,
        concepto: 'Agua',
        periodo_mes: 7,
        periodo_anio: 2025,
        monto: 80.0,
        estado: 'Pendiente',
      },
    ];

    this.historialPagos = [
      {
        pago_id: 1,
        fecha_pago: '2025-08-10T14:30:00Z',
        monto_total: 200.5,
        metodo_pago: 'Transferencia',
        comprobante: 'TRX-20250810-001',
      },
      {
        pago_id: 2,
        fecha_pago: '2025-07-05T10:15:00Z',
        monto_total: 150.0,
        metodo_pago: 'Efectivo',
        comprobante: 'REC-20250705-012',
      },
    ];
  }
}
