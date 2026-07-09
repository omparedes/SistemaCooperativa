import { afterNextRender, Component, ElementRef, inject, OnInit, signal, viewChild } from '@angular/core';
import { NgClass } from '@angular/common';
import { AsambleasService, PadronElectoral, SocioElectoral, VeredictoElectoral } from './asambleas.service';
import { mensajeAmigable } from '../../shared/utils/errores';
import { ExcelExportService } from '../../core/services/excel-export.service';
import { PdfGeneratorService } from '../../core/services/pdf-generator.service';

function fmtSoles(n: number): string {
  return `S/ ${n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function fechaLarga(): string {
  return new Date().toLocaleDateString('es-PE', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' });
}

function hoyISO(): string {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

/**
 * Padrón Electoral de Asambleas: verifica en segundos si un socio está hábil
 * para votar (deuda = 0 según la fuente canónica de deuda) y registra su
 * asistencia. Diseñado para operar de pie, en puerta, con tipografía grande.
 */
@Component({
  selector: 'app-asambleas',
  standalone: true,
  imports: [NgClass],
  template: `
    <div class="mx-auto max-w-3xl p-4 md:p-6">

      <!-- ── Encabezado ─────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Asambleas — Padrón Electoral</h2>
          <p class="mt-1 text-sm capitalize text-gray-500 dark:text-gray-400">{{ hoy }}</p>
        </div>

        <!-- Contador en vivo -->
        <div class="flex items-center gap-4 rounded-2xl border border-gray-200 bg-white px-5 py-3 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <div class="text-center">
            <p class="text-2xl font-extrabold tabular-nums text-brand-600 dark:text-brand-400">{{ asistentes().total }}</p>
            <p class="text-[11px] font-semibold uppercase tracking-wide text-gray-400">Asistentes</p>
          </div>
          <div class="h-8 w-px bg-gray-200 dark:bg-gray-700"></div>
          <div class="text-center">
            <p class="text-2xl font-extrabold tabular-nums text-green-600 dark:text-green-400">{{ asistentes().habiles }}</p>
            <p class="text-[11px] font-semibold uppercase tracking-wide text-gray-400">Hábiles</p>
          </div>
        </div>
      </div>

      <!-- ── Buscador grande ────────────────────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
        <label class="mb-2 block text-sm font-semibold text-gray-700 dark:text-gray-300">
          Buscar socio por DNI o apellido
        </label>
        <div class="relative">
          <svg class="absolute left-4 top-1/2 h-6 w-6 -translate-y-1/2 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
          </svg>
          <input
            #buscadorAsamblea
            type="text"
            inputmode="search"
            placeholder="Escriba el DNI o apellido…"
            [value]="query()"
            (input)="onQueryInput($event)"
            class="h-14 w-full rounded-xl border-2 border-gray-300 bg-gray-50 pl-13 pr-4 text-lg font-medium text-gray-800 outline-none transition focus:border-brand-500 focus:ring-4 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
            style="padding-left: 3.25rem"
          />
          @if (buscando()) {
            <span class="absolute right-4 top-1/2 -translate-y-1/2 inline-block h-5 w-5 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
          }
        </div>

        @if (error()) {
          <p class="mt-3 rounded-xl bg-amber-50 border border-amber-300 px-4 py-3 text-base text-amber-800 dark:bg-amber-900/20 dark:border-amber-700 dark:text-amber-300">
            {{ error() }}
          </p>
        }

        <!-- Resultados en tiempo real -->
        @if (resultados().length > 0) {
          <ul class="mt-4 divide-y divide-gray-100 overflow-hidden rounded-xl border border-gray-200 dark:divide-gray-700 dark:border-gray-700">
            @for (s of resultados(); track s.id) {
              <li>
                <button
                  (click)="seleccionar(s)"
                  class="flex w-full items-center justify-between gap-3 bg-white px-5 py-4 text-left transition hover:bg-brand-50 dark:bg-gray-800 dark:hover:bg-gray-700">
                  <div>
                    <p class="text-base font-semibold text-gray-800 dark:text-white">{{ s.apellidos }}, {{ s.nombres }}</p>
                    <p class="text-sm text-gray-400">DNI {{ s.dni }}</p>
                  </div>
                  <span class="rounded-full px-2.5 py-1 text-xs font-bold uppercase"
                    [ngClass]="s.estado === 'Activo'
                      ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400'
                      : 'bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-400'">
                    {{ s.estado }}
                  </span>
                </button>
              </li>
            }
          </ul>
        } @else if (query().trim().length >= 2 && !buscando() && busquedaHecha()) {
          <p class="mt-4 py-3 text-center text-base text-gray-400">
            No encontramos ningún socio con “{{ query() }}”. Verifique el DNI o apellido.
          </p>
        }

        <button
          (click)="abrirPadron()"
          [disabled]="cargandoPadron()"
          class="mt-5 flex w-full items-center justify-center gap-3 rounded-xl border-2 border-brand-500 bg-brand-50 px-6 py-4 text-base font-bold text-brand-700 shadow-sm transition hover:bg-brand-100 disabled:opacity-60 dark:border-brand-500/60 dark:bg-brand-500/10 dark:text-brand-400 dark:hover:bg-brand-500/20">
          @if (cargandoPadron()) {
            <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
            Cargando padrón…
          } @else {
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"/>
            </svg>
            Ver Padrón Electoral Completo
          }
        </button>
      </div>

      <!-- ── VEREDICTO GIGANTE ──────────────────────────────────────────── -->
      @if (evaluando()) {
        <div class="mt-6 flex flex-col items-center gap-3 rounded-3xl border-2 border-gray-200 bg-white py-16 dark:border-gray-700 dark:bg-gray-dark">
          <span class="inline-block h-10 w-10 rounded-full border-4 border-brand-500 border-t-transparent animate-spin"></span>
          <p class="text-base font-medium text-gray-500">Verificando estado de cuenta…</p>
        </div>
      }
      @if (!evaluando() && veredicto(); as v) {
        <div class="mt-6 overflow-hidden rounded-3xl border-4 shadow-xl"
          [ngClass]="v.habil ? 'border-green-500' : 'border-red-500'">

          <!-- Bloque principal -->
          <div class="flex flex-col items-center gap-4 px-6 py-10 text-center"
            [ngClass]="v.habil
              ? 'bg-gradient-to-br from-green-500 to-emerald-600'
              : 'bg-gradient-to-br from-red-500 to-rose-600'">

            <!-- Icono gigante -->
            <div class="flex h-28 w-28 items-center justify-center rounded-full bg-white/25 ring-8 ring-white/20">
              @if (v.habil) {
                <svg class="h-16 w-16 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/>
                </svg>
              } @else {
                <svg class="h-16 w-16 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                </svg>
              }
            </div>

            <div>
              <p class="text-4xl font-black tracking-tight text-white drop-shadow-sm">
                {{ v.habil ? 'SOCIO HÁBIL' : 'INHABILITADO' }}
              </p>
              <p class="mt-1 text-lg font-bold uppercase tracking-widest text-white/90">
                @if (v.habil) {
                  ✓ Autorizado para votar
                } @else if (v.motivo_inhabil === 'inactivo') {
                  Socio inactivo en el padrón
                } @else {
                  Registra deuda pendiente
                }
              </p>
            </div>

            <!-- Identidad -->
            <div class="rounded-2xl bg-white/15 px-6 py-3 backdrop-blur-sm">
              <p class="text-xl font-bold text-white">{{ v.socio.apellidos }}, {{ v.socio.nombres }}</p>
              <p class="text-sm font-medium text-white/80">DNI {{ v.socio.dni }}</p>
            </div>

            <!-- Deuda (solo inhabilitados por deuda) -->
            @if (!v.habil && v.motivo_inhabil === 'deuda') {
              <div class="mt-1 rounded-2xl bg-white px-8 py-4 shadow-lg">
                <p class="text-xs font-bold uppercase tracking-wide text-red-500">Deuda pendiente</p>
                <p class="text-3xl font-extrabold tabular-nums text-red-600">{{ fmtSoles(v.deuda_total) }}</p>
                <p class="mt-1 text-sm text-gray-500">Puede regularizar su pago en Caja para habilitarse.</p>
              </div>
            }
          </div>

          <!-- Barra de acción -->
          <div class="flex flex-col items-center gap-2 bg-white px-6 py-5 dark:bg-gray-dark sm:flex-row sm:justify-between">
            <p class="text-sm text-gray-400">
              Verificado {{ ahora }} · deuda consultada en línea
            </p>
            @if (v.ya_registrado_hoy) {
              <span class="flex items-center gap-2 rounded-xl bg-green-100 px-5 py-3 text-base font-bold text-green-700 dark:bg-green-900/30 dark:text-green-400">
                <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
                Asistencia ya registrada hoy
              </span>
            } @else {
              <button
                (click)="registrar()"
                [disabled]="registrando()"
                class="flex items-center gap-2 rounded-xl px-6 py-3 text-base font-bold text-white shadow-md transition disabled:opacity-60"
                [ngClass]="v.habil ? 'bg-green-600 hover:bg-green-700' : 'bg-gray-700 hover:bg-gray-800'">
                @if (registrando()) {
                  <span class="inline-block h-5 w-5 rounded-full border-2 border-white border-t-transparent animate-spin"></span>
                  Registrando…
                } @else {
                  📋 Registrar Asistencia
                }
              </button>
            }
          </div>
        </div>
      }

      <!-- ── Modal: Padrón Electoral Completo ──────────────────────────────── -->
      @if (mostrarPadron()) {
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/60 p-4" (click)="cerrarPadron()">
          <div
            (click)="$event.stopPropagation()"
            class="flex max-h-[90vh] w-full max-w-4xl flex-col overflow-hidden rounded-2xl bg-white shadow-2xl dark:bg-gray-dark">

            <!-- Encabezado -->
            <div class="flex items-center justify-between border-b border-gray-200 px-6 py-4 dark:border-gray-700">
              <div>
                <h3 class="text-lg font-bold text-gray-800 dark:text-white">Padrón Electoral Completo</h3>
                @if (padron(); as p) {
                  <p class="text-sm text-gray-400">{{ p.total_activos }} socios activos · generado {{ ahora }}</p>
                }
              </div>
              <button (click)="cerrarPadron()" class="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600 dark:hover:bg-gray-700">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
              </button>
            </div>

            <!-- Pestañas + exportar -->
            <div class="flex flex-col gap-3 border-b border-gray-200 px-6 py-3 dark:border-gray-700 sm:flex-row sm:items-center sm:justify-between">
              <div class="flex gap-2">
                <button
                  (click)="tabPadron.set('habiles')"
                  class="rounded-lg px-4 py-2 text-sm font-bold transition"
                  [ngClass]="tabPadron() === 'habiles'
                    ? 'bg-green-600 text-white shadow-sm'
                    : 'bg-gray-100 text-gray-500 hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300'">
                  ✓ Hábiles ({{ padron()?.habiles?.length ?? 0 }})
                </button>
                <button
                  (click)="tabPadron.set('inhabilitados')"
                  class="rounded-lg px-4 py-2 text-sm font-bold transition"
                  [ngClass]="tabPadron() === 'inhabilitados'
                    ? 'bg-red-600 text-white shadow-sm'
                    : 'bg-gray-100 text-gray-500 hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300'">
                  ✕ Inhabilitados ({{ padron()?.inhabilitados?.length ?? 0 }})
                </button>
              </div>
              <div class="flex gap-2">
                <button
                  (click)="exportarExcel()"
                  [disabled]="exportando() !== null"
                  class="flex items-center gap-1.5 rounded-lg border border-gray-300 bg-white px-3 py-2 text-xs font-bold text-gray-600 shadow-sm transition hover:bg-gray-50 disabled:opacity-60 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-200">
                  @if (exportando() === 'excel') {
                    <span class="inline-block h-4 w-4 rounded-full border-2 border-gray-400 border-t-transparent animate-spin"></span>
                  } @else {
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3"/></svg>
                  }
                  Excel
                </button>
                <button
                  (click)="exportarPdf()"
                  [disabled]="exportando() !== null"
                  class="flex items-center gap-1.5 rounded-lg bg-brand-600 px-3 py-2 text-xs font-bold text-white shadow-sm transition hover:bg-brand-700 disabled:opacity-60">
                  @if (exportando() === 'pdf') {
                    <span class="inline-block h-4 w-4 rounded-full border-2 border-white border-t-transparent animate-spin"></span>
                  } @else {
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M6.72 13.829c-.24.03-.48.062-.72.096m.72-.096a42.415 42.415 0 0110.56 0m-10.56 0L6.34 18m10.94-4.171c.24.03.48.062.72.096m-.72-.096L17.66 18m0 0l.229 2.523a1.125 1.125 0 01-1.12 1.227H7.231c-.662 0-1.18-.568-1.12-1.227L6.34 18m11.318 0h1.091A2.25 2.25 0 0021 15.75V9.456c0-1.081-.768-2.015-1.837-2.175a48.055 48.055 0 00-1.913-.247M6.34 18H5.25A2.25 2.25 0 013 15.75V9.456c0-1.081.768-2.015 1.837-2.175a48.041 48.041 0 011.913-.247m10.5 0a48.536 48.536 0 00-10.5 0m10.5 0V3.375c0-.621-.504-1.125-1.125-1.125h-8.25c-.621 0-1.125.504-1.125 1.125v3.659M18 10.5h.008v.008H18V10.5zm-3 0h.008v.008H15V10.5z"/></svg>
                  }
                  Imprimir / PDF
                </button>
              </div>
            </div>

            <!-- Contenido -->
            <div class="flex-1 overflow-y-auto px-6 py-4">
              @if (tabPadron() === 'habiles') {
                @if ((padron()?.habiles?.length ?? 0) > 0) {
                  <table class="w-full text-left text-sm">
                    <thead class="sticky top-0 bg-white dark:bg-gray-dark">
                      <tr class="border-b border-gray-200 text-xs font-bold uppercase tracking-wide text-gray-400 dark:border-gray-700">
                        <th class="py-2">Socio</th>
                        <th class="py-2">DNI</th>
                        <th class="py-2">Puesto</th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                      @for (s of padron()?.habiles ?? []; track s.id) {
                        <tr>
                          <td class="py-2.5 font-medium text-gray-800 dark:text-white">{{ s.apellidos }}, {{ s.nombres }}</td>
                          <td class="py-2.5 text-gray-500">{{ s.dni }}</td>
                          <td class="py-2.5 text-gray-500">{{ s.codigo_puesto ?? '—' }}</td>
                        </tr>
                      }
                    </tbody>
                  </table>
                } @else {
                  <p class="py-8 text-center text-gray-400">Ningún socio hábil por el momento.</p>
                }
              } @else {
                @if ((padron()?.inhabilitados?.length ?? 0) > 0) {
                  <table class="w-full text-left text-sm">
                    <thead class="sticky top-0 bg-white dark:bg-gray-dark">
                      <tr class="border-b border-gray-200 text-xs font-bold uppercase tracking-wide text-gray-400 dark:border-gray-700">
                        <th class="py-2">Socio</th>
                        <th class="py-2">DNI</th>
                        <th class="py-2">Puesto</th>
                        <th class="py-2 text-right">Deuda</th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                      @for (s of padron()?.inhabilitados ?? []; track s.id) {
                        <tr>
                          <td class="py-2.5 font-medium text-gray-800 dark:text-white">{{ s.apellidos }}, {{ s.nombres }}</td>
                          <td class="py-2.5 text-gray-500">{{ s.dni }}</td>
                          <td class="py-2.5 text-gray-500">{{ s.codigo_puesto ?? '—' }}</td>
                          <td class="py-2.5 text-right font-bold tabular-nums text-red-600">{{ fmtSoles(s.deuda_total) }}</td>
                        </tr>
                      }
                    </tbody>
                  </table>
                } @else {
                  <p class="py-8 text-center text-gray-400">Ningún socio inhabilitado. Padrón al día.</p>
                }
              }
            </div>
          </div>
        </div>
      }

      <!-- ── Toast ──────────────────────────────────────────────────────── -->
      @if (toast(); as t) {
        <div class="fixed bottom-6 left-1/2 z-50 -translate-x-1/2 flex items-center gap-3 rounded-2xl px-6 py-4 text-base font-semibold text-white shadow-2xl"
          [ngClass]="t.tipo === 'ok' ? 'bg-green-600' : 'bg-amber-500'">
          @if (t.tipo === 'ok') {
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
          } @else {
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m0 3h.008v.008H12v-.008z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.697 16.126c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126z"/></svg>
          }
          {{ t.mensaje }}
        </div>
      }
    </div>
  `,
})
export class AsambleasComponent implements OnInit {
  private readonly svc = inject(AsambleasService);
  private readonly excelSvc = inject(ExcelExportService);
  private readonly pdfSvc = inject(PdfGeneratorService);
  private readonly buscador = viewChild<ElementRef<HTMLInputElement>>('buscadorAsamblea');

  protected readonly fmtSoles = fmtSoles;
  protected readonly hoy = fechaLarga();
  protected readonly ahora = new Date().toLocaleTimeString('es-PE', { hour: '2-digit', minute: '2-digit' });

  readonly query         = signal('');
  readonly buscando      = signal(false);
  readonly busquedaHecha = signal(false);
  readonly resultados    = signal<SocioElectoral[]>([]);
  readonly evaluando     = signal(false);
  readonly veredicto     = signal<VeredictoElectoral | null>(null);
  readonly registrando   = signal(false);
  readonly error         = signal<string | null>(null);
  readonly asistentes    = signal<{ total: number; habiles: number }>({ total: 0, habiles: 0 });
  readonly toast         = signal<{ mensaje: string; tipo: 'ok' | 'aviso' } | null>(null);

  readonly mostrarPadron  = signal(false);
  readonly cargandoPadron = signal(false);
  readonly padron         = signal<PadronElectoral | null>(null);
  readonly tabPadron      = signal<'habiles' | 'inhabilitados'>('habiles');
  readonly exportando     = signal<'excel' | 'pdf' | null>(null);

  private debounce: ReturnType<typeof setTimeout> | null = null;
  private toastTimer: ReturnType<typeof setTimeout> | null = null;

  constructor() {
    afterNextRender(() => this.buscador()?.nativeElement.focus());
  }

  ngOnInit(): void {
    void this.refrescarContador();
  }

  // ── Búsqueda en tiempo real (debounce 300 ms) ──────────────────────────────
  onQueryInput(ev: Event): void {
    const valor = (ev.target as HTMLInputElement).value;
    this.query.set(valor);
    this.veredicto.set(null);
    this.error.set(null);
    if (this.debounce) clearTimeout(this.debounce);

    if (valor.trim().length < 2) {
      this.resultados.set([]);
      this.busquedaHecha.set(false);
      return;
    }
    this.debounce = setTimeout(() => void this.buscar(valor), 300);
  }

  private async buscar(q: string): Promise<void> {
    this.buscando.set(true);
    try {
      const res = await this.svc.buscarSocios(q);
      // Descarta respuestas obsoletas si el usuario siguió escribiendo
      if (this.query() === q) {
        this.resultados.set(res);
        this.busquedaHecha.set(true);
      }
    } catch (e) {
      this.error.set(mensajeAmigable(e, 'No se pudo buscar. Revise la conexión e intente otra vez.'));
    } finally {
      this.buscando.set(false);
    }
  }

  async seleccionar(s: SocioElectoral): Promise<void> {
    this.resultados.set([]);
    this.query.set(`${s.apellidos}, ${s.nombres}`);
    this.evaluando.set(true);
    this.error.set(null);
    try {
      this.veredicto.set(await this.svc.evaluarSocio(s));
    } catch (e) {
      this.error.set(mensajeAmigable(e, 'No se pudo verificar la deuda del socio. Intente nuevamente.'));
    } finally {
      this.evaluando.set(false);
    }
  }

  async registrar(): Promise<void> {
    const v = this.veredicto();
    if (!v || this.registrando()) return;
    this.registrando.set(true);
    try {
      await this.svc.registrarAsistencia(v);
      this.veredicto.set({ ...v, ya_registrado_hoy: true });
      this.mostrarToast(`Asistencia de ${v.socio.apellidos} registrada correctamente.`, 'ok');
      await this.refrescarContador();
      // Listo para el siguiente socio en la puerta
      this.buscador()?.nativeElement.focus();
      this.buscador()?.nativeElement.select();
    } catch (e) {
      const msg = e instanceof Error && /duplicate|23505/i.test(e.message)
        ? 'Este socio ya tiene asistencia registrada para hoy.'
        : mensajeAmigable(e, 'No se pudo registrar la asistencia. Intente nuevamente.');
      this.mostrarToast(msg, 'aviso');
    } finally {
      this.registrando.set(false);
    }
  }

  private async refrescarContador(): Promise<void> {
    try {
      this.asistentes.set(await this.svc.contarAsistentesHoy());
    } catch {
      // El contador es informativo: no bloquea la operación de puerta.
    }
  }

  private mostrarToast(mensaje: string, tipo: 'ok' | 'aviso'): void {
    if (this.toastTimer) clearTimeout(this.toastTimer);
    this.toast.set({ mensaje, tipo });
    this.toastTimer = setTimeout(() => this.toast.set(null), 3500);
  }

  // ── Padrón Electoral Completo ───────────────────────────────────────────────
  async abrirPadron(): Promise<void> {
    this.mostrarPadron.set(true);
    this.tabPadron.set('habiles');
    if (this.padron()) return; // ya cargado en esta sesión de la pantalla
    this.cargandoPadron.set(true);
    try {
      this.padron.set(await this.svc.obtenerPadronCompleto());
    } catch (e) {
      this.mostrarPadron.set(false);
      this.mostrarToast(mensajeAmigable(e, 'No se pudo cargar el padrón electoral.'), 'aviso');
    } finally {
      this.cargandoPadron.set(false);
    }
  }

  cerrarPadron(): void {
    this.mostrarPadron.set(false);
  }

  async exportarExcel(): Promise<void> {
    const p = this.padron();
    if (!p || this.exportando()) return;
    this.exportando.set('excel');
    try {
      await this.excelSvc.exportar(`padron-electoral-${hoyISO()}`, [
        {
          nombre: 'Hábiles',
          filas: p.habiles.map(s => ({
            DNI: s.dni, Apellidos: s.apellidos, Nombres: s.nombres, Puesto: s.codigo_puesto ?? '—',
          })),
        },
        {
          nombre: 'Inhabilitados',
          filas: p.inhabilitados.map(s => ({
            DNI: s.dni, Apellidos: s.apellidos, Nombres: s.nombres, Puesto: s.codigo_puesto ?? '—',
            'Deuda Total (S/)': s.deuda_total,
          })),
        },
      ]);
    } catch (e) {
      this.mostrarToast(mensajeAmigable(e, 'No se pudo generar el Excel.'), 'aviso');
    } finally {
      this.exportando.set(null);
    }
  }

  async exportarPdf(): Promise<void> {
    const p = this.padron();
    if (!p || this.exportando()) return;
    this.exportando.set('pdf');
    try {
      await this.pdfSvc.generarPadronElectoralYAbrir(p);
    } catch (e) {
      this.mostrarToast(mensajeAmigable(e, 'No se pudo generar el PDF.'), 'aviso');
    } finally {
      this.exportando.set(null);
    }
  }
}
