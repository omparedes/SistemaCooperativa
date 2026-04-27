import { Component, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import {
  FacturacionService,
  ResultadoGeneracionFija,
} from '../../core/services/facturacion.service';

const MESES = ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
               'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

@Component({
  selector: 'app-facturacion-fija',
  standalone: true,
  imports: [FormsModule],
  template: `
    <div class="mx-auto max-w-2xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-8">
        <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Generación de Cargos Fijos</h2>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          Genera masivamente los cargos fijos del mes para todos los puestos activos.
          La operación es idempotente: puestos que ya tengan el cargo del período serán omitidos.
        </p>
      </div>

      <!-- ── Error ────────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Resultado ────────────────────────────────────────────────────── -->
      @if (resultado()) {
        <div class="mb-6 rounded-2xl border border-green-200 bg-green-50 p-5 dark:border-green-800 dark:bg-green-900/20">
          <div class="flex items-center gap-3 mb-3">
            <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-green-100 dark:bg-green-900/40">
              <svg class="h-5 w-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div>
              <p class="font-semibold text-green-800 dark:text-green-200">
                Cargos generados para {{ MESES[mes - 1] }} {{ anio }}
              </p>
              <p class="text-xs text-green-600 dark:text-green-400">
                {{ resultado()!.puestos_elegibles }} puestos elegibles
              </p>
            </div>
          </div>
          <div class="grid grid-cols-2 gap-3 sm:grid-cols-4">
            @for (item of resumenItems(); track item.label) {
              <div class="rounded-lg bg-white px-3 py-2.5 dark:bg-gray-800">
                <p class="text-xs text-gray-400 dark:text-gray-500">{{ item.label }}</p>
                <p class="mt-0.5 text-lg font-bold text-gray-900 dark:text-white">{{ item.value }}</p>
                <p class="text-xs text-gray-400">S/ {{ item.monto.toFixed(2) }} c/u</p>
              </div>
            }
          </div>
          <p class="mt-3 text-right text-sm font-semibold text-green-700 dark:text-green-300">
            Total de líneas insertadas: {{ resultado()!.total_insertados }}
          </p>
        </div>
      }

      <!-- ── Formulario ────────────────────────────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">

        <!-- Período -->
        <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">
          1. Selecciona el período
        </h3>
        <div class="mb-6 grid grid-cols-2 gap-4">
          <div>
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Año</label>
            <input type="number" [(ngModel)]="anio" min="2020" max="2100"
              class="h-11 w-full rounded-lg border border-gray-300 bg-gray-50 px-4 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"/>
          </div>
          <div>
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Mes</label>
            <select [(ngModel)]="mes"
              class="h-11 w-full rounded-lg border border-gray-300 bg-gray-50 px-4 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none">
              @for (m of mesesArr; track m.n) {
                <option [value]="m.n">{{ m.nombre }}</option>
              }
            </select>
          </div>
        </div>

        <!-- Montos por concepto -->
        <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">
          2. Define los montos (S/ por puesto)
        </h3>
        <div class="mb-6 space-y-4">

          @for (item of conceptosFijos; track item.campo) {
            <div class="flex items-center gap-4 rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 dark:border-gray-700 dark:bg-gray-800">
              <div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg"
                   [class]="item.color">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" [attr.d]="item.icon"/>
                </svg>
              </div>
              <div class="flex-1">
                <p class="text-sm font-medium text-gray-800 dark:text-white">{{ item.label }}</p>
                <p class="text-xs text-gray-400 dark:text-gray-500">{{ item.desc }}</p>
              </div>
              <div class="flex items-center gap-2">
                <span class="text-sm text-gray-500 dark:text-gray-400">S/</span>
                <input
                  type="number"
                  min="0.01"
                  step="0.01"
                  [(ngModel)]="item.monto"
                  [name]="item.campo"
                  class="h-9 w-24 rounded-lg border border-gray-300 bg-white px-3 text-sm text-right tabular-nums dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"
                />
              </div>
            </div>
          }
        </div>

        <!-- Botón principal -->
        <button
          (click)="generar()"
          [disabled]="generando() || !periodoValido()"
          class="flex w-full items-center justify-center gap-3 rounded-xl bg-brand-600 py-4 text-base font-semibold text-white shadow-md transition hover:bg-brand-700 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed">
          @if (generando()) {
            <svg class="h-5 w-5 animate-spin" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
            </svg>
            Generando cargos…
          } @else {
            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z"/>
            </svg>
            Generar Cargos Fijos — {{ MESES[mes - 1] }} {{ anio }}
          }
        </button>

        <p class="mt-3 text-center text-xs text-gray-400 dark:text-gray-500">
          Solo se generan cargos para puestos con titular socio Activo.
          Los que ya tienen cargo en el período serán omitidos (idempotente).
        </p>
      </div>

    </div>
  `,
})
export class FacturacionFijaComponent implements OnInit {
  private readonly svc = inject(FacturacionService);

  anio = new Date().getFullYear();
  mes  = new Date().getMonth() + 1;

  readonly generando = signal(false);
  readonly error     = signal<string | null>(null);
  readonly resultado = signal<ResultadoGeneracionFija | null>(null);

  protected readonly MESES    = MESES;
  protected readonly mesesArr = MESES.map((nombre, i) => ({ n: i + 1, nombre }));

  conceptosFijos = [
    {
      campo:  'monto_admin',
      label:  'Gastos Administrativos',
      desc:   'Cuota mensual para gastos de administración',
      monto:  8.00,
      color:  'bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400',
      icon:   'M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4',
    },
    {
      campo:  'monto_prevision',
      label:  'Previsión Social',
      desc:   'Aporte mensual al fondo de previsión social',
      monto:  5.00,
      color:  'bg-green-50 text-green-600 dark:bg-green-900/20 dark:text-green-400',
      icon:   'M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z',
    },
    {
      campo:  'monto_mantenimiento',
      label:  'Mantenimiento',
      desc:   'Mantenimiento de áreas comunes y servicios',
      monto:  10.00,
      color:  'bg-amber-50 text-amber-600 dark:bg-amber-900/20 dark:text-amber-400',
      icon:   'M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z',
    },
  ];

  readonly periodoValido = () =>
    this.anio >= 2020 &&
    this.anio <= 2100 &&
    this.mes >= 1 &&
    this.mes <= 12 &&
    this.conceptosFijos.every(c => c.monto > 0);

  readonly resumenItems = () => {
    const r = this.resultado();
    if (!r) return [];
    return [
      { label: 'G. Administrativos', value: r.gastos_administrativos, monto: this.conceptosFijos[0].monto },
      { label: 'Previsión Social',    value: r.prevision_social,       monto: this.conceptosFijos[1].monto },
      { label: 'Mantenimiento',       value: r.mantenimiento,          monto: this.conceptosFijos[2].monto },
      { label: 'Total insertados',    value: r.total_insertados,        monto: 0 },
    ];
  };

  ngOnInit(): void {
    // Pre-select current month
  }

  async generar(): Promise<void> {
    if (!this.periodoValido()) return;

    this.generando.set(true);
    this.error.set(null);
    this.resultado.set(null);
    try {
      const res = await this.svc.generarCargosFijosMes({
        anio:                this.anio,
        mes:                 this.mes,
        monto_admin:         this.conceptosFijos[0].monto,
        monto_prevision:     this.conceptosFijos[1].monto,
        monto_mantenimiento: this.conceptosFijos[2].monto,
      });
      this.resultado.set(res);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al generar cargos');
    } finally {
      this.generando.set(false);
    }
  }
}
