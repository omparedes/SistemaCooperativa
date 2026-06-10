import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DecimalPipe } from '@angular/common';
import { FacturacionService } from '../../core/services/facturacion.service';

const MESES = ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
               'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

interface Resumen {
  cantidad: number;
  total: number;
}

interface ResultadoGeneracion {
  almacenes_procesados: number;
  cargos_generados: number;
  total_monto: number;
}

@Component({
  selector: 'app-facturacion-almacenes',
  standalone: true,
  imports: [FormsModule, DecimalPipe],
  template: `
    <div class="mx-auto max-w-2xl p-4 md:p-6 2xl:p-8">

      <!-- Encabezado -->
      <div class="mb-8">
        <div class="flex items-center gap-3 mb-2">
          <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-amber-100 dark:bg-amber-900/40">
            <svg class="h-5 w-5 text-amber-600 dark:text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
              <polyline stroke-linecap="round" stroke-linejoin="round" points="9 22 9 12 15 12 15 22"/>
            </svg>
          </div>
          <div>
            <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Alquiler de Almacenes</h2>
            <p class="text-sm text-gray-500 dark:text-gray-400">Generación masiva mensual de cobros por arriendo de depósitos y almacenes.</p>
          </div>
        </div>
      </div>

      <!-- Error -->
      @if (error()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- Resultado -->
      @if (resultado()) {
        <div class="mb-6 rounded-2xl border border-green-200 bg-green-50 p-5 dark:border-green-800 dark:bg-green-900/20">
          <div class="flex items-center gap-3 mb-4">
            <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-green-100 dark:bg-green-900/40">
              <svg class="h-5 w-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div>
              <p class="font-semibold text-green-800 dark:text-green-200">¡Proceso completado!</p>
              <p class="text-xs text-green-600 dark:text-green-400">
                Período: {{ MESES[mes - 1] }} {{ anio }}
              </p>
            </div>
          </div>
          <div class="grid grid-cols-3 gap-3">
            <div class="rounded-lg bg-white px-3 py-2.5 dark:bg-gray-800">
              <p class="text-xs text-gray-400 dark:text-gray-500">Almacenes activos</p>
              <p class="mt-0.5 text-2xl font-bold text-gray-900 dark:text-white">{{ resultado()!.almacenes_procesados }}</p>
            </div>
            <div class="rounded-lg bg-white px-3 py-2.5 dark:bg-gray-800">
              <p class="text-xs text-gray-400 dark:text-gray-500">Cargos generados</p>
              <p class="mt-0.5 text-2xl font-bold text-amber-600 dark:text-amber-400">{{ resultado()!.cargos_generados }}</p>
            </div>
            <div class="rounded-lg bg-white px-3 py-2.5 dark:bg-gray-800">
              <p class="text-xs text-gray-400 dark:text-gray-500">Monto total</p>
              <p class="mt-0.5 text-lg font-bold text-green-700 dark:text-green-300">S/ {{ resultado()!.total_monto | number:'1.2-2' }}</p>
            </div>
          </div>
          @if (resultado()!.almacenes_procesados > resultado()!.cargos_generados) {
            <p class="mt-3 text-xs text-green-600 dark:text-green-400">
              {{ resultado()!.almacenes_procesados - resultado()!.cargos_generados }} cargo(s) ya existían y fueron omitidos (idempotente).
            </p>
          }
        </div>
      }

      <!-- Formulario principal -->
      <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark space-y-6">

        <!-- Período -->
        <div>
          <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">
            1. Selecciona el período
          </h3>
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">Año</label>
              <input
                type="number"
                [(ngModel)]="anio"
                (ngModelChange)="onPeriodoChange()"
                min="2020" max="2100"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-amber-500"
              />
            </div>
            <div>
              <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">Mes</label>
              <select
                [(ngModel)]="mes"
                (ngModelChange)="onPeriodoChange()"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-amber-500">
                @for (m of MESES; track $index) {
                  <option [value]="$index + 1">{{ m }}</option>
                }
              </select>
            </div>
          </div>
        </div>

        <!-- Vista previa -->
        <div>
          <h3 class="mb-3 text-base font-semibold text-gray-800 dark:text-white">
            2. Vista previa de almacenes elegibles
          </h3>

          @if (cargandoResumen()) {
            <div class="flex items-center gap-2 text-sm text-gray-400 dark:text-gray-500 py-3">
              <svg class="h-4 w-4 animate-spin" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
              </svg>
              Calculando...
            </div>
          } @else if (resumen()) {
            <div class="rounded-xl border border-amber-200 dark:border-amber-800 bg-amber-50 dark:bg-amber-900/20 p-4 flex items-center justify-between">
              <div class="flex items-center gap-3">
                <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-amber-100 dark:bg-amber-900/40">
                  <svg class="h-4 w-4 text-amber-600 dark:text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                  </svg>
                </div>
                <div>
                  <p class="text-sm font-semibold text-amber-900 dark:text-amber-200">
                    {{ resumen()!.cantidad }} almacén(es) con ocupante activo
                  </p>
                  <p class="text-xs text-amber-700 dark:text-amber-400">listos para facturar este período</p>
                </div>
              </div>
              <div class="text-right">
                <p class="text-xs text-amber-600 dark:text-amber-400">Monto proyectado</p>
                <p class="text-xl font-bold text-amber-900 dark:text-amber-200">S/ {{ resumen()!.total | number:'1.2-2' }}</p>
              </div>
            </div>
            @if (resumen()!.cantidad === 0) {
              <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">
                No hay almacenes con ocupante activo para facturar.
              </p>
            }
          }
        </div>

        <!-- Acción -->
        <div>
          <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">
            3. Generar cobros
          </h3>
          <button
            (click)="generar()"
            [disabled]="generando() || (resumen()?.cantidad === 0)"
            class="w-full flex items-center justify-center gap-2.5 rounded-xl px-5 py-3 text-sm font-semibold text-white shadow-sm transition
              bg-amber-500 hover:bg-amber-600 active:bg-amber-700
              dark:bg-amber-600 dark:hover:bg-amber-500
              disabled:opacity-50 disabled:cursor-not-allowed">
            @if (generando()) {
              <svg class="h-4 w-4 animate-spin" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
              </svg>
              Procesando...
            } @else {
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
              </svg>
              Generar cobros de alquiler — {{ MESES[mes - 1] }} {{ anio }}
            }
          </button>
          <p class="mt-2 text-xs text-gray-400 dark:text-gray-500 text-center">
            La operación es idempotente: si ya se generaron cobros para este período, no se duplicarán.
          </p>
        </div>

      </div>
    </div>
  `,
})
export class FacturacionAlmacenesComponent implements OnInit {
  private readonly facturacionSvc = inject(FacturacionService);

  protected readonly MESES = MESES;

  protected anio = new Date().getFullYear();
  protected mes  = new Date().getMonth() + 1;

  protected readonly resumen       = signal<Resumen | null>(null);
  protected readonly cargandoResumen = signal(false);
  protected readonly generando     = signal(false);
  protected readonly error         = signal<string | null>(null);
  protected readonly resultado     = signal<ResultadoGeneracion | null>(null);

  ngOnInit(): void {
    void this.cargarResumen();
  }

  protected onPeriodoChange(): void {
    this.resultado.set(null);
  }

  protected async cargarResumen(): Promise<void> {
    this.cargandoResumen.set(true);
    this.error.set(null);
    try {
      const r = await this.facturacionSvc.cargarResumenAlmacenesElegibles();
      this.resumen.set(r);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar resumen de almacenes.');
    } finally {
      this.cargandoResumen.set(false);
    }
  }

  protected async generar(): Promise<void> {
    if (this.generando()) return;
    this.generando.set(true);
    this.error.set(null);
    this.resultado.set(null);
    try {
      const r = await this.facturacionSvc.generarAlquilerAlmacenesMes({
        anio: this.anio,
        mes:  this.mes,
      });
      this.resultado.set({
        almacenes_procesados: r.almacenes_procesados,
        cargos_generados:     r.cargos_generados,
        total_monto:          r.total_monto,
      });
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al generar los cobros de alquiler.');
    } finally {
      this.generando.set(false);
    }
  }
}
