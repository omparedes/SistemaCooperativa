import {
  Component, computed, effect, inject, OnInit, signal,
} from '@angular/core';
import { DatePipe, DecimalPipe, NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { AuthService } from '../../core/services/auth.service';
import { PuestosService } from '../../core/services/puestos.service';
import {
  EspacioOcupacion,
  badgeTipoEspacio,
  badgeTipoInquilino,
  nombreCompleto,
} from './espacios.model';

type FiltroTipo = 'todos' | 'Principal' | 'Almacen';

@Component({
  selector: 'app-gestion-espacios',
  standalone: true,
  imports: [NgClass, DatePipe, DecimalPipe, RouterModule, FormsModule],
  template: `
<!-- ═══════════════════════════════════════════════════ PÁGINA ═══ -->
<div class="p-6 max-w-7xl mx-auto">

  <!-- Cabecera -->
  <header class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
    <div>
      <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">
        Gestión de Espacios
      </h2>
      <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
        Padrón físico del mercado — Puestos comerciales y Almacenes con control de servicios.
      </p>
    </div>
    <!-- Contadores resumen -->
    <div class="flex gap-3 text-sm shrink-0">
      <span class="inline-flex items-center gap-1.5 rounded-lg bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 px-3 py-1.5 text-blue-700 dark:text-blue-300 font-medium">
        <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M3 9.5L12 4l9 5.5V20H3V9.5z"/>
        </svg>
        {{ totalPrincipales() }} Principales
      </span>
      <span class="inline-flex items-center gap-1.5 rounded-lg bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 px-3 py-1.5 text-amber-700 dark:text-amber-300 font-medium">
        <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
        </svg>
        {{ totalAlmacenes() }} Almacenes
      </span>
    </div>
  </header>

  <!-- Barra de filtros -->
  <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-4 mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
    <!-- Búsqueda -->
    <input
      type="text"
      [(ngModel)]="busqueda"
      placeholder="Buscar por código, titular, inquilino o giro..."
      class="flex-1 border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500"
    />
    <!-- Filtro de tipo -->
    <div class="flex rounded-lg border border-gray-200 dark:border-gray-700 overflow-hidden shrink-0">
      @for (op of opcionesFiltro; track op.valor) {
        <button
          (click)="filtroTipo.set(op.valor)"
          [ngClass]="filtroTipo() === op.valor
            ? 'bg-brand-600 text-white dark:bg-brand-500'
            : 'bg-white dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700'"
          class="px-3 py-2 text-xs font-medium transition">
          {{ op.label }}
        </button>
      }
    </div>
  </div>

  <!-- Error -->
  @if (error()) {
    <div class="mb-4 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
      <strong>Error:</strong> {{ error() }}
    </div>
  }

  <!-- Aviso de solo lectura para toggles -->
  @if (!authSvc.esAdmin()) {
    <div class="mb-4 p-3 rounded-lg bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-700 text-yellow-700 dark:text-yellow-300 text-xs">
      Los controles de Luz y Agua son de solo lectura. Solo un Administrador puede modificar el estado de servicios.
    </div>
  }

  <!-- Tabla -->
  <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm overflow-hidden">

    @if (cargando()) {
      <div class="flex items-center justify-center py-16 text-gray-400 dark:text-gray-500 text-sm gap-2">
        <svg class="h-5 w-5 animate-spin" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/>
        </svg>
        Cargando espacios…
      </div>
    } @else if (espaciosFiltrados().length === 0) {
      <div class="py-16 text-center text-gray-400 dark:text-gray-500 text-sm">
        No se encontraron espacios con los filtros aplicados.
      </div>
    } @else {
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
          <thead class="bg-gray-50 dark:bg-gray-900/50">
            <tr>
              <th class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Código</th>
              <th class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Tipo</th>
              <th class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Giro</th>
              <th class="px-4 py-3 text-left font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Titular / Ocupante</th>
              <th class="px-4 py-3 text-center font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">
                <span class="flex items-center justify-center gap-1">
                  <svg class="h-3.5 w-3.5 text-yellow-500" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M11 3a1 1 0 10-2 0v1a1 1 0 102 0V3zM15.657 5.757a1 1 0 00-1.414-1.414l-.707.707a1 1 0 001.414 1.414l.707-.707zM18 10a1 1 0 01-1 1h-1a1 1 0 110-2h1a1 1 0 011 1zM5.05 6.464A1 1 0 106.464 5.05l-.707-.707a1 1 0 00-1.414 1.414l.707.707zM5 10a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zM8 16v-1H6a2 2 0 110-4h.5V9a3.5 3.5 0 117 0v2H14a2 2 0 110 4h-2v1H8z"/>
                  </svg>
                  Luz
                </span>
              </th>
              <th class="px-4 py-3 text-center font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">
                <span class="flex items-center justify-center gap-1">
                  <svg class="h-3.5 w-3.5 text-blue-500" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
                    <path d="M10 3a7 7 0 00-7 7 7 7 0 0014 0 7 7 0 00-7-7z" opacity=".3"/>
                    <path fill-rule="evenodd" d="M10 2a8 8 0 100 16A8 8 0 0010 2zm0 2a6 6 0 100 12A6 6 0 0010 4zm0 2a4 4 0 00-4 4c0 .94.33 1.8.87 2.48L14.48 6.87A3.985 3.985 0 0010 6z" clip-rule="evenodd"/>
                  </svg>
                  Agua
                </span>
              </th>
              <th class="px-4 py-3 text-center font-semibold text-gray-600 dark:text-gray-400 uppercase tracking-wider text-xs">Estado</th>
              <th class="px-4 py-3"></th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
            @for (esp of espaciosFiltrados(); track esp.puesto_id) {
              <tr
                (click)="seleccionar(esp)"
                [ngClass]="seleccionado()?.puesto_id === esp.puesto_id
                  ? 'bg-brand-50 dark:bg-brand-900/20'
                  : 'hover:bg-gray-50 dark:hover:bg-gray-700/40'"
                class="cursor-pointer transition">

                <!-- Código -->
                <td class="px-4 py-3 font-mono font-semibold text-gray-900 dark:text-white whitespace-nowrap">
                  {{ esp.codigo_puesto }}
                </td>

                <!-- Tipo badge -->
                <td class="px-4 py-3 whitespace-nowrap">
                  @let badge = getTipoBadge(esp.tipo_espacio);
                  <span class="inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-xs font-medium {{ badge.cls }}">
                    {{ badge.label }}
                  </span>
                </td>

                <!-- Giro -->
                <td class="px-4 py-3 text-gray-600 dark:text-gray-400 max-w-[150px] truncate">
                  {{ esp.giro_nombre ?? '—' }}
                </td>

                <!-- Titular / Ocupante -->
                <td class="px-4 py-3">
                  @if (esp.titular_id) {
                    <div class="text-gray-900 dark:text-white font-medium text-xs leading-tight">
                      {{ esp.titular_apellidos }}, {{ esp.titular_nombres }}
                    </div>
                    <div class="text-gray-400 dark:text-gray-500 text-xs">DNI: {{ esp.titular_dni }}</div>
                  } @else if (esp.inquilino_id) {
                    @let inqBadge = getInqBadge(esp.tipo_inquilino!);
                    <div class="text-gray-700 dark:text-gray-300 text-xs leading-tight">
                      {{ esp.inquilino_apellidos }}, {{ esp.inquilino_nombres }}
                    </div>
                    <span class="inline-flex items-center rounded-full px-2 py-0.5 text-xs font-medium mt-0.5 {{ inqBadge.cls }}">
                      {{ inqBadge.label }}
                    </span>
                  } @else {
                    <span class="text-gray-400 dark:text-gray-500 italic text-xs">Sin asignar</span>
                  }
                </td>

                <!-- Toggle Luz -->
                <td class="px-4 py-3 text-center" (click)="$event.stopPropagation()">
                  <button
                    (click)="toggleLuz(esp)"
                    [disabled]="!authSvc.esAdmin() || toggling() === esp.puesto_id + '-luz'"
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
                    (click)="toggleAgua(esp)"
                    [disabled]="!authSvc.esAdmin() || toggling() === esp.puesto_id + '-agua'"
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

                <!-- Estado puesto -->
                <td class="px-4 py-3 text-center">
                  <span
                    [ngClass]="esp.estado === 'Activo'
                      ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300'
                      : 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-400'"
                    class="inline-flex rounded-full px-2 py-0.5 text-xs font-medium">
                    {{ esp.estado }}
                  </span>
                </td>

                <!-- Ver detalle -->
                <td class="px-4 py-3 text-right">
                  <button
                    (click)="seleccionar(esp); $event.stopPropagation()"
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
        Mostrando {{ espaciosFiltrados().length }} de {{ espacios().length }} espacios
      </div>
    }
  </div>
</div>

<!-- ═══════════════════════════════════════════════════ DRAWER ═══ -->
@if (seleccionado()) {
  <!-- Backdrop -->
  <div
    class="fixed inset-0 bg-black/30 dark:bg-black/50 z-40"
    (click)="cerrarDrawer()">
  </div>

  <!-- Panel lateral -->
  <aside
    class="fixed top-0 right-0 h-full w-full sm:w-[460px] bg-white dark:bg-gray-900 border-l border-gray-200 dark:border-gray-700 shadow-2xl z-50 flex flex-col overflow-hidden">

    <!-- Cabecera del drawer -->
    <div class="flex items-center justify-between px-5 py-4 border-b border-gray-200 dark:border-gray-700">
      <div>
        <h3 class="text-lg font-bold text-gray-900 dark:text-white font-mono">
          {{ seleccionado()!.codigo_puesto }}
        </h3>
        @let badge = getTipoBadge(seleccionado()!.tipo_espacio);
        <span class="inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium {{ badge.cls }}">
          {{ badge.label }}
        </span>
      </div>
      <button
        (click)="cerrarDrawer()"
        class="rounded-lg p-1.5 text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition">
        <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
        </svg>
      </button>
    </div>

    <!-- Cuerpo del drawer -->
    <div class="flex-1 overflow-y-auto p-5 space-y-6">

      <!-- Bloque Identificación -->
      <section>
        <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">
          Identificación
        </h4>
        <dl class="grid grid-cols-2 gap-x-4 gap-y-3 text-sm">
          <div>
            <dt class="text-gray-500 dark:text-gray-400 text-xs">Código</dt>
            <dd class="font-mono font-bold text-gray-900 dark:text-white">{{ seleccionado()!.codigo_puesto }}</dd>
          </div>
          <div>
            <dt class="text-gray-500 dark:text-gray-400 text-xs">Giro</dt>
            <dd class="text-gray-900 dark:text-white">{{ seleccionado()!.giro_nombre ?? '—' }}</dd>
          </div>
          <div>
            <dt class="text-gray-500 dark:text-gray-400 text-xs">Área</dt>
            <dd class="text-gray-900 dark:text-white">
              {{ seleccionado()!.area_m2 != null ? (seleccionado()!.area_m2 | number:'1.2-2') + ' m²' : '—' }}
            </dd>
          </div>
          <div>
            <dt class="text-gray-500 dark:text-gray-400 text-xs">Estado</dt>
            <dd>
              <span
                [ngClass]="seleccionado()!.estado === 'Activo'
                  ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300'
                  : 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-400'"
                class="inline-flex rounded-full px-2 py-0.5 text-xs font-medium">
                {{ seleccionado()!.estado }}
              </span>
            </dd>
          </div>
        </dl>
      </section>

      <!-- Bloque Servicios -->
      <section>
        <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">
          Servicios de Cobro
        </h4>
        <div class="space-y-3">
          <!-- Luz -->
          <div class="flex items-center justify-between p-3 rounded-lg bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700">
            <div class="flex items-center gap-2.5">
              <div [ngClass]="seleccionado()!.cobro_luz_activo ? 'text-yellow-500' : 'text-gray-400'">
                <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M11 3a1 1 0 10-2 0v1a1 1 0 102 0V3zM15.657 5.757a1 1 0 00-1.414-1.414l-.707.707a1 1 0 001.414 1.414l.707-.707zM18 10a1 1 0 01-1 1h-1a1 1 0 110-2h1a1 1 0 011 1zM5.05 6.464A1 1 0 106.464 5.05l-.707-.707a1 1 0 00-1.414 1.414l.707.707zM5 10a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zM8 16v-1H6a2 2 0 110-4h.5V9a3.5 3.5 0 117 0v2H14a2 2 0 110 4h-2v1H8z"/>
                </svg>
              </div>
              <div>
                <div class="text-sm font-medium text-gray-900 dark:text-white">Cobro de Luz</div>
                <div class="text-xs text-gray-500 dark:text-gray-400">
                  Medidor: {{ seleccionado()!.tiene_medidor_luz ? 'Sí' : 'No (Amperaje)' }}
                </div>
              </div>
            </div>
            <div class="flex items-center gap-2">
              <span class="text-xs font-semibold"
                [ngClass]="seleccionado()!.cobro_luz_activo ? 'text-green-600 dark:text-green-400' : 'text-red-500 dark:text-red-400'">
                {{ seleccionado()!.cobro_luz_activo ? 'Activo' : 'Inactivo' }}
              </span>
              @if (authSvc.esAdmin()) {
                <button
                  (click)="toggleLuz(seleccionado()!)"
                  [disabled]="toggling() === seleccionado()!.puesto_id + '-luz'"
                  class="relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-1 disabled:opacity-50"
                  [ngClass]="seleccionado()!.cobro_luz_activo ? 'bg-green-500' : 'bg-gray-300 dark:bg-gray-600'">
                  <span
                    class="inline-block h-4 w-4 rounded-full bg-white shadow-sm transform transition-transform"
                    [ngClass]="seleccionado()!.cobro_luz_activo ? 'translate-x-6' : 'translate-x-1'">
                  </span>
                </button>
              }
            </div>
          </div>

          <!-- Agua -->
          <div class="flex items-center justify-between p-3 rounded-lg bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700">
            <div class="flex items-center gap-2.5">
              <div [ngClass]="seleccionado()!.cobro_agua_activo ? 'text-blue-500' : 'text-gray-400'">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.31-8.86c-1.77-.45-2.34-.94-2.34-1.67 0-.84.79-1.43 2.1-1.43 1.38 0 1.9.66 1.94 1.64h1.71c-.05-1.34-.87-2.57-2.49-2.97V5H10.9v1.69c-1.51.32-2.72 1.3-2.72 2.81 0 1.79 1.49 2.69 3.66 3.21 1.95.46 2.34 1.15 2.34 1.87 0 .53-.39 1.39-2.1 1.39-1.6 0-2.23-.72-2.32-1.64H8.04c.1 1.7 1.36 2.66 2.86 2.97V19h2.34v-1.67c1.52-.29 2.72-1.16 2.73-2.77-.01-2.2-1.9-2.96-3.66-3.42z"/>
                </svg>
              </div>
              <div>
                <div class="text-sm font-medium text-gray-900 dark:text-white">Cobro de Agua</div>
                <div class="text-xs text-gray-500 dark:text-gray-400">
                  Medidor: {{ seleccionado()!.tiene_medidor_agua ? 'Sí' : 'No (Tarifa fija)' }}
                </div>
              </div>
            </div>
            <div class="flex items-center gap-2">
              <span class="text-xs font-semibold"
                [ngClass]="seleccionado()!.cobro_agua_activo ? 'text-green-600 dark:text-green-400' : 'text-red-500 dark:text-red-400'">
                {{ seleccionado()!.cobro_agua_activo ? 'Activo' : 'Inactivo' }}
              </span>
              @if (authSvc.esAdmin()) {
                <button
                  (click)="toggleAgua(seleccionado()!)"
                  [disabled]="toggling() === seleccionado()!.puesto_id + '-agua'"
                  class="relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-1 disabled:opacity-50"
                  [ngClass]="seleccionado()!.cobro_agua_activo ? 'bg-blue-500' : 'bg-gray-300 dark:bg-gray-600'">
                  <span
                    class="inline-block h-4 w-4 rounded-full bg-white shadow-sm transform transition-transform"
                    [ngClass]="seleccionado()!.cobro_agua_activo ? 'translate-x-6' : 'translate-x-1'">
                  </span>
                </button>
              }
            </div>
          </div>
        </div>
      </section>

      <!-- Bloque Titular -->
      <section>
        <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">
          Titular (Socio Propietario)
        </h4>
        @if (seleccionado()!.titular_id) {
          <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-4 space-y-2 text-sm">
            <div class="font-semibold text-gray-900 dark:text-white">
              {{ seleccionado()!.titular_apellidos }}, {{ seleccionado()!.titular_nombres }}
            </div>
            <div class="text-gray-500 dark:text-gray-400 text-xs space-y-0.5">
              <div>DNI: <span class="font-mono text-gray-700 dark:text-gray-300">{{ seleccionado()!.titular_dni }}</span></div>
              <div>Desde: {{ seleccionado()!.titularidad_inicio | date:'dd/MM/yyyy' }}</div>
              <div>Estado: <span [ngClass]="seleccionado()!.titular_estado === 'Activo' ? 'text-green-600 dark:text-green-400' : 'text-red-500'">{{ seleccionado()!.titular_estado }}</span></div>
            </div>
            <a
              [routerLink]="['/socios', seleccionado()!.titular_id]"
              class="inline-flex items-center gap-1 text-brand-600 dark:text-brand-400 hover:underline text-xs font-medium mt-1">
              Ver perfil del socio →
            </a>
          </div>
        } @else {
          <div class="rounded-lg border border-dashed border-gray-300 dark:border-gray-600 p-4 text-center text-gray-400 dark:text-gray-500 text-sm italic">
            Sin titular asignado
          </div>
        }
      </section>

      <!-- Bloque Inquilino / Tercero -->
      @if (seleccionado()!.inquilino_id || seleccionado()!.tipo_espacio === 'Principal') {
        <section>
          <h4 class="text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3">
            {{ seleccionado()!.tipo_espacio === 'Principal' ? 'Inquilino (Arrendatario)' : 'Tercero (Arrendatario)' }}
          </h4>
          @if (seleccionado()!.inquilino_id) {
            @let inqBadge = getInqBadge(seleccionado()!.tipo_inquilino!);
            <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-4 space-y-2 text-sm">
              <div class="flex items-center gap-2">
                <span class="font-semibold text-gray-900 dark:text-white">
                  {{ seleccionado()!.inquilino_apellidos }}, {{ seleccionado()!.inquilino_nombres }}
                </span>
                <span class="inline-flex rounded-full px-2 py-0.5 text-xs font-medium {{ inqBadge.cls }}">{{ inqBadge.label }}</span>
              </div>
              <div class="text-xs text-gray-500 dark:text-gray-400">
                Desde: {{ seleccionado()!.arriendo_inicio | date:'dd/MM/yyyy' }}
              </div>
              <a
                [routerLink]="['/inquilinos', seleccionado()!.inquilino_id]"
                class="inline-flex items-center gap-1 text-brand-600 dark:text-brand-400 hover:underline text-xs font-medium mt-1">
                Ver perfil →
              </a>
            </div>
          } @else {
            <div class="rounded-lg border border-dashed border-gray-300 dark:border-gray-600 p-4 text-center text-gray-400 dark:text-gray-500 text-sm italic">
              Sin inquilino vigente
            </div>
          }
        </section>
      }

    </div>

    <!-- Footer del drawer -->
    <div class="px-5 py-4 border-t border-gray-200 dark:border-gray-700">
      <button
        (click)="cerrarDrawer()"
        class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 py-2 text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-700 transition">
        Cerrar
      </button>
    </div>
  </aside>
}
  `,
})
export class GestionEspaciosComponent implements OnInit {
  protected readonly authSvc    = inject(AuthService);
  private readonly puestosSvc   = inject(PuestosService);

  // ── Estado reactivo ───────────────────────────────────────────────────────
  protected readonly espacios   = signal<EspacioOcupacion[]>([]);
  protected readonly cargando   = signal(false);
  protected readonly error      = signal<string | null>(null);
  protected readonly seleccionado = signal<EspacioOcupacion | null>(null);
  protected readonly toggling   = signal<string | null>(null);

  protected busqueda  = '';
  protected readonly filtroTipo = signal<FiltroTipo>('todos');

  protected readonly opcionesFiltro: { valor: FiltroTipo; label: string }[] = [
    { valor: 'todos',     label: 'Todos' },
    { valor: 'Principal', label: 'Principales' },
    { valor: 'Almacen',   label: 'Almacenes' },
  ];

  // ── Computed ──────────────────────────────────────────────────────────────
  protected readonly totalPrincipales = computed(
    () => this.espacios().filter(e => e.tipo_espacio === 'Principal').length,
  );
  protected readonly totalAlmacenes = computed(
    () => this.espacios().filter(e => e.tipo_espacio === 'Almacen').length,
  );

  protected readonly espaciosFiltrados = computed(() => {
    const q     = this.busqueda.toLowerCase().trim();
    const tipo  = this.filtroTipo();
    return this.espacios().filter(e => {
      const pasaTipo = tipo === 'todos' || e.tipo_espacio === tipo;
      if (!q) return pasaTipo;
      const busca = [
        e.codigo_puesto,
        e.giro_nombre,
        e.titular_apellidos,
        e.titular_nombres,
        e.titular_dni,
        e.inquilino_apellidos,
        e.inquilino_nombres,
      ].filter(Boolean).join(' ').toLowerCase();
      return pasaTipo && busca.includes(q);
    });
  });

  // ── Ciclo de vida ─────────────────────────────────────────────────────────
  ngOnInit(): void { this.cargar(); }

  private async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    try {
      const data = await this.puestosSvc.getEspacios();
      this.espacios.set(data);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar espacios.');
    } finally {
      this.cargando.set(false);
    }
  }

  // ── Interacción de tabla ──────────────────────────────────────────────────
  protected seleccionar(esp: EspacioOcupacion): void {
    this.seleccionado.set(
      this.seleccionado()?.puesto_id === esp.puesto_id ? null : esp,
    );
  }

  protected cerrarDrawer(): void { this.seleccionado.set(null); }

  // ── Toggles de servicios ──────────────────────────────────────────────────
  protected async toggleLuz(esp: EspacioOcupacion): Promise<void> {
    if (!this.authSvc.esAdmin()) return;
    const key = `${esp.puesto_id}-luz`;
    if (this.toggling() === key) return;
    this.toggling.set(key);
    try {
      await this.puestosSvc.toggleServicio(esp.puesto_id, 'luz', !esp.cobro_luz_activo);
      this.actualizarEspacio(esp.puesto_id, { cobro_luz_activo: !esp.cobro_luz_activo });
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cambiar cobro de Luz.');
    } finally {
      this.toggling.set(null);
    }
  }

  protected async toggleAgua(esp: EspacioOcupacion): Promise<void> {
    if (!this.authSvc.esAdmin()) return;
    const key = `${esp.puesto_id}-agua`;
    if (this.toggling() === key) return;
    this.toggling.set(key);
    try {
      await this.puestosSvc.toggleServicio(esp.puesto_id, 'agua', !esp.cobro_agua_activo);
      this.actualizarEspacio(esp.puesto_id, { cobro_agua_activo: !esp.cobro_agua_activo });
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cambiar cobro de Agua.');
    } finally {
      this.toggling.set(null);
    }
  }

  // Actualiza optimistamente el espacio en la lista y el drawer
  private actualizarEspacio(id: number, patch: Partial<EspacioOcupacion>): void {
    this.espacios.update(list =>
      list.map(e => e.puesto_id === id ? { ...e, ...patch } : e),
    );
    if (this.seleccionado()?.puesto_id === id) {
      this.seleccionado.update(s => s ? { ...s, ...patch } : s);
    }
  }

  // ── Helpers de badge (para el template) ──────────────────────────────────
  protected getTipoBadge   = badgeTipoEspacio;
  protected getInqBadge    = badgeTipoInquilino;
  protected getNombre      = nombreCompleto;

}
