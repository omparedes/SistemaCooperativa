import { Component, input, output } from '@angular/core';
import { DatePipe } from '@angular/common';
import { IngresoInternoItem } from '../../../core/services/gestion-ingresos.service';

@Component({
  selector: 'app-ingreso-detalle-modal',
  standalone: true,
  imports: [DatePipe],
  template: `
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-xs p-4 overflow-y-auto">
      <div class="relative w-full max-w-2xl rounded-2xl bg-white p-6 shadow-2xl dark:bg-gray-800 dark:border dark:border-gray-700 animate-in fade-in zoom-in-95 duration-150">

        <!-- Cabecera -->
        <div class="flex items-start justify-between border-b border-gray-100 pb-4 dark:border-gray-700">
          <div>
            <div class="flex items-center gap-2">
              <span class="font-mono text-sm font-bold text-brand-600 dark:text-brand-400">
                {{ ingreso().codigo_ref }}
              </span>
              @if (ingreso().es_anulado) {
                <span class="inline-flex items-center rounded-full bg-red-100 px-2.5 py-0.5 text-xs font-semibold text-red-700 dark:bg-red-900/30 dark:text-red-400">
                  Anulado
                </span>
              } @else {
                <span class="inline-flex items-center rounded-full bg-emerald-100 px-2.5 py-0.5 text-xs font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400">
                  Vigente
                </span>
              }
            </div>
            <h3 class="mt-1 text-lg font-bold text-gray-900 dark:text-white">
              Detalle del Ingreso — {{ ingreso().concepto_nombre }}
            </h3>
          </div>
          <button
            type="button"
            (click)="close.emit()"
            class="rounded-lg p-1.5 text-gray-400 hover:bg-gray-100 hover:text-gray-600 dark:hover:bg-gray-700 dark:hover:text-gray-300 transition">
            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>

        <!-- Contenido principal -->
        <div class="mt-5 space-y-4 text-sm">

          <!-- Tarjeta de Importe y Método -->
          <div class="grid grid-cols-2 gap-4 rounded-xl bg-gray-50 p-4 dark:bg-gray-900/50 dark:border dark:border-gray-700/50">
            <div>
              <p class="text-xs font-medium text-gray-500 dark:text-gray-400">Monto Registrado</p>
              <p class="mt-0.5 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
                S/ {{ ingreso().monto.toFixed(2) }}
              </p>
            </div>
            <div>
              <p class="text-xs font-medium text-gray-500 dark:text-gray-400">Método de Pago</p>
              <div class="mt-1 flex items-center gap-1.5 font-semibold text-gray-800 dark:text-gray-200">
                @if (ingreso().metodo_pago === 'Efectivo') {
                  <span class="inline-flex items-center gap-1 text-emerald-600 dark:text-emerald-400">
                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0115.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 013 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 00-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 01-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 003 15h-.75"/>
                    </svg>
                    Efectivo (Gaveta)
                  </span>
                } @else {
                  <span class="inline-flex items-center gap-1 text-blue-600 dark:text-blue-400">
                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 008.716-6.747M12 21a9.004 9.004 0 01-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 017.843 4.582M12 3a8.997 8.997 0 00-7.843 4.582m15.686 0A11.953 11.953 0 0112 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0121 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0112 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 013 12c0-1.605.42-3.113 1.157-4.418"/>
                    </svg>
                    Transferencia / QR
                  </span>
                }
              </div>
            </div>
          </div>

          <!-- Campos de datos -->
          <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Grupo de Concepto</p>
              <p class="font-medium text-gray-800 dark:text-gray-200">{{ ingreso().concepto_grupo }}</p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Registrado por</p>
              <p class="font-medium text-gray-800 dark:text-gray-200">{{ ingreso().cajero_nombre }}</p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Fecha Operativa (Arqueo)</p>
              <p class="font-medium text-gray-800 dark:text-gray-200 font-mono">
                {{ ingreso().fecha_ingreso | date:'dd/MM/yyyy HH:mm':'America/Lima' }}
              </p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Fecha Real de Creación (Técnica)</p>
              <p class="font-medium text-gray-800 dark:text-gray-200 font-mono">
                {{ ingreso().created_at | date:'dd/MM/yyyy HH:mm:ss':'America/Lima' }}
              </p>
            </div>
          </div>

          <!-- Observación -->
          @if (ingreso().observacion) {
            <div class="rounded-lg border border-gray-200 bg-gray-50 p-3 dark:border-gray-700 dark:bg-gray-900/30">
              <p class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Observación</p>
              <p class="text-gray-800 dark:text-gray-200 italic">{{ ingreso().observacion }}</p>
            </div>
          }

          <!-- Bloque de anulación si aplica -->
          @if (ingreso().es_anulado) {
            <div class="rounded-xl border border-red-200 bg-red-50/70 p-4 dark:border-red-900/50 dark:bg-red-950/20">
              <div class="flex items-center gap-2 text-red-800 dark:text-red-300 font-semibold mb-2">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"/>
                </svg>
                Datos de Anulación
              </div>
              <div class="grid grid-cols-1 gap-2 sm:grid-cols-2 text-xs">
                <div>
                  <span class="text-gray-500 dark:text-gray-400">Anulado por:</span>
                  <span class="ml-1 font-medium text-gray-800 dark:text-gray-200">{{ ingreso().anulado_por_nombre || 'Administrador' }}</span>
                </div>
                <div>
                  <span class="text-gray-500 dark:text-gray-400">Fecha de anulación:</span>
                  <span class="ml-1 font-mono font-medium text-gray-800 dark:text-gray-200">
                    {{ ingreso().deleted_at | date:'dd/MM/yyyy HH:mm:ss':'America/Lima' }}
                  </span>
                </div>
              </div>
              <div class="mt-2 text-xs">
                <span class="text-gray-500 dark:text-gray-400">Motivo:</span>
                <p class="mt-0.5 font-medium text-red-900 dark:text-red-200 bg-white/70 dark:bg-black/20 p-2 rounded border border-red-200 dark:border-red-900/30">
                  {{ ingreso().motivo_anulacion || 'Sin motivo registrado' }}
                </p>
              </div>
            </div>
          }

        </div>

        <!-- Pie -->
        <div class="mt-6 flex justify-end border-t border-gray-100 pt-4 dark:border-gray-700">
          <button
            type="button"
            (click)="close.emit()"
            class="rounded-xl bg-gray-100 px-5 py-2.5 text-sm font-semibold text-gray-700 hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-200 dark:hover:bg-gray-600 transition">
            Cerrar
          </button>
        </div>

      </div>
    </div>
  `
})
export class IngresoDetalleModalComponent {
  ingreso = input.required<IngresoInternoItem>();
  close = output<void>();
}
