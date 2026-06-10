import {
  Component, computed, inject, input, OnInit, output, signal,
} from '@angular/core';
import { NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { EspaciosService, AsignarAlmacenParams } from '../espacios.service';
import { SociosService } from '../../../core/services/socios.service';
import { InquilinosService } from '../../../core/services/inquilinos.service';
import { TipoOcupante } from '../espacios.model';

interface PersonaOpcion {
  id: number;
  label: string;
}

@Component({
  selector: 'app-asignar-almacen-dialog',
  standalone: true,
  imports: [NgClass, FormsModule],
  template: `
<!-- Backdrop -->
<div class="fixed inset-0 bg-black/40 dark:bg-black/60 z-50 flex items-center justify-center p-4">
  <div class="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md border border-gray-200 dark:border-gray-700">

    <!-- Header -->
    <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
      <h3 class="text-lg font-bold text-gray-900 dark:text-white">Asignar Almacén</h3>
      <p class="text-sm text-gray-500 dark:text-gray-400 mt-0.5">
        Almacén <span class="font-mono font-semibold">{{ codigoPuesto() }}</span>
      </p>
    </div>

    <!-- Body -->
    <div class="px-6 py-5 space-y-4">

      @if (errorMsg()) {
        <div class="p-3 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-300 text-sm">
          {{ errorMsg() }}
        </div>
      }

      <!-- Tipo de Ocupante -->
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          Tipo de ocupante *
        </label>
        <select
          [(ngModel)]="tipoOcupante"
          (change)="onTipoOcupanteChange()"
          class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
          <option value="Socio">Socio</option>
          <option value="Inquilino">Inquilino</option>
          <option value="Tercero">Tercero (Externo)</option>
        </select>
      </div>

      <!-- Ocupante (Socio o Inquilino/Tercero) -->
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          Seleccionar Persona *
        </label>
        @if (cargandoPersonas()) {
          <div class="text-sm text-gray-400 dark:text-gray-500">Cargando lista…</div>
        } @else {
          <select
            [(ngModel)]="personaSeleccionadaId"
            class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
            <option [ngValue]="null">— Seleccionar ocupante —</option>
            @for (p of personas(); track p.id) {
              <option [ngValue]="p.id">{{ p.label }}</option>
            }
          </select>
        }
      </div>

      <!-- Costo Mensual de Alquiler -->
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          Costo mensual de alquiler (S/) *
        </label>
        <input
          type="number"
          min="0"
          step="0.01"
          [(ngModel)]="costoAlquiler"
          class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500 tabular-nums" />
      </div>

      <!-- Fecha de Inicio -->
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          Fecha de asignación (Inicio)
        </label>
        <input
          type="date"
          [(ngModel)]="fechaInicio"
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
            Asignando…
          </span>
        } @else {
          Asignar Almacén
        }
      </button>
    </div>
  </div>
</div>
  `,
})
export class AsignarAlmacenDialogComponent implements OnInit {
  private readonly espaciosSvc = inject(EspaciosService);
  private readonly sociosSvc   = inject(SociosService);
  private readonly inquilinosSvc = inject(InquilinosService);

  readonly puestoId        = input.required<number>();
  readonly codigoPuesto    = input.required<string>();
  readonly costoAlquilerBase = input.required<number>();

  readonly cancelar = output<void>();
  readonly asignado = output<void>();

  protected tipoOcupante: TipoOcupante = 'Socio';
  protected personaSeleccionadaId: number | null = null;
  protected costoAlquiler = 0;
  protected fechaInicio = new Date().toISOString().slice(0, 10);

  protected readonly personas         = signal<PersonaOpcion[]>([]);
  protected readonly cargandoPersonas = signal(false);
  protected readonly guardando        = signal(false);
  protected readonly errorMsg         = signal<string | null>(null);

  protected readonly puedeConfirmar = computed(
    () => this.personaSeleccionadaId !== null && this.costoAlquiler >= 0,
  );

  ngOnInit(): void {
    this.costoAlquiler = this.costoAlquilerBase();
    void this.cargarPersonas();
  }

  protected async onTipoOcupanteChange(): Promise<void> {
    this.personaSeleccionadaId = null;
    void this.cargarPersonas();
  }

  private async cargarPersonas(): Promise<void> {
    this.cargandoPersonas.set(true);
    this.errorMsg.set(null);
    try {
      if (this.tipoOcupante === 'Socio') {
        await this.sociosSvc.cargar();
        this.personas.set(
          this.sociosSvc.socios()
            .filter(s => s.estado === 'Activo' && s.habilitado)
            .map(s => ({
              id: s.id,
              label: `${s.apellidos} ${s.nombres} - DNI: ${s.dni}`,
            }))
        );
      } else {
        // Cargar inquilinos/terceros
        await this.inquilinosSvc.cargar();
        this.personas.set(
          this.inquilinosSvc.inquilinos()
            .map(i => ({
              id: i.id,
              label: `${i.apellidos} ${i.nombres} - DNI: ${i.dni}`,
            }))
        );
      }
    } catch {
      this.errorMsg.set('No se pudo cargar la lista de personas.');
    } finally {
      this.cargandoPersonas.set(false);
    }
  }

  protected async confirmar(): Promise<void> {
    if (!this.puedeConfirmar()) return;
    this.guardando.set(true);
    this.errorMsg.set(null);
    try {
      const params: AsignarAlmacenParams = {
        puestoId:      this.puestoId(),
        tipoOcupante:  this.tipoOcupante,
        fechaInicio:   this.fechaInicio,
        costoAlquiler: this.costoAlquiler,
      };

      if (this.tipoOcupante === 'Socio') {
        params.socioId = this.personaSeleccionadaId!;
      } else {
        params.inquilinoId = this.personaSeleccionadaId!;
      }

      await this.espaciosSvc.asignarAlmacen(params);
      this.asignado.emit();
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al asignar almacén.');
    } finally {
      this.guardando.set(false);
    }
  }
}
