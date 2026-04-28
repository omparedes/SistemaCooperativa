import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { SafeHtmlPipe } from '../../shared/pipe/safe-html.pipe';
import {
  ConceptoInterno,
  IngresosInternosService,
} from '../../core/services/ingresos-internos.service';

type MetodoPago = 'Efectivo' | 'Transferencia';

// Icono SVG por concepto (fallback al genérico si no está mapeado)
const ICONOS: Record<string, string> = {
  'SS.HH 1er PISO': `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"/></svg>`,
  'Parqueo':         `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 01-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 00-3.213-9.193 2.056 2.056 0 00-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 00-10.026 0 1.106 1.106 0 00-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12"/></svg>`,
  'Alquiler':        `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"/></svg>`,
  'TICKET':          `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 6v.75m0 3v.75m0 3v.75m0 3V18m-9-5.25h5.25M7.5 15h3M3.375 5.25c-.621 0-1.125.504-1.125 1.125v3.026a2.999 2.999 0 010 5.198v3.026c0 .621.504 1.125 1.125 1.125h17.25c.621 0 1.125-.504 1.125-1.125v-3.026a2.999 2.999 0 010-5.198V6.375c0-.621-.504-1.125-1.125-1.125H3.375z"/></svg>`,
  'Donacion':        `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"/></svg>`,
  'Deposito':        `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0115.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 013 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 00-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 01-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 003 15h-.75"/></svg>`,
  'Espacio':         `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z"/></svg>`,
};

const ICONO_GENERICO = `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>`;

@Component({
  selector: 'app-ingresos-internos',
  standalone: true,
  imports: [NgClass, SafeHtmlPipe],
  template: `
    <div class="mx-auto max-w-4xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-6">
        <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Caja Rápida</h2>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          Registra ingresos espontáneos sin recibo. El monto suma al arqueo del día.
        </p>
      </div>

      <!-- ── Feedback de éxito ───────────────────────────────────────────── -->
      @if (exito()) {
        <div class="mb-6 flex items-center gap-3 rounded-2xl border border-emerald-200 bg-emerald-50 px-5 py-4 shadow-sm dark:border-emerald-800 dark:bg-emerald-900/20">
          <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-emerald-100 dark:bg-emerald-900/40">
            <svg class="h-5 w-5 text-emerald-600 dark:text-emerald-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/>
            </svg>
          </div>
          <div>
            <p class="font-semibold text-emerald-800 dark:text-emerald-200">Ingreso Registrado con Éxito</p>
            <p class="text-sm text-emerald-600 dark:text-emerald-400">{{ exito() }}</p>
          </div>
          <button (click)="exito.set(null)"
            class="ml-auto text-emerald-400 hover:text-emerald-600 dark:text-emerald-500 dark:hover:text-emerald-300 transition">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>
      }

      <!-- ── Error global ────────────────────────────────────────────────── -->
      @if (errorGlobal()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ errorGlobal() }}
        </div>
      }

      <!-- ── Skeleton ────────────────────────────────────────────────────── -->
      @if (loading()) {
        <div class="grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4">
          @for (i of [1,2,3,4,5,6]; track i) {
            <div class="animate-pulse rounded-2xl border border-gray-200 bg-white p-5 dark:border-gray-700 dark:bg-gray-800">
              <div class="mx-auto mb-3 h-10 w-10 rounded-full bg-gray-200 dark:bg-gray-700"></div>
              <div class="mx-auto h-4 w-20 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          }
        </div>
      }

      @if (!loading()) {

        <!-- ═══════════════ GRUPO: PARA INQUILINOS ════════════════════════ -->
        @if (conceptosInquilinos().length > 0) {
          <section class="mb-8">
            <div class="mb-3 flex items-center gap-2">
              <span class="inline-flex items-center rounded-full bg-amber-100 px-2.5 py-0.5 text-xs font-semibold text-amber-700 dark:bg-amber-900/30 dark:text-amber-300">
                Para Inquilinos
              </span>
              <span class="h-px flex-1 bg-gray-200 dark:bg-gray-700"></span>
            </div>
            <div class="grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4">
              @for (c of conceptosInquilinos(); track c.id) {
                <button (click)="seleccionar(c)"
                  [ngClass]="conceptoSeleccionado()?.id === c.id
                    ? 'border-brand-500 bg-brand-500 text-white shadow-lg shadow-brand-500/30 dark:border-brand-400 dark:bg-brand-600'
                    : 'border-gray-200 bg-white text-gray-700 hover:border-brand-300 hover:shadow-md dark:border-gray-700 dark:bg-gray-800 dark:text-gray-200 dark:hover:border-brand-600'"
                  class="flex flex-col items-center gap-2 rounded-2xl border p-5 text-center transition-all duration-150 active:scale-95">
                  <span class="h-10 w-10 [&>svg]:h-10 [&>svg]:w-10"
                    [innerHTML]="iconoPara(c.nombre) | safeHtml"></span>
                  <span class="text-sm font-semibold leading-tight">{{ c.nombre }}</span>
                </button>
              }
            </div>
          </section>
        }

        <!-- ═══════════════ GRUPO: OTROS INGRESOS ════════════════════════ -->
        @if (conceptosOtros().length > 0) {
          <section class="mb-8">
            <div class="mb-3 flex items-center gap-2">
              <span class="inline-flex items-center rounded-full bg-gray-100 px-2.5 py-0.5 text-xs font-semibold text-gray-600 dark:bg-gray-700 dark:text-gray-300">
                Otros Ingresos
              </span>
              <span class="h-px flex-1 bg-gray-200 dark:bg-gray-700"></span>
            </div>
            <div class="grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4">
              @for (c of conceptosOtros(); track c.id) {
                <button (click)="seleccionar(c)"
                  [ngClass]="conceptoSeleccionado()?.id === c.id
                    ? 'border-brand-500 bg-brand-500 text-white shadow-lg shadow-brand-500/30 dark:border-brand-400 dark:bg-brand-600'
                    : 'border-gray-200 bg-white text-gray-700 hover:border-brand-300 hover:shadow-md dark:border-gray-700 dark:bg-gray-800 dark:text-gray-200 dark:hover:border-brand-600'"
                  class="flex flex-col items-center gap-2 rounded-2xl border p-5 text-center transition-all duration-150 active:scale-95">
                  <span class="h-10 w-10 [&>svg]:h-10 [&>svg]:w-10"
                    [innerHTML]="iconoPara(c.nombre) | safeHtml"></span>
                  <span class="text-sm font-semibold leading-tight">{{ c.nombre }}</span>
                </button>
              }
            </div>
          </section>
        }

        <!-- ═══════════════ PANEL DE COBRO ═══════════════════════════════ -->
        @if (conceptoSeleccionado(); as c) {
          <div class="rounded-2xl border border-brand-200 bg-white shadow-sm dark:border-brand-800 dark:bg-gray-800">

            <!-- Cabecera del panel -->
            <div class="flex items-center justify-between border-b border-gray-100 px-5 py-4 dark:border-gray-700">
              <div class="flex items-center gap-3">
                <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300 [&>span>svg]:h-6 [&>span>svg]:w-6">
                  <span [innerHTML]="iconoPara(c.nombre) | safeHtml"></span>
                </div>
                <div>
                  <p class="font-semibold text-gray-900 dark:text-white">{{ c.nombre }}</p>
                  <p class="text-xs text-gray-400 dark:text-gray-500">
                    {{ c.grupo === 'INQUILINOS' ? 'Para Inquilinos' : 'Otros Ingresos' }}
                  </p>
                </div>
              </div>
              <button (click)="conceptoSeleccionado.set(null)"
                class="text-gray-400 hover:text-gray-600 dark:text-gray-500 dark:hover:text-gray-300 transition">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                </svg>
              </button>
            </div>

            <!-- Cuerpo del panel -->
            <div class="p-5 space-y-5">

              <!-- Monto -->
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Monto (S/)
                </label>
                <div class="relative">
                  <span class="absolute left-3.5 top-1/2 -translate-y-1/2 text-base font-semibold text-gray-400 dark:text-gray-500 select-none">
                    S/
                  </span>
                  <input
                    type="number"
                    [value]="monto()"
                    (input)="onMontoInput($event)"
                    min="0.01"
                    step="0.50"
                    placeholder="0.00"
                    class="h-14 w-full rounded-xl border border-gray-300 bg-white pl-9 pr-4 text-xl font-bold text-gray-900 placeholder-gray-300 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500"
                  />
                </div>
                @if (monto() && !montoValido()) {
                  <p class="mt-1 text-xs text-red-500">El monto debe ser mayor a cero.</p>
                }
              </div>

              <!-- Método de pago -->
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Método de pago
                </label>
                <div class="grid grid-cols-2 gap-3">
                  <button (click)="metodoPago.set('Efectivo')"
                    [ngClass]="metodoPago() === 'Efectivo'
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-700 dark:bg-emerald-900/20 dark:text-emerald-300 dark:border-emerald-700'
                      : 'border-gray-200 bg-white text-gray-600 hover:border-gray-300 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300'"
                    class="flex items-center justify-center gap-2 rounded-xl border px-4 py-3 text-sm font-semibold transition">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    Efectivo
                  </button>
                  <button (click)="metodoPago.set('Transferencia')"
                    [ngClass]="metodoPago() === 'Transferencia'
                      ? 'border-blue-500 bg-blue-50 text-blue-700 dark:bg-blue-900/20 dark:text-blue-300 dark:border-blue-700'
                      : 'border-gray-200 bg-white text-gray-600 hover:border-gray-300 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300'"
                    class="flex items-center justify-center gap-2 rounded-xl border px-4 py-3 text-sm font-semibold transition">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                    </svg>
                    Transferencia / QR
                  </button>
                </div>
              </div>

              <!-- Error de envío -->
              @if (errorEnvio()) {
                <p class="text-sm text-red-600 dark:text-red-400">{{ errorEnvio() }}</p>
              }

              <!-- Botón registrar -->
              <button (click)="registrar()"
                [disabled]="!puedeEnviar()"
                class="w-full rounded-xl bg-brand-600 px-6 py-3.5 text-base font-bold text-white shadow-sm transition hover:bg-brand-700 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-brand-500 dark:hover:bg-brand-600">
                @if (guardando()) {
                  <span class="inline-flex items-center gap-2">
                    <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                    </svg>
                    Registrando...
                  </span>
                } @else {
                  Registrar Ingreso — S/ {{ montoFormateado() }}
                }
              </button>

              <p class="text-center text-xs text-gray-400 dark:text-gray-500">
                Este ingreso <strong>no genera recibo</strong> ni PDF. Solo suma al arqueo del día.
              </p>
            </div>
          </div>
        }

        @if (!conceptoSeleccionado() && !loading() && conceptos().length === 0) {
          <div class="rounded-2xl border border-gray-200 bg-white py-16 text-center dark:border-gray-700 dark:bg-gray-800">
            <p class="text-gray-400 dark:text-gray-500">No hay conceptos configurados para ingresos internos.</p>
          </div>
        }
      }

    </div>
  `,
})
export class IngresosInternosComponent implements OnInit {
  private readonly svc = inject(IngresosInternosService);

  // ── Estado ─────────────────────────────────────────────────────────────────
  readonly conceptos   = signal<ConceptoInterno[]>([]);
  readonly loading     = signal(true);
  readonly errorGlobal = signal<string | null>(null);

  readonly conceptoSeleccionado = signal<ConceptoInterno | null>(null);
  readonly monto     = signal('');
  readonly metodoPago = signal<MetodoPago>('Efectivo');

  readonly guardando  = signal(false);
  readonly errorEnvio = signal<string | null>(null);
  readonly exito      = signal<string | null>(null);

  // ── Computed ────────────────────────────────────────────────────────────────
  readonly conceptosInquilinos = computed(() =>
    this.conceptos().filter(c => c.grupo === 'INQUILINOS'),
  );
  readonly conceptosOtros = computed(() =>
    this.conceptos().filter(c => c.grupo === 'OTROS'),
  );
  readonly montoValido = computed(() => {
    const n = Number(this.monto());
    return Number.isFinite(n) && n > 0;
  });
  readonly montoFormateado = computed(() => {
    const n = Number(this.monto());
    return Number.isFinite(n) && n > 0 ? n.toFixed(2) : '0.00';
  });
  readonly puedeEnviar = computed(
    () => !!this.conceptoSeleccionado() && this.montoValido() && !this.guardando(),
  );

  // ── Lifecycle ───────────────────────────────────────────────────────────────
  ngOnInit(): void {
    void this.cargarConceptos();
  }

  private async cargarConceptos(): Promise<void> {
    this.loading.set(true);
    this.errorGlobal.set(null);
    try {
      this.conceptos.set(await this.svc.getConceptos());
    } catch (e: unknown) {
      this.errorGlobal.set(e instanceof Error ? e.message : 'Error al cargar conceptos');
    } finally {
      this.loading.set(false);
    }
  }

  // ── Interacción ─────────────────────────────────────────────────────────────
  seleccionar(concepto: ConceptoInterno): void {
    const actual = this.conceptoSeleccionado();
    if (actual?.id === concepto.id) {
      this.conceptoSeleccionado.set(null);
    } else {
      this.conceptoSeleccionado.set(concepto);
      this.exito.set(null);
      this.errorEnvio.set(null);
    }
  }

  onMontoInput(ev: Event): void {
    this.monto.set((ev.target as HTMLInputElement).value);
  }

  async registrar(): Promise<void> {
    const concepto = this.conceptoSeleccionado();
    const monto    = Number(this.monto());
    if (!concepto || !this.montoValido()) return;

    this.guardando.set(true);
    this.errorEnvio.set(null);
    try {
      await this.svc.registrar({
        concepto_id: concepto.id,
        monto,
        metodo_pago: this.metodoPago(),
      });

      this.exito.set(
        `${concepto.nombre} · ${this.metodoPago()} · S/ ${monto.toFixed(2)}`,
      );
      // Reset formulario para el siguiente cobro
      this.conceptoSeleccionado.set(null);
      this.monto.set('');
      this.metodoPago.set('Efectivo');
    } catch (e: unknown) {
      this.errorEnvio.set(e instanceof Error ? e.message : 'Error al registrar el ingreso');
    } finally {
      this.guardando.set(false);
    }
  }

  iconoPara(nombre: string): string {
    return ICONOS[nombre] ?? ICONO_GENERICO;
  }
}
