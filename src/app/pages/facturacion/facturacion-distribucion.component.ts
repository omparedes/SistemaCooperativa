import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import {
  DistribucionDetalle,
  FacturacionService,
  ResultadoAprobarDistribucion,
} from '../../core/services/facturacion.service';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
const MESES = ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
               'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

function hoyAnio(): number { return new Date().getFullYear(); }
function hoyMes():  number { return new Date().getMonth() + 1; }

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-facturacion-distribucion',
  standalone: true,
  imports: [FormsModule],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">
            Distribución Mensual de Luz / Agua
          </h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Ingresa el monto del recibo real y distribúyelo entre los espacios activos.
            Los cobros solo pueden registrarse una vez por mes y por servicio.
          </p>
        </div>

        <!-- Controles del período -->
        <div class="flex flex-wrap items-end gap-3">

          <!-- Servicio -->
          <div>
            <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Servicio</label>
            <select [(ngModel)]="servicio" (change)="onPeriodoChange()"
              class="h-9 rounded-lg border border-gray-300 bg-white px-3 text-sm dark:border-gray-600 dark:bg-gray-800 dark:text-white focus:border-brand-500 focus:outline-none">
              <option value="Luz">⚡ Luz</option>
              <option value="Agua">💧 Agua</option>
            </select>
          </div>

          <!-- Año -->
          <div>
            <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Año</label>
            <input type="number" [(ngModel)]="anio" (change)="onPeriodoChange()"
              min="2020" max="2100" step="1"
              class="h-9 w-24 rounded-lg border border-gray-300 bg-white px-3 text-sm dark:border-gray-600 dark:bg-gray-800 dark:text-white focus:border-brand-500 focus:outline-none"/>
          </div>

          <!-- Mes -->
          <div>
            <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Mes</label>
            <select [(ngModel)]="mes" (change)="onPeriodoChange()"
              class="h-9 rounded-lg border border-gray-300 bg-white px-3 text-sm dark:border-gray-600 dark:bg-gray-800 dark:text-white focus:border-brand-500 focus:outline-none">
              @for (m of mesesArr; track m.n) {
                <option [value]="m.n">{{ m.nombre }}</option>
              }
            </select>
          </div>

          <!-- Botón Cargar -->
          <button (click)="cargar()" [disabled]="cargando()"
            class="h-9 flex items-center gap-1.5 rounded-lg border border-gray-300 px-3 text-sm text-gray-600 hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700 transition">
            <svg class="h-4 w-4" [class.animate-spin]="cargando()" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
            </svg>
            Cargar
          </button>
        </div>
      </div>

      <!-- ── Badge de estado ────────────────────────────────────────────── -->
      @if (estadoActual()) {
        <div class="mb-4 flex items-center gap-3">
          <span [class]="badgeClase()">
            {{ estadoActual() }}
          </span>
          @if (estadoActual() === 'Aprobado') {
            <span class="text-xs text-gray-400 dark:text-gray-500">
              Los montos_por_cobrar ya fueron generados. No se puede modificar.
            </span>
          }
        </div>
      }

      <!-- ── Errores y mensajes ─────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      @if (mensajeExito()) {
        <div class="mb-4 rounded-xl border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-700 dark:border-green-800 dark:bg-green-900/20 dark:text-green-400">
          {{ mensajeExito() }}
        </div>
      }

      <!-- ── Resultado de aprobación ──────────────────────────────────── -->
      @if (resultadoAprobacion()) {
        <div class="mb-4 rounded-xl border border-brand-200 bg-brand-50 p-4 dark:border-brand-800 dark:bg-brand-900/20">
          <p class="font-semibold text-brand-700 dark:text-brand-300">
            ✓ Distribución aprobada — {{ MESES[mes - 1] }} {{ anio }}
          </p>
          <ul class="mt-1 text-xs text-brand-600 dark:text-brand-400 space-y-0.5">
            <li>Montos generados: <strong>{{ resultadoAprobacion()!.montos_generados }}</strong></li>
            <li>Ya existían (omitidos): <strong>{{ resultadoAprobacion()!.montos_ya_existian }}</strong></li>
          </ul>
        </div>
      }

      <!-- ── Tabla de distribución ─────────────────────────────────────── -->
      @if (detalles().length > 0) {

        <!-- Monto del recibo y resumen -->
        <div class="mb-4 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">

          <!-- Monto recibo real -->
          <div class="flex items-end gap-3">
            <div>
              <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                Monto total del recibo real (S/)
              </label>
              <input
                type="number"
                min="0"
                step="0.01"
                [(ngModel)]="montoReciboReal"
                [disabled]="aprobado()"
                placeholder="0.00"
                class="h-10 w-40 rounded-lg border px-3 text-sm tabular-nums focus:outline-none focus:ring-2 focus:ring-brand-500/20"
                [class]="aprobado()
                  ? 'border-gray-200 bg-gray-100 text-gray-400 dark:border-gray-700 dark:bg-gray-800'
                  : diferencia() < 0
                    ? 'border-red-300 bg-red-50 text-red-800 dark:border-red-700 dark:bg-red-900/20'
                    : 'border-gray-300 bg-white dark:border-gray-600 dark:bg-gray-800 dark:text-white'"
              />
            </div>

            <!-- Diferencia (recibo - distribuido) -->
            <div class="pb-0.5">
              <p class="text-xs text-gray-400 mb-0.5">Diferencia</p>
              <p class="text-sm font-semibold tabular-nums"
                 [class]="diferencia() < 0
                   ? 'text-red-600 dark:text-red-400'
                   : diferencia() === 0
                     ? 'text-green-600 dark:text-green-400'
                     : 'text-amber-600 dark:text-amber-400'">
                S/ {{ diferencia().toFixed(2) }}
                @if (diferencia() > 0) { <span class="text-xs font-normal">(sin distribuir)</span> }
                @if (diferencia() < 0) { <span class="text-xs font-normal">(excede recibo)</span> }
                @if (diferencia() === 0 && totalDistribuido() > 0) { <span class="text-xs font-normal">(cuadrado)</span> }
              </p>
            </div>
          </div>

          <!-- Acciones -->
          <div class="flex flex-wrap gap-2">

            <!-- Limpiar montos -->
            @if (!aprobado()) {
              <button (click)="limpiarMontos()"
                class="h-8 rounded-lg border border-gray-300 px-3 text-xs text-gray-500 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700 transition">
                Limpiar montos
              </button>
            }

            <!-- Resetear distribución -->
            @if (!aprobado()) {
              <button (click)="confirmarResetear()" [disabled]="guardando() || aprobando()"
                class="h-8 rounded-lg border border-red-300 px-3 text-xs text-red-600 hover:bg-red-50 disabled:opacity-40 dark:border-red-800 dark:text-red-400 dark:hover:bg-red-900/20 transition">
                Resetear
              </button>
            }

            <!-- Guardar borrador -->
            @if (!aprobado()) {
              <button (click)="guardarBorrador()"
                [disabled]="guardando() || aprobando() || detallesConMonto().length === 0"
                class="h-8 flex items-center gap-1.5 rounded-lg border border-brand-300 px-3 text-xs text-brand-600 hover:bg-brand-50 disabled:opacity-40 dark:border-brand-700 dark:text-brand-400 dark:hover:bg-brand-900/20 transition">
                @if (guardando()) {
                  <svg class="h-3.5 w-3.5 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Guardando…
                } @else {
                  Guardar borrador
                }
              </button>
            }

            <!-- Aprobar -->
            @if (!aprobado()) {
              <button (click)="confirmarAprobar()"
                [disabled]="aprobando() || guardando() || detallesConMonto().length === 0 || diferencia() < 0"
                class="h-8 flex items-center gap-1.5 rounded-lg bg-brand-600 px-4 text-xs font-medium text-white hover:bg-brand-700 disabled:opacity-40 transition">
                @if (aprobando()) {
                  <svg class="h-3.5 w-3.5 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Aprobando…
                } @else {
                  <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  Aprobar y generar cobros
                }
              </button>
            }
          </div>
        </div>

        <!-- Buscador -->
        <div class="mb-4">
          <div class="relative max-w-md">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-gray-400">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
              </svg>
            </span>
            <input
              type="text"
              [ngModel]="filtro()"
              (ngModelChange)="filtro.set($event)"
              placeholder="Buscar por código de puesto u ocupante..."
              class="h-9 w-full rounded-lg border border-gray-300 bg-white pl-9 pr-3 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-800 dark:text-white"
            />
          </div>
        </div>

        <!-- Tabla -->
        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-700/40 sticky top-0">
                <tr>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-24">Puesto</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-20">Tipo</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Ocupante</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-24">Rol</th>
                  <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-36">
                    Monto S/ ★
                  </th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Observación</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (d of detallesFiltrados(); track d.puesto_id; let i = $index) {
                  <tr [class]="'transition ' + (d.monto > 0
                      ? 'bg-green-50 dark:bg-green-900/10 hover:bg-green-100/60 dark:hover:bg-green-900/20'
                      : 'hover:bg-blue-50/30 dark:hover:bg-brand-900/10')">

                    <!-- Código puesto -->
                    <td class="px-4 py-2">
                      <span class="rounded-md bg-brand-50 px-2 py-0.5 text-xs font-bold text-brand-600 dark:bg-brand-900/20 dark:text-brand-400">
                        {{ d.codigo_puesto }}
                      </span>
                    </td>

                    <!-- Tipo espacio -->
                    <td class="px-4 py-2">
                      <span [class]="d.tipo_espacio === 'Principal'
                        ? 'text-xs text-gray-500 dark:text-gray-400'
                        : 'text-xs text-amber-600 dark:text-amber-400'">
                        {{ d.tipo_espacio === 'Principal' ? 'Ppal.' : 'Almacén' }}
                      </span>
                    </td>

                    <!-- Ocupante -->
                    <td class="px-4 py-2 text-gray-700 dark:text-gray-300 leading-tight">
                      <p class="font-medium text-xs">{{ d.ocupante_nombre.split(',')[0] }}</p>
                      <p class="text-xs text-gray-400">{{ d.ocupante_nombre.split(',').slice(1).join(',').trim() }}</p>
                    </td>

                    <!-- Rol -->
                    <td class="px-4 py-2">
                      <span [class]="d.tipo_ocupante === 'Socio'
                        ? 'text-xs text-blue-600 dark:text-blue-400'
                        : d.tipo_ocupante === 'Tercero'
                          ? 'text-xs text-purple-600 dark:text-purple-400'
                          : 'text-xs text-green-600 dark:text-green-400'">
                        {{ d.tipo_ocupante ?? '—' }}
                      </span>
                    </td>

                    <!-- Monto — celda editable principal -->
                    <td class="px-2 py-1.5">
                      <input
                        type="number"
                        min="0"
                        step="0.01"
                        placeholder="0.00"
                        [(ngModel)]="d.monto"
                        [disabled]="aprobado()"
                        [name]="'monto_' + d.puesto_id"
                        [class]="'h-9 w-full rounded-lg border text-right text-sm tabular-nums transition focus:outline-none focus:ring-2 focus:ring-brand-500/20 ' + (d.monto > 0
                          ? 'border-green-300 bg-green-50 text-green-800 dark:border-green-700 dark:bg-green-900/20 dark:text-green-300 focus:border-green-400'
                          : aprobado()
                            ? 'border-gray-200 bg-gray-100 text-gray-400 dark:border-gray-700 dark:bg-gray-800'
                            : 'border-gray-300 bg-gray-50 text-gray-700 dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-400')"
                      />
                    </td>

                    <!-- Observación -->
                    <td class="px-2 py-1.5">
                      <input
                        type="text"
                        placeholder="Opcional"
                        [(ngModel)]="d.observacion"
                        [disabled]="aprobado()"
                        [name]="'obs_' + d.puesto_id"
                        class="h-9 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-xs dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none disabled:bg-gray-100 disabled:text-gray-400 dark:disabled:bg-gray-800"
                      />
                    </td>
                  </tr>
                }
              </tbody>
              <tfoot class="bg-gray-50 dark:bg-gray-700/40">
                <tr>
                  <td colspan="4" class="px-4 py-3 text-xs font-semibold text-gray-600 dark:text-gray-300 text-right">
                    Total distribuido ({{ detallesConMonto().length }} espacios con monto):
                  </td>
                  <td class="px-4 py-3 text-right font-bold tabular-nums"
                      [class]="diferencia() < 0
                        ? 'text-red-600 dark:text-red-400'
                        : 'text-brand-600 dark:text-brand-400'">
                    S/ {{ totalDistribuido().toLocaleString('en-US', {minimumFractionDigits:2, maximumFractionDigits:2}) }}
                  </td>
                  <td></td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>

        <p class="mt-2 text-xs text-gray-400 dark:text-gray-500">
          ★ Deja el monto en 0 para omitir ese espacio. Solo se generan cobros para montos mayores a 0.
          La distribución aprobada no puede modificarse.
        </p>

      } @else if (!cargando()) {
        <div class="flex flex-col items-center justify-center gap-3 py-20 text-gray-400 dark:text-gray-500">
          <svg class="h-12 w-12 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z"/>
          </svg>
          <p class="text-sm">Selecciona un período y servicio, luego pulsa <strong>Cargar</strong>.</p>
        </div>
      }

      <!-- ── Modal de confirmación de Aprobar ──────────────────────────── -->
      @if (mostrarModalAprobar()) {
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div class="w-full max-w-md rounded-2xl bg-white p-6 shadow-2xl dark:bg-gray-dark">
            <h3 class="mb-2 text-lg font-bold text-gray-900 dark:text-white">
              Confirmar aprobación
            </h3>
            <p class="text-sm text-gray-600 dark:text-gray-400">
              Se generarán <strong>{{ detallesConMonto().length }}</strong> cobros de
              <strong>{{ servicio }}</strong> para <strong>{{ MESES[mes-1] }} {{ anio }}</strong>
              con un total de
              <strong>S/ {{ totalDistribuido().toFixed(2) }}</strong>.
            </p>
            <p class="mt-2 text-xs text-amber-600 dark:text-amber-400">
              Esta acción es irreversible. Los cobros quedarán registrados en la Cuenta Corriente
              de cada espacio.
            </p>
            <div class="mt-5 flex justify-end gap-3">
              <button (click)="mostrarModalAprobar.set(false)"
                class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
                Cancelar
              </button>
              <button (click)="ejecutarAprobacion()"
                class="rounded-lg bg-brand-600 px-5 py-2 text-sm font-medium text-white hover:bg-brand-700">
                Sí, aprobar
              </button>
            </div>
          </div>
        </div>
      }

      <!-- ── Modal de confirmación de Resetear ─────────────────────────── -->
      @if (mostrarModalResetear()) {
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div class="w-full max-w-md rounded-2xl bg-white p-6 shadow-2xl dark:bg-gray-dark">
            <h3 class="mb-2 text-lg font-bold text-gray-900 dark:text-white">
              Confirmar reseteo
            </h3>
            <p class="text-sm text-gray-600 dark:text-gray-400">
              Se eliminarán todos los montos ingresados para
              <strong>{{ servicio }}</strong> — <strong>{{ MESES[mes-1] }} {{ anio }}</strong>.
              La distribución quedará en blanco.
            </p>
            <div class="mt-5 flex justify-end gap-3">
              <button (click)="mostrarModalResetear.set(false)"
                class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
                Cancelar
              </button>
              <button (click)="ejecutarResetear()"
                class="rounded-lg bg-red-600 px-5 py-2 text-sm font-medium text-white hover:bg-red-700">
                Sí, resetear
              </button>
            </div>
          </div>
        </div>
      }

    </div>
  `,
})
export class FacturacionDistribucionComponent implements OnInit {
  private readonly svc = inject(FacturacionService);
  private readonly route = inject(ActivatedRoute);

  // ── Estado del período ──────────────────────────────────────────────────
  servicio: 'Luz' | 'Agua' = 'Luz';
  anio = hoyAnio();
  mes  = hoyMes();

  // ── Estado de carga ─────────────────────────────────────────────────────
  readonly cargando  = signal(false);
  readonly guardando = signal(false);
  readonly aprobando = signal(false);

  // ── Datos ───────────────────────────────────────────────────────────────
  readonly detalles      = signal<DistribucionDetalle[]>([]);
  readonly filtro        = signal('');
  readonly estadoActual  = signal<'Borrador' | 'En Revision' | 'Aprobado' | null>(null);
  readonly resultadoAprobacion = signal<ResultadoAprobarDistribucion | null>(null);
  montoReciboReal = 0;

  // ── Mensajes ────────────────────────────────────────────────────────────
  readonly error        = signal<string | null>(null);
  readonly mensajeExito = signal<string | null>(null);

  // ── Modales de confirmación ──────────────────────────────────────────────
  readonly mostrarModalAprobar   = signal(false);
  readonly mostrarModalResetear  = signal(false);

  // ── Computed ─────────────────────────────────────────────────────────────
  readonly aprobado = computed(() => this.estadoActual() === 'Aprobado');

  readonly detallesFiltrados = computed(() => {
    const q = this.filtro().trim().toLowerCase();
    if (!q) return this.detalles();
    return this.detalles().filter(d =>
      d.codigo_puesto.toLowerCase().includes(q) ||
      d.ocupante_nombre.toLowerCase().includes(q)
    );
  });

  readonly detallesConMonto = computed(() =>
    this.detalles().filter(d => d.monto > 0),
  );

  readonly totalDistribuido = computed(() =>
    this.detalles().reduce((s, d) => s + (d.monto > 0 ? d.monto : 0), 0),
  );

  readonly diferencia = computed(() =>
    Math.round((this.montoReciboReal - this.totalDistribuido()) * 100) / 100,
  );

  readonly badgeClase = computed(() => {
    const estado = this.estadoActual();
    if (estado === 'Aprobado')    return 'inline-flex items-center rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-semibold text-green-700 dark:bg-green-900/30 dark:text-green-400';
    if (estado === 'En Revision') return 'inline-flex items-center rounded-full bg-amber-100 px-2.5 py-0.5 text-xs font-semibold text-amber-700 dark:bg-amber-900/30 dark:text-amber-400';
    return 'inline-flex items-center rounded-full bg-gray-100 px-2.5 py-0.5 text-xs font-semibold text-gray-600 dark:bg-gray-700 dark:text-gray-300';
  });

  // ── Helpers expuestos al template ─────────────────────────────────────────
  protected readonly MESES    = MESES;
  protected readonly mesesArr = MESES.map((nombre, i) => ({ n: i + 1, nombre }));

  ngOnInit(): void {
    this.route.data.subscribe(data => {
      const s = data['servicio'];
      if (s === 'Luz' || s === 'Agua') {
        this.servicio = s;
      }
      void this.cargar();
    });
  }

  onPeriodoChange(): void {
    void this.cargar();
  }

  // ── Carga combinada: puestos elegibles + distribución existente ───────────
  async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    this.mensajeExito.set(null);
    this.resultadoAprobacion.set(null);

    try {
      const [puestos, dist] = await Promise.all([
        this.svc.cargarPuestosParaDistribucion(this.servicio),
        this.svc.cargarDistribucionExistente(this.servicio, this.anio, this.mes),
      ]);

      // Mapa de montos guardados por puesto_id
      const montosGuardados = new Map<number, { monto: number; observacion: string }>();
      if (dist) {
        this.montoReciboReal = dist.monto_recibo_real;
        this.estadoActual.set(dist.estado);
        for (const d of dist.detalles) {
          montosGuardados.set(d.puesto_id, { monto: d.monto, observacion: d.observacion });
        }
      } else {
        this.montoReciboReal = 0;
        this.estadoActual.set(null);
      }

      // Fusionar puestos con montos guardados
      this.detalles.set(puestos.map(p => ({
        ...p,
        monto:       montosGuardados.get(p.puesto_id)?.monto       ?? 0,
        observacion: montosGuardados.get(p.puesto_id)?.observacion ?? '',
      })));

    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar datos');
    } finally {
      this.cargando.set(false);
    }
  }

  limpiarMontos(): void {
    this.detalles.update(ds => ds.map(d => ({ ...d, monto: 0, observacion: '' })));
  }

  // ── Guardar borrador ──────────────────────────────────────────────────────
  async guardarBorrador(): Promise<void> {
    if (this.detallesConMonto().length === 0) return;

    this.guardando.set(true);
    this.error.set(null);
    this.mensajeExito.set(null);
    try {
      const res = await this.svc.guardarProgresoDistribucion({
        servicio:        this.servicio,
        anio:            this.anio,
        mes:             this.mes,
        montoReciboReal: this.montoReciboReal,
        detalles:        this.detalles().map(d => ({
          puesto_id:   d.puesto_id,
          monto:       d.monto,
          observacion: d.observacion,
        })),
      });
      this.estadoActual.set('Borrador');
      this.mensajeExito.set(
        `Borrador guardado — ${res.detalles_guardados} espacios registrados.`,
      );
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al guardar borrador');
    } finally {
      this.guardando.set(false);
    }
  }

  // ── Resetear ──────────────────────────────────────────────────────────────
  confirmarResetear(): void {
    this.mostrarModalResetear.set(true);
  }

  async ejecutarResetear(): Promise<void> {
    this.mostrarModalResetear.set(false);
    this.guardando.set(true);
    this.error.set(null);
    this.mensajeExito.set(null);
    try {
      await this.svc.resetearDistribucionMensual(this.servicio, this.anio, this.mes);
      this.estadoActual.set(null);
      this.montoReciboReal = 0;
      this.limpiarMontos();
      this.mensajeExito.set('Distribución reseteada correctamente.');
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al resetear distribución');
    } finally {
      this.guardando.set(false);
    }
  }

  // ── Aprobar ───────────────────────────────────────────────────────────────
  confirmarAprobar(): void {
    if (this.detallesConMonto().length === 0 || this.diferencia() < 0) return;
    this.mostrarModalAprobar.set(true);
  }

  async ejecutarAprobacion(): Promise<void> {
    this.mostrarModalAprobar.set(false);
    this.aprobando.set(true);
    this.error.set(null);
    this.mensajeExito.set(null);

    try {
      // Primero guardar el estado más reciente, luego aprobar
      await this.svc.guardarProgresoDistribucion({
        servicio:        this.servicio,
        anio:            this.anio,
        mes:             this.mes,
        montoReciboReal: this.montoReciboReal,
        detalles:        this.detalles().map(d => ({
          puesto_id:   d.puesto_id,
          monto:       d.monto,
          observacion: d.observacion,
        })),
      });
      const res = await this.svc.aprobarDistribucionMensual(this.servicio, this.anio, this.mes);
      this.resultadoAprobacion.set(res);
      this.estadoActual.set('Aprobado');
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al aprobar distribución');
    } finally {
      this.aprobando.set(false);
    }
  }
}
