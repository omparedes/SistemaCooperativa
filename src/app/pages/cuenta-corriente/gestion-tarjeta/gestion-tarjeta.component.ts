import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { CommonModule, DatePipe, DecimalPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../../core/services/auth.service';
import {
  EditarRecaudacionParams,
  EstadoTarjetaFiltro,
  FiltrosTarjeta,
  GestionTarjetaService,
  RecaudacionTarjetaItem,
} from '../../../core/services/gestion-tarjeta.service';
import { TarjetaDetalleModalComponent } from './tarjeta-detalle-modal.component';
import { TarjetaFormModalComponent } from './tarjeta-form-modal.component';
import { TarjetaAnularModalComponent } from './tarjeta-anular-modal.component';

type PresetFecha = 'TODO' | 'HOY' | 'AYER' | '7DIAS' | 'MES' | 'CUSTOM';

const limaFormatter = new Intl.DateTimeFormat('en-CA', {
  timeZone: 'America/Lima',
  year: 'numeric',
  month: '2-digit',
  day: '2-digit',
});

function formatYMD(d: Date): string {
  return limaFormatter.format(d);
}

@Component({
  selector: 'app-gestion-tarjeta',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    DatePipe,
    DecimalPipe,
    TarjetaDetalleModalComponent,
    TarjetaFormModalComponent,
    TarjetaAnularModalComponent,
  ],
  template: `
    <div class="mx-auto max-w-7xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white flex items-center gap-2">
            Gestión de Tarjeta
            <span class="rounded-full bg-brand-100 px-2.5 py-0.5 text-xs font-semibold text-brand-700 dark:bg-brand-900/30 dark:text-brand-300">
              Recaudación Semanal
            </span>
          </h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Administración, trazabilidad, corrección de fechas/montos y anulación de abonos a saldo a favor.
          </p>
        </div>

        <div class="flex items-center gap-2">
          <button
            type="button"
            (click)="cargar()"
            [disabled]="cargando()"
            class="inline-flex h-9 items-center gap-1.5 rounded-xl border border-gray-300 bg-white px-3.5 text-sm font-medium text-gray-700 shadow-xs hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-200 dark:hover:bg-gray-700 transition">
            <svg class="h-4 w-4" [class.animate-spin]="cargando()" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"/>
            </svg>
            Actualizar
          </button>
        </div>
      </div>

      <!-- ── Mensajes de Éxito / Error ───────────────────────────────────── -->
      @if (exito()) {
        <div class="mb-6 flex items-center justify-between rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-800 dark:border-emerald-800 dark:bg-emerald-900/20 dark:text-emerald-300">
          <div class="flex items-center gap-2">
            <svg class="h-5 w-5 text-emerald-600 dark:text-emerald-400 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
            <span>{{ exito() }}</span>
          </div>
          <button (click)="exito.set(null)" class="text-emerald-500 hover:text-emerald-700 dark:hover:text-emerald-200">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>
      }

      @if (error()) {
        <div class="mb-6 flex items-center justify-between rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-800 dark:border-red-800 dark:bg-red-900/20 dark:text-red-300">
          <div class="flex items-center gap-2">
            <svg class="h-5 w-5 text-red-600 dark:text-red-400 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"/>
            </svg>
            <span>{{ error() }}</span>
          </div>
          <button (click)="error.set(null)" class="text-red-500 hover:text-red-700 dark:hover:text-red-200">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>
      }

      <!-- ── KPIs Superiores (4 Tarjetas requeridas en 5.1) ───────────────── -->
      <div class="grid grid-cols-2 gap-4 sm:grid-cols-2 lg:grid-cols-4 mb-6">

        <!-- 1. Total Recaudado -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Total Recaudado</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
            S/ {{ resumen().totalRecaudado | number:'1.2-2' }}
          </p>
          <p class="mt-1 text-xs text-emerald-600 dark:text-emerald-400 font-medium">
            Vigente en caja y saldo a favor
          </p>
        </div>

        <!-- 2. Total de Operaciones -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Total Operaciones</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-blue-50 text-blue-600 dark:bg-blue-900/30 dark:text-blue-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 12h16.5m-16.5 3.75h16.5M3.75 19.5h16.5M5.625 4.5h12.75a1.875 1.875 0 010 3.75H5.625a1.875 1.875 0 010-3.75z"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
            {{ resumen().totalOperaciones }}
          </p>
          <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
            Abonos vigentes del período
          </p>
        </div>

        <!-- 3. Socios Participantes -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Socios Participantes</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-emerald-50 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
            {{ resumen().sociosParticipantes }}
          </p>
          <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
            Socios distintos con abono
          </p>
        </div>

        <!-- 4. Recaudaciones Anuladas -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Recaudaciones Anuladas</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-purple-50 text-purple-600 dark:bg-purple-900/30 dark:text-purple-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
            {{ resumen().recaudacionesAnuladas }}
          </p>
          <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
            @if (resumen().recaudacionesAnuladas > 0) {
              <span class="text-red-500 font-semibold">Excluidas del arqueo</span> (S/ {{ resumen().montoAnulado | number:'1.2-2' }})
            } @else {
              0 anulaciones en el período
            }
          </p>
        </div>

      </div>

      <!-- ── Barra de Filtros ────────────────────────────────────────────── -->
      <div class="mb-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800 space-y-4">

        <!-- Presets de Fecha Rápida -->
        <div class="flex flex-wrap items-center gap-1.5 border-b border-gray-100 pb-3 dark:border-gray-700">
          <span class="text-xs font-semibold text-gray-500 dark:text-gray-400 mr-2">Período:</span>
          @for (p of presets; track p.id) {
            <button
              type="button"
              (click)="aplicarPreset(p.id)"
              [class]="presetActivo() === p.id
                ? 'bg-brand-500 text-white font-semibold dark:bg-brand-600'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600'"
              class="rounded-lg px-3 py-1.5 text-xs transition">
              {{ p.label }}
            </button>
          }
        </div>

        <!-- Filtros detallados -->
        <div class="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-12 items-end">

          <!-- Rango Personalizado: Desde -->
          <div class="lg:col-span-3">
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-300 mb-1">Fecha Desde</label>
            <input
              type="date"
              [ngModel]="fechaDesde()"
              (ngModelChange)="onFechaDesdeChange($event)"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-800 focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
            />
          </div>

          <!-- Rango Personalizado: Hasta -->
          <div class="lg:col-span-3">
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-300 mb-1">Fecha Hasta</label>
            <input
              type="date"
              [ngModel]="fechaHasta()"
              (ngModelChange)="onFechaHastaChange($event)"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-800 focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
            />
          </div>

          <!-- Estado -->
          <div class="lg:col-span-3">
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-300 mb-1">Estado</label>
            <select
              [ngModel]="estadoFiltro()"
              (ngModelChange)="onEstadoChange($event)"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-800 focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-white">
              <option value="TODOS">Todos los estados</option>
              <option value="VIGENTES">Solo Vigentes</option>
              <option value="ANULADOS">Solo Anulados</option>
            </select>
          </div>

          <!-- Buscador Rápido -->
          <div class="lg:col-span-3">
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-300 mb-1">Buscador</label>
            <div class="relative">
              <input
                type="text"
                [ngModel]="busqueda()"
                (ngModelChange)="onBusquedaChange($event)"
                placeholder="Socio, DNI, Puesto o REC..."
                class="w-full rounded-xl border border-gray-300 bg-white pl-8 pr-3 py-2 text-xs text-gray-800 placeholder:text-gray-400 focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
              />
              <svg class="absolute left-2.5 top-2.5 h-3.5 w-3.5 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z"/>
              </svg>
            </div>
          </div>

        </div>

      </div>

      <!-- ── Tabla Principal de Movimientos ──────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-xs dark:border-gray-700 dark:bg-gray-800 overflow-hidden">

        <div class="overflow-x-auto">
          <table class="w-full text-left text-sm text-gray-600 dark:text-gray-300">
            <thead class="border-b border-gray-200 bg-gray-50/75 text-2xs font-semibold uppercase tracking-wider text-gray-500 dark:border-gray-700 dark:bg-gray-900/40 dark:text-gray-400">
              <tr>
                <th scope="col" class="py-3 px-4">ID</th>
                <th scope="col" class="py-3 px-4">Fecha Recaudación</th>
                <th scope="col" class="py-3 px-4">Socio Participante</th>
                <th scope="col" class="py-3 px-4">Puesto</th>
                <th scope="col" class="py-3 px-4 text-right">Monto</th>
                <th scope="col" class="py-3 px-4">Registrado Por</th>
                <th scope="col" class="py-3 px-4 text-center">Estado</th>
                <th scope="col" class="py-3 px-4 text-right">Acciones</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-100 dark:divide-gray-700">

              @if (cargando()) {
                <tr>
                  <td colspan="8" class="py-12 text-center text-sm text-gray-500">
                    <div class="flex items-center justify-center gap-2">
                      <svg class="h-5 w-5 animate-spin text-brand-600" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                      </svg>
                      Cargando recaudaciones de tarjeta...
                    </div>
                  </td>
                </tr>
              } @else if (itemsPaginados().length === 0) {
                <tr>
                  <td colspan="8" class="py-12 text-center text-sm text-gray-500 dark:text-gray-400">
                    <div class="flex flex-col items-center justify-center gap-1.5">
                      <svg class="h-8 w-8 text-gray-300 dark:text-gray-600" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z"/>
                      </svg>
                      <span>No se encontraron recaudaciones con los filtros aplicados.</span>
                    </div>
                  </td>
                </tr>
              } @else {
                @for (item of itemsPaginados(); track item.id) {
                  <tr class="hover:bg-gray-50/70 dark:hover:bg-gray-700/30 transition">

                    <!-- ID -->
                    <td class="py-3 px-4 font-mono text-xs font-semibold text-gray-700 dark:text-gray-300">
                      {{ item.codigo_ref }}
                    </td>

                    <!-- Fecha Recaudación -->
                    <td class="py-3 px-4 whitespace-nowrap font-mono text-xs text-gray-800 dark:text-gray-200">
                      {{ item.fecha | date:'dd/MM/yyyy':'America/Lima' }}
                    </td>

                    <!-- Socio -->
                    <td class="py-3 px-4">
                      <div class="font-medium text-gray-900 dark:text-white">{{ item.socio_nombre }}</div>
                      <div class="text-2xs text-gray-400 font-mono">DNI: {{ item.socio_dni }}</div>
                    </td>

                    <!-- Puesto -->
                    <td class="py-3 px-4">
                      @if (item.codigo_puesto !== '—') {
                        <span class="inline-flex items-center rounded-md bg-gray-100 px-2 py-0.5 text-xs font-medium text-gray-700 dark:bg-gray-700 dark:text-gray-300">
                          Puesto {{ item.codigo_puesto }}
                        </span>
                      } @else {
                        <span class="text-xs text-gray-400">—</span>
                      }
                    </td>

                    <!-- Monto -->
                    <td class="py-3 px-4 text-right font-black tabular-nums whitespace-nowrap"
                        [class]="item.es_anulado ? 'text-gray-400 line-through' : 'text-gray-900 dark:text-white'">
                      S/ {{ item.monto | number:'1.2-2' }}
                    </td>

                    <!-- Registrado por -->
                    <td class="py-3 px-4 text-xs text-gray-600 dark:text-gray-300">
                      {{ item.cajero_nombre }}
                    </td>

                    <!-- Estado -->
                    <td class="py-3 px-4 text-center">
                      @if (item.es_anulado) {
                        <span class="inline-flex items-center rounded-full bg-red-100 px-2.5 py-0.5 text-2xs font-semibold text-red-700 dark:bg-red-900/30 dark:text-red-400">
                          Anulado
                        </span>
                      } @else {
                        <span class="inline-flex items-center rounded-full bg-emerald-100 px-2.5 py-0.5 text-2xs font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400">
                          Vigente
                        </span>
                      }
                    </td>

                    <!-- Acciones -->
                    <td class="py-3 px-4 text-right whitespace-nowrap">
                      <div class="flex items-center justify-end gap-1">

                        <!-- Ver Detalle -->
                        <button
                          type="button"
                          (click)="abrirDetalle(item)"
                          title="Ver detalle de auditoría"
                          class="rounded-lg p-1.5 text-gray-500 hover:bg-gray-100 hover:text-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-gray-200 transition">
                          <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                          </svg>
                        </button>

                        <!-- Editar (Solo Vigente y Admin) -->
                        @if (!item.es_anulado && esAdmin()) {
                          <button
                            type="button"
                            (click)="abrirEdicion(item)"
                            title="Corregir fecha o monto"
                            class="rounded-lg p-1.5 text-amber-600 hover:bg-amber-50 hover:text-amber-700 dark:text-amber-400 dark:hover:bg-amber-900/30 transition">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0115.75 21H5.25A2.25 2.25 0 013 18.75V8.25A2.25 2.25 0 015.25 6H10"/>
                            </svg>
                          </button>
                        }

                        <!-- Anular (Solo Vigente y Admin) -->
                        @if (!item.es_anulado && esAdmin()) {
                          <button
                            type="button"
                            (click)="abrirAnulacion(item)"
                            title="Anular recaudación"
                            class="rounded-lg p-1.5 text-red-600 hover:bg-red-50 hover:text-red-700 dark:text-red-400 dark:hover:bg-red-900/30 transition">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"/>
                            </svg>
                          </button>
                        }

                      </div>
                    </td>

                  </tr>
                }
              }

            </tbody>
          </table>
        </div>

        <!-- ── Paginación ────────────────────────────────────────────────── -->
        <div class="flex flex-col sm:flex-row items-center justify-between border-t border-gray-200 bg-white px-4 py-3 dark:border-gray-700 dark:bg-gray-800 gap-3">
          <div class="text-xs text-gray-500 dark:text-gray-400">
            Mostrando
            <span class="font-medium text-gray-800 dark:text-gray-200">{{ indiceInicio() + 1 }}</span>
            a
            <span class="font-medium text-gray-800 dark:text-gray-200">{{ indiceFin() }}</span>
            de
            <span class="font-medium text-gray-800 dark:text-gray-200">{{ totalItems() }}</span>
            movimientos
          </div>

          <div class="flex items-center gap-1.5">
            <button
              type="button"
              (click)="paginaAnterior()"
              [disabled]="paginaActual() === 1"
              class="rounded-lg border border-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 hover:bg-gray-50 disabled:opacity-40 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700 transition">
              Anterior
            </button>
            <span class="px-2 text-xs text-gray-500 dark:text-gray-400">
              Página {{ paginaActual() }} de {{ totalPaginas() }}
            </span>
            <button
              type="button"
              (click)="paginaSiguiente()"
              [disabled]="paginaActual() === totalPaginas()"
              class="rounded-lg border border-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 hover:bg-gray-50 disabled:opacity-40 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700 transition">
              Siguiente
            </button>
          </div>
        </div>

      </div>

      <!-- ── Modales ─────────────────────────────────────────────────────── -->
      @if (itemSeleccionadoDetalle()) {
        <app-tarjeta-detalle-modal
          [recaudacion]="itemSeleccionadoDetalle()!"
          (close)="itemSeleccionadoDetalle.set(null)"
        />
      }

      @if (itemSeleccionadoEdicion()) {
        <app-tarjeta-form-modal
          [recaudacion]="itemSeleccionadoEdicion()!"
          (save)="guardarEdicion($event)"
          (cancel)="itemSeleccionadoEdicion.set(null)"
        />
      }

      @if (itemSeleccionadoAnulacion()) {
        <app-tarjeta-anular-modal
          [recaudacion]="itemSeleccionadoAnulacion()!"
          (confirm)="confirmarAnulacion($event)"
          (cancel)="itemSeleccionadoAnulacion.set(null)"
        />
      }

    </div>
  `
})
export class GestionTarjetaComponent implements OnInit {
  private readonly svc = inject(GestionTarjetaService);
  private readonly auth = inject(AuthService);

  readonly esAdmin = computed(() => this.auth.esAdmin());

  // Estado general
  readonly cargando = signal(false);
  readonly error = signal<string | null>(null);
  readonly exito = signal<string | null>(null);

  // Lista base de datos del período y filtro reactivo de búsqueda
  readonly itemsBase = signal<RecaudacionTarjetaItem[]>([]);

  // Filtros
  readonly presetActivo = signal<PresetFecha>('MES');
  readonly fechaDesde = signal<string>('');
  readonly fechaHasta = signal<string>('');
  readonly estadoFiltro = signal<EstadoTarjetaFiltro>('TODOS');
  readonly busqueda = signal<string>('');

  readonly items = computed(() => {
    const lista = this.itemsBase();
    const term = this.busqueda().trim().toLowerCase();
    if (!term) return lista;
    return lista.filter(i =>
      i.id.toString().includes(term) ||
      i.codigo_ref.toLowerCase().includes(term) ||
      i.socio_nombre.toLowerCase().includes(term) ||
      i.socio_dni.toLowerCase().includes(term) ||
      i.codigo_puesto.toLowerCase().includes(term) ||
      i.cajero_nombre.toLowerCase().includes(term)
    );
  });

  // Modales
  readonly itemSeleccionadoDetalle = signal<RecaudacionTarjetaItem | null>(null);
  readonly itemSeleccionadoEdicion = signal<RecaudacionTarjetaItem | null>(null);
  readonly itemSeleccionadoAnulacion = signal<RecaudacionTarjetaItem | null>(null);

  // Paginación
  readonly paginaActual = signal(1);
  readonly tamanioPagina = 25;

  readonly presets: { id: PresetFecha; label: string }[] = [
    { id: 'TODO',   label: 'Histórico Completo' },
    { id: 'HOY',    label: 'Hoy' },
    { id: 'AYER',   label: 'Ayer' },
    { id: '7DIAS',  label: 'Últimos 7 días' },
    { id: 'MES',    label: 'Este mes' },
    { id: 'CUSTOM', label: 'Personalizado' },
  ];

  // Resumen financiero superior
  readonly resumen = computed(() => this.svc.calcularResumen(this.items()));

  readonly totalItems = computed(() => this.items().length);

  readonly totalPaginas = computed(() => {
    const t = Math.ceil(this.totalItems() / this.tamanioPagina);
    return t > 0 ? t : 1;
  });

  readonly indiceInicio = computed(() => (this.paginaActual() - 1) * this.tamanioPagina);

  readonly indiceFin = computed(() =>
    Math.min(this.indiceInicio() + this.tamanioPagina, this.totalItems())
  );

  readonly itemsPaginados = computed(() =>
    this.items().slice(this.indiceInicio(), this.indiceFin())
  );

  ngOnInit(): void {
    this.aplicarPreset('MES', false);
    this.cargar();
  }

  aplicarPreset(preset: PresetFecha, recargar = true): void {
    this.presetActivo.set(preset);
    const hoy = new Date();

    if (preset === 'HOY') {
      const s = formatYMD(hoy);
      this.fechaDesde.set(s);
      this.fechaHasta.set(s);
    } else if (preset === 'AYER') {
      const ayer = new Date(hoy);
      ayer.setDate(hoy.getDate() - 1);
      const s = formatYMD(ayer);
      this.fechaDesde.set(s);
      this.fechaHasta.set(s);
    } else if (preset === '7DIAS') {
      const d7 = new Date(hoy);
      d7.setDate(hoy.getDate() - 6);
      this.fechaDesde.set(formatYMD(d7));
      this.fechaHasta.set(formatYMD(hoy));
    } else if (preset === 'MES') {
      const mIni = new Date(hoy.getFullYear(), hoy.getMonth(), 1);
      this.fechaDesde.set(formatYMD(mIni));
      this.fechaHasta.set(formatYMD(hoy));
    } else if (preset === 'TODO') {
      this.fechaDesde.set('');
      this.fechaHasta.set('');
    }

    if (recargar) {
      this.paginaActual.set(1);
      this.cargar();
    }
  }

  onFechaDesdeChange(val: string): void {
    this.fechaDesde.set(val);
    this.presetActivo.set('CUSTOM');
    this.paginaActual.set(1);
    this.cargar();
  }

  onFechaHastaChange(val: string): void {
    this.fechaHasta.set(val);
    this.presetActivo.set('CUSTOM');
    this.paginaActual.set(1);
    this.cargar();
  }

  onEstadoChange(val: EstadoTarjetaFiltro): void {
    this.estadoFiltro.set(val);
    this.paginaActual.set(1);
    this.cargar();
  }

  onBusquedaChange(val: string): void {
    this.busqueda.set(val);
    this.paginaActual.set(1);
  }

  async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);

    const f: FiltrosTarjeta = {
      fechaDesde: this.fechaDesde() || undefined,
      fechaHasta: this.fechaHasta() || undefined,
      estado:     this.estadoFiltro(),
    };

    try {
      const datos = await this.svc.getRecaudaciones(f);
      this.itemsBase.set(datos);
    } catch (e: any) {
      this.error.set(e?.message ?? 'Error al cargar las recaudaciones de tarjeta.');
    } finally {
      this.cargando.set(false);
    }
  }

  paginaAnterior(): void {
    if (this.paginaActual() > 1) {
      this.paginaActual.update(p => p - 1);
    }
  }

  paginaSiguiente(): void {
    if (this.paginaActual() < this.totalPaginas()) {
      this.paginaActual.update(p => p + 1);
    }
  }

  abrirDetalle(item: RecaudacionTarjetaItem): void {
    this.itemSeleccionadoDetalle.set(item);
  }

  abrirEdicion(item: RecaudacionTarjetaItem): void {
    this.itemSeleccionadoEdicion.set(item);
  }

  abrirAnulacion(item: RecaudacionTarjetaItem): void {
    this.itemSeleccionadoAnulacion.set(item);
  }

  async guardarEdicion(params: EditarRecaudacionParams): Promise<void> {
    this.error.set(null);
    try {
      await this.svc.editarRecaudacion(params);
      this.itemSeleccionadoEdicion.set(null);
      this.exito.set(`Recaudación REC-${String(params.id).padStart(6, '0')} actualizada correctamente.`);
      await this.cargar();
    } catch (e: any) {
      this.itemSeleccionadoEdicion.set(null);
      this.error.set(e?.message ?? 'Error al actualizar la recaudación.');
      await this.cargar();
    }
  }

  async confirmarAnulacion(ev: { id: number; motivo: string; updated_at: string }): Promise<void> {
    this.error.set(null);
    try {
      await this.svc.anularRecaudacion(ev.id, ev.motivo, ev.updated_at);
      this.itemSeleccionadoAnulacion.set(null);
      this.exito.set(`Recaudación REC-${String(ev.id).padStart(6, '0')} anulada exitosamente.`);
      await this.cargar();
    } catch (e: any) {
      this.itemSeleccionadoAnulacion.set(null);
      this.error.set(e?.message ?? 'Error al anular la recaudación.');
      await this.cargar();
    }
  }
}
