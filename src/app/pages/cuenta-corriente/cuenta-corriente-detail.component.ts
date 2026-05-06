import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { CuentaCorrienteService } from './cuenta-corriente.service';
import {
  DeudaItem,
  EditarPagoForm,
  MESES_NOMBRES,
  NuevoAbonoForm,
  NuevoCargoForm,
  PagoResumen,
  PersonaDetalle,
  TipoPersona,
} from './cuenta-corriente.model';

function formatSoles(n: number): string {
  return `S/ ${Number(n ?? 0).toFixed(2)}`;
}
function formatPeriodo(anio: number, mes: number): string {
  return `${MESES_NOMBRES[mes] ?? mes} ${anio}`;
}
function formatFecha(s: string): string {
  if (!s) return '—';
  return new Date(s).toLocaleDateString('es-PE', { day: '2-digit', month: 'short', year: 'numeric' });
}
function todayIso(): string {
  return new Date().toISOString().slice(0, 10);
}
function fechaToInputDate(isoStr: string): string {
  if (!isoStr) return todayIso();
  return new Date(isoStr).toISOString().slice(0, 10);
}

type Tab = 'deudas' | 'pagos';

@Component({
  selector: 'app-cuenta-corriente-detail',
  standalone: true,
  imports: [RouterModule],
  template: `
    <div class="mx-auto max-w-5xl p-4 md:p-6">

      <!-- Breadcrumb -->
      <nav class="mb-4 flex items-center gap-2 text-sm text-gray-500 dark:text-gray-400">
        <a routerLink="/cuenta-corriente" class="hover:text-brand-500">Cuenta Corriente</a>
        <span>/</span>
        <span class="text-gray-800 dark:text-white">{{ persona()?.nombre || 'Detalle' }}</span>
      </nav>

      @if (cargando()) {
        <div class="flex h-64 items-center justify-center">
          <svg class="h-8 w-8 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
          </svg>
        </div>
      } @else if (error()) {
        <p class="rounded-xl bg-red-50 p-4 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">
          {{ error() }}
        </p>
      } @else if (detalle()) {

        <!-- ── CABECERA PERSONA ────────────────────────────────────────────── -->
        <div class="mb-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
            <div class="flex items-center gap-4">
              <div class="flex h-14 w-14 items-center justify-center rounded-full text-sm font-bold"
                   [class]="persona()!.tipo === 'socio'
                     ? 'bg-brand-100 text-brand-600 dark:bg-brand-900/40 dark:text-brand-300'
                     : 'bg-amber-100 text-amber-600 dark:bg-amber-900/40 dark:text-amber-300'">
                {{ persona()!.tipo === 'socio' ? 'SC' : 'IQ' }}
              </div>
              <div>
                <div class="flex items-center gap-2">
                  <h2 class="text-xl font-bold text-gray-800 dark:text-white">
                    {{ persona()!.nombre }}
                  </h2>
                  <span class="rounded-full px-2.5 py-0.5 text-xs font-semibold"
                        [class]="persona()!.tipo === 'socio'
                          ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/40 dark:text-brand-300'
                          : 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300'">
                    {{ persona()!.tipo === 'socio' ? 'Socio' : 'Inquilino' }}
                  </span>
                </div>
                <p class="text-sm text-gray-400">
                  DNI {{ persona()!.dni }}
                  @if (persona()!.codigo_puesto) { · Puesto {{ persona()!.codigo_puesto }} }
                </p>
              </div>
            </div>

            <!-- Botones de acción -->
            <div class="flex gap-2">
              <button (click)="abrirNuevoCargo()"
                      class="flex items-center gap-1.5 rounded-lg border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700
                             transition hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
                </svg>
                Nuevo Cargo
              </button>
              <button (click)="abrirNuevoAbono()"
                      class="flex items-center gap-1.5 rounded-lg bg-green-600 px-4 py-2 text-sm font-semibold text-white
                             transition hover:bg-green-700">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
                </svg>
                Nuevo Abono
              </button>
            </div>
          </div>
        </div>

        <!-- ── KPIs ──────────────────────────────────────────────────────── -->
        <div class="mb-6 grid grid-cols-2 gap-4 sm:grid-cols-4">
          <!-- Saldo a favor -->
          <div class="rounded-2xl border border-emerald-200 bg-emerald-50 p-4 dark:border-emerald-800/40 dark:bg-emerald-900/20">
            <p class="text-xs font-medium text-emerald-600 dark:text-emerald-400">Saldo a Favor</p>
            <p class="mt-1 text-2xl font-bold text-emerald-700 dark:text-emerald-300">
              {{ formatSoles(persona()!.saldo_a_favor) }}
            </p>
          </div>
          <!-- Deuda total -->
          <div class="rounded-2xl border p-4"
               [class]="deudaTotal() > 0
                 ? 'border-red-200 bg-red-50 dark:border-red-800/40 dark:bg-red-900/20'
                 : 'border-green-200 bg-green-50 dark:border-green-800/40 dark:bg-green-900/20'">
            <p class="text-xs font-medium"
               [class]="deudaTotal() > 0 ? 'text-red-600 dark:text-red-400' : 'text-green-600 dark:text-green-400'">
              Deuda Pendiente
            </p>
            <p class="mt-1 text-2xl font-bold"
               [class]="deudaTotal() > 0 ? 'text-red-700 dark:text-red-300' : 'text-green-700 dark:text-green-300'">
              {{ formatSoles(deudaTotal()) }}
            </p>
          </div>
          <!-- Deudas activas -->
          <div class="rounded-2xl border border-gray-200 bg-gray-50 p-4 dark:border-gray-700 dark:bg-gray-700/30">
            <p class="text-xs font-medium text-gray-500 dark:text-gray-400">Deudas Activas</p>
            <p class="mt-1 text-2xl font-bold text-gray-800 dark:text-white">
              {{ deudasPendientes().length }}
            </p>
          </div>
          <!-- Pagos realizados -->
          <div class="rounded-2xl border border-gray-200 bg-gray-50 p-4 dark:border-gray-700 dark:bg-gray-700/30">
            <p class="text-xs font-medium text-gray-500 dark:text-gray-400">Pagos Realizados</p>
            <p class="mt-1 text-2xl font-bold text-gray-800 dark:text-white">
              {{ pagosActivos().length }}
            </p>
          </div>
        </div>

        <!-- ── TABS ──────────────────────────────────────────────────────── -->
        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <!-- Tab headers -->
          <div class="flex border-b border-gray-200 dark:border-gray-700">
            <button (click)="tab.set('deudas')"
                    class="flex items-center gap-2 px-6 py-4 text-sm font-medium transition border-b-2"
                    [class]="tab() === 'deudas'
                      ? 'border-brand-500 text-brand-600 dark:text-brand-400'
                      : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'">
              Deudas Pendientes
              @if (deudasPendientes().length > 0) {
                <span class="rounded-full bg-red-100 px-2 py-0.5 text-xs text-red-600 dark:bg-red-900/30 dark:text-red-400">
                  {{ deudasPendientes().length }}
                </span>
              }
            </button>
            <button (click)="tab.set('pagos')"
                    class="flex items-center gap-2 px-6 py-4 text-sm font-medium transition border-b-2"
                    [class]="tab() === 'pagos'
                      ? 'border-brand-500 text-brand-600 dark:text-brand-400'
                      : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'">
              Historial de Pagos
              <span class="rounded-full bg-gray-100 px-2 py-0.5 text-xs text-gray-600 dark:bg-gray-700 dark:text-gray-300">
                {{ pagosActivos().length }}
              </span>
            </button>
          </div>

          <!-- ── TAB DEUDAS ─────────────────────────────────────────────── -->
          @if (tab() === 'deudas') {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Concepto / Período</th>
                    <th class="px-5 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Original</th>
                    <th class="px-5 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Ya Pagado</th>
                    <th class="px-5 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Saldo</th>
                    <th class="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Estado</th>
                    <th class="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Acciones</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (d of deudasPendientes(); track d.id) {
                    <tr class="bg-white dark:bg-gray-800">
                      <td class="px-5 py-3.5">
                        <p class="font-medium text-gray-800 dark:text-white">{{ d.concepto }}</p>
                        <p class="text-xs text-gray-400">{{ formatPeriodo(d.periodo_anio, d.periodo_mes) }}</p>
                      </td>
                      <td class="px-5 py-3.5 text-right text-gray-600 dark:text-gray-300">{{ formatSoles(d.monto) }}</td>
                      <td class="px-5 py-3.5 text-right text-green-600 dark:text-green-400">
                        {{ d.ya_pagado > 0 ? formatSoles(d.ya_pagado) : '—' }}
                      </td>
                      <td class="px-5 py-3.5 text-right font-bold text-red-600 dark:text-red-400">
                        {{ formatSoles(d.saldo_pendiente) }}
                      </td>
                      <td class="px-5 py-3.5 text-center">
                        <span class="rounded-full px-2.5 py-0.5 text-xs font-medium"
                              [class]="d.estado === 'Pagado'
                                ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400'
                                : d.ya_pagado > 0
                                  ? 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400'
                                  : 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400'">
                          {{ d.ya_pagado > 0 && d.estado !== 'Pagado' ? 'Parcial' : d.estado }}
                        </span>
                      </td>
                      <td class="px-5 py-3.5 text-center">
                        @if (d.ya_pagado === 0) {
                          <button (click)="confirmarAnularCargo(d)"
                                  class="rounded-lg border border-red-200 px-3 py-1 text-xs font-medium text-red-600
                                         hover:bg-red-50 dark:border-red-800 dark:text-red-400 dark:hover:bg-red-900/20">
                            Anular
                          </button>
                        } @else {
                          <span class="text-xs text-gray-400">Con pagos</span>
                        }
                      </td>
                    </tr>
                  } @empty {
                    <tr>
                      <td colspan="6" class="py-10 text-center text-sm text-gray-400">
                        No hay deudas pendientes.
                      </td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>
          }

          <!-- ── TAB PAGOS ─────────────────────────────────────────────── -->
          @if (tab() === 'pagos') {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Transacción</th>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Fecha</th>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Método</th>
                    <th class="px-5 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Total</th>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Conceptos</th>
                    <th class="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Acciones</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (pg of detalle()!.pagos; track pg.id) {
                    <tr [class]="pg.anulado ? 'opacity-50 bg-gray-50 dark:bg-gray-800/50' : 'bg-white dark:bg-gray-800'">
                      <td class="px-5 py-3.5">
                        <p class="font-mono text-xs font-medium text-gray-800 dark:text-white">
                          {{ pg.codigo_transaccion }}
                        </p>
                        @if (pg.comprobante) {
                          <p class="text-xs text-gray-400">Ref: {{ pg.comprobante }}</p>
                        }
                        @if (pg.anulado) {
                          <p class="text-xs text-red-500">ANULADO</p>
                        }
                      </td>
                      <td class="px-5 py-3.5 text-gray-600 dark:text-gray-300">
                        {{ formatFecha(pg.fecha_pago) }}
                      </td>
                      <td class="px-5 py-3.5">
                        <span class="rounded-full px-2 py-0.5 text-xs"
                              [class]="pg.metodo_pago === 'Efectivo'
                                ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400'
                                : 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400'">
                          {{ pg.metodo_pago }}
                        </span>
                      </td>
                      <td class="px-5 py-3.5 text-right font-bold text-gray-800 dark:text-white">
                        {{ formatSoles(pg.monto_total) }}
                      </td>
                      <td class="px-5 py-3.5">
                        <div class="flex flex-wrap gap-1">
                          @for (d of pg.detalle; track d.concepto) {
                            <span class="rounded-full border border-gray-200 bg-gray-50 px-2 py-0.5 text-xs text-gray-600
                                         dark:border-gray-700 dark:bg-gray-700 dark:text-gray-300">
                              {{ d.concepto }}: {{ formatSoles(d.monto_aplicado) }}
                            </span>
                          }
                        </div>
                      </td>
                      <td class="px-5 py-3.5 text-center">
                        @if (!pg.anulado) {
                          <div class="flex items-center justify-center gap-1.5">
                            <button (click)="abrirEditarPago(pg)"
                                    class="rounded-lg border border-blue-200 px-3 py-1 text-xs font-medium text-blue-600
                                           hover:bg-blue-50 dark:border-blue-800 dark:text-blue-400 dark:hover:bg-blue-900/20">
                              Editar
                            </button>
                            <button (click)="confirmarAnularPago(pg)"
                                    class="rounded-lg border border-red-200 px-3 py-1 text-xs font-medium text-red-600
                                           hover:bg-red-50 dark:border-red-800 dark:text-red-400 dark:hover:bg-red-900/20">
                              Anular
                            </button>
                          </div>
                        } @else {
                          <span class="text-xs text-gray-400">Anulado</span>
                        }
                      </td>
                    </tr>
                  } @empty {
                    <tr>
                      <td colspan="6" class="py-10 text-center text-sm text-gray-400">
                        No hay pagos registrados.
                      </td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>
          }
        </div>
      }
    </div>

    <!-- ══════════════════════════════════════════════════════════════════════ -->
    <!-- MODALES                                                               -->
    <!-- ══════════════════════════════════════════════════════════════════════ -->

    <!-- Modal: Nuevo Cargo -->
    @if (modalCargo()) {
      <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4" (click)="cerrarModales()">
        <div class="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl dark:bg-gray-dark" (click)="$event.stopPropagation()">
          <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">Nuevo Cargo</h3>
          @if (errorModal()) {
            <p class="mb-3 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">{{ errorModal() }}</p>
          }
          <div class="space-y-4">
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Concepto *</label>
              <select class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                      [value]="cargoForm().concepto_id ?? ''"
                      (change)="setCargoConcepto($event)">
                <option value="">Seleccionar concepto…</option>
                @for (c of conceptos(); track c.id) {
                  <option [value]="c.id">{{ c.nombre }}</option>
                }
              </select>
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Año *</label>
                <input type="number" min="2000" max="2100" placeholder="2026"
                       class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                       [value]="cargoForm().periodo_anio"
                       (input)="setCargoAnio($event)"/>
              </div>
              <div>
                <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Mes *</label>
                <select class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                        [value]="cargoForm().periodo_mes"
                        (change)="setCargoMes($event)">
                  @for (m of mesesOpts; track m.v) {
                    <option [value]="m.v">{{ m.label }}</option>
                  }
                </select>
              </div>
            </div>
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Monto (S/) *</label>
              <input type="number" min="0.01" step="0.01" placeholder="0.00"
                     class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                     [value]="cargoForm().monto || ''"
                     (input)="setCargoMonto($event)"/>
            </div>
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Observación</label>
              <input type="text" placeholder="Descripción del cargo…"
                     class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                     [value]="cargoForm().observacion"
                     (input)="setCargoObservacion($event)"/>
            </div>
          </div>
          <div class="mt-5 flex justify-end gap-2">
            <button (click)="cerrarModales()"
                    class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              Cancelar
            </button>
            <button (click)="guardarCargo()" [disabled]="guardando()"
                    class="flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2 text-sm font-medium text-white hover:bg-brand-600 disabled:opacity-60">
              @if (guardando()) { Guardando… } @else { Crear Cargo }
            </button>
          </div>
        </div>
      </div>
    }

    <!-- Modal: Nuevo Abono -->
    @if (modalAbono()) {
      <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4" (click)="cerrarModales()">
        <div class="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl dark:bg-gray-dark" (click)="$event.stopPropagation()">
          <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">Nuevo Abono Manual</h3>
          @if (errorModal()) {
            <p class="mb-3 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">{{ errorModal() }}</p>
          }
          <div class="space-y-4">
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Aplicar a deuda *</label>
              <select class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                      [value]="abonoForm().monto_deuda_id ?? ''"
                      (change)="setAbonoDeuda($event)">
                <option value="">Seleccionar deuda…</option>
                @for (d of deudasPendientes(); track d.id) {
                  <option [value]="d.id">
                    {{ d.concepto }} — {{ formatPeriodo(d.periodo_anio, d.periodo_mes) }} — {{ formatSoles(d.saldo_pendiente) }}
                  </option>
                }
              </select>
            </div>
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Monto (S/) *</label>
              <input type="number" min="0.01" step="0.01" placeholder="0.00"
                     class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                     [value]="abonoForm().monto || ''"
                     (input)="setAbonoMonto($event)"/>
            </div>
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Método de pago</label>
              <div class="flex gap-2">
                <button (click)="setAbonoMetodo('Efectivo')"
                        class="flex-1 rounded-lg border py-2 text-sm font-medium transition"
                        [class]="abonoForm().metodo_pago === 'Efectivo'
                          ? 'border-brand-500 bg-brand-500 text-white'
                          : 'border-gray-300 text-gray-600 hover:border-brand-400 dark:border-gray-600 dark:text-gray-300'">
                  Efectivo
                </button>
                <button (click)="setAbonoMetodo('Transferencia')"
                        class="flex-1 rounded-lg border py-2 text-sm font-medium transition"
                        [class]="abonoForm().metodo_pago === 'Transferencia'
                          ? 'border-brand-500 bg-brand-500 text-white'
                          : 'border-gray-300 text-gray-600 hover:border-brand-400 dark:border-gray-600 dark:text-gray-300'">
                  Transferencia
                </button>
              </div>
            </div>
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">N.° Comprobante</label>
              <input type="text" placeholder="Número de recibo o referencia"
                     class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                     [value]="abonoForm().comprobante"
                     (input)="setAbonoComprobante($event)"/>
            </div>
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Fecha de Pago *</label>
              <input type="date"
                     class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                     [value]="abonoForm().fecha_pago"
                     (input)="setAbonoFecha($event)"/>
            </div>
          </div>
          <div class="mt-5 flex justify-end gap-2">
            <button (click)="cerrarModales()"
                    class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              Cancelar
            </button>
            <button (click)="guardarAbono()" [disabled]="guardando()"
                    class="flex items-center gap-2 rounded-lg bg-green-600 px-4 py-2 text-sm font-semibold text-white hover:bg-green-700 disabled:opacity-60">
              @if (guardando()) { Procesando… } @else { Registrar Abono }
            </button>
          </div>
        </div>
      </div>
    }

    <!-- Modal: Confirmar Anular Cargo -->
    @if (modalAnularCargo()) {
      <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4" (click)="cerrarModales()">
        <div class="w-full max-w-sm rounded-2xl bg-white p-6 shadow-xl dark:bg-gray-dark" (click)="$event.stopPropagation()">
          <div class="mb-4 flex items-center gap-3">
            <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-red-100 dark:bg-red-900/30">
              <svg class="h-5 w-5 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
              </svg>
            </div>
            <div>
              <h3 class="text-base font-semibold text-gray-800 dark:text-white">¿Anular este cargo?</h3>
              <p class="text-sm text-gray-600 dark:text-gray-400">Esta acción es irreversible.</p>
            </div>
          </div>
          <div class="mb-4 rounded-lg border border-red-200 bg-red-50 p-3 dark:border-red-800/40 dark:bg-red-900/20">
            <p class="text-sm text-red-700 dark:text-red-300">
              ¿Estás seguro que deseas anular la deuda de
              <strong>{{ formatSoles(modalAnularCargo()!.monto) }}</strong>
              por <strong>{{ modalAnularCargo()!.concepto }}</strong>
              del período <strong>{{ formatPeriodo(modalAnularCargo()!.periodo_anio, modalAnularCargo()!.periodo_mes) }}</strong>?
            </p>
          </div>
          <div class="mb-4">
            <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Motivo *</label>
            <input type="text" placeholder="Motivo de la anulación…"
                   class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-red-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                   [value]="motivoAnulacion()"
                   (input)="setMotivo($event)"/>
          </div>
          @if (errorModal()) {
            <p class="mb-3 text-sm text-red-600 dark:text-red-400">{{ errorModal() }}</p>
          }
          <div class="flex justify-end gap-2">
            <button (click)="cerrarModales()"
                    class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              Cancelar
            </button>
            <button (click)="ejecutarAnularCargo()" [disabled]="guardando()"
                    class="rounded-lg bg-red-600 px-4 py-2 text-sm font-semibold text-white hover:bg-red-700 disabled:opacity-60">
              @if (guardando()) { Anulando… } @else { Sí, Anular Definitivamente }
            </button>
          </div>
        </div>
      </div>
    }

    <!-- Modal: Confirmar Anular Pago -->
    @if (modalAnularPago()) {
      <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4" (click)="cerrarModales()">
        <div class="w-full max-w-sm rounded-2xl bg-white p-6 shadow-xl dark:bg-gray-dark" (click)="$event.stopPropagation()">
          <div class="mb-4 flex items-center gap-3">
            <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-red-100 dark:bg-red-900/30">
              <svg class="h-5 w-5 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
              </svg>
            </div>
            <div>
              <h3 class="text-base font-semibold text-gray-800 dark:text-white">¿Anular este pago?</h3>
              <p class="text-sm text-gray-600 dark:text-gray-400">La deuda volverá a estado Pendiente y se revertirá el saldo a favor.</p>
            </div>
          </div>
          <div class="mb-4 rounded-lg border border-red-200 bg-red-50 p-3 dark:border-red-800/40 dark:bg-red-900/20">
            <p class="text-sm text-red-700 dark:text-red-300">
              ¿Estás seguro de anular el abono por
              <strong>{{ formatSoles(modalAnularPago()!.monto_total) }}</strong>
              @if (modalAnularPago()!.comprobante) {
                con recibo <strong>{{ modalAnularPago()!.comprobante }}</strong>
              }
              del <strong>{{ formatFecha(modalAnularPago()!.fecha_pago) }}</strong>?
            </p>
          </div>
          <div class="mb-4">
            <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Motivo *</label>
            <input type="text" placeholder="Motivo de la anulación…"
                   class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-red-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                   [value]="motivoAnulacion()"
                   (input)="setMotivo($event)"/>
          </div>
          @if (errorModal()) {
            <p class="mb-3 text-sm text-red-600 dark:text-red-400">{{ errorModal() }}</p>
          }
          <div class="flex justify-end gap-2">
            <button (click)="cerrarModales()"
                    class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              Cancelar
            </button>
            <button (click)="ejecutarAnularPago()" [disabled]="guardando()"
                    class="rounded-lg bg-red-600 px-4 py-2 text-sm font-semibold text-white hover:bg-red-700 disabled:opacity-60">
              @if (guardando()) { Anulando… } @else { Sí, Anular Definitivamente }
            </button>
          </div>
        </div>
      </div>
    }
    <!-- Modal: Editar Pago -->
    @if (modalEditarPago()) {
      <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4" (click)="cerrarModales()">
        <div class="w-full max-w-sm rounded-2xl bg-white p-6 shadow-xl dark:bg-gray-dark" (click)="$event.stopPropagation()">
          <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">Editar Pago</h3>
          <p class="mb-4 text-xs text-gray-400 dark:text-gray-400">
            Transacción: <span class="font-mono font-medium text-gray-600 dark:text-gray-300">{{ modalEditarPago()!.codigo_transaccion }}</span>
          </p>
          @if (errorModal()) {
            <p class="mb-3 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">{{ errorModal() }}</p>
          }
          <div class="space-y-4">
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">N.° Comprobante</label>
              <input type="text" placeholder="Número de recibo o referencia"
                     class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                     [value]="editarPagoForm().comprobante"
                     (input)="setEditComprobante($event)"/>
            </div>
            <div>
              <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Fecha de Pago *</label>
              <input type="date"
                     class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none focus:border-brand-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                     [value]="editarPagoForm().fecha_pago"
                     (input)="setEditFecha($event)"/>
            </div>
          </div>
          <div class="mt-5 flex justify-end gap-2">
            <button (click)="cerrarModales()"
                    class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              Cancelar
            </button>
            <button (click)="guardarEditPago()" [disabled]="guardando()"
                    class="flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700 disabled:opacity-60">
              @if (guardando()) { Guardando… } @else { Guardar Cambios }
            </button>
          </div>
        </div>
      </div>
    }
  `,
})
export class CuentaCorrienteDetailComponent implements OnInit {
  private readonly svc    = inject(CuentaCorrienteService);
  private readonly route  = inject(ActivatedRoute);
  private readonly router = inject(Router);

  readonly formatSoles  = formatSoles;
  readonly formatPeriodo = formatPeriodo;
  readonly formatFecha  = formatFecha;
  readonly mesesOpts    = MESES_NOMBRES.slice(1).map((l, i) => ({ label: l, v: i + 1 }));

  // Estado
  readonly cargando = signal(true);
  readonly error    = signal<string | null>(null);
  readonly detalle  = signal<PersonaDetalle | null>(null);
  readonly tab      = signal<Tab>('deudas');
  readonly conceptos = signal<{ id: number; nombre: string }[]>([]);

  // Modales
  readonly modalCargo       = signal(false);
  readonly modalAbono       = signal(false);
  readonly modalAnularCargo = signal<DeudaItem | null>(null);
  readonly modalAnularPago  = signal<PagoResumen | null>(null);
  readonly motivoAnulacion  = signal('');
  readonly guardando        = signal(false);
  readonly errorModal       = signal<string | null>(null);

  // Formularios
  readonly cargoForm = signal<NuevoCargoForm>({
    concepto_id: null, periodo_anio: new Date().getFullYear(),
    periodo_mes: new Date().getMonth() + 1, monto: 0, observacion: '',
  });
  readonly abonoForm = signal<NuevoAbonoForm>({
    monto_deuda_id: null, monto: 0,
    metodo_pago: 'Efectivo', comprobante: '', observacion: '',
    fecha_pago: todayIso(),
  });

  // ── Editar pago ───────────────────────────────────────────────────────────
  readonly modalEditarPago = signal<PagoResumen | null>(null);
  readonly editarPagoForm  = signal<EditarPagoForm>({ comprobante: '', fecha_pago: todayIso() });

  // Computed
  readonly persona          = computed(() => this.detalle()?.persona ?? null);
  readonly deudasPendientes = computed(() =>
    (this.detalle()?.deudas ?? []).filter(d => d.saldo_pendiente > 0),
  );
  readonly pagosActivos     = computed(() =>
    (this.detalle()?.pagos ?? []).filter(p => !p.anulado),
  );
  readonly deudaTotal       = computed(() =>
    this.deudasPendientes().reduce((s, d) => s + d.saldo_pendiente, 0),
  );

  private tipo!: TipoPersona;
  private personaId!: number;

  // ── Form event handlers (arrow functions not allowed in Angular templates) ──
  setCargoConcepto(ev: Event): void {
    const v = +(ev.target as HTMLSelectElement).value || null;
    this.cargoForm.update(f => ({ ...f, concepto_id: v }));
  }
  setCargoAnio(ev: Event): void {
    const v = +(ev.target as HTMLInputElement).value;
    this.cargoForm.update(f => ({ ...f, periodo_anio: v }));
  }
  setCargoMes(ev: Event): void {
    const v = +(ev.target as HTMLSelectElement).value;
    this.cargoForm.update(f => ({ ...f, periodo_mes: v }));
  }
  setCargoMonto(ev: Event): void {
    const v = +(ev.target as HTMLInputElement).value;
    this.cargoForm.update(f => ({ ...f, monto: v }));
  }
  setCargoObservacion(ev: Event): void {
    const v = (ev.target as HTMLInputElement).value;
    this.cargoForm.update(f => ({ ...f, observacion: v }));
  }
  setAbonoDeuda(ev: Event): void {
    const v = +(ev.target as HTMLSelectElement).value || null;
    this.abonoForm.update(f => ({ ...f, monto_deuda_id: v }));
  }
  setAbonoMonto(ev: Event): void {
    const v = +(ev.target as HTMLInputElement).value;
    this.abonoForm.update(f => ({ ...f, monto: v }));
  }
  setAbonoMetodo(metodo: 'Efectivo' | 'Transferencia'): void {
    this.abonoForm.update(f => ({ ...f, metodo_pago: metodo }));
  }
  setAbonoComprobante(ev: Event): void {
    const v = (ev.target as HTMLInputElement).value;
    this.abonoForm.update(f => ({ ...f, comprobante: v }));
  }
  setAbonoFecha(ev: Event): void {
    const v = (ev.target as HTMLInputElement).value;
    this.abonoForm.update(f => ({ ...f, fecha_pago: v }));
  }
  setMotivo(ev: Event): void {
    this.motivoAnulacion.set((ev.target as HTMLInputElement).value);
  }
  setEditComprobante(ev: Event): void {
    const v = (ev.target as HTMLInputElement).value;
    this.editarPagoForm.update(f => ({ ...f, comprobante: v }));
  }
  setEditFecha(ev: Event): void {
    const v = (ev.target as HTMLInputElement).value;
    this.editarPagoForm.update(f => ({ ...f, fecha_pago: v }));
  }

  async ngOnInit(): Promise<void> {
    const tipoParam = this.route.snapshot.paramMap.get('tipo');
    if (tipoParam !== 'socio' && tipoParam !== 'inquilino') {
      void this.router.navigate(['/cuenta-corriente']);
      return;
    }
    this.tipo      = tipoParam;
    this.personaId = Number(this.route.snapshot.paramMap.get('id'));
    if (!this.personaId) {
      void this.router.navigate(['/cuenta-corriente']);
      return;
    }
    await Promise.all([this.cargarDetalle(), this.cargarConceptos()]);
  }

  private async cargarDetalle(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    try {
      const d = await this.svc.obtenerDetalle(this.tipo, this.personaId);
      this.detalle.set(d);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el detalle');
    } finally {
      this.cargando.set(false);
    }
  }

  private async cargarConceptos(): Promise<void> {
    try {
      this.conceptos.set(await this.svc.obtenerConceptos());
    } catch { /* non-critical */ }
  }

  // ── Modales ────────────────────────────────────────────────────────────────
  abrirNuevoCargo(): void {
    this.errorModal.set(null);
    this.cargoForm.set({
      concepto_id: null, periodo_anio: new Date().getFullYear(),
      periodo_mes: new Date().getMonth() + 1, monto: 0, observacion: '',
    });
    this.modalCargo.set(true);
  }

  abrirNuevoAbono(): void {
    this.errorModal.set(null);
    this.abonoForm.set({
      monto_deuda_id: null, monto: 0,
      metodo_pago: 'Efectivo', comprobante: '', observacion: '',
      fecha_pago: todayIso(),
    });
    this.modalAbono.set(true);
  }

  abrirEditarPago(pg: PagoResumen): void {
    this.errorModal.set(null);
    this.editarPagoForm.set({
      comprobante: pg.comprobante ?? '',
      fecha_pago:  fechaToInputDate(pg.fecha_pago),
    });
    this.modalEditarPago.set(pg);
  }

  confirmarAnularCargo(d: DeudaItem): void {
    this.motivoAnulacion.set('');
    this.errorModal.set(null);
    this.modalAnularCargo.set(d);
  }

  confirmarAnularPago(pg: PagoResumen): void {
    this.motivoAnulacion.set('');
    this.errorModal.set(null);
    this.modalAnularPago.set(pg);
  }

  cerrarModales(): void {
    if (this.guardando()) return;
    this.modalCargo.set(false);
    this.modalAbono.set(false);
    this.modalAnularCargo.set(null);
    this.modalAnularPago.set(null);
    this.modalEditarPago.set(null);
    this.errorModal.set(null);
  }

  // ── Acciones ──────────────────────────────────────────────────────────────
  async guardarCargo(): Promise<void> {
    this.errorModal.set(null);
    this.guardando.set(true);
    try {
      await this.svc.crearCargo(
        this.tipo, this.personaId,
        this.persona()?.puesto_id ?? null,
        this.cargoForm(),
      );
      this.modalCargo.set(false);
      await this.cargarDetalle();
    } catch (e: unknown) {
      this.errorModal.set(e instanceof Error ? e.message : 'Error al crear el cargo');
    } finally {
      this.guardando.set(false);
    }
  }

  async guardarAbono(): Promise<void> {
    this.errorModal.set(null);
    this.guardando.set(true);
    try {
      await this.svc.crearAbono(
        this.tipo, this.personaId,
        this.persona()?.puesto_id ?? null,
        this.abonoForm(),
      );
      this.modalAbono.set(false);
      await this.cargarDetalle();
      this.tab.set('pagos');
    } catch (e: unknown) {
      this.errorModal.set(e instanceof Error ? e.message : 'Error al registrar el abono');
    } finally {
      this.guardando.set(false);
    }
  }

  async guardarEditPago(): Promise<void> {
    const pg = this.modalEditarPago();
    if (!pg) return;
    this.errorModal.set(null);  // limpiar error previo antes de reintentar
    this.guardando.set(true);
    try {
      await this.svc.editarPago(pg.id, this.editarPagoForm());
      this.modalEditarPago.set(null);
      await this.cargarDetalle();
    } catch (e: unknown) {
      this.errorModal.set(e instanceof Error ? e.message : 'Error al editar el pago');
    } finally {
      this.guardando.set(false);
    }
  }

  async ejecutarAnularCargo(): Promise<void> {
    const d = this.modalAnularCargo();
    if (!d || !this.motivoAnulacion().trim()) {
      this.errorModal.set('El motivo es requerido.');
      return;
    }
    this.guardando.set(true);
    this.errorModal.set(null);
    try {
      await this.svc.anularCargo(d.id, this.motivoAnulacion());
      this.modalAnularCargo.set(null);
      await this.cargarDetalle();
    } catch (e: unknown) {
      this.errorModal.set(e instanceof Error ? e.message : 'Error al anular el cargo');
    } finally {
      this.guardando.set(false);
    }
  }

  async ejecutarAnularPago(): Promise<void> {
    const pg = this.modalAnularPago();
    if (!pg || !this.motivoAnulacion().trim()) {
      this.errorModal.set('El motivo es requerido.');
      return;
    }
    this.guardando.set(true);
    this.errorModal.set(null);
    try {
      await this.svc.anularPago(pg.id, this.motivoAnulacion());
      this.modalAnularPago.set(null);
      await this.cargarDetalle();
    } catch (e: unknown) {
      this.errorModal.set(e instanceof Error ? e.message : 'Error al anular el pago');
    } finally {
      this.guardando.set(false);
    }
  }
}
