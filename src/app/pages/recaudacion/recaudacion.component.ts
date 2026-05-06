import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { RecaudacionService } from './recaudacion.service';
import { AbonoLog, ResultadoRecaudacion, SocioTarjeta } from './recaudacion.model';

type Tab = 'registro' | 'gestion' | 'historial';

function todayIso(): string {
  return new Date().toISOString().slice(0, 10);
}
function formatSoles(n: number): string {
  return `S/ ${Number(n ?? 0).toFixed(2)}`;
}
function formatFecha(s: string): string {
  if (!s) return '—';
  return new Date(s).toLocaleDateString('es-PE', {
    day: '2-digit', month: 'short', year: 'numeric',
  });
}

@Component({
  selector: 'app-recaudacion',
  standalone: true,
  imports: [],
  template: `
    <div class="mx-auto max-w-5xl p-4 md:p-6">

      <!-- Cabecera -->
      <div class="mb-6">
        <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Recaudación por Tarjeta</h2>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          Prepagos semanales → se acreditan directamente al Saldo a Favor del socio.
        </p>
      </div>

      <!-- Tabs -->
      <div class="mb-6 flex gap-1 rounded-xl border border-gray-200 bg-gray-50 p-1 dark:border-gray-700 dark:bg-gray-800">
        @for (t of tabs; track t.id) {
          <button
            (click)="setTab(t.id)"
            class="flex flex-1 items-center justify-center gap-2 rounded-lg px-4 py-2.5 text-sm font-medium transition"
            [class]="tab() === t.id
              ? 'bg-white shadow-sm text-brand-600 dark:bg-gray-700 dark:text-brand-400'
              : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'">
            {{ t.label }}
            @if (t.id === 'registro' && sociosActivos().length > 0) {
              <span class="rounded-full bg-brand-100 px-2 py-0.5 text-xs text-brand-700 dark:bg-brand-900/40 dark:text-brand-300">
                {{ sociosActivos().length }}
              </span>
            }
          </button>
        }
      </div>

      <!-- ================================================================ -->
      <!-- TAB 1: REGISTRO SEMANAL                                          -->
      <!-- ================================================================ -->
      @if (tab() === 'registro') {
        <div class="space-y-4">

          <!-- Barra superior: fecha + monto rápido + acciones -->
          <div class="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
            <div class="flex flex-wrap items-end gap-3">
              <div>
                <label class="mb-1 block text-xs font-medium text-gray-500 dark:text-gray-400">Fecha de recaudación</label>
                <input type="date"
                       class="h-10 rounded-lg border border-gray-300 bg-white px-3 text-sm text-gray-800 outline-none
                              focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20
                              dark:border-gray-600 dark:bg-gray-800 dark:text-white"
                       [value]="fechaRecaudacion()"
                       (input)="setFechaRecaudacion($event)"/>
              </div>
              <div>
                <label class="mb-1 block text-xs font-medium text-gray-500 dark:text-gray-400">Monto rápido (aplicar a todos)</label>
                <div class="flex gap-2">
                  <input type="number" min="0" step="0.50" placeholder="0.00"
                         class="h-10 w-28 rounded-lg border border-gray-300 bg-white px-3 text-sm text-gray-800 outline-none
                                focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20
                                dark:border-gray-600 dark:bg-gray-800 dark:text-white"
                         [value]="montoRapido() || ''"
                         (input)="setMontoRapido($event)"/>
                  <button (click)="aplicarMontoRapido()"
                          [disabled]="montoRapido() <= 0 || sociosActivos().length === 0"
                          class="h-10 rounded-lg border border-gray-300 px-3 text-sm font-medium text-gray-600 transition
                                 hover:bg-gray-50 disabled:opacity-40
                                 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
                    Llenar todos
                  </button>
                  <button (click)="limpiarAbonos()"
                          class="h-10 rounded-lg border border-gray-300 px-3 text-sm text-gray-500 transition
                                 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
                    Limpiar
                  </button>
                </div>
              </div>
            </div>

            <!-- Resumen -->
            <div class="text-right">
              <p class="text-xs text-gray-400">Total a abonar</p>
              <p class="text-2xl font-bold text-brand-600 dark:text-brand-400">{{ formatSoles(totalAbono()) }}</p>
              <p class="text-xs text-gray-400">{{ conteoAbonos() }} de {{ sociosActivos().length }} socios</p>
            </div>
          </div>

          @if (cargando()) {
            <div class="flex h-32 items-center justify-center">
              <svg class="h-6 w-6 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
            </div>
          } @else if (sociosActivos().length === 0) {
            <div class="rounded-2xl border border-dashed border-gray-300 bg-white p-10 text-center dark:border-gray-700 dark:bg-gray-dark">
              <svg class="mx-auto mb-3 h-10 w-10 text-gray-300 dark:text-gray-600" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"/>
              </svg>
              <p class="text-sm font-medium text-gray-500 dark:text-gray-400">No hay socios con tarjeta activa.</p>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">Actívalos en la pestaña "Gestión de Participantes".</p>
            </div>
          } @else {
            <!-- Tabla de socios -->
            <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <th class="px-5 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Socio</th>
                    <th class="px-4 py-3.5 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Puesto</th>
                    <th class="px-4 py-3.5 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Saldo Actual</th>
                    <th class="px-5 py-3.5 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto a Abonar</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (s of sociosActivos(); track s.id) {
                    <tr class="group transition-colors hover:bg-gray-50/50 dark:hover:bg-gray-700/20">
                      <td class="px-5 py-3">
                        <p class="font-medium text-gray-800 dark:text-white">{{ s.apellidos }}</p>
                        <p class="text-xs text-gray-400">DNI {{ s.dni }}</p>
                      </td>
                      <td class="px-4 py-3 text-center">
                        <span class="font-mono text-xs text-gray-600 dark:text-gray-300">{{ s.codigo_puesto || '—' }}</span>
                      </td>
                      <td class="px-4 py-3 text-right">
                        <span [class]="s.saldo_a_favor > 0
                          ? 'font-semibold text-emerald-600 dark:text-emerald-400'
                          : 'text-gray-400'">
                          {{ formatSoles(s.saldo_a_favor) }}
                        </span>
                      </td>
                      <td class="px-5 py-3 text-right">
                        <div class="flex items-center justify-end gap-2">
                          <span class="text-xs text-gray-400">S/</span>
                          <input
                            type="number"
                            min="0"
                            step="0.50"
                            placeholder="0.00"
                            class="h-9 w-28 rounded-lg border text-right text-sm outline-none transition
                                   focus:ring-2 focus:ring-brand-500/20
                                   dark:bg-gray-800 dark:text-white"
                            [class]="getAbono(s.id) > 0
                              ? 'border-brand-400 bg-brand-50 text-brand-700 focus:border-brand-500 dark:bg-brand-900/20 dark:text-brand-300 dark:border-brand-700'
                              : 'border-gray-300 bg-white text-gray-700 focus:border-brand-500 dark:border-gray-600'"
                            [value]="getAbono(s.id) || ''"
                            (input)="setAbono(s.id, $event)"
                          />
                        </div>
                      </td>
                    </tr>
                  }
                </tbody>
                <tfoot class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <td colspan="3" class="px-5 py-3 text-sm font-semibold text-gray-700 dark:text-white">
                      Total — {{ conteoAbonos() }} socios con abono
                    </td>
                    <td class="px-5 py-3 text-right text-base font-bold text-brand-600 dark:text-brand-400">
                      {{ formatSoles(totalAbono()) }}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>

            <!-- Mensajes feedback -->
            @if (errorRegistro()) {
              <p class="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">
                {{ errorRegistro() }}
              </p>
            }
            @if (resultadoRegistro()) {
              <div class="rounded-xl border border-green-200 bg-green-50 px-5 py-4 dark:border-green-800/40 dark:bg-green-900/20">
                <p class="font-semibold text-green-700 dark:text-green-400">
                  ✓ Recaudación registrada
                </p>
                <p class="mt-1 text-sm text-green-600 dark:text-green-500">
                  {{ resultadoRegistro()!.insertados }} abonos · Total:
                  <strong>{{ formatSoles(resultadoRegistro()!.total_abonado) }}</strong>
                  @if (resultadoRegistro()!.omitidos > 0) {
                    · ⚠ {{ resultadoRegistro()!.omitidos }} omitidos
                  }
                </p>
              </div>
            }

            <!-- Botón registrar -->
            <div class="flex justify-end">
              <button
                (click)="registrar()"
                [disabled]="guardando() || totalAbono() === 0"
                class="flex items-center gap-2 rounded-xl bg-brand-500 px-6 py-3 text-sm font-semibold text-white
                       shadow-sm transition hover:bg-brand-600 disabled:cursor-not-allowed disabled:opacity-40">
                @if (guardando()) {
                  <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Registrando…
                } @else {
                  <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  Registrar Recaudación
                }
              </button>
            </div>
          }
        </div>
      }

      <!-- ================================================================ -->
      <!-- TAB 2: GESTIÓN DE PARTICIPANTES                                  -->
      <!-- ================================================================ -->
      @if (tab() === 'gestion') {
        <div class="space-y-4">
          <!-- Búsqueda -->
          <div class="relative">
            <svg class="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8"/><path stroke-linecap="round" d="m21 21-4.35-4.35"/>
            </svg>
            <input
              type="text"
              placeholder="Buscar socio por nombre o DNI…"
              class="h-10 w-full rounded-lg border border-gray-300 bg-white pl-9 pr-4 text-sm text-gray-800 outline-none
                     focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20
                     dark:border-gray-700 dark:bg-gray-800 dark:text-white dark:placeholder-gray-500"
              [value]="queryGestion()"
              (input)="onQueryGestion($event)"
            />
          </div>

          <!-- Estadísticas rápidas -->
          <div class="grid grid-cols-2 gap-4 sm:grid-cols-3">
            <div class="rounded-xl border border-gray-200 bg-white p-4 dark:border-gray-700 dark:bg-gray-dark">
              <p class="text-xs text-gray-400 dark:text-gray-500">Total socios activos</p>
              <p class="mt-1 text-2xl font-bold text-gray-800 dark:text-white">{{ todosSocios().length }}</p>
            </div>
            <div class="rounded-xl border border-brand-200 bg-brand-50 p-4 dark:border-brand-800/40 dark:bg-brand-900/20">
              <p class="text-xs text-brand-500 dark:text-brand-400">Con tarjeta activa</p>
              <p class="mt-1 text-2xl font-bold text-brand-600 dark:text-brand-300">
                {{ totalConTarjeta() }}
              </p>
            </div>
            <div class="rounded-xl border border-gray-200 bg-white p-4 dark:border-gray-700 dark:bg-gray-dark">
              <p class="text-xs text-gray-400 dark:text-gray-500">Sin tarjeta</p>
              <p class="mt-1 text-2xl font-bold text-gray-600 dark:text-gray-300">
                {{ todosSocios().length - totalConTarjeta() }}
              </p>
            </div>
          </div>

          @if (errorGestion()) {
            <p class="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">
              {{ errorGestion() }}
            </p>
          }
          @if (cargandoGestion()) {
            <div class="flex h-32 items-center justify-center">
              <svg class="h-6 w-6 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
            </div>
          } @else {
            <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <th class="px-5 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Socio</th>
                    <th class="px-4 py-3.5 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Puesto</th>
                    <th class="px-4 py-3.5 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Saldo a Favor</th>
                    <th class="px-5 py-3.5 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Participa</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (s of sociosFiltradosGestion(); track s.id) {
                    <tr class="bg-white transition-colors hover:bg-gray-50/50 dark:bg-gray-800 dark:hover:bg-gray-700/30">
                      <td class="px-5 py-3">
                        <p class="font-medium text-gray-800 dark:text-white">{{ s.apellidos }}</p>
                        <p class="text-xs text-gray-400">DNI {{ s.dni }}</p>
                      </td>
                      <td class="px-4 py-3 text-center">
                        <span class="font-mono text-xs text-gray-600 dark:text-gray-300">{{ s.codigo_puesto || '—' }}</span>
                      </td>
                      <td class="px-4 py-3 text-right">
                        <span [class]="s.saldo_a_favor > 0
                          ? 'font-semibold text-emerald-600 dark:text-emerald-400'
                          : 'text-gray-400'">
                          {{ formatSoles(s.saldo_a_favor) }}
                        </span>
                      </td>
                      <td class="px-5 py-3 text-center">
                        <button
                          (click)="toggleParticipacion(s)"
                          [disabled]="toggling().has(s.id)"
                          class="relative inline-flex h-6 w-11 items-center rounded-full transition-colors disabled:opacity-60"
                          [class]="s.usa_recaudacion_tarjeta
                            ? 'bg-brand-500'
                            : 'bg-gray-300 dark:bg-gray-600'"
                          [attr.aria-checked]="s.usa_recaudacion_tarjeta"
                          role="switch">
                          @if (toggling().has(s.id)) {
                            <svg class="mx-auto h-3 w-3 animate-spin text-white" fill="none" viewBox="0 0 24 24">
                              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                            </svg>
                          } @else {
                            <span class="inline-block h-4 w-4 transform rounded-full bg-white shadow transition-transform"
                                  [class]="s.usa_recaudacion_tarjeta ? 'translate-x-6' : 'translate-x-1'">
                            </span>
                          }
                        </button>
                      </td>
                    </tr>
                  } @empty {
                    <tr>
                      <td colspan="4" class="py-10 text-center text-sm text-gray-400 dark:text-gray-500">
                        No hay socios que coincidan con la búsqueda.
                      </td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>
          }
        </div>
      }

      <!-- ================================================================ -->
      <!-- TAB 3: HISTORIAL                                                  -->
      <!-- ================================================================ -->
      @if (tab() === 'historial') {
        <div class="space-y-4">
          <div class="flex items-center justify-between">
            <p class="text-sm text-gray-500 dark:text-gray-400">Últimos 50 abonos registrados</p>
            <button (click)="cargarHistorial()"
                    class="rounded-lg border border-gray-300 px-4 py-2 text-xs font-medium text-gray-600 transition hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              Actualizar
            </button>
          </div>

          @if (cargandoHistorial()) {
            <div class="flex h-32 items-center justify-center">
              <svg class="h-6 w-6 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
            </div>
          } @else {
            <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/50">
                  <tr>
                    <th class="px-5 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Socio</th>
                    <th class="px-4 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Fecha</th>
                    <th class="px-4 py-3.5 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (a of historial(); track a.id) {
                    <tr class="bg-white dark:bg-gray-800">
                      <td class="px-5 py-3 font-medium text-gray-800 dark:text-white">{{ a.nombre_socio }}</td>
                      <td class="px-4 py-3 text-gray-500 dark:text-gray-400">{{ formatFecha(a.fecha) }}</td>
                      <td class="px-4 py-3 text-right font-semibold text-emerald-600 dark:text-emerald-400">
                        {{ formatSoles(a.monto) }}
                      </td>
                    </tr>
                  } @empty {
                    <tr>
                      <td colspan="3" class="py-10 text-center text-sm text-gray-400">
                        No hay abonos registrados aún.
                      </td>
                    </tr>
                  }
                </tbody>
                @if (historial().length > 0) {
                  <tfoot class="bg-gray-50 dark:bg-gray-700/50">
                    <tr>
                      <td colspan="2" class="px-5 py-3 text-sm font-semibold text-gray-700 dark:text-white">Total mostrado</td>
                      <td class="px-4 py-3 text-right text-base font-bold text-emerald-600 dark:text-emerald-400">
                        {{ formatSoles(totalHistorial()) }}
                      </td>
                    </tr>
                  </tfoot>
                }
              </table>
            </div>
          }
        </div>
      }

    </div>
  `,
})
export class RecaudacionComponent implements OnInit {
  private readonly svc = inject(RecaudacionService);

  readonly formatSoles  = formatSoles;
  readonly formatFecha  = formatFecha;

  readonly tabs = [
    { id: 'registro'  as Tab, label: 'Registro Semanal'       },
    { id: 'gestion'   as Tab, label: 'Gestión de Participantes' },
    { id: 'historial' as Tab, label: 'Historial'               },
  ];

  // ── Tab activo ─────────────────────────────────────────────────────────────
  readonly tab = signal<Tab>('registro');

  setTab(t: Tab): void {
    this.tab.set(t);
    if (t === 'gestion'   && this.todosSocios().length === 0)  void this.cargarGestion();
    if (t === 'historial' && this.historial().length === 0)    void this.cargarHistorial();
  }

  // ── Tab 1: Registro Semanal ────────────────────────────────────────────────
  readonly cargando          = signal(true);
  readonly sociosActivos     = signal<SocioTarjeta[]>([]);
  readonly fechaRecaudacion  = signal(todayIso());
  readonly montoRapido       = signal(0);
  readonly abonos            = signal<Record<number, number>>({});
  readonly guardando         = signal(false);
  readonly errorRegistro     = signal<string | null>(null);
  readonly resultadoRegistro = signal<ResultadoRecaudacion | null>(null);

  readonly totalAbono = computed(() =>
    Math.round(
      Object.values(this.abonos()).reduce((s, m) => s + (m > 0 ? m : 0), 0) * 100,
    ) / 100,
  );
  readonly conteoAbonos = computed(() =>
    Object.values(this.abonos()).filter(m => m > 0).length,
  );

  getAbono(socioId: number): number {
    return this.abonos()[socioId] ?? 0;
  }

  setAbono(socioId: number, ev: Event): void {
    const val = parseFloat((ev.target as HTMLInputElement).value);
    this.abonos.update(a => ({ ...a, [socioId]: isNaN(val) || val < 0 ? 0 : val }));
    this.resultadoRegistro.set(null);
  }

  setFechaRecaudacion(ev: Event): void {
    this.fechaRecaudacion.set((ev.target as HTMLInputElement).value);
  }

  setMontoRapido(ev: Event): void {
    const val = parseFloat((ev.target as HTMLInputElement).value);
    this.montoRapido.set(isNaN(val) || val < 0 ? 0 : val);
  }

  aplicarMontoRapido(): void {
    if (this.montoRapido() <= 0) return;
    const nuevo: Record<number, number> = {};
    this.sociosActivos().forEach(s => { nuevo[s.id] = this.montoRapido(); });
    this.abonos.set(nuevo);
    this.resultadoRegistro.set(null);
  }

  limpiarAbonos(): void {
    this.abonos.set({});
    this.montoRapido.set(0);
    this.resultadoRegistro.set(null);
    this.errorRegistro.set(null);
  }

  async registrar(): Promise<void> {
    this.errorRegistro.set(null);
    this.resultadoRegistro.set(null);

    const items = this.sociosActivos()
      .map(s => ({ socio_id: s.id, monto: this.getAbono(s.id) }))
      .filter(i => i.monto > 0);

    if (items.length === 0) {
      this.errorRegistro.set('Ingresa al menos un monto antes de registrar.');
      return;
    }

    this.guardando.set(true);
    try {
      const r = await this.svc.registrarRecaudacion(items, this.fechaRecaudacion());
      this.resultadoRegistro.set(r);
      this.limpiarAbonos();
      // Refrescar saldos
      const actualizados = await this.svc.listarConTarjeta();
      this.sociosActivos.set(actualizados);
    } catch (e: unknown) {
      this.errorRegistro.set(e instanceof Error ? e.message : 'Error al registrar');
    } finally {
      this.guardando.set(false);
    }
  }

  // ── Tab 2: Gestión ─────────────────────────────────────────────────────────
  readonly cargandoGestion    = signal(false);
  readonly errorGestion       = signal<string | null>(null);
  readonly todosSocios        = signal<SocioTarjeta[]>([]);
  readonly totalConTarjeta    = computed(() => this.todosSocios().filter(s => s.usa_recaudacion_tarjeta).length);
  readonly queryGestion       = signal('');
  readonly toggling           = signal<Set<number>>(new Set());

  readonly sociosFiltradosGestion = computed(() => {
    const q = this.queryGestion().toLowerCase().trim();
    if (!q) return this.todosSocios();
    return this.todosSocios().filter(s =>
      s.apellidos.toLowerCase().includes(q) || s.dni.includes(q),
    );
  });

  onQueryGestion(ev: Event): void {
    this.queryGestion.set((ev.target as HTMLInputElement).value);
  }

  async toggleParticipacion(s: SocioTarjeta): Promise<void> {
    if (this.toggling().has(s.id)) return;
    this.toggling.update(set => { const ns = new Set(set); ns.add(s.id); return ns; });
    try {
      await this.svc.toggleTarjeta(s.id, !s.usa_recaudacion_tarjeta);
      // Actualizar localmente en ambas listas
      this.todosSocios.update(lst =>
        lst.map(x => x.id === s.id ? { ...x, usa_recaudacion_tarjeta: !x.usa_recaudacion_tarjeta } : x),
      );
      // Refrescar tab registro si está activo
      const activos = await this.svc.listarConTarjeta();
      this.sociosActivos.set(activos);
    } catch (e: unknown) {
      this.errorGestion.set(e instanceof Error ? e.message : 'Error al cambiar la participación');
    } finally {
      this.toggling.update(set => { const ns = new Set(set); ns.delete(s.id); return ns; });
    }
  }

  // ── Tab 3: Historial ───────────────────────────────────────────────────────
  readonly cargandoHistorial = signal(false);
  readonly historial         = signal<AbonoLog[]>([]);

  readonly totalHistorial = computed(() =>
    Math.round(this.historial().reduce((s, a) => s + a.monto, 0) * 100) / 100,
  );

  async cargarHistorial(): Promise<void> {
    this.cargandoHistorial.set(true);
    try {
      this.historial.set(await this.svc.listarAbonos());
    } catch { /* no crítico */ }
    finally { this.cargandoHistorial.set(false); }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  private async cargarGestion(): Promise<void> {
    this.cargandoGestion.set(true);
    try {
      this.todosSocios.set(await this.svc.listarTodosParaGestion());
    } catch { /* no crítico */ }
    finally { this.cargandoGestion.set(false); }
  }

  async ngOnInit(): Promise<void> {
    try {
      this.sociosActivos.set(await this.svc.listarConTarjeta());
    } catch { /* manejado en template */ }
    finally { this.cargando.set(false); }
  }
}
