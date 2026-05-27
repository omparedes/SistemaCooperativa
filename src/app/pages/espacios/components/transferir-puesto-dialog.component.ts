import {
  Component, computed, inject, input, OnInit, output, signal,
} from '@angular/core';
import { NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { PuestosService } from '../../../core/services/puestos.service';
import { EspaciosService, TransferirPuestoParams } from '../espacios.service';
import { SociosService } from '../../../core/services/socios.service';

interface SocioOpcion {
  id: number;
  label: string;
}

@Component({
  selector: 'app-transferir-puesto-dialog',
  standalone: true,
  imports: [NgClass, FormsModule],
  template: `
<!-- Backdrop -->
<div class="fixed inset-0 bg-black/40 dark:bg-black/60 z-50 flex items-center justify-center p-4">
  <div class="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md border border-gray-200 dark:border-gray-700">

    <!-- Header -->
    <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
      <h3 class="text-lg font-bold text-gray-900 dark:text-white">Transferir Puesto</h3>
      <p class="text-sm text-gray-500 dark:text-gray-400 mt-0.5">
        Puesto <span class="font-mono font-semibold">{{ codigoPuesto() }}</span>
      </p>
    </div>

    <!-- Body -->
    <div class="px-6 py-5 space-y-4">

      @if (errorMsg()) {
        <div class="p-3 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-300 text-sm">
          {{ errorMsg() }}
        </div>
      }

      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          Nuevo titular *
        </label>
        @if (cargandoSocios()) {
          <div class="text-sm text-gray-400 dark:text-gray-500">Cargando socios…</div>
        } @else {
          <select
            [(ngModel)]="nuevoSocioId"
            class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
            <option [ngValue]="null">— Seleccionar socio —</option>
            @for (s of socios(); track s.id) {
              <option [ngValue]="s.id">{{ s.label }}</option>
            }
          </select>
        }
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          Motivo de transferencia *
        </label>
        <textarea
          [(ngModel)]="motivo"
          rows="3"
          placeholder="Ej: Venta del derecho de puesto, fallecimiento del titular, etc."
          class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500 resize-none">
        </textarea>
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          Fecha efectiva
        </label>
        <input
          type="date"
          [(ngModel)]="fechaEfectiva"
          class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
      </div>

    </div>

    <!-- Footer -->
    <div class="px-6 py-4 border-t border-gray-200 dark:border-gray-700 flex gap-3 justify-end">
      <button
        (click)="cancelar.emit()"
        class="px-4 py-2 rounded-xl border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-800 transition">
        Cancelar
      </button>
      <button
        (click)="confirmar()"
        [disabled]="!puedeConfirmar() || guardando()"
        class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-semibold hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed transition">
        @if (guardando()) {
          <span class="inline-flex items-center gap-2">
            <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/>
            </svg>
            Transfiriendo…
          </span>
        } @else {
          Confirmar Transferencia
        }
      </button>
    </div>
  </div>
</div>
  `,
})
export class TransferirPuestoDialogComponent implements OnInit {
  private readonly espaciosSvc = inject(EspaciosService);
  private readonly puestosSvc  = inject(PuestosService);
  private readonly sociosSvc   = inject(SociosService);

  readonly puestoId    = input.required<number>();
  readonly codigoPuesto = input.required<string>();

  readonly cancelar    = output<void>();
  readonly transferido = output<{ nuevoSocioId: number; deudas: boolean }>();

  protected nuevoSocioId:  number | null = null;
  protected motivo         = '';
  protected fechaEfectiva  = new Date().toISOString().slice(0, 10);

  protected readonly socios         = signal<SocioOpcion[]>([]);
  protected readonly cargandoSocios = signal(false);
  protected readonly guardando      = signal(false);
  protected readonly errorMsg       = signal<string | null>(null);

  protected readonly puedeConfirmar = computed(
    () => this.nuevoSocioId !== null && this.motivo.trim().length > 5,
  );

  ngOnInit(): void {
    void this.cargarSocios();
  }

  private async cargarSocios(): Promise<void> {
    this.cargandoSocios.set(true);
    try {
      await this.sociosSvc.cargar();
      const todos = this.sociosSvc.socios();
      
      this.socios.set(
        todos
          .filter(s => s.estado === 'Activo' && s.habilitado)
          .map(s => ({
            id: s.id,
            label: `${s.apellidos} ${s.nombres} - DNI: ${s.dni}`,
          }))
      );
    } catch {
      this.errorMsg.set('No se pudo cargar la lista de socios.');
    } finally {
      this.cargandoSocios.set(false);
    }
  }

  protected async confirmar(): Promise<void> {
    if (!this.puedeConfirmar()) return;
    this.guardando.set(true);
    this.errorMsg.set(null);
    try {
      const params: TransferirPuestoParams = {
        puestoId:       this.puestoId(),
        nuevoSocioId:   this.nuevoSocioId!,
        motivo:         this.motivo.trim(),
        fechaEfectiva:  this.fechaEfectiva,
      };
      const result = await this.espaciosSvc.transferirPuesto(params);
      this.transferido.emit({
        nuevoSocioId: this.nuevoSocioId!,
        deudas:       result.tiene_deudas_pendientes,
      });
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al transferir puesto.');
    } finally {
      this.guardando.set(false);
    }
  }
}
