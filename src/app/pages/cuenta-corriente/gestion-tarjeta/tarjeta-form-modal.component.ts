import { Component, computed, effect, input, output, signal } from '@angular/core';
import { CommonModule, DecimalPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { EditarRecaudacionParams, RecaudacionTarjetaItem } from '../../../core/services/gestion-tarjeta.service';

const limaDateFormatter = new Intl.DateTimeFormat('en-CA', {
  timeZone: 'America/Lima',
  year: 'numeric',
  month: '2-digit',
  day: '2-digit',
});

function toYMD(iso: string): string {
  if (!iso) return '';
  return limaDateFormatter.format(new Date(iso));
}

@Component({
  selector: 'app-tarjeta-form-modal',
  standalone: true,
  imports: [CommonModule, FormsModule, DecimalPipe],
  template: `
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-xs p-4 overflow-y-auto">
      <div class="relative w-full max-w-2xl rounded-2xl bg-white p-6 shadow-2xl dark:bg-gray-800 dark:border dark:border-gray-700 animate-in fade-in zoom-in-95 duration-150">

        <!-- Cabecera -->
        <div class="flex items-start justify-between border-b border-gray-100 pb-4 dark:border-gray-700">
          <div>
            <div class="flex items-center gap-2">
              <span class="font-mono text-sm font-bold text-brand-600 dark:text-brand-400">
                {{ recaudacion().codigo_ref }}
              </span>
              <span class="inline-flex items-center rounded-full bg-amber-100 px-2.5 py-0.5 text-xs font-semibold text-amber-700 dark:bg-amber-900/30 dark:text-amber-400">
                Corrección Administrativa
              </span>
            </div>
            <h3 class="mt-1 text-lg font-bold text-gray-900 dark:text-white">
              Corregir Recaudación de Tarjeta
            </h3>
            <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
              Socio: <strong>{{ recaudacion().socio_nombre }}</strong> (DNI: {{ recaudacion().socio_dni }})
            </p>
          </div>
          <button
            type="button"
            (click)="cancel.emit()"
            [disabled]="guardando()"
            class="rounded-lg p-1.5 text-gray-400 hover:bg-gray-100 hover:text-gray-600 dark:hover:bg-gray-700 dark:hover:text-gray-300 transition">
            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>

        <!-- Banner de Saldo a Favor Actual -->
        <div class="mt-4 flex items-center justify-between rounded-xl border border-blue-200 bg-blue-50/70 p-3.5 text-xs text-blue-900 dark:border-blue-900/50 dark:bg-blue-950/20 dark:text-blue-300">
          <div class="flex items-center gap-2">
            <svg class="h-4 w-4 text-blue-600 dark:text-blue-400 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z"/>
            </svg>
            <span>Saldo a favor actual en cuenta corriente del socio:</span>
          </div>
          <span class="font-bold text-sm text-blue-950 dark:text-white tabular-nums">
            S/ {{ recaudacion().socio_saldo_a_favor | number:'1.2-2' }}
          </span>
        </div>

        <!-- Advertencia de Fecha Pasada -->
        @if (esFechaPasada()) {
          <div class="mt-3 rounded-xl border border-amber-300 bg-amber-50 p-3 text-xs text-amber-900 dark:border-amber-800 dark:bg-amber-900/20 dark:text-amber-300">
            <div class="flex items-start gap-2">
              <svg class="h-4 w-4 shrink-0 mt-0.5 text-amber-600 dark:text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
              </svg>
              <div>
                <strong>Atención Contable:</strong> La nueva fecha seleccionada traslada el movimiento a otro día.
                El arqueo de caja y reportes diarios del día original disminuirán en S/ {{ monto() | number:'1.2-2' }} y se registrarán en la nueva fecha.
              </div>
            </div>
          </div>
        }

        <!-- Validación Crítica de Reducción de Monto -->
        @if (excedeSaldoDisponible()) {
          <div class="mt-3 rounded-xl border border-red-300 bg-red-50 p-3.5 text-xs text-red-900 dark:border-red-800 dark:bg-red-900/20 dark:text-red-300">
            <div class="flex items-start gap-2.5">
              <svg class="h-5 w-5 shrink-0 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"/>
              </svg>
              <div>
                <strong class="font-bold">BLOQUEO FINANCIERO:</strong> No es posible reducir el monto a S/ {{ monto() | number:'1.2-2' }} (reducción de S/ {{ absDelta() | number:'1.2-2' }}).
                El socio solo dispone de <strong>S/ {{ recaudacion().socio_saldo_a_favor | number:'1.2-2' }}</strong> de saldo a favor disponible.
                Parte del saldo generado por este cobro ya fue utilizado en el wizard de pagos para amortizar deudas en cuenta corriente.
              </div>
            </div>
          </div>
        } @else if (deltaMonto() !== 0) {
          <div class="mt-3 rounded-xl border border-emerald-200 bg-emerald-50 p-3 text-xs text-emerald-900 dark:border-emerald-800 dark:bg-emerald-900/20 dark:text-emerald-300">
            @if (deltaMonto() > 0) {
              <span>
                <strong>Ajuste de Saldo:</strong> Se incrementará el saldo a favor del socio en
                <strong class="font-bold">+S/ {{ deltaMonto() | number:'1.2-2' }}</strong>.
              </span>
            } @else {
              <span>
                <strong>Ajuste de Saldo:</strong> Se deducirá del saldo a favor disponible del socio
                <strong class="font-bold">-S/ {{ absDelta() | number:'1.2-2' }}</strong>. El saldo resultante será de S/ {{ nuevoSaldoCalculado() | number:'1.2-2' }}.
              </span>
            }
          </div>
        }

        <!-- Formulario -->
        <form class="mt-4 space-y-4">

          <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">

            <!-- Fecha de Recaudación -->
            <div>
              <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
                Fecha Efectiva de Recaudación <span class="text-red-500">*</span>
              </label>
              <input
                type="date"
                [ngModel]="fecha()"
                (ngModelChange)="fecha.set($event)"
                name="fecha"
                class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-sm text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
              />
              <p class="text-2xs text-gray-400 mt-1">Fecha contable que impacta el arqueo de caja.</p>
            </div>

            <!-- Monto -->
            <div>
              <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
                Monto Recaudado (S/) <span class="text-red-500">*</span>
              </label>
              <input
                type="number"
                step="0.50"
                min="0.50"
                [ngModel]="monto()"
                (ngModelChange)="monto.set(+$event)"
                name="monto"
                class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-sm font-semibold text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
              />
              <p class="text-2xs text-gray-400 mt-1">Original: S/ {{ recaudacion().monto | number:'1.2-2' }}</p>
            </div>

          </div>

          <!-- Motivo Obligatorio -->
          <div>
            <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
              Motivo o Justificación de la Modificación <span class="text-red-500">*</span>
            </label>
            <textarea
              rows="3"
              [ngModel]="motivo()"
              (ngModelChange)="motivo.set($event)"
              name="motivo"
              placeholder="Describa el motivo de la corrección (ej. Fecha errónea al digitar el turno anterior / Corrección de monto por comprobante físico)..."
              class="w-full rounded-xl border border-gray-300 bg-white p-3 text-sm text-gray-900 placeholder:text-gray-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
            ></textarea>
            @if (motivo().trim().length > 0 && motivo().trim().length < 5) {
              <p class="mt-1 text-xs text-red-500">El motivo debe tener al menos 5 caracteres.</p>
            } @else if (motivo().trim().length === 0) {
              <p class="mt-1 text-xs text-gray-400">Requerido para auditoría (mínimo 5 caracteres).</p>
            }
          </div>

        </form>

        <!-- Pie de Botones -->
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
            (click)="submit()"
            [disabled]="guardando() || !formularioValido()"
            class="inline-flex items-center gap-2 rounded-xl bg-brand-500 px-5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-brand-600 focus:ring-2 focus:ring-brand-500/30 disabled:opacity-50 disabled:cursor-not-allowed transition">
            @if (guardando()) {
              <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Guardando...
            } @else {
              <span>Guardar Corrección</span>
            }
          </button>
        </div>

      </div>
    </div>
  `
})
export class TarjetaFormModalComponent {
  recaudacion = input.required<RecaudacionTarjetaItem>();
  save = output<EditarRecaudacionParams>();
  cancel = output<void>();

  fecha = signal('');
  monto = signal(0);
  motivo = signal('');
  guardando = signal(false);

  constructor() {
    effect(() => {
      const item = this.recaudacion();
      if (item) {
        this.fecha.set(toYMD(item.fecha));
        this.monto.set(item.monto);
        this.motivo.set('');
      }
    });
  }

  readonly deltaMonto = computed(() => {
    const act = this.monto();
    const orig = this.recaudacion().monto;
    return Math.round((act - orig) * 100) / 100;
  });

  readonly absDelta = computed(() => Math.abs(this.deltaMonto()));

  readonly nuevoSaldoCalculado = computed(() => {
    const s = this.recaudacion().socio_saldo_a_favor;
    return Math.round((s + this.deltaMonto()) * 100) / 100;
  });

  readonly excedeSaldoDisponible = computed(() => {
    const delta = this.deltaMonto();
    if (delta >= 0) return false;
    return (this.recaudacion().socio_saldo_a_favor + delta) < 0;
  });

  readonly esFechaPasada = computed(() => {
    const fSel = this.fecha();
    if (!fSel) return false;
    const fOrig = toYMD(this.recaudacion().fecha);
    return fSel !== fOrig;
  });

  readonly formularioValido = computed(() => {
    if (this.monto() <= 0) return false;
    if (!this.fecha()) return false;
    if (this.motivo().trim().length < 5) return false;
    if (this.excedeSaldoDisponible()) return false;

    // Verificar si realmente hubo algún cambio
    const fechaCambio = this.fecha() !== toYMD(this.recaudacion().fecha);
    const montoCambio = Math.abs(this.monto() - this.recaudacion().monto) > 0.001;
    return fechaCambio || montoCambio;
  });

  submit(): void {
    if (!this.formularioValido()) return;

    this.guardando.set(true);

    // Convertir fecha YYYY-MM-DD a timestamptz local a mediodía para evitar cualquier corrimiento UTC
    const [y, m, d] = this.fecha().split('-').map(Number);
    // 12:00 Lima (UTC-5) = 17:00 UTC
    const fechaIso = new Date(Date.UTC(y, m - 1, d, 17, 0, 0)).toISOString();

    this.save.emit({
      id: this.recaudacion().id,
      fecha: fechaIso,
      monto: this.monto(),
      motivo: this.motivo().trim(),
      updated_at: this.recaudacion().updated_at,
    });
  }
}
