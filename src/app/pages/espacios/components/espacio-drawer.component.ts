import { Component, input, output } from '@angular/core';
import { DatePipe, DecimalPipe, NgClass } from '@angular/common';
import { RouterModule } from '@angular/router';
import {
  EspacioOcupacion,
  OcupacionAlmacen,
  badgeTipoEspacio,
  badgeTipoOcupante,
  esEspacioPrincipal,
} from '../espacios.model';

@Component({
  selector: 'app-espacio-drawer',
  standalone: true,
  imports: [NgClass, DatePipe, DecimalPipe, RouterModule],
  template: `
<!-- Backdrop -->
<div
  class="fixed inset-0 bg-black/30 dark:bg-black/50 z-40"
  (click)="cerrar.emit()">
</div>

<!-- Panel lateral -->
<aside
  class="fixed top-0 right-0 h-full w-full sm:w-[480px] bg-white dark:bg-gray-900 border-l border-gray-200 dark:border-gray-700 shadow-2xl z-50 flex flex-col overflow-hidden">

  <!-- Cabecera -->
  <div class="flex items-center justify-between px-5 py-4 border-b border-gray-200 dark:border-gray-700">
    <div>
      <h3 class="text-lg font-bold text-gray-900 dark:text-white font-mono">
        {{ espacio().codigo_puesto }}
      </h3>
      @let badge = getTipoBadge(espacio().tipo_espacio);
      <span class="inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium {{ badge.cls }}">
        {{ badge.label }}
      </span>
    </div>
    <button
      (click)="cerrar.emit()"
      class="rounded-lg p-1.5 text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition">
      <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
      </svg>
    </button>
  </div>

  <!-- Cuerpo -->
  <div class="flex-1 overflow-y-auto p-5 space-y-6">

    <!-- Identificación -->
    <section>
      <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">Identificación</h4>
      <dl class="grid grid-cols-2 gap-x-4 gap-y-3 text-sm">
        <div>
          <dt class="text-gray-500 dark:text-gray-400 text-xs">Código</dt>
          <dd class="font-mono font-bold text-gray-900 dark:text-white">{{ espacio().codigo_puesto }}</dd>
        </div>
        <div>
          <dt class="text-gray-500 dark:text-gray-400 text-xs">Giro</dt>
          <dd class="text-gray-900 dark:text-white">{{ espacio().giro_nombre ?? '—' }}</dd>
        </div>
        <div>
          <dt class="text-gray-500 dark:text-gray-400 text-xs">Área</dt>
          <dd class="text-gray-900 dark:text-white">
            {{ espacio().area_m2 != null ? (espacio().area_m2 | number:'1.2-2') + ' m²' : '—' }}
          </dd>
        </div>
        <div>
          <dt class="text-gray-500 dark:text-gray-400 text-xs">Estado</dt>
          <dd>
            <span
              [ngClass]="espacio().estado === 'Activo'
                ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300'
                : 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-400'"
              class="inline-flex rounded-full px-2 py-0.5 text-xs font-medium">
              {{ espacio().estado }}
            </span>
          </dd>
        </div>
      </dl>
    </section>

    <!-- Servicios de cobro -->
    <section>
      <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">Servicios de Cobro</h4>
      <div class="space-y-3">
        <!-- Luz -->
        <div class="flex items-center justify-between p-3 rounded-lg bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700">
          <div class="flex items-center gap-2.5">
            <div [ngClass]="espacio().cobro_luz_activo ? 'text-yellow-500' : 'text-gray-400'">
              <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                <path d="M11 3a1 1 0 10-2 0v1a1 1 0 102 0V3zM15.657 5.757a1 1 0 00-1.414-1.414l-.707.707a1 1 0 001.414 1.414l.707-.707zM18 10a1 1 0 01-1 1h-1a1 1 0 110-2h1a1 1 0 011 1zM5.05 6.464A1 1 0 106.464 5.05l-.707-.707a1 1 0 00-1.414 1.414l.707.707zM5 10a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zM8 16v-1H6a2 2 0 110-4h.5V9a3.5 3.5 0 117 0v2H14a2 2 0 110 4h-2v1H8z"/>
              </svg>
            </div>
            <div>
              <div class="text-sm font-medium text-gray-900 dark:text-white">Cobro de Luz</div>
              <div class="text-xs text-gray-500 dark:text-gray-400">
                Medidor: {{ espacio().tiene_medidor_luz ? 'Sí' : 'No (Amperaje)' }}
              </div>
            </div>
          </div>
          <div class="flex items-center gap-2">
            <span class="text-xs font-semibold"
              [ngClass]="espacio().cobro_luz_activo ? 'text-green-600 dark:text-green-400' : 'text-red-500 dark:text-red-400'">
              {{ espacio().cobro_luz_activo ? 'Activo' : 'Inactivo' }}
            </span>
            @if (esAdmin()) {
              <button
                (click)="toggleLuz.emit(espacio())"
                [disabled]="toggling() === espacio().puesto_id + '-luz'"
                class="relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-brand-500 disabled:opacity-50"
                [ngClass]="espacio().cobro_luz_activo ? 'bg-green-500' : 'bg-gray-300 dark:bg-gray-600'">
                <span
                  class="inline-block h-4 w-4 rounded-full bg-white shadow-sm transform transition-transform"
                  [ngClass]="espacio().cobro_luz_activo ? 'translate-x-6' : 'translate-x-1'">
                </span>
              </button>
            }
          </div>
        </div>
        <!-- Agua -->
        <div class="flex items-center justify-between p-3 rounded-lg bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700">
          <div class="flex items-center gap-2.5">
            <div [ngClass]="espacio().cobro_agua_activo ? 'text-blue-500' : 'text-gray-400'">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 2.69l5.66 5.66a8 8 0 11-11.31 0z"/>
              </svg>
            </div>
            <div>
              <div class="text-sm font-medium text-gray-900 dark:text-white">Cobro de Agua</div>
              <div class="text-xs text-gray-500 dark:text-gray-400">
                Medidor: {{ espacio().tiene_medidor_agua ? 'Sí' : 'No (Tarifa fija)' }}
              </div>
            </div>
          </div>
          <div class="flex items-center gap-2">
            <span class="text-xs font-semibold"
              [ngClass]="espacio().cobro_agua_activo ? 'text-green-600 dark:text-green-400' : 'text-red-500 dark:text-red-400'">
              {{ espacio().cobro_agua_activo ? 'Activo' : 'Inactivo' }}
            </span>
            @if (esAdmin()) {
              <button
                (click)="toggleAgua.emit(espacio())"
                [disabled]="toggling() === espacio().puesto_id + '-agua'"
                class="relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-brand-500 disabled:opacity-50"
                [ngClass]="espacio().cobro_agua_activo ? 'bg-blue-500' : 'bg-gray-300 dark:bg-gray-600'">
                <span
                  class="inline-block h-4 w-4 rounded-full bg-white shadow-sm transform transition-transform"
                  [ngClass]="espacio().cobro_agua_activo ? 'translate-x-6' : 'translate-x-1'">
                </span>
              </button>
            }
          </div>
        </div>
      </div>
    </section>

    <!-- Ocupante principal -->
    @if (esEspacioPrincipal(espacio().tipo_espacio)) {
      <!-- Socio titular para Regular/Pequeño -->
      <section>
        <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">Titular (Socio)</h4>
        @if (espacio().titular_id) {
          <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-4 space-y-2 text-sm">
            <div class="font-semibold text-gray-900 dark:text-white">
              {{ espacio().titular_apellidos }}, {{ espacio().titular_nombres }}
            </div>
            <div class="text-gray-500 dark:text-gray-400 text-xs space-y-0.5">
              <div>DNI: <span class="font-mono text-gray-700 dark:text-gray-300">{{ espacio().titular_dni }}</span></div>
              <div>Desde: {{ espacio().titularidad_inicio | date:'dd/MM/yyyy' }}</div>
              <div>Estado:
                <span [ngClass]="espacio().titular_estado === 'Activo' ? 'text-green-600 dark:text-green-400' : 'text-red-500'">
                  {{ espacio().titular_estado }}
                </span>
              </div>
            </div>
            <div class="flex items-center gap-3 mt-2">
              <a [routerLink]="['/socios', espacio().titular_id]"
                class="text-brand-600 dark:text-brand-400 hover:underline text-xs font-medium">
                Ver perfil →
              </a>
              @if (esAdmin()) {
                <button
                  (click)="requestTransferir.emit(espacio())"
                  class="text-xs font-medium text-amber-600 dark:text-amber-400 hover:underline">
                  Transferir puesto
                </button>
              }
            </div>
          </div>
        } @else {
          <div class="rounded-lg border border-dashed border-gray-300 dark:border-gray-600 p-4 text-center text-gray-400 dark:text-gray-500 text-sm italic">
            Sin titular asignado
          </div>
        }
      </section>
      <!-- Inquilino para Regular/Pequeño -->
      <section>
        <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">Inquilino (Arrendatario)</h4>
        @if (espacio().inquilino_id) {
          @let inqBadge = getOcupanteBadge(espacio().tipo_inquilino ?? 'Inquilino');
          <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-4 space-y-2 text-sm">
            <div class="flex items-center gap-2">
              <span class="font-semibold text-gray-900 dark:text-white">
                {{ espacio().inquilino_apellidos }}, {{ espacio().inquilino_nombres }}
              </span>
              <span class="inline-flex rounded-full px-2 py-0.5 text-xs font-medium {{ inqBadge.cls }}">{{ inqBadge.label }}</span>
            </div>
            <div class="text-xs text-gray-500 dark:text-gray-400">
              Desde: {{ espacio().arriendo_inicio | date:'dd/MM/yyyy' }}
            </div>
            <a [routerLink]="['/inquilinos', espacio().inquilino_id]"
              class="inline-flex items-center gap-1 text-brand-600 dark:text-brand-400 hover:underline text-xs font-medium">
              Ver perfil →
            </a>
          </div>
        } @else {
          <div class="rounded-lg border border-dashed border-gray-300 dark:border-gray-600 p-4 text-center text-gray-400 dark:text-gray-500 text-sm italic">
            Sin inquilino vigente
          </div>
        }
      </section>
    } @else {
      <!-- Costo de alquiler (solo Almacén) -->
      <section>
        <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">Tarifa de Alquiler</h4>
        <div class="flex items-center justify-between rounded-lg bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 px-4 py-3">
          <div>
            <div class="text-xs text-amber-700 dark:text-amber-400">Costo mensual base</div>
            <div class="text-lg font-bold text-amber-900 dark:text-amber-200">
              S/ {{ espacio().costo_alquiler | number:'1.2-2' }}
            </div>
            @if (espacio().costo_alquiler_contrato !== null && espacio().costo_alquiler_contrato !== espacio().costo_alquiler) {
              <div class="text-xs text-amber-600 dark:text-amber-400 mt-0.5">
                Contrato vigente: S/ {{ espacio().costo_alquiler_contrato! | number:'1.2-2' }}
              </div>
            }
          </div>
          @if (esAdmin()) {
            <button
              (click)="requestEditarCosto.emit(espacio())"
              title="Editar costo"
              class="p-1.5 rounded-lg text-amber-600 dark:text-amber-400 hover:bg-amber-100 dark:hover:bg-amber-900/40 transition">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
              </svg>
            </button>
          }
        </div>
      </section>

      <!-- Ocupante para Almacén -->
      <section>
        <div class="flex items-center justify-between mb-3">
          <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Ocupante del Almacén</h4>
          @if (esAdmin()) {
            <button
              (click)="requestAsignarAlmacen.emit(espacio())"
              class="text-xs font-medium text-brand-600 dark:text-brand-400 hover:underline">
              + Asignar
            </button>
          }
        </div>
        @if (espacio().tipo_ocupante) {
          @let ocBadge = getOcupanteBadge(espacio().tipo_ocupante!);
          <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-4 space-y-2 text-sm">
            <div class="flex items-center gap-2">
              <span class="font-semibold text-gray-900 dark:text-white">
                @if (espacio().titular_id) {
                  {{ espacio().titular_apellidos }}, {{ espacio().titular_nombres }}
                } @else {
                  {{ espacio().inquilino_apellidos }}, {{ espacio().inquilino_nombres }}
                }
              </span>
              <span class="inline-flex rounded-full px-2 py-0.5 text-xs font-medium {{ ocBadge.cls }}">{{ ocBadge.label }}</span>
            </div>
            <div class="text-xs text-gray-500 dark:text-gray-400">
              Desde: {{ (espacio().titularidad_inicio ?? espacio().arriendo_inicio) | date:'dd/MM/yyyy' }}
            </div>
            @if (espacio().costo_alquiler_contrato !== null) {
              <div class="text-xs text-gray-500 dark:text-gray-400">
                Alquiler acordado: <span class="font-semibold text-gray-700 dark:text-gray-300">S/ {{ espacio().costo_alquiler_contrato! | number:'1.2-2' }}</span>
              </div>
            }
            @if (esAdmin() && espacio().ocupacion_almacen_id) {
              <button
                (click)="requestLiberarAlmacen.emit({ espacio: espacio(), ocupacionId: espacio().ocupacion_almacen_id! })"
                class="text-xs font-medium text-red-500 dark:text-red-400 hover:underline mt-1">
                Liberar almacén
              </button>
            }
          </div>
        } @else {
          <div class="rounded-lg border border-dashed border-gray-300 dark:border-gray-600 p-4 text-center text-gray-400 dark:text-gray-500 text-sm italic">
            Almacén disponible (sin ocupante)
          </div>
        }
      </section>
    }

  </div>

  <!-- Footer -->
  <div class="px-5 py-4 border-t border-gray-200 dark:border-gray-700">
    <button
      (click)="cerrar.emit()"
      class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 py-2 text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-700 transition">
      Cerrar
    </button>
  </div>
</aside>
  `,
})
export class EspacioDrawerComponent {
  readonly espacio  = input.required<EspacioOcupacion>();
  readonly esAdmin  = input(false);
  readonly toggling = input<string | null>(null);

  readonly cerrar                 = output<void>();
  readonly toggleLuz              = output<EspacioOcupacion>();
  readonly toggleAgua             = output<EspacioOcupacion>();
  readonly requestTransferir      = output<EspacioOcupacion>();
  readonly requestAsignarAlmacen  = output<EspacioOcupacion>();
  readonly requestLiberarAlmacen  = output<{ espacio: EspacioOcupacion; ocupacionId: number }>();
  readonly requestEditarCosto     = output<EspacioOcupacion>();

  protected readonly getTipoBadge      = badgeTipoEspacio;
  protected readonly getOcupanteBadge  = badgeTipoOcupante;
  protected readonly esEspacioPrincipal = esEspacioPrincipal;
}
