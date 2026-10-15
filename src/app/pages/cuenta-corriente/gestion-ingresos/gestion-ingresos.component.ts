import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { CommonModule, DatePipe, DecimalPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../../core/services/auth.service';
import {
  ConceptoSimple,
  EditarIngresoParams,
  EstadoIngreso,
  GestionIngresosService,
  IngresoInternoItem,
  MetodoPagoIngreso,
} from '../../../core/services/gestion-ingresos.service';
import { IngresoDetalleModalComponent } from './ingreso-detalle-modal.component';
import { IngresoFormModalComponent } from './ingreso-form-modal.component';
import { IngresoAnularModalComponent } from './ingreso-anular-modal.component';

type PresetFecha = 'TODO' | 'HOY' | 'AYER' | '7DIAS' | 'MES' | 'CUSTOM';

function formatYMD(d: Date): string {
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const dd = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${dd}`;
}

@Component({
  selector: 'app-gestion-ingresos',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    DatePipe,
    DecimalPipe,
    IngresoDetalleModalComponent,
    IngresoFormModalComponent,
    IngresoAnularModalComponent,
  ],
  template: `
    <div class="mx-auto max-w-7xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white flex items-center gap-2">
            Gestión de Ingresos
            <span class="rounded-full bg-brand-100 px-2.5 py-0.5 text-xs font-semibold text-brand-700 dark:bg-brand-900/30 dark:text-brand-300">
              Caja Rápida
            </span>
          </h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Administración, auditoría, corrección y anulación de cobros espontáneos sin recibo.
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

      <!-- ── KPIs Financieros Superiores (Calculados sobre todo el filtro) ── -->
      <div class="grid grid-cols-2 gap-4 sm:grid-cols-2 lg:grid-cols-4 mb-6">

        <!-- Total Vigente -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Total Vigente</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
            S/ {{ resumen().totalVigente | number:'1.2-2' }}
          </p>
          <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
            {{ resumen().cantidadVigentes }} movimiento(s) activo(s)
          </p>
        </div>

        <!-- Efectivo -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Efectivo (Gaveta)</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-emerald-50 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0115.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 013 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 00-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 01-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 003 15h-.75"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-emerald-600 dark:text-emerald-400 tabular-nums">
            S/ {{ resumen().totalEfectivo | number:'1.2-2' }}
          </p>
          <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
            Suma física en caja diaria
          </p>
        </div>

        <!-- Transferencia / QR -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Transferencia / QR</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-blue-50 text-blue-600 dark:bg-blue-900/30 dark:text-blue-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 008.716-6.747M12 21a9.004 9.004 0 01-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 017.843 4.582M12 3a8.997 8.997 0 00-7.843 4.582m15.686 0A11.953 11.953 0 0112 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0121 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0112 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 013 12c0-1.605.42-3.113 1.157-4.418"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-blue-600 dark:text-blue-400 tabular-nums">
            S/ {{ resumen().totalTransferencia | number:'1.2-2' }}
          </p>
          <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
            Abonos en cuenta bancaria
          </p>
        </div>

        <!-- Total Operaciones / Anulados -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-700 dark:bg-gray-800">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Total Operaciones</span>
            <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-purple-50 text-purple-600 dark:bg-purple-900/30 dark:text-purple-300">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 12h16.5m-16.5 3.75h16.5M3.75 19.5h16.5M5.625 4.5h12.75a1.875 1.875 0 010 3.75H5.625a1.875 1.875 0 010-3.75z"/>
              </svg>
            </div>
          </div>
          <p class="mt-2 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
            {{ totalItems() }}
          </p>
          <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
            @if (resumen().cantidadAnuladas > 0) {
              <span class="text-red-500 font-semibold">{{ resumen().cantidadAnuladas }} anulado(s)</span> (S/ {{ resumen().totalAnulados | number:'1.2-2' }})
            } @else {
              0 anulados en este período
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

        <!-- Controles de Filtros Detallados -->
        <div class="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-5">

          <!-- Rango Desde -->
          <div>
            <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Fecha Desde</label>
            <input
              type="date"
              [ngModel]="fechaDesde()"
              (ngModelChange)="onFechaChange('desde', $event)"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
            />
          </div>

          <!-- Rango Hasta -->
          <div>
            <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Fecha Hasta</label>
            <input
              type="date"
              [ngModel]="fechaHasta()"
              (ngModelChange)="onFechaChange('hasta', $event)"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white"
            />
          </div>

          <!-- Concepto -->
          <div>
            <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Concepto</label>
            <select
              [ngModel]="conceptoIdFiltro()"
              (ngModelChange)="conceptoIdFiltro.set($event ? +$event : null); cargar()"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white">
              <option [value]="null">Todos los conceptos</option>
              @for (c of conceptos(); track c.id) {
                <option [value]="c.id">{{ c.nombre }}</option>
              }
            </select>
          </div>

          <!-- Método de Pago -->
          <div>
            <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Método de Pago</label>
            <select
              [ngModel]="metodoPagoFiltro()"
              (ngModelChange)="metodoPagoFiltro.set($event); cargar()"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white">
              <option value="TODOS">Todos</option>
              <option value="Efectivo">Solo Efectivo</option>
              <option value="Transferencia">Solo Transferencia/QR</option>
            </select>
          </div>

          <!-- Estado -->
          <div>
            <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Estado</label>
            <select
              [ngModel]="estadoFiltro()"
              (ngModelChange)="estadoFiltro.set($event); cargar()"
              class="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-xs text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white">
              <option value="TODOS">Todos los estados</option>
              <option value="VIGENTES">Solo Vigentes</option>
              <option value="ANULADOS">Solo Anulados</option>
            </select>
          </div>

        </div>

        <!-- Buscador de texto y reset -->
        <div class="flex flex-col sm:flex-row items-center gap-3 pt-2">
          <div class="relative flex-1 w-full">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z"/>
              </svg>
            </span>
            <input
              type="text"
              [ngModel]="busquedaTexto()"
              (ngModelChange)="busquedaTexto.set($event); onBusquedaInput()"
              placeholder="Buscar por ID (INT-000056), concepto, cajero u observación..."
              class="w-full rounded-xl border border-gray-300 bg-white pl-9 pr-4 py-2 text-xs text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-900 dark:text-white placeholder:text-gray-400"
            />
          </div>

          <button
            type="button"
            (click)="limpiarFiltros()"
            class="text-xs text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 transition underline whitespace-nowrap">
            Limpiar filtros
          </button>
        </div>

      </div>

      <!-- ── Tabla Principal de Movimientos ──────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-xs dark:border-gray-700 dark:bg-gray-800 overflow-hidden">

        @if (cargando() && ingresos().length === 0) {
          <div class="p-12 flex flex-col items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="inline-block h-6 w-6 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            <p class="text-sm">Cargando registros de ingresos...</p>
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
              <thead class="bg-gray-50 text-xs font-semibold uppercase tracking-wider text-gray-600 dark:bg-gray-900/60 dark:text-gray-400 border-b border-gray-200 dark:border-gray-700">
                <tr>
                  <th class="px-4 py-3.5">Ref. / ID</th>
                  <th class="px-4 py-3.5">Fecha Operación</th>
                  <th class="px-4 py-3.5">Concepto</th>
                  <th class="px-4 py-3.5">Método</th>
                  <th class="px-4 py-3.5 text-right">Monto</th>
                  <th class="px-4 py-3.5">Registrado por</th>
                  <th class="px-4 py-3.5 text-center">Estado</th>
                  <th class="px-4 py-3.5 text-right">Acciones</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700 text-xs sm:text-sm">
                @for (item of ingresosPaginados(); track item.id) {
                  <tr
                    [class]="item.es_anulado
                      ? 'bg-red-50/30 text-gray-400 dark:bg-red-950/10 dark:text-gray-500'
                      : 'hover:bg-gray-50 dark:hover:bg-gray-900/30 text-gray-800 dark:text-gray-200'"
                    class="transition">

                    <!-- Ref / ID -->
                    <td class="px-4 py-3 font-mono font-bold whitespace-nowrap text-brand-600 dark:text-brand-400">
                      {{ item.codigo_ref }}
                    </td>

                    <!-- Fecha Operación -->
                    <td class="px-4 py-3 whitespace-nowrap font-mono text-xs">
                      <div>{{ item.fecha_ingreso | date:'dd/MM/yyyy HH:mm':'America/Lima' }}</div>
                      <div class="text-[10px] text-gray-400">Creado: {{ item.created_at | date:'dd/MM/yy HH:mm':'America/Lima' }}</div>
                    </td>

                    <!-- Concepto -->
                    <td class="px-4 py-3">
                      <div class="font-semibold text-gray-900 dark:text-white">{{ item.concepto_nombre }}</div>
                      <span class="inline-flex items-center rounded-md px-1.5 py-0.5 text-[10px] font-medium"
                        [class]="item.concepto_grupo === 'INQUILINOS'
                          ? 'bg-amber-100 text-amber-800 dark:bg-amber-900/30 dark:text-amber-300'
                          : 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-300'">
                        {{ item.concepto_grupo === 'INQUILINOS' ? 'Inquilinos' : 'Otros' }}
                      </span>
                    </td>

                    <!-- Método -->
                    <td class="px-4 py-3 whitespace-nowrap">
                      @if (item.metodo_pago === 'Efectivo') {
                        <span class="inline-flex items-center gap-1 rounded-full bg-emerald-50 px-2 py-0.5 text-xs font-medium text-emerald-700 dark:bg-emerald-950/40 dark:text-emerald-400">
                          <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>
                          Efectivo
                        </span>
                      } @else {
                        <span class="inline-flex items-center gap-1 rounded-full bg-blue-50 px-2 py-0.5 text-xs font-medium text-blue-700 dark:bg-blue-950/40 dark:text-blue-400">
                          <span class="h-1.5 w-1.5 rounded-full bg-blue-500"></span>
                          Transferencia
                        </span>
                      }
                    </td>

                    <!-- Monto -->
                    <td class="px-4 py-3 text-right font-bold tabular-nums whitespace-nowrap"
                      [class.line-through]="item.es_anulado">
                      S/ {{ item.monto | number:'1.2-2' }}
                    </td>

                    <!-- Cajero -->
                    <td class="px-4 py-3 whitespace-nowrap text-xs">
                      <div class="text-gray-900 dark:text-gray-200 font-medium">{{ item.cajero_nombre }}</div>
                    </td>

                    <!-- Estado -->
                    <td class="px-4 py-3 text-center whitespace-nowrap">
                      @if (item.es_anulado) {
                        <span class="inline-flex items-center rounded-full bg-red-100 px-2 py-0.5 text-xs font-semibold text-red-700 dark:bg-red-900/30 dark:text-red-400"
                          [title]="item.motivo_anulacion || 'Sin motivo'">
                          Anulado
                        </span>
                      } @else {
                        <span class="inline-flex items-center rounded-full bg-emerald-100 px-2 py-0.5 text-xs font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400">
                          Vigente
                        </span>
                      }
                    </td>

                    <!-- Acciones -->
                    <td class="px-4 py-3 text-right whitespace-nowrap">
                      <div class="inline-flex items-center gap-1">

                        <!-- Ver Detalle (Todos los roles) -->
                        <button
                          type="button"
                          (click)="itemDetalle.set(item)"
                          title="Ver detalle de auditoría"
                          class="rounded-lg p-1.5 text-gray-500 hover:bg-gray-100 hover:text-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-gray-200 transition">
                          <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                          </svg>
                        </button>

                        <!-- Editar (Solo Administrador y registros vigentes) -->
                        @if (esAdmin() && !item.es_anulado) {
                          <button
                            type="button"
                            (click)="itemEditar.set(item)"
                            title="Editar ingreso"
                            class="rounded-lg p-1.5 text-amber-600 hover:bg-amber-50 hover:text-amber-800 dark:text-amber-400 dark:hover:bg-amber-900/30 transition">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0115.75 21H5.25A2.25 2.25 0 013 18.75V8.25A2.25 2.25 0 015.25 6H10"/>
                            </svg>
                          </button>
                        }

                        <!-- Anular (Solo Administrador y registros vigentes) -->
                        @if (esAdmin() && !item.es_anulado) {
                          <button
                            type="button"
                            (click)="itemAnular.set(item)"
                            title="Anular ingreso"
                            class="rounded-lg p-1.5 text-red-600 hover:bg-red-50 hover:text-red-800 dark:text-red-400 dark:hover:bg-red-900/30 transition">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0"/>
                            </svg>
                          </button>
                        }

                      </div>
                    </td>

                  </tr>
                } @empty {
                  <tr>
                    <td colspan="8" class="p-12 text-center text-gray-500 dark:text-gray-400">
                      <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-gray-100 text-gray-400 dark:bg-gray-700">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5m6 4.125l2.25 2.25m0 0l2.25 2.25M12 13.875l2.25-2.25M12 13.875l-2.25 2.25M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z"/>
                        </svg>
                      </div>
                      <p class="mt-3 text-sm font-medium text-gray-900 dark:text-white">No se encontraron ingresos</p>
                      <p class="mt-1 text-xs text-gray-400">Intente modificar los filtros o el rango de fechas.</p>
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>

          <!-- Paginador -->
          @if (totalItems() > 0) {
            <div class="flex flex-col sm:flex-row items-center justify-between border-t border-gray-200 bg-gray-50/50 px-4 py-3 dark:border-gray-700 dark:bg-gray-900/40 gap-3">
              <div class="text-xs text-gray-500 dark:text-gray-400">
                Mostrando <strong class="text-gray-900 dark:text-white">{{ (paginaActual() - 1) * itemsPorPagina() + 1 }}</strong> a
                <strong class="text-gray-900 dark:text-white">{{ Math.min(paginaActual() * itemsPorPagina(), totalItems()) }}</strong> de
                <strong class="text-gray-900 dark:text-white">{{ totalItems() }}</strong> ingresos filtrados
              </div>

              <div class="flex items-center gap-2">
                <select
                  [ngModel]="itemsPorPagina()"
                  (ngModelChange)="itemsPorPagina.set(+$event); paginaActual.set(1)"
                  class="rounded-lg border border-gray-300 bg-white px-2 py-1 text-xs text-gray-700 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-200">
                  <option [value]="10">10 por pág.</option>
                  <option [value]="25">25 por pág.</option>
                  <option [value]="50">50 por pág.</option>
                  <option [value]="100">100 por pág.</option>
                </select>

                <div class="inline-flex rounded-lg border border-gray-300 bg-white dark:border-gray-600 dark:bg-gray-800 shadow-2xs">
                  <button
                    type="button"
                    (click)="paginaActual.set(paginaActual() - 1)"
                    [disabled]="paginaActual() <= 1"
                    class="rounded-l-lg px-2.5 py-1 text-xs text-gray-600 hover:bg-gray-50 disabled:opacity-40 dark:text-gray-300 dark:hover:bg-gray-700 transition">
                    Anterior
                  </button>
                  <span class="border-x border-gray-300 px-3 py-1 text-xs font-semibold text-gray-700 dark:border-gray-600 dark:text-gray-200">
                    {{ paginaActual() }} / {{ totalPaginas() }}
                  </span>
                  <button
                    type="button"
                    (click)="paginaActual.set(paginaActual() + 1)"
                    [disabled]="paginaActual() >= totalPaginas()"
                    class="rounded-r-lg px-2.5 py-1 text-xs text-gray-600 hover:bg-gray-50 disabled:opacity-40 dark:text-gray-300 dark:hover:bg-gray-700 transition">
                    Siguiente
                  </button>
                </div>
              </div>
            </div>
          }
        }

      </div>

    </div>

    <!-- ── Modales ───────────────────────────────────────────────────────── -->
    @if (itemDetalle(); as item) {
      <app-ingreso-detalle-modal
        [ingreso]="item"
        (close)="itemDetalle.set(null)"
      />
    }

    @if (itemEditar(); as item) {
      <app-ingreso-form-modal
        [ingreso]="item"
        [conceptos]="conceptos()"
        (cancel)="itemEditar.set(null)"
        (save)="guardarEdicion($event)"
      />
    }

    @if (itemAnular(); as item) {
      <app-ingreso-anular-modal
        [ingreso]="item"
        (cancel)="itemAnular.set(null)"
        (confirm)="confirmarAnulacion($event)"
      />
    }
  `
})
export class GestionIngresosComponent implements OnInit {
  protected readonly Math = Math;
  private readonly gestionSvc = inject(GestionIngresosService);
  protected readonly auth = inject(AuthService);

  // Datos
  ingresos = signal<IngresoInternoItem[]>([]);
  conceptos = signal<ConceptoSimple[]>([]);
  cargando = signal<boolean>(false);
  error = signal<string | null>(null);
  exito = signal<string | null>(null);

  // Filtros
  presetActivo = signal<PresetFecha>('TODO');
  fechaDesde = signal<string>('');
  fechaHasta = signal<string>('');
  conceptoIdFiltro = signal<number | null>(null);
  metodoPagoFiltro = signal<MetodoPagoIngreso | 'TODOS'>('TODOS');
  estadoFiltro = signal<EstadoIngreso>('TODOS');
  busquedaTexto = signal<string>('');

  // Paginación
  paginaActual = signal<number>(1);
  itemsPorPagina = signal<number>(25);

  // Modales
  itemDetalle = signal<IngresoInternoItem | null>(null);
  itemEditar = signal<IngresoInternoItem | null>(null);
  itemAnular = signal<IngresoInternoItem | null>(null);

  // Roles
  esAdmin = computed(() => this.auth.esAdmin());

  // KPIs calculados sobre el conjunto total filtrado
  resumen = computed(() => this.gestionSvc.calcularResumen(this.ingresos()));
  totalItems = computed(() => this.ingresos().length);
  totalPaginas = computed(() => Math.ceil(this.totalItems() / this.itemsPorPagina()) || 1);

  ingresosPaginados = computed(() => {
    const start = (this.paginaActual() - 1) * this.itemsPorPagina();
    return this.ingresos().slice(start, start + this.itemsPorPagina());
  });

  presets: { id: PresetFecha; label: string }[] = [
    { id: 'TODO', label: 'Histórico Completo' },
    { id: 'HOY', label: 'Hoy' },
    { id: 'AYER', label: 'Ayer' },
    { id: '7DIAS', label: 'Últimos 7 días' },
    { id: 'MES', label: 'Este Mes' },
  ];

  ngOnInit() {
    void this.cargarConceptos();
    void this.cargar();
  }

  async cargarConceptos() {
    try {
      const data = await this.gestionSvc.getConceptos();
      this.conceptos.set(data);
    } catch (e: any) {
      console.error('Error cargando conceptos:', e);
    }
  }

  async cargar() {
    this.cargando.set(true);
    this.error.set(null);
    try {
      const items = await this.gestionSvc.getIngresos({
        fechaDesde: this.fechaDesde() || undefined,
        fechaHasta: this.fechaHasta() || undefined,
        conceptoId: this.conceptoIdFiltro(),
        metodoPago: this.metodoPagoFiltro(),
        estado: this.estadoFiltro(),
        busqueda: this.busquedaTexto(),
      });
      this.ingresos.set(items);
      this.paginaActual.set(1);
    } catch (e: any) {
      this.error.set(e?.message || 'Error al consultar los registros de ingresos.');
    } finally {
      this.cargando.set(false);
    }
  }

  aplicarPreset(preset: PresetFecha) {
    this.presetActivo.set(preset);
    const hoy = new Date();

    if (preset === 'HOY') {
      const s = formatYMD(hoy);
      this.fechaDesde.set(s);
      this.fechaHasta.set(s);
    } else if (preset === 'AYER') {
      const ayer = new Date(hoy);
      ayer.setDate(ayer.getDate() - 1);
      const s = formatYMD(ayer);
      this.fechaDesde.set(s);
      this.fechaHasta.set(s);
    } else if (preset === '7DIAS') {
      const sieteDias = new Date(hoy);
      sieteDias.setDate(sieteDias.getDate() - 6);
      this.fechaDesde.set(formatYMD(sieteDias));
      this.fechaHasta.set(formatYMD(hoy));
    } else if (preset === 'MES') {
      const primerDia = new Date(hoy.getFullYear(), hoy.getMonth(), 1);
      this.fechaDesde.set(formatYMD(primerDia));
      this.fechaHasta.set(formatYMD(hoy));
    } else if (preset === 'TODO') {
      this.fechaDesde.set('');
      this.fechaHasta.set('');
    }

    void this.cargar();
  }

  onFechaChange(tipo: 'desde' | 'hasta', valor: string) {
    this.presetActivo.set('CUSTOM');
    if (tipo === 'desde') this.fechaDesde.set(valor);
    else this.fechaHasta.set(valor);
    void this.cargar();
  }

  private searchDebounce: any;
  onBusquedaInput() {
    clearTimeout(this.searchDebounce);
    this.searchDebounce = setTimeout(() => {
      void this.cargar();
    }, 300);
  }

  limpiarFiltros() {
    this.presetActivo.set('TODO');
    this.fechaDesde.set('');
    this.fechaHasta.set('');
    this.conceptoIdFiltro.set(null);
    this.metodoPagoFiltro.set('TODOS');
    this.estadoFiltro.set('TODOS');
    this.busquedaTexto.set('');
    void this.cargar();
  }

  async guardarEdicion(params: EditarIngresoParams) {
    this.error.set(null);
    try {
      await this.gestionSvc.editarIngreso(params);
      this.itemEditar.set(null);
      this.exito.set('El ingreso fue corregido y auditado exitosamente.');
      void this.cargar();
    } catch (e: any) {
      this.error.set(e?.message || 'Error al actualizar el ingreso.');
    }
  }

  async confirmarAnulacion(data: { id: number; motivo: string; updated_at: string }) {
    this.error.set(null);
    try {
      await this.gestionSvc.anularIngreso(data.id, data.motivo, data.updated_at);
      this.itemAnular.set(null);
      this.exito.set('El ingreso fue anulado y registrado en auditoría correctamente.');
      void this.cargar();
    } catch (e: any) {
      this.error.set(e?.message || 'Error al anular el ingreso.');
    }
  }
}
