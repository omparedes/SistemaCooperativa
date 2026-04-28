import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { DecimalPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  AfectadosConteo,
  CargosExtraordinariosService,
  ConceptoCargo,
  ResultadoCargoSegmentado,
  Segmento,
} from '../../core/services/cargos-extraordinarios.service';
import { PagosService } from '../../core/services/pagos.service';

// Tipo local equivalente a BusquedaResultado — evita acoplamiento cross-feature
interface PersonaBusqueda {
  tipo: 'socio' | 'inquilino';
  persona_id: number;
  dni: string;
  nombre_completo: string;
  puesto_id: number;
  codigo_puesto: string;
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
const MESES = ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
               'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

function hoyAnio(): number { return new Date().getFullYear(); }
function hoyMes():  number { return new Date().getMonth() + 1; }

interface OpcionSegmento {
  valor: Segmento;
  label: string;
  desc:  string;
}

const OPCIONES_SEGMENTO: OpcionSegmento[] = [
  { valor: 'SOCIOS',     label: 'Sólo Socios',     desc: 'Cargo personal a cada socio activo' },
  { valor: 'INQUILINOS', label: 'Sólo Inquilinos',  desc: 'Cargo al puesto de cada inquilino con arriendo vigente' },
  { valor: 'TODOS',      label: 'Todos',             desc: 'Socios activos + puestos con inquilino' },
  { valor: 'ESPECIFICO', label: 'Específico',        desc: 'Busca y selecciona una persona manualmente' },
];

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-cargos-extraordinarios',
  standalone: true,
  imports: [FormsModule, DecimalPipe],
  template: `
    <div class="mx-auto max-w-2xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-8">
        <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Cargos Extraordinarios</h2>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          Aplica un cargo masivo o individual fuera del ciclo regular de facturación.
        </p>
      </div>

      <!-- ── Error ───────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-5 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Resultado ────────────────────────────────────────────────────── -->
      @if (resultado(); as r) {
        <div class="mb-5 rounded-2xl border border-green-200 bg-green-50 p-5 dark:border-green-800 dark:bg-green-900/20">
          <div class="flex items-center gap-3 mb-3">
            <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-green-100 dark:bg-green-900/40">
              <svg class="h-5 w-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div>
              <p class="font-semibold text-green-800 dark:text-green-200">
                Cargos generados para {{ MESES[r.periodo.mes - 1] }} {{ r.periodo.anio }}
              </p>
              <p class="text-xs text-green-600 dark:text-green-400">
                Segmento: {{ r.segmento }}
              </p>
            </div>
          </div>
          <div class="grid grid-cols-3 gap-3">
            <div class="rounded-lg bg-white px-3 py-2.5 dark:bg-gray-800">
              <p class="text-xs text-gray-400 dark:text-gray-500">Socios</p>
              <p class="mt-0.5 text-xl font-bold text-gray-900 dark:text-white">{{ r.insertados_socios }}</p>
            </div>
            <div class="rounded-lg bg-white px-3 py-2.5 dark:bg-gray-800">
              <p class="text-xs text-gray-400 dark:text-gray-500">Inquilinos</p>
              <p class="mt-0.5 text-xl font-bold text-gray-900 dark:text-white">{{ r.insertados_inquilinos }}</p>
            </div>
            <div class="rounded-lg bg-white px-3 py-2.5 dark:bg-gray-800">
              <p class="text-xs text-gray-400 dark:text-gray-500">Total</p>
              <p class="mt-0.5 text-xl font-bold text-brand-600 dark:text-brand-400">{{ r.total_insertados }}</p>
            </div>
          </div>
        </div>
      }

      <!-- ══════════════════════════════════════════════════════════════════ -->
      <!-- FORMULARIO                                                          -->
      <!-- ══════════════════════════════════════════════════════════════════ -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">

        <!-- ── Sección 1: Período ─────────────────────────────────────────── -->
        <div class="border-b border-gray-100 px-6 py-5 dark:border-gray-700">
          <h3 class="mb-4 text-sm font-semibold text-gray-800 dark:text-white">1. Período</h3>
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="mb-1.5 block text-xs font-medium text-gray-500 dark:text-gray-400">Año</label>
              <input type="number" [(ngModel)]="anio" min="2020" max="2100"
                class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"/>
            </div>
            <div>
              <label class="mb-1.5 block text-xs font-medium text-gray-500 dark:text-gray-400">Mes</label>
              <select [(ngModel)]="mes"
                class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none">
                @for (m of mesesArr; track m.n) {
                  <option [value]="m.n">{{ m.nombre }}</option>
                }
              </select>
            </div>
          </div>
        </div>

        <!-- ── Sección 2: Concepto y Monto ────────────────────────────────── -->
        <div class="border-b border-gray-100 px-6 py-5 dark:border-gray-700">
          <h3 class="mb-4 text-sm font-semibold text-gray-800 dark:text-white">2. Concepto y Monto</h3>

          <!-- Selector de concepto -->
          <div class="mb-4 flex items-end gap-2">
            <div class="flex-1">
              <label class="mb-1.5 block text-xs font-medium text-gray-500 dark:text-gray-400">Concepto</label>
              @if (cargandoConceptos()) {
                <div class="h-10 w-full animate-pulse rounded-lg bg-gray-200 dark:bg-gray-700"></div>
              } @else {
                <select [(ngModel)]="conceptoIdStr"
                  class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none">
                  <option value="">— Seleccionar concepto —</option>
                  @for (c of conceptos(); track c.id) {
                    <option [value]="c.id">{{ c.nombre }} ({{ c.tipo }})</option>
                  }
                </select>
              }
            </div>
            <!-- Botón nuevo concepto -->
            <button
              type="button"
              (click)="abrirModal()"
              title="Crear nuevo concepto"
              class="flex h-10 shrink-0 items-center gap-1.5 rounded-lg border border-brand-300 px-3 text-sm text-brand-600 transition hover:bg-brand-50 dark:border-brand-700 dark:text-brand-400 dark:hover:bg-brand-900/20">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
              </svg>
              Nuevo
            </button>
          </div>

          <!-- Monto -->
          <div>
            <label class="mb-1.5 block text-xs font-medium text-gray-500 dark:text-gray-400">Monto (S/ por persona)</label>
            <div class="flex items-center gap-2">
              <span class="text-sm font-medium text-gray-500 dark:text-gray-400">S/</span>
              <input type="number" [ngModel]="monto()" (ngModelChange)="monto.set(+$event)" min="0.01" step="0.01"
                class="h-10 w-40 rounded-lg border border-gray-300 bg-gray-50 px-3 text-right text-sm tabular-nums dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"/>
            </div>
          </div>
        </div>

        <!-- ── Sección 3: Público Objetivo ────────────────────────────────── -->
        <div class="px-6 py-5">
          <h3 class="mb-4 text-sm font-semibold text-gray-800 dark:text-white">3. Público Objetivo</h3>

          <!-- Radio buttons -->
          <div class="space-y-2.5 mb-5">
            @for (opt of opciones; track opt.valor) {
              <label
                [class]="'flex cursor-pointer items-start gap-3 rounded-xl border p-3 transition ' +
                  (segmento() === opt.valor
                    ? 'border-brand-400 bg-brand-50 dark:border-brand-600 dark:bg-brand-900/20'
                    : 'border-gray-200 hover:border-brand-200 hover:bg-gray-50/50 dark:border-gray-700 dark:hover:bg-gray-700/30')">
                <input
                  type="radio"
                  name="segmento"
                  [value]="opt.valor"
                  [ngModel]="segmento()"
                  (ngModelChange)="onSegmentoChange($event)"
                  class="mt-0.5 h-4 w-4 accent-brand-600"/>
                <div class="flex-1 min-w-0">
                  <div class="flex items-center gap-2">
                    <span class="text-sm font-medium text-gray-800 dark:text-white">{{ opt.label }}</span>
                    <!-- Badge de conteo (solo para segmentos no-ESPECIFICO) -->
                    @if (opt.valor !== 'ESPECIFICO' && afectados()) {
                      <span class="rounded-full bg-brand-100 px-2 py-0.5 text-xs font-semibold text-brand-700 dark:bg-brand-900/40 dark:text-brand-300">
                        {{ conteoSegmento(opt.valor) }} persona{{ conteoSegmento(opt.valor) !== 1 ? 's' : '' }}
                      </span>
                    }
                    @if (opt.valor !== 'ESPECIFICO' && cargandoAfectados()) {
                      <span class="h-3 w-12 animate-pulse rounded bg-gray-200 dark:bg-gray-700"></span>
                    }
                  </div>
                  <p class="text-xs text-gray-400 dark:text-gray-500">{{ opt.desc }}</p>
                </div>
              </label>
            }
          </div>

          <!-- Preview de monto total -->
          @if (segmento() !== 'ESPECIFICO' && afectados() && monto() > 0) {
            <div class="mb-5 flex items-center justify-between rounded-xl border border-brand-200 bg-brand-50 px-4 py-3 dark:border-brand-700/50 dark:bg-brand-900/10">
              <div class="flex items-center gap-2">
                <svg class="h-4 w-4 text-brand-600 dark:text-brand-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z"/>
                </svg>
                <span class="text-sm text-brand-700 dark:text-brand-300">
                  {{ conteoSegmento(segmento()) }} × S/ {{ monto() | number: '1.2-2' }}
                </span>
              </div>
              <span class="text-base font-bold text-brand-700 dark:text-brand-300">
                S/ {{ totalEstimado() | number: '1.2-2' }}
              </span>
            </div>
          }

          <!-- Buscador para ESPECIFICO -->
          @if (segmento() === 'ESPECIFICO') {
            <div class="mb-5 rounded-xl border border-gray-200 bg-gray-50 p-4 dark:border-gray-700 dark:bg-gray-800/50">
              <p class="mb-3 text-xs font-medium text-gray-500 dark:text-gray-400">Busca por DNI, nombre o código de puesto</p>

              <div class="flex gap-2 mb-3">
                <input
                  type="text"
                  placeholder="Ej: 47123456 · García · A-01…"
                  [ngModel]="queryBusqueda()"
                  (ngModelChange)="queryBusqueda.set($event)"
                  (keydown.enter)="buscar()"
                  class="h-10 flex-1 rounded-lg border border-gray-300 bg-white px-3 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"/>
                <button (click)="buscar()" [disabled]="buscando()"
                  class="h-10 rounded-lg bg-brand-600 px-4 text-sm font-medium text-white transition hover:bg-brand-700 disabled:opacity-60">
                  @if (buscando()) { Buscando… } @else { Buscar }
                </button>
              </div>

              <!-- Resultados de búsqueda -->
              @if (resultadosBusqueda().length > 0 && !personaEspecifica()) {
                <ul class="divide-y divide-gray-100 overflow-hidden rounded-lg border border-gray-200 dark:divide-gray-700 dark:border-gray-700">
                  @for (r of resultadosBusqueda(); track r.puesto_id) {
                    <li>
                      <button type="button"
                        (click)="seleccionarPersona(r)"
                        class="flex w-full items-center gap-3 bg-white px-3 py-2.5 text-left transition hover:bg-brand-50 dark:bg-gray-800 dark:hover:bg-gray-700">
                        <span [class]="'flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-xs font-bold ' +
                          (r.tipo === 'socio'
                            ? 'bg-brand-100 text-brand-600 dark:bg-brand-900/40 dark:text-brand-300'
                            : 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300')">
                          {{ r.tipo === 'socio' ? 'SC' : 'IQ' }}
                        </span>
                        <div class="flex-1 min-w-0">
                          <p class="truncate text-sm font-medium text-gray-800 dark:text-white">{{ r.nombre_completo }}</p>
                          <p class="text-xs text-gray-400">DNI {{ r.dni }} · Puesto {{ r.codigo_puesto }}</p>
                        </div>
                        <span [class]="'shrink-0 rounded-full px-2 py-0.5 text-xs font-medium ' +
                          (r.tipo === 'socio'
                            ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/40 dark:text-brand-300'
                            : 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300')">
                          {{ r.tipo === 'socio' ? 'Socio' : 'Inquilino' }}
                        </span>
                      </button>
                    </li>
                  }
                </ul>
              }

              <!-- Persona seleccionada -->
              @if (personaEspecifica(); as p) {
                <div class="flex items-center justify-between rounded-xl border border-green-200 bg-green-50 px-4 py-3 dark:border-green-700 dark:bg-green-900/20">
                  <div class="flex items-center gap-3">
                    <span [class]="'flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-xs font-bold ' +
                      (p.tipo === 'socio'
                        ? 'bg-brand-100 text-brand-600 dark:bg-brand-900/40 dark:text-brand-300'
                        : 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300')">
                      {{ p.tipo === 'socio' ? 'SC' : 'IQ' }}
                    </span>
                    <div>
                      <p class="text-sm font-semibold text-gray-800 dark:text-white">{{ p.nombre_completo }}</p>
                      <p class="text-xs text-gray-400">DNI {{ p.dni }} · Puesto {{ p.codigo_puesto }}</p>
                    </div>
                  </div>
                  <button type="button" (click)="limpiarPersona()"
                    class="text-gray-400 hover:text-red-500 transition dark:text-gray-500 dark:hover:text-red-400">
                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                  </button>
                </div>
              }
            </div>
          }

          <!-- Botón generar -->
          <button
            type="button"
            (click)="generar()"
            [disabled]="generando() || !puedeGenerar()"
            class="flex w-full items-center justify-center gap-3 rounded-xl bg-brand-600 py-4 text-base font-semibold text-white shadow-md transition hover:bg-brand-700 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50">
            @if (generando()) {
              <svg class="h-5 w-5 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Generando cargos…
            } @else {
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z"/>
              </svg>
              Generar Cargos — {{ etiquetaSegmento() }}
            }
          </button>
          <p class="mt-2 text-center text-xs text-gray-400 dark:text-gray-500">
            La operación es idempotente: puestos/socios que ya tienen el cargo en el período serán omitidos.
          </p>
        </div>
      </div>

    </div>

    <!-- ══════════════════════════════════════════════════════════════════════ -->
    <!-- MODAL: Nuevo Concepto                                                  -->
    <!-- ══════════════════════════════════════════════════════════════════════ -->
    @if (modalAbierto()) {
      <!-- Backdrop -->
      <div
        class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4"
        (click)="cerrarModal()">
        <!-- Card (detener propagación para no cerrar al hacer click dentro) -->
        <div
          class="w-full max-w-md rounded-2xl border border-gray-200 bg-white shadow-xl dark:border-gray-700 dark:bg-gray-dark"
          (click)="$event.stopPropagation()">

          <!-- Header modal -->
          <div class="flex items-center justify-between border-b border-gray-200 px-6 py-4 dark:border-gray-700">
            <h3 class="text-base font-semibold text-gray-800 dark:text-white">Nuevo Concepto</h3>
            <button type="button" (click)="cerrarModal()"
              class="flex h-8 w-8 items-center justify-center rounded-lg text-gray-400 hover:bg-gray-100 hover:text-gray-600 transition dark:hover:bg-gray-700 dark:hover:text-gray-300">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
              </svg>
            </button>
          </div>

          <!-- Body modal -->
          <div class="p-6 space-y-4">
            @if (errorModal()) {
              <div class="rounded-lg border border-red-200 bg-red-50 px-3 py-2.5 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
                {{ errorModal() }}
              </div>
            }

            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Nombre del concepto *</label>
              <input type="text" [(ngModel)]="nuevoNombre" placeholder="Ej: Cuota de seguridad"
                class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"/>
            </div>

            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Tipo</label>
              <select [(ngModel)]="nuevoTipo"
                class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none">
                <option value="Variable">Variable (manual o por evento)</option>
                <option value="Fijo">Fijo (se genera mensualmente)</option>
              </select>
            </div>

            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Descripción (opcional)</label>
              <textarea [(ngModel)]="nuevoDesc" rows="2"
                placeholder="Describe brevemente el concepto…"
                class="w-full resize-none rounded-lg border border-gray-300 bg-gray-50 px-3 py-2 text-sm dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none">
              </textarea>
            </div>
          </div>

          <!-- Footer modal -->
          <div class="flex justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-700">
            <button type="button" (click)="cerrarModal()"
              class="h-10 rounded-lg border border-gray-300 px-4 text-sm text-gray-600 transition hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
              Cancelar
            </button>
            <button type="button" (click)="crearConcepto()" [disabled]="guardandoConcepto() || !nuevoNombre.trim()"
              class="h-10 flex items-center gap-2 rounded-lg bg-brand-600 px-4 text-sm font-semibold text-white transition hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed">
              @if (guardandoConcepto()) {
                <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Creando…
              } @else {
                Crear concepto
              }
            </button>
          </div>
        </div>
      </div>
    }
  `,
})
export class CargosExtraordinariosComponent implements OnInit {
  private readonly svc      = inject(CargosExtraordinariosService);
  private readonly pagosSvc = inject(PagosService);

  // Helpers expuestos al template
  protected readonly MESES    = MESES;
  protected readonly mesesArr = MESES.map((nombre, i) => ({ n: i + 1, nombre }));
  protected readonly opciones = OPCIONES_SEGMENTO;

  // ── Formulario principal ─────────────────────────────────────────────────
  anio  = hoyAnio();
  mes   = hoyMes();
  readonly monto = signal(0);
  conceptoIdStr = '';   // valor del <select> como string

  // ── Estado reactivo ──────────────────────────────────────────────────────
  readonly conceptos          = signal<ConceptoCargo[]>([]);
  readonly cargandoConceptos  = signal(true);

  readonly segmento           = signal<Segmento>('SOCIOS');
  readonly afectados          = signal<AfectadosConteo | null>(null);
  readonly cargandoAfectados  = signal(false);

  // Búsqueda persona específica
  readonly queryBusqueda      = signal('');
  readonly resultadosBusqueda = signal<PersonaBusqueda[]>([]);
  readonly buscando           = signal(false);
  readonly personaEspecifica  = signal<PersonaBusqueda | null>(null);

  // Ejecución
  readonly generando = signal(false);
  readonly error     = signal<string | null>(null);
  readonly resultado = signal<ResultadoCargoSegmentado | null>(null);

  // Modal nuevo concepto
  readonly modalAbierto       = signal(false);
  nuevoNombre = '';
  nuevoTipo: 'Fijo' | 'Variable' = 'Variable';
  nuevoDesc   = '';
  readonly guardandoConcepto = signal(false);
  readonly errorModal        = signal<string | null>(null);

  // ── Computed ─────────────────────────────────────────────────────────────
  readonly totalEstimado = computed(() => {
    const a = this.afectados();
    const m = this.monto();
    if (!a || m <= 0) return 0;
    return this.conteoSegmento(this.segmento()) * m;
  });

  // ── Lifecycle ────────────────────────────────────────────────────────────
  ngOnInit(): void {
    void Promise.all([
      this.cargarConceptos(),
      this.cargarAfectados(),
    ]);
  }

  // ── Carga de datos ───────────────────────────────────────────────────────
  private async cargarConceptos(): Promise<void> {
    this.cargandoConceptos.set(true);
    try {
      this.conceptos.set(await this.svc.getConceptos());
    } finally {
      this.cargandoConceptos.set(false);
    }
  }

  private async cargarAfectados(): Promise<void> {
    this.cargandoAfectados.set(true);
    try {
      this.afectados.set(await this.svc.contarAfectados());
    } catch {
      // no bloquea la UI si falla el conteo
    } finally {
      this.cargandoAfectados.set(false);
    }
  }

  // ── Helpers de conteo ────────────────────────────────────────────────────
  conteoSegmento(seg: Segmento): number {
    const a = this.afectados();
    if (!a) return 0;
    if (seg === 'SOCIOS')     return a.socios;
    if (seg === 'INQUILINOS') return a.inquilinos;
    if (seg === 'TODOS')      return a.total;
    return 1; // ESPECIFICO
  }

  etiquetaSegmento(): string {
    return OPCIONES_SEGMENTO.find(o => o.valor === this.segmento())?.label ?? '';
  }

  // ── Cambio de segmento ───────────────────────────────────────────────────
  private static readonly SEGMENTOS_VALIDOS: ReadonlyArray<Segmento> =
    ['SOCIOS', 'INQUILINOS', 'TODOS', 'ESPECIFICO'];

  onSegmentoChange(val: string): void {
    if (!CargosExtraordinariosComponent.SEGMENTOS_VALIDOS.includes(val as Segmento)) return;
    this.segmento.set(val as Segmento);
    this.personaEspecifica.set(null);
    this.resultadosBusqueda.set([]);
    this.queryBusqueda.set('');
  }

  // ── Búsqueda persona específica ──────────────────────────────────────────
  async buscar(): Promise<void> {
    const q = this.queryBusqueda().trim();
    if (!q) return;
    this.buscando.set(true);
    this.resultadosBusqueda.set([]);
    try {
      const raw = await this.pagosSvc.buscarPagador(q);
      this.resultadosBusqueda.set(raw.map(r => ({
        tipo:           r.tipo,
        persona_id:     r.persona_id,
        dni:            r.dni,
        nombre_completo: r.nombre_completo,
        puesto_id:      r.puesto_id,
        codigo_puesto:  r.codigo_puesto,
      })));
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error en la búsqueda');
    } finally {
      this.buscando.set(false);
    }
  }

  seleccionarPersona(r: PersonaBusqueda): void {
    this.personaEspecifica.set(r);
    this.resultadosBusqueda.set([]);
  }

  limpiarPersona(): void {
    this.personaEspecifica.set(null);
    this.queryBusqueda.set('');
    this.resultadosBusqueda.set([]);
  }

  // ── Validación ───────────────────────────────────────────────────────────
  puedeGenerar(): boolean {
    if (!this.conceptoIdStr || this.monto() <= 0) return false;
    if (this.segmento() === 'ESPECIFICO' && !this.personaEspecifica()) return false;
    return true;
  }

  // ── Generar cargos ───────────────────────────────────────────────────────
  async generar(): Promise<void> {
    if (!this.puedeGenerar()) return;

    this.generando.set(true);
    this.error.set(null);
    this.resultado.set(null);
    try {
      const persona = this.personaEspecifica();
      const res = await this.svc.generarCargoSegmentado({
        concepto_id: Number(this.conceptoIdStr),
        monto:       this.monto(),
        segmento:    this.segmento(),
        anio:        this.anio,
        mes:         this.mes,
        socio_id_especifico:
          persona?.tipo === 'socio' ? persona.persona_id : undefined,
        inquilino_id_especifico:
          persona?.tipo === 'inquilino' ? persona.persona_id : undefined,
      });
      this.resultado.set(res);
      // Limpiar selección específica tras éxito
      if (this.segmento() === 'ESPECIFICO') this.limpiarPersona();
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al generar los cargos');
    } finally {
      this.generando.set(false);
    }
  }

  // ── Modal nuevo concepto ─────────────────────────────────────────────────
  abrirModal(): void {
    this.nuevoNombre = '';
    this.nuevoTipo   = 'Variable';
    this.nuevoDesc   = '';
    this.errorModal.set(null);
    this.modalAbierto.set(true);
  }

  cerrarModal(): void {
    if (this.guardandoConcepto()) return;
    this.modalAbierto.set(false);
  }

  async crearConcepto(): Promise<void> {
    if (!this.nuevoNombre.trim()) return;
    this.guardandoConcepto.set(true);
    this.errorModal.set(null);
    try {
      const nuevo = await this.svc.crearConcepto({
        nombre:      this.nuevoNombre,
        tipo:        this.nuevoTipo,
        descripcion: this.nuevoDesc,
      });
      // Añadir al listado y seleccionarlo automáticamente
      this.conceptos.update(cs => [...cs, nuevo].sort((a, b) => a.nombre.localeCompare(b.nombre)));
      this.conceptoIdStr = String(nuevo.id);
      this.modalAbierto.set(false);
    } catch (e: unknown) {
      this.errorModal.set(e instanceof Error ? e.message : 'Error al crear el concepto');
    } finally {
      this.guardandoConcepto.set(false);
    }
  }
}
