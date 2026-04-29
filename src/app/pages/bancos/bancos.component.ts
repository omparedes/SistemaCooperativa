import { Component, computed, inject, OnDestroy, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  BancosService,
  Moneda,
  MovimientoInput,
  TipoMovimiento,
  movimientoInputVacio,
} from '../../core/services/bancos.service';

// ---------------------------------------------------------------------------
// Helpers de formato
// ---------------------------------------------------------------------------
function fmtSoles(n: number, moneda: Moneda = 'PEN'): string {
  const prefix = moneda === 'USD' ? '$ ' : 'S/ ';
  return `${prefix}${n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function fmtFecha(yyyymmdd: string): string {
  const [y, m, d] = yyyymmdd.split('-').map(Number);
  return `${String(d).padStart(2, '0')}/${String(m).padStart(2, '0')}/${y}`;
}

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-bancos',
  standalone: true,
  imports: [NgClass, FormsModule],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Movimientos Bancarios</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Registro de ingresos y egresos por cuenta
            @if (realtimeActivo()) {
              <span class="ml-2 inline-flex items-center gap-1 text-emerald-600 dark:text-emerald-400">
                <span class="h-1.5 w-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                en vivo
              </span>
            }
          </p>
        </div>
        <button
          (click)="abrirForm()"
          class="inline-flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-brand-700 transition">
          <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
          </svg>
          Registrar Movimiento
        </button>
      </div>

      <!-- ── Error ──────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Tarjetas de cuentas bancarias ─────────────────────────────── -->
      @if (loading() && cuentas().length === 0) {
        <div class="mb-6 grid grid-cols-1 gap-4 sm:grid-cols-2">
          @for (i of [1, 2]; track i) {
            <div class="animate-pulse rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-700 dark:bg-gray-800">
              <div class="h-3 w-32 rounded bg-gray-200 dark:bg-gray-700 mb-4"></div>
              <div class="h-8 w-40 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          }
        </div>
      } @else {
        <div class="mb-6 grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-3">
          @for (c of cuentas(); track c.id) {
            <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
              <div class="flex items-start justify-between">
                <div class="flex-1 min-w-0">
                  <p class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500 truncate">
                    {{ c.nombre_banco }}
                  </p>
                  <p class="mt-0.5 text-xs font-mono text-gray-400 dark:text-gray-500">
                    {{ c.numero_cuenta }}
                  </p>
                </div>
                <div class="ml-3 flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-brand-50 dark:bg-brand-900/20">
                  <svg class="h-5 w-5 text-brand-600 dark:text-brand-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                  </svg>
                </div>
              </div>
              <div class="mt-4">
                <p class="text-xs text-gray-400 dark:text-gray-500">Saldo actual</p>
                <p class="mt-1 text-2xl font-bold tabular-nums"
                  [ngClass]="c.saldo_actual >= 0
                    ? 'text-gray-900 dark:text-white'
                    : 'text-red-600 dark:text-red-400'">
                  {{ fmtSoles(c.saldo_actual, c.moneda) }}
                </p>
                <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">{{ c.moneda }}</p>
              </div>
            </div>
          }
          @empty {
            <div class="sm:col-span-2 xl:col-span-3 rounded-2xl border border-dashed border-gray-300 p-8 text-center text-sm text-gray-400 dark:border-gray-600 dark:text-gray-500">
              No hay cuentas bancarias registradas.
            </div>
          }
        </div>
      }

      <!-- ── Filtros ─────────────────────────────────────────────────────── -->
      <div class="mb-4 rounded-2xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
        <div class="grid grid-cols-2 gap-3 sm:grid-cols-4">
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Cuenta</label>
            <select [ngModel]="filtroCuenta()" (ngModelChange)="filtroCuenta.set($event)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
              <option value="0">Todas</option>
              @for (c of cuentas(); track c.id) {
                <option [value]="c.id">{{ c.nombre_banco }}</option>
              }
            </select>
          </div>
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Tipo</label>
            <select [ngModel]="filtroTipo()" (ngModelChange)="filtroTipo.set($event)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
              <option value="">Todos</option>
              <option value="Ingreso">Ingreso</option>
              <option value="Egreso">Egreso</option>
            </select>
          </div>
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Desde</label>
            <input type="date" [ngModel]="filtroDesde()" (ngModelChange)="filtroDesde.set($event)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Hasta</label>
            <input type="date" [ngModel]="filtroHasta()" (ngModelChange)="filtroHasta.set($event)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>
        </div>
      </div>

      <!-- ── Tabla de movimientos ───────────────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">

        <div class="flex items-center justify-between border-b border-gray-200 px-5 py-4 dark:border-gray-700">
          <div>
            <h3 class="text-sm font-semibold text-gray-800 dark:text-white">Movimientos</h3>
            <p class="mt-0.5 text-xs text-gray-400 dark:text-gray-500">
              {{ movimientosFiltrados().length }} registro{{ movimientosFiltrados().length !== 1 ? 's' : '' }}
            </p>
          </div>
          @if (loading()) {
            <svg class="h-4 w-4 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
            </svg>
          }
        </div>

        @if (loading() && movimientos().length === 0) {
          <div class="p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            Cargando movimientos...
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-700/40">
                <tr>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Fecha</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Banco / Cuenta</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Tipo</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Motivo / Detalle</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">N° Operación</th>
                  <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (m of movimientosFiltrados(); track m.id) {
                  <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 transition">

                    <!-- Fecha -->
                    <td class="px-4 py-3 text-xs whitespace-nowrap text-gray-500 dark:text-gray-400">
                      {{ fmtFecha(m.fecha_operacion) }}
                    </td>

                    <!-- Banco / Cuenta -->
                    <td class="px-4 py-3">
                      <p class="font-medium text-gray-800 dark:text-white leading-tight">{{ m.nombre_banco }}</p>
                      <p class="text-xs font-mono text-gray-400 dark:text-gray-500 mt-0.5">{{ m.numero_cuenta }}</p>
                    </td>

                    <!-- Tipo badge -->
                    <td class="px-4 py-3 text-center">
                      <span class="inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-xs font-semibold"
                        [ngClass]="m.tipo === 'Ingreso'
                          ? 'bg-green-50 text-green-700 dark:bg-green-900/30 dark:text-green-400'
                          : 'bg-red-50 text-red-700 dark:bg-red-900/30 dark:text-red-400'">
                        <span class="h-1.5 w-1.5 rounded-full"
                          [ngClass]="m.tipo === 'Ingreso' ? 'bg-green-500' : 'bg-red-500'">
                        </span>
                        {{ m.tipo }}
                      </span>
                    </td>

                    <!-- Motivo -->
                    <td class="px-4 py-3 text-gray-600 dark:text-gray-300 max-w-xs">
                      {{ m.motivo_detalle || '—' }}
                    </td>

                    <!-- N° Operación -->
                    <td class="px-4 py-3 font-mono text-xs text-gray-500 dark:text-gray-400 whitespace-nowrap">
                      {{ m.nro_operacion || '—' }}
                    </td>

                    <!-- Monto -->
                    <td class="px-4 py-3 text-right font-bold tabular-nums whitespace-nowrap"
                      [ngClass]="m.tipo === 'Ingreso'
                        ? 'text-green-600 dark:text-green-400'
                        : 'text-red-600 dark:text-red-400'">
                      {{ m.tipo === 'Ingreso' ? '+' : '−' }} {{ fmtSoles(m.monto) }}
                    </td>
                  </tr>
                } @empty {
                  <tr>
                    <td colspan="6" class="px-4 py-14 text-center">
                      <div class="flex flex-col items-center gap-2 text-gray-400 dark:text-gray-500">
                        <svg class="h-10 w-10 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                        </svg>
                        <p class="text-sm">Sin movimientos que coincidan con los filtros.</p>
                      </div>
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>

          <!-- Footer de totales -->
          @if (movimientosFiltrados().length > 0) {
            <div class="grid grid-cols-3 divide-x divide-gray-100 border-t border-gray-200 dark:divide-gray-700 dark:border-gray-700">
              <div class="px-5 py-3 text-center">
                <p class="text-xs text-gray-400 dark:text-gray-500">Ingresos</p>
                <p class="text-sm font-bold text-green-600 dark:text-green-400 tabular-nums">
                  + {{ fmtSoles(totalIngresos()) }}
                </p>
              </div>
              <div class="px-5 py-3 text-center">
                <p class="text-xs text-gray-400 dark:text-gray-500">Egresos</p>
                <p class="text-sm font-bold text-red-600 dark:text-red-400 tabular-nums">
                  − {{ fmtSoles(totalEgresos()) }}
                </p>
              </div>
              <div class="px-5 py-3 text-center">
                <p class="text-xs text-gray-400 dark:text-gray-500">Saldo Neto (período)</p>
                <p class="text-sm font-bold tabular-nums"
                  [ngClass]="saldoPeriodo() >= 0
                    ? 'text-brand-600 dark:text-brand-400'
                    : 'text-red-600 dark:text-red-400'">
                  {{ fmtSoles(saldoPeriodo()) }}
                </p>
              </div>
            </div>
          }
        }
      </div>
    </div>

    <!-- ── Modal: Registrar Movimiento ─────────────────────────────────── -->
    @if (showForm()) {
      <div
        class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4"
        (click)="cerrarForm()">
        <div
          class="w-full max-w-lg rounded-2xl border border-gray-200 bg-white shadow-2xl dark:border-gray-700 dark:bg-gray-800 p-6"
          (click)="$event.stopPropagation()">

          <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-5">
            Registrar Movimiento Bancario
          </h3>

          <div class="space-y-4">

            <!-- Cuenta -->
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Cuenta bancaria</label>
              <select
                [ngModel]="formInput().cuenta_id"
                (ngModelChange)="actualizarForm('cuenta_id', +$event)"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                <option [ngValue]="0" disabled>— Selecciona una cuenta —</option>
                @for (c of cuentas(); track c.id) {
                  <option [ngValue]="c.id">{{ c.nombre_banco }} · {{ c.numero_cuenta }}</option>
                }
              </select>
            </div>

            <!-- Fecha + Tipo -->
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Fecha de operación</label>
                <input type="date"
                  [ngModel]="formInput().fecha_operacion"
                  (ngModelChange)="actualizarForm('fecha_operacion', $event)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Tipo</label>
                <select
                  [ngModel]="formInput().tipo"
                  (ngModelChange)="actualizarForm('tipo', $event)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                  <option value="Ingreso">Ingreso</option>
                  <option value="Egreso">Egreso</option>
                </select>
              </div>
            </div>

            <!-- Monto + N° Operación -->
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Monto (S/)</label>
                <input type="number" step="0.01" min="0.01"
                  [ngModel]="formInput().monto"
                  (ngModelChange)="actualizarForm('monto', +$event)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">N° Operación</label>
                <input type="text"
                  placeholder="Opcional"
                  [ngModel]="formInput().nro_operacion"
                  (ngModelChange)="actualizarForm('nro_operacion', $event || null)"
                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
            </div>

            <!-- Motivo / Detalle -->
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Motivo / Detalle</label>
              <textarea rows="2"
                [ngModel]="formInput().motivo_detalle"
                (ngModelChange)="actualizarForm('motivo_detalle', $event || null)"
                class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500 resize-none"></textarea>
            </div>

            <!-- Validación -->
            @if (errorValidacion()) {
              <p class="text-sm text-red-600 dark:text-red-400">{{ errorValidacion() }}</p>
            }

          </div>

          <div class="mt-5 flex justify-end gap-2">
            <button type="button" (click)="cerrarForm()"
              class="rounded-lg bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-800 dark:text-gray-200 px-4 py-2 text-sm transition">
              Cancelar
            </button>
            <button type="button" (click)="guardar()"
              [disabled]="!!errorValidacion() || guardando()"
              class="rounded-lg bg-brand-600 hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed text-white px-4 py-2 text-sm font-semibold shadow-sm transition flex items-center gap-2">
              @if (guardando()) {
                <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Guardando…
              } @else {
                Guardar
              }
            </button>
          </div>
        </div>
      </div>
    }
  `,
})
export class BancosComponent implements OnInit, OnDestroy {
  private readonly svc = inject(BancosService);

  readonly cuentas     = this.svc.cuentas;
  readonly movimientos = this.svc.movimientos;
  readonly loading     = this.svc.loading;
  readonly error       = this.svc.error;

  readonly realtimeActivo = signal(false);
  readonly showForm       = signal(false);
  readonly guardando      = signal(false);

  // Filtros
  readonly filtroCuenta = signal<number>(0);
  readonly filtroTipo   = signal<TipoMovimiento | ''>('');
  readonly filtroDesde  = signal<string>('');
  readonly filtroHasta  = signal<string>('');

  // Formulario
  readonly formInput = signal<MovimientoInput>(movimientoInputVacio());

  // Helpers expuestos al template
  protected readonly fmtSoles = fmtSoles;
  protected readonly fmtFecha = fmtFecha;

  // ── Computed ──────────────────────────────────────────────────────────────

  readonly movimientosFiltrados = computed(() => {
    const cuenta = this.filtroCuenta();
    const tipo   = this.filtroTipo();
    const desde  = this.filtroDesde();
    const hasta  = this.filtroHasta();

    return this.movimientos().filter(m => {
      if (cuenta && m.cuenta_id !== cuenta) return false;
      if (tipo   && m.tipo !== tipo)         return false;
      if (desde  && m.fecha_operacion < desde) return false;
      if (hasta  && m.fecha_operacion > hasta) return false;
      return true;
    });
  });

  readonly totalIngresos = computed(() =>
    this.movimientosFiltrados()
      .filter(m => m.tipo === 'Ingreso')
      .reduce((s, m) => s + m.monto, 0),
  );

  readonly totalEgresos = computed(() =>
    this.movimientosFiltrados()
      .filter(m => m.tipo === 'Egreso')
      .reduce((s, m) => s + m.monto, 0),
  );

  readonly saldoPeriodo = computed(() => this.totalIngresos() - this.totalEgresos());

  readonly errorValidacion = computed(() => {
    const f = this.formInput();
    if (!f.cuenta_id)          return 'Selecciona una cuenta bancaria.';
    if (!f.fecha_operacion)    return 'La fecha de operación es obligatoria.';
    if (!f.monto || f.monto <= 0) return 'El monto debe ser mayor a 0.';
    return null;
  });

  // ── Ciclo de vida ─────────────────────────────────────────────────────────

  ngOnInit(): void {
    void this.svc.cargarTodo();
    this.svc.conectarRealtime();
    this.realtimeActivo.set(true);
  }

  ngOnDestroy(): void {
    this.svc.desconectarRealtime();
    this.realtimeActivo.set(false);
  }

  // ── Formulario ────────────────────────────────────────────────────────────

  abrirForm(): void {
    this.formInput.set(movimientoInputVacio());
    this.showForm.set(true);
  }

  cerrarForm(): void {
    this.showForm.set(false);
  }

  actualizarForm<K extends keyof MovimientoInput>(key: K, value: MovimientoInput[K]): void {
    this.formInput.update(f => ({ ...f, [key]: value }));
  }

  async guardar(): Promise<void> {
    if (this.errorValidacion() || this.guardando()) return;
    this.guardando.set(true);
    try {
      await this.svc.crearMovimiento(this.formInput());
      this.cerrarForm();
    } catch {
      // Error ya reflejado en el signal del servicio.
    } finally {
      this.guardando.set(false);
    }
  }
}
