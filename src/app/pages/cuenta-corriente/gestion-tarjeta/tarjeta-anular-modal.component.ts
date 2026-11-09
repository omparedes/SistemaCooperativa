import { Component, computed, input, output, signal } from '@angular/core';
import { CommonModule, DatePipe, DecimalPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RecaudacionTarjetaItem } from '../../../core/services/gestion-tarjeta.service';

@Component({
  selector: 'app-tarjeta-anular-modal',
  standalone: true,
  imports: [CommonModule, DatePipe, DecimalPipe, FormsModule],
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
              Anular Recaudación {{ recaudacion().codigo_ref }}
            </h3>
            <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
              Esta operación es irreversible, auditable y revertirá el saldo a favor generado.
            </p>
          </div>
        </div>

        <!-- Resumen del registro -->
        <div class="mt-4 rounded-xl border border-gray-200 bg-gray-50 p-4 text-sm dark:border-gray-700 dark:bg-gray-900/40 space-y-2">
          <div class="flex justify-between items-center">
            <span class="font-medium text-gray-700 dark:text-gray-300">Socio</span>
            <span class="font-semibold text-gray-900 dark:text-white">{{ recaudacion().socio_nombre }}</span>
          </div>
          <div class="flex justify-between items-center text-xs text-gray-500 dark:text-gray-400">
            <span>DNI / Puesto</span>
            <span>{{ recaudacion().socio_dni }} · {{ recaudacion().codigo_puesto !== '—' ? 'Puesto ' + recaudacion().codigo_puesto : 'Sin puesto' }}</span>
          </div>
          <div class="flex justify-between items-center text-xs text-gray-500 dark:text-gray-400">
            <span>Fecha de recaudación</span>
            <span class="font-mono font-medium text-gray-700 dark:text-gray-300">{{ recaudacion().fecha | date:'dd/MM/yyyy':'America/Lima' }}</span>
          </div>
          <div class="pt-2 border-t border-gray-200 dark:border-gray-700 flex justify-between items-center">
            <span class="text-xs font-semibold text-gray-700 dark:text-gray-300">Monto a anular</span>
            <span class="text-base font-black text-red-600 dark:text-red-400 tabular-nums">
              S/ {{ recaudacion().monto | number:'1.2-2' }}
            </span>
          </div>
          <div class="flex justify-between items-center text-xs">
            <span class="text-gray-500 dark:text-gray-400">Saldo a favor actual del socio</span>
            <span class="font-bold text-gray-900 dark:text-white tabular-nums">
              S/ {{ recaudacion().socio_saldo_a_favor | number:'1.2-2' }}
            </span>
          </div>
        </div>

        <!-- Validación Crítica de Saldo Insuficiente para Reversión -->
        @if (saldoInsuficiente()) {
          <div class="mt-3.5 rounded-xl border border-red-300 bg-red-50 p-3.5 text-xs text-red-900 dark:border-red-800 dark:bg-red-900/20 dark:text-red-300">
            <div class="flex items-start gap-2.5">
              <svg class="h-5 w-5 shrink-0 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"/>
              </svg>
              <div>
                <strong class="font-bold">BLOQUEO FINANCIERO:</strong> No se puede anular esta recaudación.
                El socio solo dispone de <strong>S/ {{ recaudacion().socio_saldo_a_favor | number:'1.2-2' }}</strong> de saldo a favor, y el monto a revertir es de <strong>S/ {{ recaudacion().monto | number:'1.2-2' }}</strong>.
                El dinero ya fue consumido en pagos o amortizaciones en la cuenta corriente. Anularlo causaría un saldo contable negativo.
              </div>
            </div>
          </div>
        } @else {
          <div class="mt-3.5 rounded-xl border border-amber-300 bg-amber-50 p-3 text-xs text-amber-900 dark:border-amber-800 dark:bg-amber-900/20 dark:text-amber-300">
            <strong>Impacto Contable:</strong> Se deducirán <strong>S/ {{ recaudacion().monto | number:'1.2-2' }}</strong> del saldo a favor del socio (quedará en S/ {{ saldoRestante() | number:'1.2-2' }}).
            El registro se marcará como anulado y se excluirá de los totales vigentes del arqueo de caja.
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
            placeholder="Indique con claridad la causa de la anulación (ej. Registro duplicado por error de digitación / Cobro cancelado)..."
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
            [disabled]="guardando() || motivo().trim().length < 5 || saldoInsuficiente()"
            class="inline-flex items-center gap-2 rounded-xl bg-red-600 px-5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-700 focus:ring-2 focus:ring-red-500/30 disabled:opacity-50 disabled:cursor-not-allowed transition">
            @if (guardando()) {
              <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Anulando...
            } @else {
              <span>Confirmar Anulación</span>
            }
          </button>
        </div>

      </div>
    </div>
  `
})
export class TarjetaAnularModalComponent {
  recaudacion = input.required<RecaudacionTarjetaItem>();
  confirm = output<{ id: number; motivo: string; updated_at: string }>();
  cancel = output<void>();

  motivo = signal('');
  guardando = signal(false);

  readonly saldoInsuficiente = computed(() => {
    const s = this.recaudacion().socio_saldo_a_favor;
    const m = this.recaudacion().monto;
    return s < m;
  });

  readonly saldoRestante = computed(() => {
    const s = this.recaudacion().socio_saldo_a_favor;
    const m = this.recaudacion().monto;
    return Math.max(0, Math.round((s - m) * 100) / 100);
  });

  confirmar(): void {
    if (this.motivo().trim().length < 5 || this.saldoInsuficiente()) return;

    this.guardando.set(true);
    this.confirm.emit({
      id: this.recaudacion().id,
      motivo: this.motivo().trim(),
      updated_at: this.recaudacion().updated_at,
    });
  }
}
