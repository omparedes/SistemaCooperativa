import { Component, computed, inject, signal } from '@angular/core';
import { PagosService } from '../../core/services/pagos.service';
import { PdfGeneratorService, ReciboDatos } from '../../core/services/pdf-generator.service';
import {
  BusquedaResultado,
  DeudaItem,
  LineaFifo,
  MetodoPago,
} from './pago.model';

const MESES = ['', 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Set', 'Oct', 'Nov', 'Dic'];

function formatPeriodo(anio: number, mes: number): string {
  return `${MESES[mes] ?? mes}-${anio}`;
}

function formatSoles(n: number): string {
  return `S/ ${n.toFixed(2)}`;
}

@Component({
  selector: 'app-pago-wizard',
  standalone: true,
  imports: [],
  template: `
    <div class="mx-auto max-w-3xl p-4 md:p-6">

      <!-- Breadcrumb -->
      <nav class="mb-5 flex items-center gap-2 text-sm text-gray-500 dark:text-gray-400">
        <a href="/socios" class="hover:text-brand-500">Socios</a>
        <span>/</span>
        <span class="text-gray-800 dark:text-white">Registrar Pago</span>
      </nav>

      <!-- Encabezado -->
      <div class="mb-6">
        <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Registrar Pago</h2>
        <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">Módulo de Recaudación — Cooperativa Primero de Mayo</p>
      </div>

      <!-- Indicador de pasos -->
      <div class="flex items-center justify-center mb-8 gap-0">
        @for (step of pasos; track step.n) {
          <div class="flex flex-col items-center">
            <div class="flex h-9 w-9 items-center justify-center rounded-full text-sm font-semibold transition-colors"
                 [class]="paso() >= step.n
                   ? 'bg-brand-500 text-white shadow-md'
                   : 'bg-gray-100 text-gray-400 dark:bg-gray-700 dark:text-gray-500'">
              @if (paso() > step.n) {
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                </svg>
              } @else {
                {{ step.n }}
              }
            </div>
            <span class="mt-1.5 text-xs font-medium"
                  [class]="paso() >= step.n ? 'text-brand-500' : 'text-gray-400 dark:text-gray-500'">
              {{ step.label }}
            </span>
          </div>
          @if (!$last) {
            <div class="mb-5 h-0.5 w-16 mx-1 transition-colors"
                 [class]="paso() > step.n ? 'bg-brand-500' : 'bg-gray-200 dark:bg-gray-700'"></div>
          }
        }
      </div>

      <!-- ================================================================ -->
      <!-- PASO 1 — BÚSQUEDA                                                -->
      <!-- ================================================================ -->
      @if (paso() === 1) {
        <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">Buscar pagador</h3>

          <div class="flex gap-3">
            <input
              type="text"
              placeholder="DNI, apellido/nombre o código de puesto…"
              class="h-11 flex-1 rounded-lg border border-gray-300 bg-gray-50 px-4 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
              [value]="query()"
              (input)="onQueryInput($event)"
              (keydown.enter)="buscar()"
            />
            <button
              (click)="buscar()"
              [disabled]="buscando()"
              class="h-11 rounded-lg bg-brand-500 px-5 text-sm font-medium text-white transition hover:bg-brand-600 disabled:opacity-60">
              @if (buscando()) { Buscando… } @else { Buscar }
            </button>
          </div>

          <!-- Error de búsqueda -->
          @if (errorBusqueda()) {
            <p class="mt-3 rounded-lg bg-red-50 px-4 py-2.5 text-sm text-red-600 dark:bg-red-900/30 dark:text-red-400">
              {{ errorBusqueda() }}
            </p>
          }

          <!-- Resultados -->
          @if (resultados().length > 0) {
            <ul class="mt-4 divide-y divide-gray-100 rounded-xl border border-gray-200 dark:divide-gray-700 dark:border-gray-700 overflow-hidden">
              @for (r of resultados(); track r.puesto_id) {
                <li>
                  <button
                    class="flex w-full items-center gap-4 px-4 py-3 text-left transition hover:bg-brand-50 dark:hover:bg-gray-700"
                    [class]="seleccionado()?.puesto_id === r.puesto_id
                      ? 'bg-brand-50 dark:bg-gray-700'
                      : 'bg-white dark:bg-gray-800'"
                    (click)="seleccionar(r)">
                    <div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-xs font-bold"
                         [class]="r.tipo === 'socio'
                           ? 'bg-brand-100 text-brand-600 dark:bg-brand-900/40 dark:text-brand-300'
                           : 'bg-amber-100 text-amber-600 dark:bg-amber-900/40 dark:text-amber-300'">
                      {{ r.tipo === 'socio' ? 'SC' : 'IQ' }}
                    </div>
                    <div class="flex-1 min-w-0">
                      <p class="truncate text-sm font-medium text-gray-800 dark:text-white">{{ r.nombre_completo }}</p>
                      <p class="text-xs text-gray-400">DNI {{ r.dni }} · Puesto {{ r.codigo_puesto }}</p>
                    </div>
                    <span class="shrink-0 rounded-full px-2 py-0.5 text-xs font-medium"
                          [class]="r.tipo === 'socio'
                            ? 'bg-brand-100 text-brand-600 dark:bg-brand-900/40 dark:text-brand-300'
                            : 'bg-amber-100 text-amber-600 dark:bg-amber-900/40 dark:text-amber-300'">
                      {{ r.tipo === 'socio' ? 'Socio' : 'Inquilino' }}
                    </span>
                  </button>
                </li>
              }
            </ul>
          } @else if (busquedaRealizada() && !buscando()) {
            <p class="mt-4 text-sm text-gray-400 dark:text-gray-500 text-center py-4">
              No se encontraron resultados para "{{ query() }}"
            </p>
          }

          <!-- Resumen deudas del seleccionado -->
          @if (seleccionado()) {
            <div class="mt-5 rounded-xl border border-brand-200 bg-brand-50 p-4 dark:border-brand-900/50 dark:bg-brand-900/20">
              @if (cargandoDeudas()) {
                <p class="text-sm text-brand-500">Cargando deudas…</p>
              } @else if (errorDeudas()) {
                <p class="text-sm text-red-500">{{ errorDeudas() }}</p>
              } @else if (deudas().length === 0) {
                <p class="text-sm font-medium text-green-600 dark:text-green-400">
                  ✓ Sin deudas pendientes — este puesto está al día.
                </p>
              } @else {
                <div class="flex items-center justify-between mb-3">
                  <div>
                    <p class="text-sm font-semibold text-gray-800 dark:text-white">
                      {{ seleccionado()!.nombre_completo }}
                    </p>
                    <p class="text-xs text-gray-500 dark:text-gray-400">
                      Puesto {{ seleccionado()!.codigo_puesto }} ·
                      {{ seleccionado()!.tipo === 'socio' ? 'Socio titular' : 'Inquilino' }}
                    </p>
                  </div>
                  <div class="flex gap-4 text-right">
                    @if (saldoAFavor() > 0) {
                      <div>
                        <p class="text-xs text-emerald-500 dark:text-emerald-400">Saldo a favor</p>
                        <p class="text-base font-bold text-emerald-600 dark:text-emerald-300">{{ formatSoles(saldoAFavor()) }}</p>
                      </div>
                    }
                    <div>
                      <p class="text-xs text-gray-400 dark:text-gray-500">Deuda total</p>
                      <p class="text-xl font-bold text-red-500">{{ formatSoles(totalDeuda()) }}</p>
                    </div>
                  </div>
                </div>
                <div class="flex flex-wrap gap-2">
                  @for (d of deudas(); track d.monto_id) {
                    <span class="rounded-full border border-red-200 bg-red-50 px-3 py-1 text-xs font-medium text-red-600 dark:border-red-900/50 dark:bg-red-900/20 dark:text-red-400">
                      {{ d.concepto }} {{ formatPeriodo(d.periodo_anio, d.periodo_mes) }}: {{ formatSoles(d.saldo_pendiente) }}
                    </span>
                  }
                </div>
              }
            </div>
          }
        </div>

        <div class="mt-4 flex justify-end">
          <button
            (click)="irPaso2()"
            [disabled]="!seleccionado() || deudas().length === 0 || cargandoDeudas()"
            class="rounded-lg bg-brand-500 px-6 py-2.5 text-sm font-medium text-white transition hover:bg-brand-600 disabled:opacity-40 disabled:cursor-not-allowed">
            Siguiente →
          </button>
        </div>
      }

      <!-- ================================================================ -->
      <!-- PASO 2 — DISTRIBUCIÓN                                            -->
      <!-- ================================================================ -->
      @if (paso() === 2) {
        <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">

          <!-- Datos del pagador (resumen compacto) -->
          <div class="mb-4 flex items-center justify-between rounded-xl bg-gray-50 px-4 py-3 dark:bg-gray-700/50">
            <div>
              <p class="text-sm font-medium text-gray-800 dark:text-white">{{ seleccionado()!.nombre_completo }}</p>
              <p class="text-xs text-gray-400">Puesto {{ seleccionado()!.codigo_puesto }} · {{ seleccionado()!.tipo === 'socio' ? 'Socio' : 'Inquilino' }}</p>
            </div>
            <p class="text-sm font-bold text-red-500">Debe: {{ formatSoles(totalDeuda()) }}</p>
          </div>

          <!-- Banner: Saldo a Favor disponible -->
          @if (saldoAFavor() > 0) {
            <div class="mb-4 flex items-center gap-3 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 dark:border-emerald-800/50 dark:bg-emerald-900/20">
              <svg class="h-5 w-5 shrink-0 text-emerald-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
              </svg>
              <div class="flex-1">
                <p class="text-xs font-medium text-emerald-600 dark:text-emerald-400">Saldo a Favor Disponible</p>
                <p class="text-lg font-bold text-emerald-700 dark:text-emerald-300">{{ formatSoles(saldoAFavor()) }}</p>
              </div>
              @if (saldoUtilizado() > 0) {
                <div class="text-right">
                  <p class="text-xs text-emerald-600 dark:text-emerald-400">Se utilizará</p>
                  <p class="text-sm font-bold text-emerald-700 dark:text-emerald-300">{{ formatSoles(saldoUtilizado()) }}</p>
                </div>
              }
            </div>
          }

          <h3 class="mb-4 text-base font-semibold text-gray-800 dark:text-white">Monto recibido y método de pago</h3>

          <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <!-- Monto -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Monto recibido
                @if (saldoAFavor() === 0) { <span class="text-red-500">*</span> }
                @if (saldoAFavor() > 0) { <span class="ml-1 text-xs font-normal text-emerald-500">(puede ser 0 si el saldo cubre la deuda)</span> }
              </label>
              <div class="relative">
                <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm font-medium text-gray-500">S/</span>
                <input
                  type="number"
                  [attr.min]="saldoAFavor() > 0 ? '0' : '0.01'"
                  step="0.01"
                  placeholder="0.00"
                  class="h-11 w-full rounded-lg border border-gray-300 bg-gray-50 pl-8 pr-4 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                  [value]="montoRecibido() || ''"
                  (input)="onMontoInput($event)"
                />
              </div>
              @if (!puedeContinuarPaso2() && (montoRecibido() + saldoAFavor()) > 0) {
                <p class="mt-1.5 text-xs text-amber-600 dark:text-amber-400">
                  El monto recibido más el saldo a favor ({{ formatSoles(montoRecibido() + saldoAFavor()) }}) debe cubrir al menos una deuda.
                </p>
              }
            </div>

            <!-- Método de pago -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Método de pago</label>
              <div class="flex gap-2 h-11">
                @for (m of metodos; track m) {
                  <button
                    (click)="metodoPago.set(m)"
                    class="flex-1 rounded-lg border text-sm font-medium transition"
                    [class]="metodoPago() === m
                      ? 'border-brand-500 bg-brand-500 text-white'
                      : 'border-gray-300 bg-gray-50 text-gray-600 hover:border-brand-400 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300'">
                    {{ m }}
                  </button>
                }
              </div>
            </div>
          </div>

          <!-- Comprobante (solo Transferencia) -->
          @if (metodoPago() === 'Transferencia') {
            <div class="mt-4">
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">N.° de operación / referencia</label>
              <input
                type="text"
                placeholder="Número de operación bancaria"
                class="h-11 w-full rounded-lg border border-gray-300 bg-gray-50 px-4 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                [value]="comprobante()"
                (input)="onComprobanteInput($event)"
              />
            </div>
          }

          <!-- Notas u Observaciones (opcional) -->
          <div class="mt-4">
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Notas u Observaciones
              <span class="ml-1 text-xs font-normal text-gray-400 dark:text-gray-500">(opcional)</span>
            </label>
            <textarea
              rows="2"
              placeholder="Ej. Agua Nov 2025, Cuota Santa Rosa, Saldo Inicial parcial…"
              class="w-full resize-none rounded-lg border border-gray-300 bg-gray-50 px-4 py-2.5 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
              [value]="observacionPago()"
              (input)="onObservacionInput($event)"
            ></textarea>
            <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">
              Se guardará en el recibo y en el historial de pagos.
            </p>
          </div>

          <!-- Tabla de distribución — reactiva -->
          @if (montoRecibido() > 0 || saldoAFavor() > 0) {
            <div class="mt-6">

              <!-- Selector de modo de asignación -->
              <div class="mb-4 flex items-center justify-between rounded-xl bg-gray-50 p-4 dark:bg-gray-700/30">
                <div>
                  <p class="text-sm font-semibold text-gray-800 dark:text-white">Asignación de Pagos</p>
                  <p class="text-xs text-gray-400">Distribuye el dinero en los conceptos correspondientes</p>
                </div>
                <div class="flex gap-2">
                  <button type="button" (click)="cambiarModoDistribucion('automatico')"
                    [class]="modoDistribucion() === 'automatico'
                      ? 'rounded-lg bg-brand-600 px-3 py-1.5 text-xs font-semibold text-white'
                      : 'rounded-lg border border-gray-300 px-3 py-1.5 text-xs text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700'">
                    Automático (FIFO)
                  </button>
                  <button type="button" (click)="cambiarModoDistribucion('manual')"
                    [class]="modoDistribucion() === 'manual'
                      ? 'rounded-lg bg-brand-600 px-3 py-1.5 text-xs font-semibold text-white'
                      : 'rounded-lg border border-gray-300 px-3 py-1.5 text-xs text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700'">
                    Manual
                  </button>
                </div>
              </div>

              <h4 class="mb-3 text-sm font-semibold text-gray-700 dark:text-gray-300">
                @if (modoDistribucion() === 'automatico') {
                  Distribución FIFO <span class="font-normal text-gray-400">(más antigua → más reciente)</span>
                } @else {
                  Distribución Manual <span class="font-normal text-gray-400">— ingresa el monto a aplicar en cada concepto</span>
                }
              </h4>

              <!-- Error de cuadre en modo manual -->
              @if (errorManual()) {
                <div class="mb-3 rounded-xl border border-red-200 bg-red-50 px-4 py-3 dark:border-red-800/50 dark:bg-red-900/20">
                  <p class="text-sm text-red-600 dark:text-red-400">
                    <strong>Error de cuadre:</strong> {{ errorManual() }}
                  </p>
                </div>
              }

              <div class="overflow-hidden rounded-xl border border-gray-200 dark:border-gray-700">
                <table class="w-full text-sm">
                  <thead class="bg-gray-50 dark:bg-gray-700/50">
                    <tr>
                      <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Concepto / Período</th>
                      <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Deuda</th>
                      <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Aplicado</th>
                      <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Estado</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-100 bg-white dark:divide-gray-700 dark:bg-gray-800">
                    @for (linea of distribucionFinal(); track linea.monto_id) {
                      <tr [class]="modoDistribucion() === 'automatico' && linea.monto_aplicado <= 0
                        ? 'bg-gray-50/50 dark:bg-gray-800/50 opacity-50'
                        : 'bg-white dark:bg-gray-800'">
                        <td class="px-4 py-3">
                          <p class="font-medium text-gray-800 dark:text-white">{{ linea.concepto }}</p>
                          <p class="text-xs text-gray-400">{{ linea.periodo_label }}</p>
                        </td>
                        <td class="px-4 py-3 text-right font-medium text-gray-800 dark:text-white">
                          {{ formatSoles(linea.saldo_pendiente) }}
                        </td>
                        <td class="px-4 py-3 text-right">
                          @if (modoDistribucion() === 'manual') {
                            <input
                              type="number"
                              min="0"
                              [attr.max]="linea.saldo_pendiente"
                              step="0.01"
                              [value]="getMontoManual(linea.monto_id)"
                              (input)="setMontoManual(linea.monto_id, $event)"
                              class="w-24 rounded border border-gray-300 bg-white py-1 pl-2 pr-2 text-right text-sm font-bold text-brand-600 outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-brand-400"
                            />
                          } @else {
                            <span class="font-bold"
                                  [class]="linea.monto_aplicado > 0 ? 'text-brand-600 dark:text-brand-400' : 'text-gray-300 dark:text-gray-600'">
                              {{ formatSoles(linea.monto_aplicado) }}
                            </span>
                          }
                        </td>
                        <td class="px-4 py-3 text-center">
                          @if (linea.cubierto_completo) {
                            <span class="inline-flex items-center gap-1 rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-medium text-green-700 dark:bg-green-900/30 dark:text-green-400">
                              <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>
                              Cancelado
                            </span>
                          } @else if (linea.monto_aplicado > 0) {
                            <span class="inline-flex rounded-full bg-amber-100 px-2.5 py-0.5 text-xs font-medium text-amber-700 dark:bg-amber-900/30 dark:text-amber-400">Parcial</span>
                          } @else {
                            <span class="inline-flex rounded-full bg-gray-100 px-2.5 py-0.5 text-xs font-medium text-gray-400 dark:bg-gray-700 dark:text-gray-500">Pendiente</span>
                          }
                        </td>
                      </tr>
                    }
                  </tbody>
                </table>
              </div>

              <!-- Resumen totales -->
              <div class="mt-3 flex flex-wrap items-center justify-between gap-3 rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 dark:border-gray-700 dark:bg-gray-700/50">
                <div class="flex flex-wrap gap-4 text-sm">
                  <div>
                    <span class="text-gray-400">Aplicado:</span>
                    <span class="ml-1.5 font-bold text-brand-600 dark:text-brand-400">{{ formatSoles(totalAplicado()) }}</span>
                  </div>
                  @if (saldoUtilizado() > 0) {
                    <div>
                      <span class="text-gray-400">Saldo usado:</span>
                      <span class="ml-1.5 font-bold text-emerald-600 dark:text-emerald-400">{{ formatSoles(saldoUtilizado()) }}</span>
                    </div>
                  }
                  @if (saldoRestante() > 0) {
                    <div>
                      <span class="text-gray-400">Excedente → saldo:</span>
                      <span class="ml-1.5 font-bold text-green-600 dark:text-green-400">{{ formatSoles(saldoRestante()) }}</span>
                    </div>
                  }
                </div>
                <div class="text-right">
                  <p class="text-xs text-gray-400">Efectivo recibido</p>
                  <p class="text-lg font-bold text-gray-800 dark:text-white">{{ formatSoles(montoRecibido()) }}</p>
                </div>
              </div>
            </div>
          }
        </div>

        <div class="mt-4 flex justify-between">
          <button (click)="irPaso1()"
                  class="rounded-lg border border-gray-300 px-5 py-2.5 text-sm font-medium text-gray-600 transition hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
            ← Atrás
          </button>
          <button
            (click)="irPaso3()"
            [disabled]="!puedeContinuarPaso2()"
            class="rounded-lg bg-brand-500 px-6 py-2.5 text-sm font-medium text-white transition hover:bg-brand-600 disabled:opacity-40 disabled:cursor-not-allowed"
            [title]="!puedeContinuarPaso2() ? 'El monto recibido + saldo a favor debe cubrir al menos una deuda' : ''">
            Confirmar →
          </button>
        </div>
      }

      <!-- ================================================================ -->
      <!-- PASO 3 — CONFIRMACIÓN Y GUARDADO                                 -->
      <!-- ================================================================ -->
      @if (paso() === 3) {

        <!-- Éxito -->
        @if (codigoTransaccion()) {
          <div class="rounded-2xl border border-green-200 bg-green-50 p-6 text-center shadow-sm dark:border-green-900/50 dark:bg-green-900/20">
            <div class="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-green-100 dark:bg-green-900/40">
              <svg class="h-8 w-8 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <h3 class="text-xl font-bold text-green-800 dark:text-green-300">¡Pago registrado!</h3>
            <p class="mt-1 text-sm text-green-600 dark:text-green-400">Código de transacción</p>
            <p class="mt-2 text-2xl font-mono font-bold tracking-wider text-green-700 dark:text-green-300">
              {{ codigoTransaccion() }}
            </p>
            <p class="mt-4 text-sm text-gray-600 dark:text-gray-300">
              <span class="font-medium">{{ seleccionado()!.nombre_completo }}</span> ·
              Puesto {{ seleccionado()!.codigo_puesto }} ·
              {{ formatSoles(totalAplicado()) }} · {{ metodoPago() }}
            </p>
            <div class="mt-6 flex justify-center gap-3">
              <button
                (click)="imprimirRecibo()"
                [disabled]="generandoPdf()"
                class="flex items-center gap-2 rounded-lg border border-green-300 px-5 py-2.5 text-sm font-medium text-green-700 transition hover:bg-green-100 disabled:opacity-60 dark:border-green-700 dark:text-green-300 dark:hover:bg-green-900/40">
                @if (generandoPdf()) {
                  <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Generando PDF…
                } @else {
                  <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                  </svg>
                  Imprimir Recibo (PDF)
                }
              </button>
              <button
                (click)="reiniciar()"
                class="rounded-lg bg-brand-500 px-5 py-2.5 text-sm font-medium text-white transition hover:bg-brand-600">
                Nuevo Pago
              </button>
            </div>
            @if (errorPdf()) {
              <p class="mt-3 rounded-lg bg-red-50 px-4 py-2 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">
                Error al generar PDF: {{ errorPdf() }}
              </p>
            }
          </div>
        } @else {
          <!-- Resumen antes de confirmar -->
          <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <h3 class="mb-5 text-base font-semibold text-gray-800 dark:text-white">Resumen del pago — confirmar antes de cobrar</h3>

            <div class="mb-5 grid grid-cols-2 gap-4 sm:grid-cols-4">
              <div class="rounded-xl bg-gray-50 p-3 dark:bg-gray-700/50">
                <p class="text-xs text-gray-400 dark:text-gray-500">Pagador</p>
                <p class="mt-1 text-sm font-semibold text-gray-800 dark:text-white leading-tight">
                  {{ seleccionado()!.nombre_completo }}
                </p>
              </div>
              <div class="rounded-xl bg-gray-50 p-3 dark:bg-gray-700/50">
                <p class="text-xs text-gray-400 dark:text-gray-500">Puesto</p>
                <p class="mt-1 text-sm font-semibold text-gray-800 dark:text-white">{{ seleccionado()!.codigo_puesto }}</p>
              </div>
              <div class="rounded-xl bg-gray-50 p-3 dark:bg-gray-700/50">
                <p class="text-xs text-gray-400 dark:text-gray-500">Método</p>
                <p class="mt-1 text-sm font-semibold text-gray-800 dark:text-white">{{ metodoPago() }}</p>
              </div>
              <div class="rounded-xl bg-brand-50 p-3 dark:bg-brand-900/20">
                <p class="text-xs text-brand-400 dark:text-brand-500">Total cobrado</p>
                <p class="mt-1 text-lg font-bold text-brand-600 dark:text-brand-400">{{ formatSoles(totalAplicado()) }}</p>
              </div>
            </div>

            @if (comprobante()) {
              <p class="mb-4 text-sm text-gray-500 dark:text-gray-400">
                Ref. operación: <span class="font-medium text-gray-700 dark:text-gray-200">{{ comprobante() }}</span>
              </p>
            }

            @if (observacionPago()) {
              <div class="mb-4 rounded-lg border border-amber-200 bg-amber-50 px-4 py-2.5 dark:border-amber-800/40 dark:bg-amber-900/20">
                <p class="text-xs font-semibold uppercase tracking-wider text-amber-600 dark:text-amber-400">Observaciones</p>
                <p class="mt-0.5 text-sm text-amber-800 dark:text-amber-200">{{ observacionPago() }}</p>
              </div>
            }

            <div class="overflow-hidden rounded-xl border border-gray-200 dark:border-gray-700">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Concepto</th>
                    <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Aplicado</th>
                    <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Resultado</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 bg-white dark:divide-gray-700 dark:bg-gray-800">
                  @for (linea of distribucionFinal(); track linea.monto_id) {
                    @if (linea.monto_aplicado > 0) {
                      <tr>
                        <td class="px-4 py-3">
                          <p class="font-medium text-gray-800 dark:text-white">{{ linea.concepto }}</p>
                          <p class="text-xs text-gray-400">{{ linea.periodo_label }}</p>
                        </td>
                        <td class="px-4 py-3 text-right font-bold text-brand-600 dark:text-brand-400">
                          {{ formatSoles(linea.monto_aplicado) }}
                        </td>
                        <td class="px-4 py-3 text-center">
                          @if (linea.cubierto_completo) {
                            <span class="rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-medium text-green-700 dark:bg-green-900/30 dark:text-green-400">Cancelado ✓</span>
                          } @else {
                            <span class="rounded-full bg-amber-100 px-2.5 py-0.5 text-xs font-medium text-amber-700 dark:bg-amber-900/30 dark:text-amber-400">Parcial</span>
                          }
                        </td>
                      </tr>
                    }
                  }
                </tbody>
                <tfoot class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <td class="px-4 py-3 text-sm font-semibold text-gray-800 dark:text-white">Total</td>
                    <td class="px-4 py-3 text-right text-base font-bold text-brand-600 dark:text-brand-400">
                      {{ formatSoles(totalAplicado()) }}
                    </td>
                    <td></td>
                  </tr>
                </tfoot>
              </table>
            </div>

            @if (saldoRestante() > 0) {
              <p class="mt-3 rounded-lg bg-blue-50 px-4 py-2.5 text-sm text-blue-600 dark:bg-blue-900/20 dark:text-blue-400">
                Saldo a favor del {{ seleccionado()!.tipo === 'socio' ? 'socio' : 'inquilino' }}: <strong>{{ formatSoles(saldoRestante()) }}</strong>
                (no aplicado en esta transacción)
              </p>
            }

            <!-- Error al guardar -->
            @if (errorGuardado()) {
              <p class="mt-4 rounded-lg bg-red-50 px-4 py-2.5 text-sm text-red-600 dark:bg-red-900/30 dark:text-red-400">
                {{ errorGuardado() }}
              </p>
            }
          </div>

          <div class="mt-4 flex justify-between">
            <button (click)="irPaso2()"
                    [disabled]="guardando()"
                    class="rounded-lg border border-gray-300 px-5 py-2.5 text-sm font-medium text-gray-600 transition hover:bg-gray-50 disabled:opacity-40 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              ← Atrás
            </button>
            <button
              (click)="confirmarPago()"
              [disabled]="guardando()"
              class="flex items-center gap-2 rounded-lg bg-green-600 px-6 py-2.5 text-sm font-medium text-white transition hover:bg-green-700 disabled:opacity-60">
              @if (guardando()) {
                <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Guardando…
              } @else {
                ✓ Confirmar y Cobrar
              }
            </button>
          </div>
        }
      }
    </div>
  `,
})
export class PagoWizardComponent {
  private readonly pagosService = inject(PagosService);
  private readonly pdfService = inject(PdfGeneratorService);

  readonly formatSoles = formatSoles;
  readonly formatPeriodo = formatPeriodo;

  readonly metodos: MetodoPago[] = ['Efectivo', 'Transferencia'];
  readonly pasos = [
    { n: 1, label: 'Búsqueda' },
    { n: 2, label: 'Distribución' },
    { n: 3, label: 'Confirmación' },
  ];

  // --- Estado del wizard ---
  readonly paso = signal<1 | 2 | 3>(1);

  // --- Paso 1 ---
  readonly query = signal('');
  readonly buscando = signal(false);
  readonly busquedaRealizada = signal(false);
  readonly errorBusqueda = signal<string | null>(null);
  readonly resultados = signal<BusquedaResultado[]>([]);
  readonly seleccionado = signal<BusquedaResultado | null>(null);
  readonly cargandoDeudas = signal(false);
  readonly errorDeudas = signal<string | null>(null);
  readonly deudas = signal<DeudaItem[]>([]);
  readonly saldoAFavor = signal<number>(0);

  readonly totalDeuda = computed(() =>
    Math.round(this.deudas().reduce((s, d) => s + d.saldo_pendiente, 0) * 100) / 100,
  );

  // --- Paso 2 ---
  readonly montoRecibido = signal(0);
  readonly metodoPago = signal<MetodoPago>('Efectivo');
  readonly comprobante = signal('');
  readonly observacionPago = signal('');

  readonly modoDistribucion = signal<'automatico' | 'manual'>('automatico');
  readonly distribucionManualMap = signal<Map<number, number>>(new Map());

  readonly distribucionFifo = computed<LineaFifo[]>(() => {
    let restante = Math.round((this.montoRecibido() + this.saldoAFavor()) * 100) / 100;
    return this.deudas().map(d => {
      if (restante <= 0) {
        return {
          monto_id: d.monto_id,
          concepto: d.concepto,
          periodo_label: formatPeriodo(d.periodo_anio, d.periodo_mes),
          saldo_pendiente: d.saldo_pendiente,
          monto_aplicado: 0,
          cubierto_completo: false,
        };
      }
      const aplicar = Math.round(Math.min(restante, d.saldo_pendiente) * 100) / 100;
      restante = Math.round((restante - aplicar) * 100) / 100;
      return {
        monto_id: d.monto_id,
        concepto: d.concepto,
        periodo_label: formatPeriodo(d.periodo_anio, d.periodo_mes),
        saldo_pendiente: d.saldo_pendiente,
        monto_aplicado: aplicar,
        cubierto_completo: aplicar >= d.saldo_pendiente,
      };
    });
  });

  readonly distribucionFinal = computed<LineaFifo[]>(() => {
    if (this.modoDistribucion() === 'automatico') {
      return this.distribucionFifo();
    }
    const map = this.distribucionManualMap();
    return this.deudas().map(d => {
      const monto_aplicado = map.get(d.monto_id) ?? 0;
      return {
        monto_id: d.monto_id,
        concepto: d.concepto,
        periodo_label: formatPeriodo(d.periodo_anio, d.periodo_mes),
        saldo_pendiente: d.saldo_pendiente,
        monto_aplicado,
        cubierto_completo: monto_aplicado >= d.saldo_pendiente,
      };
    });
  });

  readonly errorManual = computed<string | null>(() => {
    if (this.modoDistribucion() !== 'manual') return null;
    const totalManual = Math.round(
      this.distribucionFinal().reduce((s, l) => s + l.monto_aplicado, 0) * 100,
    ) / 100;
    const disponible = Math.round((this.montoRecibido() + this.saldoAFavor()) * 100) / 100;
    if (totalManual > disponible) {
      const diff = Math.round((totalManual - disponible) * 100) / 100;
      return `El total asignado (${formatSoles(totalManual)}) supera el disponible (${formatSoles(disponible)}) en ${formatSoles(diff)}.`;
    }
    return null;
  });

  readonly totalAplicado = computed(() =>
    Math.round(
      this.distribucionFinal().reduce((s, l) => s + l.monto_aplicado, 0) * 100,
    ) / 100,
  );

  readonly saldoRestante = computed(() =>
    Math.round((this.montoRecibido() + this.saldoAFavor() - this.totalAplicado()) * 100) / 100,
  );

  readonly saldoUtilizado = computed(() => {
    const util = Math.round((this.totalAplicado() - this.montoRecibido()) * 100) / 100;
    return Math.max(0, Math.min(util, this.saldoAFavor()));
  });

  readonly puedeContinuarPaso2 = computed(() => {
    const montoDisponible = Math.round((this.montoRecibido() + this.saldoAFavor()) * 100) / 100;
    return (
      montoDisponible > 0 &&
      this.montoRecibido() >= 0 &&
      this.totalAplicado() > 0 &&
      this.errorManual() === null &&
      (this.metodoPago() === 'Efectivo' || this.comprobante().trim().length > 0)
    );
  });

  // --- Paso 3 ---
  readonly guardando = signal(false);
  readonly errorGuardado = signal<string | null>(null);
  readonly codigoTransaccion = signal<string | null>(null);
  readonly generandoPdf = signal(false);
  readonly errorPdf = signal<string | null>(null);

  // --- Helpers de distribución manual ---
  getMontoManual(montoId: number): number {
    return this.distribucionManualMap().get(montoId) ?? 0;
  }

  setMontoManual(montoId: number, valor: any): void {
    let v: number;
    if (valor instanceof Event) {
      v = parseFloat((valor.target as HTMLInputElement).value);
    } else {
      v = parseFloat(String(valor));
    }
    if (isNaN(v) || v < 0) v = 0;
    const deuda = this.deudas().find(d => d.monto_id === montoId);
    const max = deuda?.saldo_pendiente ?? 0;
    v = Math.round(Math.min(v, max) * 100) / 100;
    const newMap = new Map(this.distribucionManualMap());
    newMap.set(montoId, v);
    this.distribucionManualMap.set(newMap);
  }

  cambiarModoDistribucion(modo: 'automatico' | 'manual'): void {
    if (modo === 'manual') {
      const preload = new Map<number, number>();
      this.distribucionFifo().forEach(l => preload.set(l.monto_id, l.monto_aplicado));
      this.distribucionManualMap.set(preload);
    } else {
      this.distribucionManualMap.set(new Map());
    }
    this.modoDistribucion.set(modo);
  }

  // --- Handlers ---
  onQueryInput(ev: Event): void {
    this.query.set((ev.target as HTMLInputElement).value);
  }

  onMontoInput(ev: Event): void {
    const val = parseFloat((ev.target as HTMLInputElement).value);
    this.montoRecibido.set(isNaN(val) || val < 0 ? 0 : val);
  }

  onComprobanteInput(ev: Event): void {
    this.comprobante.set((ev.target as HTMLInputElement).value);
  }

  onObservacionInput(ev: Event): void {
    this.observacionPago.set((ev.target as HTMLTextAreaElement).value);
  }

  async buscar(): Promise<void> {
    if (!this.query().trim()) return;
    this.buscando.set(true);
    this.errorBusqueda.set(null);
    this.busquedaRealizada.set(false);
    this.seleccionado.set(null);
    this.deudas.set([]);
    try {
      const r = await this.pagosService.buscarPagador(this.query());
      this.resultados.set(r);
      this.busquedaRealizada.set(true);
    } catch (e: unknown) {
      this.errorBusqueda.set(e instanceof Error ? e.message : 'Error al buscar');
    } finally {
      this.buscando.set(false);
    }
  }

  async seleccionar(r: BusquedaResultado): Promise<void> {
    this.seleccionado.set(r);
    this.deudas.set([]);
    this.saldoAFavor.set(0);
    this.errorDeudas.set(null);
    this.cargandoDeudas.set(true);
    try {
      const [items, saldo] = await Promise.all([
        this.pagosService.cargarDeudasPuesto(r.puesto_id, r.persona_id, r.tipo),
        this.pagosService.obtenerSaldoAFavor(r.persona_id, r.tipo),
      ]);
      this.deudas.set(items);
      this.saldoAFavor.set(saldo);
    } catch (e: unknown) {
      this.errorDeudas.set(e instanceof Error ? e.message : 'Error al cargar deudas');
    } finally {
      this.cargandoDeudas.set(false);
    }
  }

  irPaso1(): void {
    this.paso.set(1);
  }

  irPaso2(): void {
    if (!this.seleccionado() || this.deudas().length === 0) return;
    this.montoRecibido.set(0);
    this.comprobante.set('');
    this.observacionPago.set('');
    this.modoDistribucion.set('automatico');
    this.distribucionManualMap.set(new Map());
    this.paso.set(2);
  }

  irPaso3(): void {
    if (!this.puedeContinuarPaso2()) return;
    this.errorGuardado.set(null);
    this.codigoTransaccion.set(null);
    this.paso.set(3);
  }

  async confirmarPago(): Promise<void> {
    const sel = this.seleccionado();
    if (!sel || this.totalAplicado() <= 0) return;

    this.guardando.set(true);
    this.errorGuardado.set(null);
    try {
      const resultado = await this.pagosService.procesarPago({
        resultado: sel,
        distribucion: this.distribucionFinal(),
        monto_recibido: this.montoRecibido(),
        saldo_utilizado: this.saldoUtilizado(),
        metodo_pago: this.metodoPago(),
        comprobante: this.comprobante(),
        observacion: this.observacionPago(),
      });
      this.codigoTransaccion.set(resultado.codigo_transaccion);
    } catch (e: unknown) {
      this.errorGuardado.set(e instanceof Error ? e.message : 'Error al guardar el pago');
    } finally {
      this.guardando.set(false);
    }
  }

  async imprimirRecibo(): Promise<void> {
    const sel = this.seleccionado();
    const codigo = this.codigoTransaccion();
    if (!sel || !codigo) return;

    const datos: ReciboDatos = {
      codigo_transaccion: codigo,
      fecha_pago: new Date(),
      cajero: 'Sistema de Recaudación',
      nombre_pagador: sel.nombre_completo,
      tipo_pagador: sel.tipo === 'socio' ? 'Socio titular' : 'Inquilino',
      dni_pagador: sel.dni,
      codigo_puesto: sel.codigo_puesto,
      metodo_pago: this.metodoPago(),
      comprobante: this.comprobante() || null,
      observacion: this.observacionPago() || null,
      detalle: this.distribucionFinal()
        .filter(l => l.monto_aplicado > 0)
        .map(l => ({
          concepto: l.concepto,
          periodo: l.periodo_label,
          saldo_original: l.saldo_pendiente,
          aplicado: l.monto_aplicado,
          cubierto_completo: l.cubierto_completo,
        })),
      total_pagado: this.totalAplicado(),
      saldo_a_favor: this.saldoRestante(),
    };

    this.generandoPdf.set(true);
    this.errorPdf.set(null);
    try {
      await this.pdfService.generarYAbrir(datos);
    } catch (e: unknown) {
      this.errorPdf.set(e instanceof Error ? e.message : 'Error al generar el PDF');
    } finally {
      this.generandoPdf.set(false);
    }
  }

  reiniciar(): void {
    this.paso.set(1);
    this.query.set('');
    this.resultados.set([]);
    this.seleccionado.set(null);
    this.deudas.set([]);
    this.saldoAFavor.set(0);
    this.busquedaRealizada.set(false);
    this.montoRecibido.set(0);
    this.metodoPago.set('Efectivo');
    this.comprobante.set('');
    this.observacionPago.set('');
    this.modoDistribucion.set('automatico');
    this.distribucionManualMap.set(new Map());
    this.codigoTransaccion.set(null);
    this.errorGuardado.set(null);
  }
}
