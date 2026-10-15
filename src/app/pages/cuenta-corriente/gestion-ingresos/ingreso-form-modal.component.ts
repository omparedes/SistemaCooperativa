import { Component, computed, effect, input, OnInit, output, signal } from '@angular/core';
import { DatePipe, DecimalPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  ConceptoSimple,
  EditarIngresoParams,
  IngresoInternoItem,
  MetodoPagoIngreso,
} from '../../../core/services/gestion-ingresos.service';

function toDatetimeLocal(iso: string): string {
  const d = new Date(iso);
  const pad = (n: number) => String(n).padStart(2, '0');
  const y = d.getFullYear();
  const m = pad(d.getMonth() + 1);
  const dd = pad(d.getDate());
  const h = pad(d.getHours());
  const min = pad(d.getMinutes());
  return `${y}-${m}-${dd}T${h}:${min}`;
}

@Component({
  selector: 'app-ingreso-form-modal',
  standalone: true,
  imports: [FormsModule, DatePipe, DecimalPipe],
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
              <span class="inline-flex items-center rounded-full bg-amber-100 px-2.5 py-0.5 text-xs font-semibold text-amber-700 dark:bg-amber-900/30 dark:text-amber-400">
                Edición Administrativa
              </span>
            </div>
            <h3 class="mt-1 text-lg font-bold text-gray-900 dark:text-white">
              Corregir Datos del Ingreso
            </h3>
            <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
              Fecha de creación técnica original (inmutable):
              <strong class="font-mono">{{ ingreso().created_at | date:'dd/MM/yyyy HH:mm:ss':'America/Lima' }}</strong>
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

        <!-- Advertencia de Fecha Pasada -->
        @if (esFechaPasada()) {
          <div class="mt-4 rounded-xl border border-amber-300 bg-amber-50 p-3.5 text-xs text-amber-900 dark:border-amber-800 dark:bg-amber-900/20 dark:text-amber-300">
            <div class="flex items-start gap-2.5">
              <svg class="h-4 w-4 shrink-0 mt-0.5 text-amber-600 dark:text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
              </svg>
              <div>
                <strong>Atención Contable:</strong> La fecha operativa seleccionada corresponde a un día anterior.
                Esta modificación alterará el saldo contable histórico y el arqueo diario de dicha fecha.
              </div>
            </div>
          </div>
        }

        <!-- Formulario -->
        <form class="mt-4 space-y-4">

          <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">

            <!-- Concepto -->
            <div>
              <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
                Concepto de Ingreso <span class="text-red-500">*</span>
              </label>
              <select
                [ngModel]="conceptoId()"
                (ngModelChange)="conceptoId.set(+$event)"
                name="conceptoId"
                class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-sm text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white">
                @for (c of conceptos(); track c.id) {
                  <option [value]="c.id">
                    {{ c.nombre }} ({{ c.grupo === 'INQUILINOS' ? 'Inquilinos' : 'Otros' }})
                  </option>
                }
              </select>
            </div>

            <!-- Monto -->
            <div>
              <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
                Monto en Soles (S/) <span class="text-red-500">*</span>
              </label>
              <div class="relative">
                <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-sm font-bold text-gray-400">
                  S/
                </span>
                <input
                  type="number"
                  step="0.10"
                  min="0.10"
                  [ngModel]="monto()"
                  (ngModelChange)="monto.set(+$event)"
                  name="monto"
                  class="w-full rounded-xl border border-gray-300 bg-white pl-8 pr-3 py-2 text-sm font-semibold text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white tabular-nums"
                  placeholder="0.00"
                />
              </div>
              @if (monto() <= 0) {
                <p class="mt-1 text-xs text-red-500">El monto debe ser mayor a 0.</p>
              }
            </div>

            <!-- Método de Pago -->
            <div>
              <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1.5">
                Método de Pago <span class="text-red-500">*</span>
              </label>
              <div class="grid grid-cols-2 gap-2">
                <button
                  type="button"
                  (click)="metodoPago.set('Efectivo')"
                  [class]="metodoPago() === 'Efectivo'
                    ? 'border-emerald-500 bg-emerald-50 text-emerald-800 dark:bg-emerald-950/40 dark:text-emerald-300 dark:border-emerald-700'
                    : 'border-gray-200 bg-white text-gray-600 hover:bg-gray-50 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400'"
                  class="flex items-center justify-center gap-1.5 rounded-xl border py-2 text-xs font-semibold transition">
                  <span class="h-2 w-2 rounded-full" [class]="metodoPago() === 'Efectivo' ? 'bg-emerald-500' : 'bg-gray-300'"></span>
                  Efectivo
                </button>
                <button
                  type="button"
                  (click)="metodoPago.set('Transferencia')"
                  [class]="metodoPago() === 'Transferencia'
                    ? 'border-blue-500 bg-blue-50 text-blue-800 dark:bg-blue-950/40 dark:text-blue-300 dark:border-blue-700'
                    : 'border-gray-200 bg-white text-gray-600 hover:bg-gray-50 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400'"
                  class="flex items-center justify-center gap-1.5 rounded-xl border py-2 text-xs font-semibold transition">
                  <span class="h-2 w-2 rounded-full" [class]="metodoPago() === 'Transferencia' ? 'bg-blue-500' : 'bg-gray-300'"></span>
                  Transferencia
                </button>
              </div>
            </div>

            <!-- Fecha Operativa (fecha_ingreso) -->
            <div>
              <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
                Fecha Operativa del Ingreso <span class="text-red-500">*</span>
              </label>
              <input
                type="datetime-local"
                [ngModel]="fechaIngresoStr()"
                (ngModelChange)="fechaIngresoStr.set($event)"
                name="fechaIngresoStr"
                class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-sm text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
              />
            </div>

          </div>

          <!-- Observación -->
          <div>
            <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
              Observación / Referencia
            </label>
            <input
              type="text"
              [ngModel]="observacion()"
              (ngModelChange)="observacion.set($event)"
              name="observacion"
              placeholder="Ej. Espacio temporal feria navideña..."
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-sm text-gray-900 placeholder:text-gray-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
            />
          </div>

          <!-- Comparativa Antes vs Después (si hay cambios) -->
          @if (hayCambios()) {
            <div class="rounded-xl border border-brand-200 bg-brand-50/50 p-3.5 dark:border-brand-900/50 dark:bg-brand-950/20">
              <p class="text-xs font-bold text-brand-800 dark:text-brand-300 uppercase tracking-wider mb-2">
                Resumen de Cambios a Aplicar
              </p>
              <div class="space-y-1 text-xs">
                @if (monto() !== ingreso().monto) {
                  <div class="flex items-center justify-between">
                    <span class="text-gray-500 dark:text-gray-400">Monto:</span>
                    <span class="font-mono">
                      <s class="text-red-500">S/ {{ ingreso().monto | number:'1.2-2' }}</s>
                      →
                      <strong class="text-emerald-600 dark:text-emerald-400">S/ {{ monto() | number:'1.2-2' }}</strong>
                    </span>
                  </div>
                }
                @if (metodoPago() !== ingreso().metodo_pago) {
                  <div class="flex items-center justify-between">
                    <span class="text-gray-500 dark:text-gray-400">Método de pago:</span>
                    <span>
                      <s class="text-red-500">{{ ingreso().metodo_pago }}</s>
                      →
                      <strong class="text-brand-600 dark:text-brand-400">{{ metodoPago() }}</strong>
                    </span>
                  </div>
                }
                @if (conceptoId() !== ingreso().concepto_id) {
                  <div class="flex items-center justify-between">
                    <span class="text-gray-500 dark:text-gray-400">Concepto:</span>
                    <span>
                      <s class="text-red-500">{{ ingreso().concepto_nombre }}</s>
                      →
                      <strong class="text-brand-600 dark:text-brand-400">{{ nombreConceptoSeleccionado() }}</strong>
                    </span>
                  </div>
                }
                @if (fechaIngresoStr() !== fechaOriginalStr()) {
                  <div class="flex items-center justify-between">
                    <span class="text-gray-500 dark:text-gray-400">Fecha operativa:</span>
                    <span>
                      <s class="text-red-500 font-mono">{{ fechaOriginalStr() }}</s>
                      →
                      <strong class="text-brand-600 dark:text-brand-400 font-mono">{{ fechaIngresoStr() }}</strong>
                    </span>
                  </div>
                }
              </div>
            </div>
          }

          <!-- Justificación Obligatoria para Auditoría -->
          <div class="border-t border-gray-100 pt-3 dark:border-gray-700">
            <label class="block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1">
              Justificación de la corrección <span class="text-red-500">*</span>
            </label>
            <textarea
              rows="2"
              [ngModel]="motivo()"
              (ngModelChange)="motivo.set($event)"
              name="motivo"
              placeholder="Explique el motivo del cambio (ej. Corrección por error de digitación en método de pago)..."
              class="w-full rounded-xl border border-gray-300 bg-white p-2.5 text-sm text-gray-900 placeholder:text-gray-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
            ></textarea>
            @if (motivo().trim().length > 0 && motivo().trim().length < 5) {
              <p class="mt-1 text-xs text-red-500">La justificación debe tener al menos 5 caracteres.</p>
            } @else if (motivo().trim().length === 0) {
              <p class="mt-1 text-xs text-gray-400">Obligatorio: este motivo quedará registrado en el historial de auditoría.</p>
            }
          </div>

        </form>

        <!-- Pie de botones -->
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
            (click)="guardar()"
            [disabled]="guardando() || !formularioValido()"
            class="inline-flex items-center gap-2 rounded-xl bg-brand-600 px-5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-brand-700 focus:ring-2 focus:ring-brand-500/30 disabled:opacity-50 disabled:cursor-not-allowed transition">
            @if (guardando()) {
              <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Guardando cambios...
            } @else {
              Guardar Corrección
            }
          </button>
        </div>

      </div>
    </div>
  `
})
export class IngresoFormModalComponent implements OnInit {
  ingreso = input.required<IngresoInternoItem>();
  conceptos = input.required<ConceptoSimple[]>();
  cancel = output<void>();
  save = output<EditarIngresoParams>();

  monto = signal<number>(0);
  metodoPago = signal<MetodoPagoIngreso>('Efectivo');
  conceptoId = signal<number>(0);
  fechaIngresoStr = signal<string>('');
  observacion = signal<string>('');
  motivo = signal<string>('');
  guardando = signal<boolean>(false);

  fechaOriginalStr = signal<string>('');

  ngOnInit() {
    const item = this.ingreso();
    this.monto.set(item.monto);
    this.metodoPago.set(item.metodo_pago);
    this.conceptoId.set(item.concepto_id);
    this.observacion.set(item.observacion || '');

    const fechaLocal = toDatetimeLocal(item.fecha_ingreso);
    this.fechaIngresoStr.set(fechaLocal);
    this.fechaOriginalStr.set(fechaLocal);
  }

  nombreConceptoSeleccionado = computed(() => {
    const c = this.conceptos().find(x => x.id === this.conceptoId());
    return c?.nombre || 'Seleccionado';
  });

  hayCambios = computed(() => {
    const orig = this.ingreso();
    return (
      this.monto() !== orig.monto ||
      this.metodoPago() !== orig.metodo_pago ||
      this.conceptoId() !== orig.concepto_id ||
      this.observacion().trim() !== (orig.observacion || '').trim() ||
      this.fechaIngresoStr() !== this.fechaOriginalStr()
    );
  });

  esFechaPasada = computed(() => {
    const val = this.fechaIngresoStr();
    if (!val) return false;
    const fechaOp = new Date(val);
    const hoy = new Date();
    return (
      fechaOp.getFullYear() < hoy.getFullYear() ||
      (fechaOp.getFullYear() === hoy.getFullYear() &&
        (fechaOp.getMonth() < hoy.getMonth() ||
          (fechaOp.getMonth() === hoy.getMonth() && fechaOp.getDate() < hoy.getDate())))
    );
  });

  formularioValido = computed(() => {
    return (
      this.hayCambios() &&
      this.monto() > 0 &&
      this.conceptoId() > 0 &&
      this.fechaIngresoStr().trim().length > 0 &&
      this.motivo().trim().length >= 5
    );
  });

  guardar() {
    if (!this.formularioValido()) return;

    // Convertir la fecha local seleccionada a ISO con offset de Lima -05:00
    const [datePart, timePart] = this.fechaIngresoStr().split('T');
    const isoLima = `${datePart}T${timePart}:00-05:00`;

    this.save.emit({
      id: this.ingreso().id,
      fecha_ingreso: isoLima,
      monto: Number(this.monto().toFixed(2)),
      metodo_pago: this.metodoPago(),
      concepto_id: this.conceptoId(),
      observacion: this.observacion().trim() || null,
      motivo: this.motivo().trim(),
      updated_at: this.ingreso().updated_at,
    });
  }
}
