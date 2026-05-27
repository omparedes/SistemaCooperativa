import { Component, input, output } from '@angular/core';
import { NgClass } from '@angular/common';
import {
  EspacioOcupacion,
  badgeTipoEspacio,
  badgeTipoOcupante,
  esEspacioPrincipal,
} from '../espacios.model';

export interface ToggleServicioEvent {
  espacio: EspacioOcupacion;
  servicio: 'luz' | 'agua';
}

@Component({
  selector: 'app-espacio-table',
  standalone: true,
  imports: [NgClass],
  template: `
<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm overflow-hidden">

  @if (cargando()) {
    <div class="flex items-center justify-center py-16 text-gray-400 dark:text-gray-500 text-sm gap-2">
      <svg class="h-5 w-5 animate-spin" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/>
      </svg>
      Cargando espacios…
    </div>
  } @else if (espacios().length === 0) {
    <div class="py-16 text-center text-gray-400 dark:text-gray-500 text-sm">
      No se encontraron espacios con los filtros aplicados.
    </div>
  } @else {
    <div class="overflow-x-auto">
      <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
        <thead class="bg-gray-50 dark:bg-gray-900/50">
          <tr>
            <th 
              class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-800 transition select-none"
              (click)="sortChange.emit('codigo')">
              <div class="flex items-center gap-1">
                N° Puesto
                @if (sortCol() === 'codigo') {
                  <span class="text-brand-600 dark:text-brand-400">{{ sortAsc() ? '↑' : '↓' }}</span>
                }
              </div>
            </th>
            <th class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Tipo</th>
            <th class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Giro</th>
            <th 
              class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-800 transition select-none"
              (click)="sortChange.emit('ocupante')">
              <div class="flex items-center gap-1">
                Ocupante
                @if (sortCol() === 'ocupante') {
                  <span class="text-brand-600 dark:text-brand-400">{{ sortAsc() ? '↑' : '↓' }}</span>
                }
              </div>
            </th>
            <th class="px-4 py-3 text-center font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Luz</th>
            <th class="px-4 py-3 text-center font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Agua</th>
            <th class="px-4 py-3 text-center font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Estado</th>
            <th class="px-4 py-3"></th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
          @for (esp of espacios(); track esp.puesto_id) {
            <tr
              (click)="seleccionar.emit(esp)"
              [ngClass]="seleccionadoId() === esp.puesto_id
                ? 'bg-brand-50 dark:bg-brand-900/20'
                : 'hover:bg-gray-50 dark:hover:bg-gray-700/40'"
              class="cursor-pointer transition">

              <td class="px-4 py-3 font-mono font-semibold text-gray-900 dark:text-white whitespace-nowrap">
                {{ esp.codigo_puesto }}
              </td>

              <td class="px-4 py-3 whitespace-nowrap">
                @let badge = getTipoBadge(esp.tipo_espacio);
                <span class="inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium {{ badge.cls }}">
                  {{ badge.label }}
                </span>
              </td>

              <td class="px-4 py-3 text-gray-600 dark:text-gray-400 max-w-[140px] truncate">
                {{ esp.giro_nombre ?? '—' }}
              </td>

              <td class="px-4 py-3">
                @if (esp.tipo_ocupante) {
                  @let ocBadge = getOcupanteBadge(esp.tipo_ocupante);
                  <div class="text-gray-900 dark:text-white text-xs leading-tight font-medium">
                    @if (esEspacioPrincipal(esp.tipo_espacio) && esp.titular_id) {
                      {{ esp.titular_apellidos }}, {{ esp.titular_nombres }}
                    } @else if (esp.inquilino_id) {
                      {{ esp.inquilino_apellidos }}, {{ esp.inquilino_nombres }}
                    }
                  </div>
                  <span class="inline-flex items-center rounded-full px-2 py-0.5 text-xs font-medium mt-0.5 {{ ocBadge.cls }}">
                    {{ ocBadge.label }}
                  </span>
                } @else {
                  <span class="text-gray-400 dark:text-gray-500 italic text-xs">Sin asignar</span>
                }
              </td>

              <!-- Toggle Luz -->
              <td class="px-4 py-3 text-center" (click)="$event.stopPropagation()">
                <button
                  (click)="toggleServicio.emit({ espacio: esp, servicio: 'luz' })"
                  [disabled]="!esAdmin() || toggling() === esp.puesto_id + '-luz'"
                  [title]="esp.cobro_luz_activo ? 'Desactivar cobro de Luz' : 'Activar cobro de Luz'"
                  class="relative inline-flex h-5 w-9 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-1 disabled:opacity-50 disabled:cursor-not-allowed"
                  [ngClass]="esp.cobro_luz_activo
                    ? 'bg-green-500 dark:bg-green-600'
                    : 'bg-gray-300 dark:bg-gray-600'">
                  <span
                    class="inline-block h-3.5 w-3.5 rounded-full bg-white shadow-sm transform transition-transform"
                    [ngClass]="esp.cobro_luz_activo ? 'translate-x-4' : 'translate-x-0.5'">
                  </span>
                </button>
              </td>

              <!-- Toggle Agua -->
              <td class="px-4 py-3 text-center" (click)="$event.stopPropagation()">
                <button
                  (click)="toggleServicio.emit({ espacio: esp, servicio: 'agua' })"
                  [disabled]="!esAdmin() || toggling() === esp.puesto_id + '-agua'"
                  [title]="esp.cobro_agua_activo ? 'Desactivar cobro de Agua' : 'Activar cobro de Agua'"
                  class="relative inline-flex h-5 w-9 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-1 disabled:opacity-50 disabled:cursor-not-allowed"
                  [ngClass]="esp.cobro_agua_activo
                    ? 'bg-blue-500 dark:bg-blue-600'
                    : 'bg-gray-300 dark:bg-gray-600'">
                  <span
                    class="inline-block h-3.5 w-3.5 rounded-full bg-white shadow-sm transform transition-transform"
                    [ngClass]="esp.cobro_agua_activo ? 'translate-x-4' : 'translate-x-0.5'">
                  </span>
                </button>
              </td>

              <td class="px-4 py-3 text-center">
                <span
                  [ngClass]="esp.estado === 'Activo'
                    ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300'
                    : 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-400'"
                  class="inline-flex rounded-full px-2 py-0.5 text-xs font-medium">
                  {{ esp.estado }}
                </span>
              </td>

              <td class="px-4 py-3 text-right">
                <button
                  (click)="seleccionar.emit(esp); $event.stopPropagation()"
                  class="text-brand-600 dark:text-brand-400 hover:text-brand-800 dark:hover:text-brand-300 text-xs font-medium">
                  Ver →
                </button>
              </td>
            </tr>
          }
        </tbody>
      </table>
    </div>
    <div class="px-4 py-3 border-t border-gray-100 dark:border-gray-700 text-xs text-gray-500 dark:text-gray-400">
      Mostrando {{ espacios().length }} espacios
    </div>
  }
</div>
  `,
})
export class EspacioTableComponent {
  readonly espacios       = input.required<EspacioOcupacion[]>();
  readonly seleccionadoId = input<number | null>(null);
  readonly cargando       = input(false);
  readonly esAdmin        = input(false);
  readonly toggling       = input<string | null>(null);
  readonly sortCol        = input<'codigo' | 'ocupante'>('codigo');
  readonly sortAsc        = input<boolean>(true);

  readonly seleccionar    = output<EspacioOcupacion>();
  readonly toggleServicio = output<ToggleServicioEvent>();
  readonly sortChange     = output<'codigo' | 'ocupante'>();

  protected readonly getTipoBadge     = badgeTipoEspacio;
  protected readonly getOcupanteBadge = badgeTipoOcupante;
  protected readonly esEspacioPrincipal = esEspacioPrincipal;
}
