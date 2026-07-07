import { Component, inject, Input, OnInit, signal } from '@angular/core';
import { DatePipe, DecimalPipe, NgClass } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { BeneficiosService, BeneficioSocioAgrupado, TipoBeneficio } from '../../core/services/beneficios.service';

@Component({
  selector: 'app-beneficios-reporte',
  standalone: true,
  imports: [NgClass, DatePipe, DecimalPipe],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6">
      <!-- Encabezado -->
      <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">{{ titulo() }}</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Resumen anual de apoyos económicos entregados a los socios.
          </p>
        </div>

        <!-- Selector de Año -->
        <div class="flex items-center gap-2">
          <label class="text-sm font-medium text-gray-700 dark:text-gray-300">Año:</label>
          <select [value]="anio()" (change)="cambiarAnio($event)"
            class="rounded-lg border border-gray-300 bg-white px-3 py-1.5 text-sm font-medium shadow-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500">
            @for (a of aniosDisponibles; track a) {
              <option [value]="a">{{ a }}</option>
            }
          </select>
        </div>
      </div>

      <!-- Resumen Cards -->
      <div class="mb-6 grid grid-cols-1 gap-4 sm:grid-cols-2">
        <div class="rounded-xl border border-gray-200 bg-white p-5 shadow-sm">
          <p class="text-sm font-medium text-gray-500">Total Entregado ({{ anio() }})</p>
          <p class="mt-2 text-3xl font-bold text-gray-900">S/ {{ totalGlobal() | number:'1.2-2' }}</p>
        </div>
        <div class="rounded-xl border border-gray-200 bg-white p-5 shadow-sm">
          <p class="text-sm font-medium text-gray-500">Socios Beneficiados</p>
          <p class="mt-2 text-3xl font-bold text-gray-900">{{ sociosCount() }}</p>
        </div>
      </div>

      <!-- Errores y Loading -->
      @if (error()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
          {{ error() }}
        </div>
      }

      @if (loading()) {
        <div class="flex items-center justify-center py-12 text-gray-500">
          <span class="mr-2 inline-block h-5 w-5 animate-spin rounded-full border-2 border-brand-600 border-t-transparent"></span>
          Cargando información...
        </div>
      } @else if (data().length === 0) {
        <div class="rounded-xl border border-gray-200 bg-white py-16 text-center shadow-sm">
          <p class="font-medium text-gray-500">No hay registros para este año.</p>
        </div>
      } @else {
        <!-- Tabla Detallada -->
        <div class="overflow-hidden rounded-xl border border-gray-200 bg-white shadow-sm">
          <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
              <thead class="bg-gray-50 text-xs uppercase text-gray-500">
                <tr>
                  <th class="px-6 py-3 font-medium">Socio</th>
                  <th class="px-6 py-3 font-medium">DNI</th>
                  <th class="px-6 py-3 font-medium">Detalle ({{ anio() }})</th>
                  <th class="px-6 py-3 text-right font-medium">Monto Total</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-200">
                @for (grupo of data(); track grupo.socio_id) {
                  <tr class="hover:bg-gray-50">
                    <td class="px-6 py-4 font-medium text-gray-900">{{ grupo.nombre_completo }}</td>
                    <td class="px-6 py-4 text-gray-500">{{ grupo.dni }}</td>
                    <td class="px-6 py-4">
                      <div class="space-y-2">
                        @for (reg of grupo.registros; track reg.id) {
                          <div class="flex items-center gap-2 text-xs">
                            <span class="inline-flex rounded-md bg-gray-100 px-2 py-0.5 text-gray-600">
                              {{ reg.fecha | date:'dd/MM' }}
                            </span>
                            <span class="text-gray-700">{{ reg.motivo || 'Sin motivo' }}</span>
                            <span class="font-medium text-gray-900 ml-auto">S/ {{ reg.monto | number:'1.2-2' }}</span>
                          </div>
                        }
                      </div>
                    </td>
                    <td class="px-6 py-4 text-right text-base font-bold text-gray-900">
                      S/ {{ grupo.total_monto | number:'1.2-2' }}
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        </div>
      }
    </div>
  `
})
export class BeneficiosReporteComponent implements OnInit {
  private readonly beneficiosSvc = inject(BeneficiosService);
  private readonly route = inject(ActivatedRoute);

  readonly titulo = signal('');
  readonly tipo = signal<TipoBeneficio>('dieta');
  readonly anio = signal(new Date().getFullYear());
  
  readonly data = signal<BeneficioSocioAgrupado[]>([]);
  readonly loading = signal(false);
  readonly error = signal<string | null>(null);

  readonly totalGlobal = signal(0);
  readonly sociosCount = signal(0);

  readonly aniosDisponibles = Array.from({ length: 5 }, (_, i) => new Date().getFullYear() - i);

  ngOnInit() {
    this.route.data.subscribe(data => {
      this.titulo.set(data['titulo'] || 'Reporte');
      this.tipo.set(data['tipo'] || 'dieta');
      this.cargarDatos();
    });
  }

  cambiarAnio(event: Event) {
    const selected = (event.target as HTMLSelectElement).value;
    this.anio.set(Number(selected));
    this.cargarDatos();
  }

  async cargarDatos() {
    this.loading.set(true);
    this.error.set(null);
    try {
      const res = await this.beneficiosSvc.reporteAnual(this.tipo(), this.anio());
      this.data.set(res);
      this.totalGlobal.set(res.reduce((sum, g) => sum + g.total_monto, 0));
      this.sociosCount.set(res.length);
    } catch (err: any) {
      this.error.set(err.message || 'Error al cargar el reporte');
    } finally {
      this.loading.set(false);
    }
  }
}
