import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { SociosService } from '../../core/services/socios.service';
import { InquilinosService } from '../../core/services/inquilinos.service';

type Tab = 'socios' | 'inquilinos';

@Component({
  selector: 'app-socio-list',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  template: `
    <div class="p-6 max-w-7xl mx-auto">
      <header class="mb-6">
        <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Directorio del Mercado</h2>
        <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
          Padrón de socios titulares e inquilinos posesionarios — vista del estado vigente.
        </p>
      </header>

      <div class="border-b border-gray-200 dark:border-gray-700 mb-4">
        <nav class="flex gap-1" role="tablist">
          <button (click)="cambiarTab('socios')" role="tab"
            [ngClass]="tab() === 'socios'
              ? 'text-brand-600 dark:text-brand-400 border-brand-600 dark:border-brand-400'
              : 'text-gray-500 border-transparent'"
            class="px-4 py-2.5 -mb-px border-b-2 font-medium text-sm transition hover:text-brand-600 dark:hover:text-brand-400">
            Socios
            <span class="ml-1.5 inline-flex items-center justify-center px-2 py-0.5 rounded-full text-xs bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
              {{ totalSocios() }}
            </span>
          </button>
          <button (click)="cambiarTab('inquilinos')" role="tab"
            [ngClass]="tab() === 'inquilinos'
              ? 'text-brand-600 dark:text-brand-400 border-brand-600 dark:border-brand-400'
              : 'text-gray-500 border-transparent'"
            class="px-4 py-2.5 -mb-px border-b-2 font-medium text-sm transition hover:text-brand-600 dark:hover:text-brand-400">
            Inquilinos
            <span class="ml-1.5 inline-flex items-center justify-center px-2 py-0.5 rounded-full text-xs bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
              {{ totalInquilinos() }}
            </span>
          </button>
        </nav>
      </div>

      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-4 mb-4">
        <input type="text"
          [ngModel]="busqueda()"
          (ngModelChange)="busqueda.set($event)"
          placeholder="Buscar por nombre, apellido, DNI o código de puesto..."
          class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
      </div>

      @if (errorActivo()) {
        <div class="mb-4 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
          <strong>Error:</strong> {{ errorActivo() }}
        </div>
      }

      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm overflow-hidden">
        @if (loadingActivo()) {
          <div class="p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            Cargando {{ tab() }}...
          </div>
        } @else if (tab() === 'socios') {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs">
                <tr>
                  <th class="px-4 py-3 text-left font-medium">DNI</th>
                  <th class="px-4 py-3 text-left font-medium">Apellidos y nombres</th>
                  <th class="px-4 py-3 text-left font-medium">Puesto</th>
                  <th class="px-4 py-3 text-left font-medium">Estado</th>
                  <th class="px-4 py-3 text-left font-medium">Habilitación</th>
                  <th class="px-4 py-3 text-right font-medium">Acciones</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (s of sociosFiltrados(); track s.id) {
                  <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/30 transition">
                    <td class="px-4 py-3 font-mono text-xs text-gray-600 dark:text-gray-400">{{ s.dni }}</td>
                    <td class="px-4 py-3 text-gray-800 dark:text-gray-200">
                      {{ s.apellidos }}{{ s.nombres ? ', ' + s.nombres : '' }}
                      @if (s.es_institucional) {
                        <span class="ml-2 inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-purple-50 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300">
                          Institucional
                        </span>
                      }
                    </td>
                    <td class="px-4 py-3">
                      @if (s.puesto) {
                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300">
                          {{ s.puesto.codigo }}
                        </span>
                      } @else {
                        <span class="text-xs text-gray-400 dark:text-gray-500">— sin puesto —</span>
                      }
                    </td>
                    <td class="px-4 py-3">
                      <span [ngClass]="s.estado === 'Activo'
                              ? 'bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300'
                              : 'bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300'"
                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium">
                        {{ s.estado }}
                      </span>
                    </td>
                    <td class="px-4 py-3">
                      <span [ngClass]="s.habilitado
                              ? 'bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300'
                              : 'bg-amber-50 dark:bg-amber-900/30 text-amber-700 dark:text-amber-300'"
                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium">
                        {{ s.habilitado ? 'Hábil' : 'Inhábil' }}
                      </span>
                    </td>
                    <td class="px-4 py-3 text-right">
                      <a [routerLink]="['/socios', s.id]"
                        class="text-xs font-medium text-brand-600 dark:text-brand-400 hover:underline">
                        Ver detalle →
                      </a>
                    </td>
                  </tr>
                } @empty {
                  <tr>
                    <td colspan="6" class="px-4 py-12 text-center text-gray-500 dark:text-gray-400">
                      No se encontraron socios.
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs">
                <tr>
                  <th class="px-4 py-3 text-left font-medium">DNI</th>
                  <th class="px-4 py-3 text-left font-medium">Apellidos y nombres</th>
                  <th class="px-4 py-3 text-left font-medium">Puesto arrendado</th>
                  <th class="px-4 py-3 text-left font-medium">Titular del puesto</th>
                  <th class="px-4 py-3 text-right font-medium">Arriendo (S/)</th>
                  <th class="px-4 py-3 text-left font-medium">Desde</th>
                  <th class="px-4 py-3 text-right font-medium">Acciones</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (i of inquilinosFiltrados(); track i.id) {
                  <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/30 transition">
                    <td class="px-4 py-3 font-mono text-xs text-gray-600 dark:text-gray-400">{{ i.dni }}</td>
                    <td class="px-4 py-3 text-gray-800 dark:text-gray-200">
                      {{ i.apellidos }}{{ i.nombres ? ', ' + i.nombres : '' }}
                    </td>
                    <td class="px-4 py-3">
                      @if (i.puesto) {
                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300">
                          {{ i.puesto.codigo }}
                        </span>
                      } @else {
                        <span class="text-xs text-gray-400 dark:text-gray-500">— sin arriendo vigente —</span>
                      }
                    </td>
                    <td class="px-4 py-3 text-gray-700 dark:text-gray-300">
                      @if (i.titular) {
                        @if (i.titular.dni === 'COOP-00000') {
                          <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-purple-50 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300">
                            Cooperativa
                          </span>
                        } @else {
                          <span class="text-xs">{{ i.titular.apellidos }}</span>
                        }
                      } @else {
                        <span class="text-xs text-gray-400">—</span>
                      }
                    </td>
                    <td class="px-4 py-3 text-right tabular-nums text-gray-700 dark:text-gray-300">
                      {{ i.puesto?.monto_arriendo ? (i.puesto?.monto_arriendo | number:'1.2-2') : '—' }}
                    </td>
                    <td class="px-4 py-3 text-gray-600 dark:text-gray-400 text-xs whitespace-nowrap">
                      {{ i.puesto ? (i.puesto.fecha_inicio_arriendo | date:'dd/MM/yyyy') : '—' }}
                    </td>
                    <td class="px-4 py-3 text-right">
                      <a [routerLink]="['/inquilinos', i.id]"
                        class="text-xs font-medium text-brand-600 dark:text-brand-400 hover:underline">
                        Ver detalle →
                      </a>
                    </td>
                  </tr>
                } @empty {
                  <tr>
                    <td colspan="7" class="px-4 py-12 text-center text-gray-500 dark:text-gray-400">
                      No se encontraron inquilinos.
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        }
      </div>
    </div>
  `,
})
export class SocioListComponent implements OnInit {
  private readonly sociosSvc = inject(SociosService);
  private readonly inquilinosSvc = inject(InquilinosService);

  readonly tab = signal<Tab>('socios');
  readonly busqueda = signal<string>('');

  readonly totalSocios = computed(() => this.sociosSvc.socios().length);
  readonly totalInquilinos = computed(() => this.inquilinosSvc.inquilinos().length);

  readonly loadingActivo = computed(() =>
    this.tab() === 'socios' ? this.sociosSvc.loading() : this.inquilinosSvc.loading()
  );
  readonly errorActivo = computed(() =>
    this.tab() === 'socios' ? this.sociosSvc.error() : this.inquilinosSvc.error()
  );

  readonly sociosFiltrados = computed(() => {
    const q = this.busqueda().trim().toLowerCase();
    const lista = this.sociosSvc.socios();
    if (!q) return lista;
    return lista.filter(s =>
      s.apellidos.toLowerCase().includes(q) ||
      s.nombres.toLowerCase().includes(q) ||
      s.dni.toLowerCase().includes(q) ||
      (s.puesto?.codigo.toLowerCase().includes(q) ?? false)
    );
  });

  readonly inquilinosFiltrados = computed(() => {
    const q = this.busqueda().trim().toLowerCase();
    const lista = this.inquilinosSvc.inquilinos();
    if (!q) return lista;
    return lista.filter(i =>
      i.apellidos.toLowerCase().includes(q) ||
      i.nombres.toLowerCase().includes(q) ||
      i.dni.toLowerCase().includes(q) ||
      (i.puesto?.codigo.toLowerCase().includes(q) ?? false) ||
      (i.titular?.apellidos.toLowerCase().includes(q) ?? false)
    );
  });

  ngOnInit(): void {
    void this.sociosSvc.cargar();
    void this.inquilinosSvc.cargar();
  }

  cambiarTab(t: Tab): void {
    this.tab.set(t);
  }
}
