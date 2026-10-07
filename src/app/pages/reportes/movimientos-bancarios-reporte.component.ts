import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  BancosService,
  BancoCuenta,
  MovimientoBancario,
  TipoMovimiento,
} from '../../core/services/bancos.service';
import {
  PdfGeneratorService,
  ReporteMovimientosPdfDatos,
} from '../../core/services/pdf-generator.service';

// ---------------------------------------------------------------------------
// Helpers de fecha y moneda
// ---------------------------------------------------------------------------
function fmtSoles(n: number): string {
  return `S/ ${n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function fmtFecha(yyyymmdd: string): string {
  if (!yyyymmdd) return '—';
  const [y, m, d] = yyyymmdd.split('-').map(Number);
  return `${String(d).padStart(2, '0')}/${String(m).padStart(2, '0')}/${y}`;
}

function hoyStr(): string {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

function primerDiaMesStr(): string {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-01`;
}

function diasAtrasStr(dias: number): string {
  const d = new Date();
  d.setDate(d.getDate() - dias);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

type RangoRapido = 'hoy' | 'mes' | 'semana' | 'personalizado';

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-movimientos-bancarios-reporte',
  standalone: true,
  imports: [NgClass, FormsModule],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Reporte de Movimientos Bancarios</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Consulta y conciliación de ingresos y egresos bancarios por período
          </p>
        </div>

        <!-- Botón Exportar PDF -->
        <button
          (click)="descargarPdf()"
          [disabled]="movimientos().length === 0 || cargando() || generandoPdf()"
          class="inline-flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-brand-700 disabled:opacity-40 disabled:cursor-not-allowed transition">
          @if (generandoPdf()) {
            <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
            </svg>
            Generando PDF…
          } @else {
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
            </svg>
            Exportar PDF
          }
        </button>
      </div>

      <!-- ── Error ──────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Filtros ─────────────────────────────────────────────────────── -->
      <div class="mb-6 rounded-2xl border border-gray-200 bg-white p-4 sm:p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark space-y-4">

        <!-- Fila 1: Filtros rápidos de período -->
        <div class="flex flex-wrap items-center justify-between gap-3 border-b border-gray-100 dark:border-gray-700 pb-3">
          <div class="flex items-center gap-1">
            <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 mr-2">
              Período rápido:
            </span>
            <div class="inline-flex rounded-xl border border-gray-200 bg-gray-50 p-1 dark:border-gray-700 dark:bg-gray-800">
              <button
                type="button"
                (click)="seleccionarRangoRapido('hoy')"
                [ngClass]="rangoRapido() === 'hoy'
                  ? 'bg-white text-brand-600 shadow-sm font-semibold dark:bg-gray-700 dark:text-brand-400'
                  : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
                class="rounded-lg px-3 py-1 text-xs transition">
                Hoy
              </button>
              <button
                type="button"
                (click)="seleccionarRangoRapido('mes')"
                [ngClass]="rangoRapido() === 'mes'
                  ? 'bg-white text-brand-600 shadow-sm font-semibold dark:bg-gray-700 dark:text-brand-400'
                  : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
                class="rounded-lg px-3 py-1 text-xs transition">
                Este mes
              </button>
              <button
                type="button"
                (click)="seleccionarRangoRapido('semana')"
                [ngClass]="rangoRapido() === 'semana'
                  ? 'bg-white text-brand-600 shadow-sm font-semibold dark:bg-gray-700 dark:text-brand-400'
                  : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
                class="rounded-lg px-3 py-1 text-xs transition">
                Últimos 7 días
              </button>
              <button
                type="button"
                (click)="seleccionarRangoRapido('personalizado')"
                [ngClass]="rangoRapido() === 'personalizado'
                  ? 'bg-white text-brand-600 shadow-sm font-semibold dark:bg-gray-700 dark:text-brand-400'
                  : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
                class="rounded-lg px-3 py-1 text-xs transition">
                Personalizado
              </button>
            </div>
          </div>

          <div class="text-xs text-gray-500 dark:text-gray-400">
            Rango: <span class="font-medium text-gray-700 dark:text-gray-200">{{ fmtFecha(filtroDesde()) }}</span> al <span class="font-medium text-gray-700 dark:text-gray-200">{{ fmtFecha(filtroHasta()) }}</span>
          </div>
        </div>

        <!-- Fila 2: Inputs de rango y filtros adicionales -->
        <div class="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-4">

          <!-- Desde -->
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Desde</label>
            <input
              type="date"
              [ngModel]="filtroDesde()"
              (ngModelChange)="cambiarFechaDesde($event)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>

          <!-- Hasta -->
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Hasta</label>
            <input
              type="date"
              [ngModel]="filtroHasta()"
              (ngModelChange)="cambiarFechaHasta($event)"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
          </div>

          <!-- Cuenta / Banco -->
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Cuenta / Banco</label>
            <select
              [ngModel]="filtroCuenta()"
              (ngModelChange)="filtroCuenta.set(+$event); consultar()"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
              <option [value]="0">Todas las cuentas</option>
              @for (c of cuentas(); track c.id) {
                <option [value]="c.id">{{ c.nombre_banco }} ({{ c.numero_cuenta }})</option>
              }
            </select>
          </div>

          <!-- Tipo -->
          <div>
            <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Tipo de movimiento</label>
            <select
              [ngModel]="filtroTipo()"
              (ngModelChange)="filtroTipo.set($event); consultar()"
              class="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
              <option value="">Todos (Ingresos y Egresos)</option>
              <option value="Ingreso">Solo Ingresos</option>
              <option value="Egreso">Solo Egresos</option>
            </select>
          </div>

        </div>

        @if (errorRangoFechas()) {
          <p class="text-xs text-red-600 dark:text-red-400">
            {{ errorRangoFechas() }}
          </p>
        }
      </div>

      <!-- ── Resumen KPI del Período ────────────────────────────────────── -->
      <div class="mb-6 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">

        <!-- Movimientos -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <p class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500">
            Total Movimientos
          </p>
          <p class="mt-2 text-2xl font-bold text-gray-900 dark:text-white tabular-nums">
            {{ totalMovimientos() }}
          </p>
          <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">
            En el período filtrado
          </p>
        </div>

        <!-- Total Ingresos -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <p class="text-xs font-semibold uppercase tracking-wider text-green-600 dark:text-green-400">
            Total Ingresos
          </p>
          <p class="mt-2 text-2xl font-bold text-green-600 dark:text-green-400 tabular-nums">
            + {{ fmtSoles(totalIngresos()) }}
          </p>
          <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">
            Abonos registrados
          </p>
        </div>

        <!-- Total Egresos -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <p class="text-xs font-semibold uppercase tracking-wider text-red-600 dark:text-red-400">
            Total Egresos
          </p>
          <p class="mt-2 text-2xl font-bold text-red-600 dark:text-red-400 tabular-nums">
            − {{ fmtSoles(totalEgresos()) }}
          </p>
          <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">
            Cargos registrados
          </p>
        </div>

        <!-- Movimiento Neto del Período -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <p class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500">
            Movimiento Neto (Período)
          </p>
          <p class="mt-2 text-2xl font-bold tabular-nums"
            [ngClass]="movimientoNeto() >= 0
              ? 'text-brand-600 dark:text-brand-400'
              : 'text-red-600 dark:text-red-400'">
            {{ movimientoNeto() >= 0 ? '+' : '−' }} {{ fmtSoles(absMovimientoNeto()) }}
          </p>
          <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">
            Ingresos − Egresos del período
          </p>
        </div>

      </div>

      <!-- ── Tabla de Resultados ────────────────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">

        <div class="flex items-center justify-between border-b border-gray-200 px-5 py-4 dark:border-gray-700">
          <div>
            <h3 class="text-sm font-semibold text-gray-800 dark:text-white">Detalle de Movimientos</h3>
            <p class="mt-0.5 text-xs text-gray-400 dark:text-gray-500">
              Mostrando {{ movimientos().length }} registro{{ movimientos().length !== 1 ? 's' : '' }}
            </p>
          </div>
          @if (cargando()) {
            <svg class="h-4 w-4 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
            </svg>
          }
        </div>

        @if (cargando()) {
          <div class="p-14 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            Consultando movimientos bancarios…
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
                @for (m of movimientos(); track m.id) {
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
                    <td class="px-4 py-3 text-center whitespace-nowrap">
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
                    <td class="px-4 py-3 text-gray-600 dark:text-gray-300 max-w-sm">
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
                    <td colspan="6" class="px-4 py-16 text-center">
                      <div class="flex flex-col items-center gap-2 text-gray-400 dark:text-gray-500">
                        <svg class="h-10 w-10 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                        </svg>
                        <p class="text-sm font-medium">No se encontraron movimientos bancarios para el período seleccionado.</p>
                        <p class="text-xs text-gray-400">Intenta ampliando el rango de fechas o modificando los filtros.</p>
                      </div>
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        }

      </div>
    </div>
  `,
})
export class MovimientosBancariosReporteComponent implements OnInit {
  private readonly bancosSvc = inject(BancosService);
  private readonly pdfSvc    = inject(PdfGeneratorService);

  // Datos
  readonly cuentas     = signal<BancoCuenta[]>([]);
  readonly movimientos = signal<MovimientoBancario[]>([]);
  readonly cargando    = signal(false);
  readonly error       = signal<string | null>(null);
  readonly generandoPdf = signal(false);

  // Filtros
  readonly rangoRapido = signal<RangoRapido>('mes');
  readonly filtroDesde = signal<string>(primerDiaMesStr());
  readonly filtroHasta = signal<string>(hoyStr());
  readonly filtroCuenta = signal<number>(0);
  readonly filtroTipo   = signal<TipoMovimiento | ''>('');

  // Helpers expuestos al template
  protected readonly fmtSoles = fmtSoles;
  protected readonly fmtFecha = fmtFecha;

  // ── Computed ──────────────────────────────────────────────────────────────

  readonly errorRangoFechas = computed(() => {
    const d = this.filtroDesde();
    const h = this.filtroHasta();
    if (!d || !h) return 'Debes especificar ambas fechas.';
    if (d > h)    return 'La fecha inicial (Desde) no puede ser posterior a la fecha final (Hasta).';
    return null;
  });

  readonly totalMovimientos = computed(() => this.movimientos().length);

  readonly totalIngresos = computed(() =>
    this.movimientos()
      .filter(m => m.tipo === 'Ingreso')
      .reduce((s, m) => s + m.monto, 0),
  );

  readonly totalEgresos = computed(() =>
    this.movimientos()
      .filter(m => m.tipo === 'Egreso')
      .reduce((s, m) => s + m.monto, 0),
  );

  readonly movimientoNeto = computed(() => this.totalIngresos() - this.totalEgresos());

  readonly absMovimientoNeto = computed(() => Math.abs(this.movimientoNeto()));

  // ── Ciclo de vida ─────────────────────────────────────────────────────────

  async ngOnInit(): Promise<void> {
    await this.cargarCuentas();
    await this.consultar();
  }

  // ── Métodos de carga ──────────────────────────────────────────────────────

  private async cargarCuentas(): Promise<void> {
    try {
      await this.bancosSvc.cargarCuentas();
      this.cuentas.set(this.bancosSvc.cuentas());
    } catch {
      // Ignorar, fallback a cuentas vacías
    }
  }

  async consultar(): Promise<void> {
    if (this.errorRangoFechas()) return;

    this.cargando.set(true);
    this.error.set(null);

    try {
      const data = await this.bancosSvc.consultarMovimientosReporte({
        desde:     this.filtroDesde(),
        hasta:     this.filtroHasta(),
        cuenta_id: this.filtroCuenta(),
        tipo:      this.filtroTipo(),
      });
      this.movimientos.set(data);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al consultar movimientos.');
    } finally {
      this.cargando.set(false);
    }
  }

  // ── Manejadores de filtros ────────────────────────────────────────────────

  seleccionarRangoRapido(rango: RangoRapido): void {
    this.rangoRapido.set(rango);
    const hoy = hoyStr();

    switch (rango) {
      case 'hoy':
        this.filtroDesde.set(hoy);
        this.filtroHasta.set(hoy);
        break;
      case 'mes':
        this.filtroDesde.set(primerDiaMesStr());
        this.filtroHasta.set(hoy);
        break;
      case 'semana':
        this.filtroDesde.set(diasAtrasStr(6));
        this.filtroHasta.set(hoy);
        break;
      case 'personalizado':
        // Mantiene fechas actuales
        break;
    }
    void this.consultar();
  }

  cambiarFechaDesde(val: string): void {
    this.filtroDesde.set(val);
    this.rangoRapido.set('personalizado');
    void this.consultar();
  }

  cambiarFechaHasta(val: string): void {
    this.filtroHasta.set(val);
    this.rangoRapido.set('personalizado');
    void this.consultar();
  }

  // ── Exportación PDF ───────────────────────────────────────────────────────

  async descargarPdf(): Promise<void> {
    if (this.movimientos().length === 0 || this.generandoPdf()) return;

    this.generandoPdf.set(true);
    try {
      // Nombre de cuenta para el encabezado
      let cuentaNombre = 'Todas';
      if (this.filtroCuenta() > 0) {
        const c = this.cuentas().find(x => x.id === this.filtroCuenta());
        cuentaNombre = c ? `${c.nombre_banco} (${c.numero_cuenta})` : 'Cuenta seleccionada';
      }

      const tipoNombre = this.filtroTipo() ? this.filtroTipo() : 'Todos';

      const ahora = new Date();
      const generadoStr = `${String(ahora.getDate()).padStart(2, '0')}/${String(ahora.getMonth() + 1).padStart(2, '0')}/${ahora.getFullYear()} ${String(ahora.getHours()).padStart(2, '0')}:${String(ahora.getMinutes()).padStart(2, '0')}`;

      const payload: ReporteMovimientosPdfDatos = {
        periodo_desde:     fmtFecha(this.filtroDesde()),
        periodo_hasta:     fmtFecha(this.filtroHasta()),
        filtro_cuenta:     cuentaNombre,
        filtro_tipo:       tipoNombre,
        generado_en:       generadoStr,
        total_movimientos: this.totalMovimientos(),
        total_ingresos:    this.totalIngresos(),
        total_egresos:     this.totalEgresos(),
        movimiento_neto:   this.movimientoNeto(),
        movimientos:       this.movimientos().map(m => ({
          fecha:         fmtFecha(m.fecha_operacion),
          banco:         m.nombre_banco,
          cuenta:        m.numero_cuenta,
          tipo:          m.tipo,
          motivo:        m.motivo_detalle,
          nro_operacion: m.nro_operacion,
          monto:         m.monto,
        })),
      };

      await this.pdfSvc.descargarReporteMovimientos(payload);
    } catch (e: unknown) {
      this.error.set(`Error al generar PDF: ${e instanceof Error ? e.message : 'error desconocido'}`);
    } finally {
      this.generandoPdf.set(false);
    }
  }
}
