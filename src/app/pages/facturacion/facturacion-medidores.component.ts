import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import {
  FacturacionService,
  LecturaMedidor,
  ResultadoBulkMediciones,
} from '../../core/services/facturacion.service';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
function hoyAnio(): number { return new Date().getFullYear(); }
function hoyMes(): number  { return new Date().getMonth() + 1; }

function calcKwh(a: number, h: number, d: number): number {
  return Math.round((a * 220 * h * d) / 1000 * 1000) / 1000;
}

function calcMonto(a: number, h: number, d: number, precio: number): number {
  return Math.round(calcKwh(a, h, d) * precio * 100) / 100;
}

const MESES = ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
               'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-facturacion-medidores',
  standalone: true,
  imports: [FormsModule],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Registro de Medidores</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Ingresa el amperaje de cada puesto para el período seleccionado.
          </p>
        </div>

        <!-- Controles del período -->
        <div class="flex flex-wrap items-end gap-3">
          <div>
            <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Año</label>
            <input type="number" [(ngModel)]="anio" (change)="onPeriodoChange()"
              min="2020" max="2100" step="1"
              class="h-9 w-24 rounded-lg border border-gray-300 bg-white px-3 text-sm dark:border-gray-600 dark:bg-gray-800 dark:text-white focus:border-brand-500 focus:outline-none"/>
          </div>
          <div>
            <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Mes</label>
            <select [(ngModel)]="mes" (change)="onPeriodoChange()"
              class="h-9 rounded-lg border border-gray-300 bg-white px-3 text-sm dark:border-gray-600 dark:bg-gray-800 dark:text-white focus:border-brand-500 focus:outline-none">
              @for (m of mesesArr; track m.n) {
                <option [value]="m.n">{{ m.nombre }}</option>
              }
            </select>
          </div>
          <div>
            <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Precio S/ kWh</label>
            <input type="number" [(ngModel)]="precioKwh" min="0.01" step="0.01"
              class="h-9 w-28 rounded-lg border border-gray-300 bg-white px-3 text-sm dark:border-gray-600 dark:bg-gray-800 dark:text-white focus:border-brand-500 focus:outline-none"/>
          </div>
          <button (click)="cargar()" [disabled]="cargando()"
            class="h-9 flex items-center gap-1.5 rounded-lg border border-gray-300 px-3 text-sm text-gray-600 hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700 transition">
            <svg class="h-4 w-4" [class.animate-spin]="cargando()" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
            </svg>
            Cargar puestos
          </button>
        </div>
      </div>

      <!-- ── Error ────────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Resultado del guardado ─────────────────────────────────────── -->
      @if (resultado()) {
        <div class="mb-4 rounded-xl border border-green-200 bg-green-50 px-4 py-3 dark:border-green-800 dark:bg-green-900/20">
          <p class="text-sm font-semibold text-green-700 dark:text-green-300">
            ✓ Guardado correctamente para {{ MESES[mes - 1] }} {{ anio }}
          </p>
          <ul class="mt-1 text-xs text-green-600 dark:text-green-400 space-y-0.5">
            <li>Mediciones nuevas: <strong>{{ resultado()!.mediciones_nuevas }}</strong></li>
            <li>Mediciones ya existían (ignoradas): <strong>{{ resultado()!.mediciones_ya_existian }}</strong></li>
            <li>Montos de Luz generados: <strong>{{ resultado()!.montos_luz_generados }}</strong></li>
          </ul>
        </div>
      }

      <!-- ── Tabla editable ─────────────────────────────────────────────── -->
      @if (lecturas().length > 0) {

        <!-- Resumen superior -->
        <div class="mb-3 flex flex-wrap items-center justify-between gap-3">
          <p class="text-sm text-gray-500 dark:text-gray-400">
            <span class="font-medium text-gray-700 dark:text-gray-300">{{ lecturas().length }}</span> puestos sin medidor ·
            Monto estimado total:
            <span class="font-bold text-brand-600 dark:text-brand-400">
              S/ {{ totalEstimado().toLocaleString('en-US', {minimumFractionDigits:2, maximumFractionDigits:2}) }}
            </span>
          </p>
          <div class="flex gap-2">
            <button (click)="limpiarTodo()"
              class="h-8 rounded-lg border border-gray-300 px-3 text-xs text-gray-500 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700 transition">
              Limpiar todo
            </button>
            <button (click)="guardar()" [disabled]="guardando() || lecturasSinAmperaje().length === lecturas().length"
              class="h-8 flex items-center gap-1.5 rounded-lg bg-brand-600 px-4 text-xs font-medium text-white hover:bg-brand-700 disabled:opacity-40 transition">
              @if (guardando()) {
                <svg class="h-3.5 w-3.5 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Guardando…
              } @else {
                <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"/>
                </svg>
                Guardar {{ lecturasConAmperaje().length }} lectura{{ lecturasConAmperaje().length !== 1 ? 's' : '' }}
              }
            </button>
          </div>
        </div>

        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-700/40 sticky top-0">
                <tr>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-20">Puesto</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Titular</th>
                  <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-28">Giro</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-32">
                    Amperaje (A) ★
                  </th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-20">Hs/día</th>
                  <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-20">Días</th>
                  <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-24">KWH est.</th>
                  <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 w-28">Monto est.</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (l of lecturas(); track l.puesto_id; let i = $index) {
                  <tr [class]="'transition ' + (ampNum(l.amperaje) > 0
                      ? 'bg-green-50 dark:bg-green-900/10 hover:bg-green-100/60 dark:hover:bg-green-900/20'
                      : 'hover:bg-blue-50/30 dark:hover:bg-brand-900/10')">

                    <!-- Código puesto -->
                    <td class="px-4 py-2">
                      <span class="rounded-md bg-brand-50 px-2 py-0.5 text-xs font-bold text-brand-600 dark:bg-brand-900/20 dark:text-brand-400">
                        {{ l.codigo_puesto }}
                      </span>
                    </td>

                    <!-- Titular -->
                    <td class="px-4 py-2 text-gray-700 dark:text-gray-300 leading-tight">
                      <p class="font-medium">{{ l.titular.split(',')[0] }}</p>
                      <p class="text-xs text-gray-400">{{ l.titular.split(',').slice(1).join(',').trim() }}</p>
                    </td>

                    <!-- Giro -->
                    <td class="px-4 py-2 text-xs text-gray-500 dark:text-gray-400">{{ l.giro }}</td>

                    <!-- Amperaje — celda editable principal -->
                    <td class="px-2 py-1.5">
                      <input
                        type="number"
                        min="0"
                        step="0.001"
                        placeholder="0.000"
                        [(ngModel)]="l.amperaje"
                        [name]="'amp_' + l.puesto_id"
                        class="h-9 w-full rounded-lg border text-center text-sm tabular-nums transition focus:outline-none focus:ring-2 focus:ring-brand-500/20"
                        [class]="ampNum(l.amperaje) > 0
                          ? 'border-green-300 bg-green-50 text-green-800 dark:border-green-700 dark:bg-green-900/20 dark:text-green-300 focus:border-green-400'
                          : 'border-gray-300 bg-gray-50 text-gray-700 dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-400'"
                      />
                    </td>

                    <!-- Horas/día -->
                    <td class="px-2 py-1.5">
                      <input
                        type="number"
                        min="1" max="24"
                        [(ngModel)]="l.horas_uso"
                        [name]="'hs_' + l.puesto_id"
                        class="h-9 w-full rounded-lg border border-gray-300 bg-gray-50 text-center text-xs dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"
                      />
                    </td>

                    <!-- Días/mes -->
                    <td class="px-2 py-1.5">
                      <input
                        type="number"
                        min="1" max="31"
                        [(ngModel)]="l.dias_uso"
                        [name]="'dias_' + l.puesto_id"
                        class="h-9 w-full rounded-lg border border-gray-300 bg-gray-50 text-center text-xs dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"
                      />
                    </td>

                    <!-- KWH estimado -->
                    <td class="px-4 py-2 text-right text-xs tabular-nums text-gray-600 dark:text-gray-400">
                      {{ ampNum(l.amperaje) > 0 ? calcKwh(ampNum(l.amperaje), l.horas_uso, l.dias_uso).toFixed(3) : '—' }}
                    </td>

                    <!-- Monto estimado -->
                    <td class="px-4 py-2 text-right tabular-nums">
                      @if (ampNum(l.amperaje) > 0) {
                        <span class="font-semibold text-gray-900 dark:text-white text-xs">
                          S/ {{ calcMonto(ampNum(l.amperaje), l.horas_uso, l.dias_uso, precioKwh).toFixed(2) }}
                        </span>
                      } @else {
                        <span class="text-xs text-gray-300 dark:text-gray-600">—</span>
                      }
                    </td>
                  </tr>
                }
              </tbody>
              <tfoot class="bg-gray-50 dark:bg-gray-700/40">
                <tr>
                  <td colspan="7" class="px-4 py-3 text-xs font-semibold text-gray-600 dark:text-gray-300 text-right">
                    Total estimado ({{ lecturasConAmperaje().length }} puestos con lectura):
                  </td>
                  <td class="px-4 py-3 text-right font-bold text-brand-600 dark:text-brand-400 tabular-nums">
                    S/ {{ totalEstimado().toLocaleString('en-US', {minimumFractionDigits:2, maximumFractionDigits:2}) }}
                  </td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>

        <p class="mt-2 text-xs text-gray-400 dark:text-gray-500">
          ★ Deja el amperaje en blanco o en 0 para omitir ese puesto. Los puestos con medidor propio no aparecen aquí.
        </p>

      } @else if (!cargando()) {
        <div class="flex flex-col items-center justify-center gap-3 py-20 text-gray-400 dark:text-gray-500">
          <svg class="h-12 w-12 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z"/>
          </svg>
          <p class="text-sm">Selecciona un período y pulsa <strong>Cargar puestos</strong>.</p>
        </div>
      }

    </div>
  `,
})
export class FacturacionMedidoresComponent implements OnInit {
  private readonly svc = inject(FacturacionService);

  // Estado
  anio      = hoyAnio();
  mes       = hoyMes();
  precioKwh = 0.75;

  readonly lecturas   = signal<LecturaMedidor[]>([]);
  readonly cargando   = signal(false);
  readonly guardando  = signal(false);
  readonly error      = signal<string | null>(null);
  readonly resultado  = signal<ResultadoBulkMediciones | null>(null);

  // Helpers de dominio expuestos al template
  protected readonly calcKwh    = calcKwh;
  protected readonly calcMonto  = calcMonto;
  protected readonly MESES      = MESES;
  protected readonly mesesArr   = MESES.map((nombre, i) => ({ n: i + 1, nombre }));

  // Computed
  readonly lecturasConAmperaje = computed(() =>
    this.lecturas().filter(l => this.ampNum(l.amperaje) > 0),
  );

  readonly lecturasSinAmperaje = computed(() =>
    this.lecturas().filter(l => this.ampNum(l.amperaje) === 0),
  );

  readonly totalEstimado = computed(() =>
    this.lecturasConAmperaje().reduce((s, l) =>
      s + calcMonto(this.ampNum(l.amperaje), l.horas_uso, l.dias_uso, this.precioKwh), 0,
    ),
  );

  ngOnInit(): void {
    void this.cargar();
  }

  ampNum(v: string | number): number {
    const n = typeof v === 'string' ? parseFloat(v) : v;
    return isNaN(n) || n < 0 ? 0 : n;
  }

  async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    this.resultado.set(null);
    try {
      const [puestos, medicionesExistentes] = await Promise.all([
        this.svc.cargarPuestosSinMedidor(),
        this.svc.cargarMedicionesExistentes(this.anio, this.mes),
      ]);

      this.lecturas.set(puestos.map(p => ({
        puesto_id:    p.puesto_id,
        codigo_puesto: p.codigo_puesto,
        giro:         p.giro,
        titular:      p.titular,
        amperaje:     medicionesExistentes.has(p.puesto_id)
          ? String(medicionesExistentes.get(p.puesto_id)!)
          : '',
        horas_uso: 12,
        dias_uso:  30,
      })));
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar puestos');
    } finally {
      this.cargando.set(false);
    }
  }

  onPeriodoChange(): void {
    void this.cargar();
  }

  limpiarTodo(): void {
    this.lecturas.update(ls => ls.map(l => ({ ...l, amperaje: '' })));
  }

  async guardar(): Promise<void> {
    const conAmperaje = this.lecturasConAmperaje();
    if (conAmperaje.length === 0) return;

    this.guardando.set(true);
    this.error.set(null);
    this.resultado.set(null);
    try {
      const res = await this.svc.guardarMedicionesLuzBulk({
        lecturas: conAmperaje.map(l => ({
          puesto_id: l.puesto_id,
          amperaje:  this.ampNum(l.amperaje),
          horas_uso: l.horas_uso,
          dias_uso:  l.dias_uso,
        })),
        anio:       this.anio,
        mes:        this.mes,
        precio_kwh: this.precioKwh,
      });
      this.resultado.set(res);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al guardar lecturas');
    } finally {
      this.guardando.set(false);
    }
  }
}
