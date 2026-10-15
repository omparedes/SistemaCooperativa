import { Component, computed, input, output, signal } from '@angular/core';
import { DatePipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IngresoInternoItem } from '../../../core/services/gestion-ingresos.service';

@Component({
  selector: 'app-ingreso-anular-modal',
  standalone: true,
  imports: [DatePipe, FormsModule],
  template: `
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-xs p-4 overflow-y-auto">
      <div class="relative w-full max-w-lg rounded-2xl bg-white p-6 shadow-2xl dark:bg-gray-800 dark:border dark:border-gray-700 animate-in fade-in zoom-in-95 duration-150">

        <!-- Cabecera -->
        <div class="flex items-start gap-3">
          <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-red-100 text-red-600 dark:bg-red-900/40 dark:text-red-400">
            <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
            </svg>
          </div>
          <div>
            <h3 class="text-lg font-bold text-gray-900 dark:text-white">
              Anular Ingreso {{ ingreso().codigo_ref }}
            </h3>
            <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
              Esta acción requiere justificación obligatoria y quedará registrada en auditoría.
            </p>
          </div>
        </div>

        <!-- Resumen del ingreso a anular -->
        <div class="mt-4 rounded-xl border border-gray-200 bg-gray-50 p-3.5 text-sm dark:border-gray-700 dark:bg-gray-900/40">
          <div class="flex justify-between items-center">
            <span class="font-medium text-gray-700 dark:text-gray-300">{{ ingreso().concepto_nombre }}</span>
            <span class="text-base font-bold text-gray-900 dark:text-white tabular-nums">
              S/ {{ ingreso().monto.toFixed(2) }}
            </span>
          </div>
          <div class="mt-1 flex items-center justify-between text-xs text-gray-500 dark:text-gray-400">
            <span>Método: {{ ingreso().metodo_pago }}</span>
            <span>Fecha: {{ ingreso().fecha_ingreso | date:'dd/MM/yyyy HH:mm':'America/Lima' }}</span>
          </div>
        </div>

        <!-- Advertencia de fecha pasada si aplica -->
        @if (esFechaPasada()) {
          <div class="mt-3.5 rounded-xl border border-amber-300 bg-amber-50 p-3 text-xs text-amber-900 dark:border-amber-800 dark:bg-amber-900/20 dark:text-amber-300">
            <div class="flex items-start gap-2">
              <svg class="h-4 w-4 shrink-0 mt-0.5 text-amber-600 dark:text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
              </svg>
              <div>
                <strong>Aviso de Impacto Histórico:</strong> Este ingreso corresponde al arqueo del
                <strong>{{ ingreso().fecha_ingreso | date:'dd/MM/yyyy':'America/Lima' }}</strong>.
                Al anularlo, el saldo contable ya cerrado de dicha fecha se reducirá retroactivamente.
              </div>
            </div>
          </div>
        }

        <!-- Motivo de Anulación Obligatorio -->
        <div class="mt-4">
          <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1.5">
            Motivo de la anulación <span class="text-red-500">*</span>
          </label>
          <textarea
            rows="3"
            [ngModel]="motivo()"
            (ngModelChange)="motivo.set($event)"
            placeholder="Indique con claridad la causa de la anulación (ej. Registro duplicado en turno mañana)..."
            class="w-full rounded-xl border border-gray-300 bg-white p-3 text-sm text-gray-900 placeholder:text-gray-400 focus:border-red-500 focus:outline-none focus:ring-2 focus:ring-red-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
          ></textarea>
          @if (motivo().trim().length > 0 && motivo().trim().length < 5) {
            <p class="mt-1 text-xs text-red-500">El motivo debe tener al menos 5 caracteres.</p>
          } @else if (motivo().trim().length === 0) {
            <p class="mt-1 text-xs text-gray-400">Requerido para autorizar la anulación.</p>
          }
        </div>

        <!-- Botones de Acción -->
        <div class="mt-6 flex items-center justify-end gap-3 border-t border-gray-100 pt-4 dark:border-gray-700">
          <button
            type="button"
            (click)="cancel.emit()"
            [disabled]="guardando()"
            class="rounded-xl border border-gray-300 px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700 transition">
            Cancelar
          </button>
          <button
            type="button"
            (click)="confirmar()"
            [disabled]="guardando() || motivo().trim().length < 5"
            class="inline-flex items-center gap-2 rounded-xl bg-red-600 px-5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-700 focus:ring-2 focus:ring-red-500/30 disabled:opacity-50 disabled:cursor-not-allowed transition">
            @if (guardando()) {
              <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Anulando...
            } @else {
              Confirmar Anulación
            }
          </button>
        </div>

      </div>
    </div>
  `
})
export class IngresoAnularModalComponent {
  ingreso = input.required<IngresoInternoItem>();
  cancel = output<void>();
  confirm = output<{ id: number; motivo: string; updated_at: string }>();

  motivo = signal('');
  guardando = signal(false);

  esFechaPasada = computed(() => {
    const item = this.ingreso();
    if (!item?.fecha_ingreso) return false;
    const fechaOp = new Date(item.fecha_ingreso);
    const hoy = new Date();
    return (
      fechaOp.getFullYear() < hoy.getFullYear() ||
      (fechaOp.getFullYear() === hoy.getFullYear() &&
        (fechaOp.getMonth() < hoy.getMonth() ||
          (fechaOp.getMonth() === hoy.getMonth() && fechaOp.getDate() < hoy.getDate())))
    );
  });

  confirmar() {
    if (this.motivo().trim().length < 5) return;
    this.confirm.emit({
      id: this.ingreso().id,
      motivo: this.motivo().trim(),
      updated_at: this.ingreso().updated_at,
    });
  }
}
