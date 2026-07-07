import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import {
  AccionTimeline,
  AuditoriaService,
  EventoAuditoria,
  FiltrosAuditoria,
} from '../../core/services/auditoria.service';
import {
  ACCION_LABELS,
  TABLA_LABELS,
  esCampoVisible,
  etiquetaCampo,
  etiquetaTabla,
  formatearAntes,
  formatearValor,
} from './auditoria-labels';

interface GrupoDia {
  etiqueta: string;
  eventos: EventoAuditoria[];
}

function fmtSoles(n: number): string {
  return `S/ ${n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function fmtHora(iso: string): string {
  const d = new Date(iso);
  return `${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`;
}

function claveDia(iso: string): string {
  const d = new Date(iso);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

function etiquetaDia(clave: string): string {
  const hoy  = claveDia(new Date().toISOString());
  const ayerDate = new Date(); ayerDate.setDate(ayerDate.getDate() - 1);
  const ayer = claveDia(ayerDate.toISOString());
  if (clave === hoy)  return 'Hoy';
  if (clave === ayer) return 'Ayer';
  const meses = ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'];
  const [y, m, d] = clave.split('-').map(Number);
  return `${d} de ${meses[m - 1]} de ${y}`;
}

@Component({
  selector: 'app-auditoria-list',
  standalone: true,
  imports: [NgClass],
  template: `
    <div class="mx-auto max-w-screen-lg p-4 md:p-6">

      <!-- ── Encabezado ─────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Auditoría — Registro de Actividad</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Bitácora inmutable de acciones críticas · solo lectura
          </p>
        </div>

        <button
          (click)="recargar()"
          [disabled]="svc.cargando()"
          class="flex h-9 items-center gap-1.5 self-start rounded-lg border border-gray-300 px-3 text-sm text-gray-600 transition hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
          <svg class="h-4 w-4" [class.animate-spin]="svc.cargando()" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
          </svg>
          Recargar
        </button>
      </div>

      <!-- ── Filtros ────────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-wrap items-center gap-3 rounded-2xl border border-gray-200 bg-white p-4 dark:border-gray-700 dark:bg-gray-dark">
        <select
          [value]="filtroTabla() ?? ''"
          (change)="onTablaChange($event)"
          class="h-9 rounded-lg border border-gray-300 bg-white px-3 text-sm text-gray-700 focus:border-brand-500 focus:outline-none dark:border-gray-600 dark:bg-gray-800 dark:text-white">
          <option value="">Todas las entidades</option>
          @for (t of tablas; track t) {
            <option [value]="t">{{ etiquetaTabla(t) }}</option>
          }
        </select>

        <select
          [value]="filtroAccion() ?? ''"
          (change)="onAccionChange($event)"
          class="h-9 rounded-lg border border-gray-300 bg-white px-3 text-sm text-gray-700 focus:border-brand-500 focus:outline-none dark:border-gray-600 dark:bg-gray-800 dark:text-white">
          <option value="">Todas las acciones</option>
          @for (a of acciones; track a) {
            <option [value]="a">{{ accionLabel(a) }}</option>
          }
        </select>

        <div class="relative flex-1 min-w-48">
          <svg class="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
          </svg>
          <input
            type="text"
            placeholder="Buscar por persona, recibo o usuario…"
            [value]="busquedaInput()"
            (input)="busquedaInput.set($any($event.target).value)"
            (keyup.enter)="aplicarBusqueda()"
            class="h-9 w-full rounded-lg border border-gray-300 bg-white pl-9 pr-3 text-sm text-gray-700 focus:border-brand-500 focus:outline-none dark:border-gray-600 dark:bg-gray-800 dark:text-white" />
        </div>
        <button
          (click)="aplicarBusqueda()"
          class="h-9 rounded-lg bg-brand-600 px-4 text-sm font-medium text-white transition hover:bg-brand-700">
          Buscar
        </button>
        @if (hayFiltrosActivos()) {
          <button
            (click)="limpiarFiltros()"
            class="h-9 rounded-lg border border-gray-300 px-3 text-sm text-gray-500 transition hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
            Limpiar
          </button>
        }
      </div>

      <!-- ── Error ──────────────────────────────────────────────────────── -->
      @if (svc.error()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ svc.error() }}
        </div>
      }

      <!-- ── Skeleton inicial ───────────────────────────────────────────── -->
      @if (svc.cargando() && svc.eventos().length === 0) {
        <div class="space-y-4">
          @for (i of [1,2,3,4]; track i) {
            <div class="animate-pulse rounded-2xl border border-gray-200 bg-white p-5 dark:border-gray-700 dark:bg-gray-dark">
              <div class="h-3 w-48 rounded bg-gray-200 dark:bg-gray-700 mb-3"></div>
              <div class="h-4 w-72 rounded bg-gray-200 dark:bg-gray-700 mb-2"></div>
              <div class="h-3 w-40 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          }
        </div>
      } @else if (svc.eventos().length === 0) {
        <div class="flex flex-col items-center gap-2 py-20 text-gray-400 dark:text-gray-500">
          <svg class="h-12 w-12 opacity-40" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
          </svg>
          <p class="text-sm font-medium">Sin eventos que coincidan con los filtros.</p>
        </div>
      } @else {

        <!-- ── TIMELINE ───────────────────────────────────────────────────── -->
        @for (grupo of grupos(); track grupo.etiqueta) {
          <div class="mb-2 mt-6 first:mt-0 flex items-center gap-3">
            <span class="text-xs font-bold uppercase tracking-widest text-gray-400 dark:text-gray-500">{{ grupo.etiqueta }}</span>
            <div class="h-px flex-1 bg-gray-200 dark:bg-gray-700"></div>
          </div>

          <div class="relative ml-3 border-l-2 border-gray-200 pl-6 dark:border-gray-700">
            @for (ev of grupo.eventos; track ev.id) {
              <!-- Nodo -->
              <span class="absolute -left-[9px] mt-5 flex h-4 w-4 items-center justify-center rounded-full border-2 border-white dark:border-gray-900"
                [ngClass]="nodoClass(ev.accion)"></span>

              <!-- Tarjeta -->
              <div class="mb-4 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">

                <!-- Línea 1: hora · acción · actor -->
                <div class="flex flex-wrap items-center gap-2">
                  <span class="font-mono text-xs text-gray-400 dark:text-gray-500">{{ fmtHora(ev.fecha) }}</span>
                  <span class="rounded-full px-2.5 py-0.5 text-[11px] font-bold uppercase tracking-wide"
                    [ngClass]="badgeClass(ev.accion)">
                    {{ accionLabel(ev.accion) }}
                  </span>
                  <span class="rounded-full bg-gray-100 px-2 py-0.5 text-[11px] font-medium text-gray-500 dark:bg-gray-700 dark:text-gray-400">
                    {{ etiquetaTabla(ev.tabla) }}
                  </span>
                  <span class="ml-auto text-sm text-gray-600 dark:text-gray-300">
                    <span class="font-semibold text-gray-800 dark:text-white">{{ ev.actor.nombre }}</span>
                    <span class="text-gray-400"> · {{ ev.actor.rol }}</span>
                  </span>
                </div>

                <!-- Línea 2: narrativa -->
                <p class="mt-2 text-sm font-medium text-gray-800 dark:text-white">
                  {{ verbo(ev) }} <span class="font-semibold">{{ ev.entidad }}</span>
                </p>

                <!-- Resumen de pago -->
                @if (ev.resumen; as res) {
                  <div class="mt-2 flex flex-wrap items-center gap-1.5">
                    @if (res.monto !== null) {
                      <span class="rounded-lg bg-green-50 px-2 py-0.5 text-xs font-bold text-green-700 dark:bg-green-900/20 dark:text-green-400">
                        {{ fmtSoles(res.monto) }}
                      </span>
                    }
                    @if (res.metodo) {
                      <span class="rounded-lg bg-blue-50 px-2 py-0.5 text-xs font-medium text-blue-600 dark:bg-blue-900/20 dark:text-blue-400">
                        {{ res.metodo }}
                      </span>
                    }
                    @for (c of res.conceptos; track c) {
                      <span class="rounded-full border border-gray-200 bg-gray-50 px-2 py-0.5 text-xs text-gray-500 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400">
                        {{ c }}
                      </span>
                    }
                  </div>
                }

                <!-- Deltas: Antes ➔ Ahora -->
                @if (cambiosVisibles(ev).length > 0) {
                  <div class="mt-3 space-y-1 rounded-xl bg-gray-50 px-4 py-3 dark:bg-gray-800/60">
                    @for (c of cambiosVisibles(ev); track c.campo) {
                      <div class="flex flex-wrap items-baseline gap-1.5 text-sm">
                        <span class="font-medium text-gray-600 dark:text-gray-300">{{ etiquetaCampo(c.campo) }}:</span>
                        <span class="rounded bg-red-50 px-1.5 py-0.5 text-xs text-red-600 line-through dark:bg-red-900/20 dark:text-red-400">
                          {{ formatearAntes(c.campo, c.antes) }}
                        </span>
                        <svg class="h-3.5 w-3.5 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M13 7l5 5m0 0l-5 5m5-5H6"/>
                        </svg>
                        <span class="rounded bg-green-50 px-1.5 py-0.5 text-xs font-semibold text-green-700 dark:bg-green-900/20 dark:text-green-400">
                          {{ formatearValor(c.campo, c.despues) }}
                        </span>
                      </div>
                    }
                  </div>
                }

                <!-- Motivo -->
                @if (ev.motivo) {
                  <div class="mt-3 flex items-start gap-2 rounded-xl border border-amber-200 bg-amber-50 px-3 py-2 dark:border-amber-800/50 dark:bg-amber-900/20">
                    <svg class="mt-0.5 h-4 w-4 shrink-0 text-amber-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                    </svg>
                    <p class="text-sm text-amber-800 dark:text-amber-300">
                      <span class="font-semibold">Motivo:</span> “{{ ev.motivo }}”
                    </p>
                  </div>
                }

                <!-- Referencia técnica -->
                <p class="mt-3 text-[11px] text-gray-300 dark:text-gray-600">
                  {{ ev.tabla }} · registro #{{ ev.registro_id }} · evento {{ ev.id.substring(0, 8) }}
                </p>
              </div>
            }
          </div>
        }

        <!-- ── Cargar más ─────────────────────────────────────────────────── -->
        <div class="flex justify-center py-4">
          @if (svc.hayMas()) {
            <button
              (click)="cargarMas()"
              [disabled]="svc.cargando()"
              class="flex items-center gap-2 rounded-xl border border-gray-300 px-6 py-2.5 text-sm font-medium text-gray-600 transition hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              @if (svc.cargando()) {
                <span class="inline-block h-4 w-4 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
                Cargando…
              } @else {
                Cargar más eventos
              }
            </button>
          } @else {
            <p class="text-xs text-gray-300 dark:text-gray-600">— fin del registro —</p>
          }
        </div>
      }
    </div>
  `,
})
export class AuditoriaListComponent implements OnInit {
  readonly svc = inject(AuditoriaService);

  // Helpers expuestos al template
  protected readonly fmtHora        = fmtHora;
  protected readonly fmtSoles       = fmtSoles;
  protected readonly etiquetaTabla  = etiquetaTabla;
  protected readonly etiquetaCampo  = etiquetaCampo;
  protected readonly formatearValor = formatearValor;
  protected readonly formatearAntes = formatearAntes;

  readonly tablas   = Object.keys(TABLA_LABELS);
  readonly acciones: AccionTimeline[] = ['CREACION', 'EDICION', 'ANULACION', 'RETIRO', 'ELIMINACION'];

  readonly filtroTabla    = signal<string | null>(null);
  readonly filtroAccion   = signal<AccionTimeline | null>(null);
  readonly busquedaInput  = signal('');
  readonly busquedaActiva = signal<string | null>(null);

  readonly hayFiltrosActivos = computed(() =>
    this.filtroTabla() !== null || this.filtroAccion() !== null || this.busquedaActiva() !== null,
  );

  /** Eventos agrupados por día para el timeline. */
  readonly grupos = computed<GrupoDia[]>(() => {
    const grupos: GrupoDia[] = [];
    let claveActual = '';
    for (const ev of this.svc.eventos()) {
      const clave = claveDia(ev.fecha);
      if (clave !== claveActual) {
        claveActual = clave;
        grupos.push({ etiqueta: etiquetaDia(clave), eventos: [] });
      }
      grupos[grupos.length - 1].eventos.push(ev);
    }
    return grupos;
  });

  ngOnInit(): void {
    void this.svc.cargar(this.filtros());
  }

  private filtros(): FiltrosAuditoria {
    return {
      tabla:    this.filtroTabla(),
      accion:   this.filtroAccion(),
      busqueda: this.busquedaActiva(),
    };
  }

  recargar(): void {
    void this.svc.cargar(this.filtros());
  }

  cargarMas(): void {
    void this.svc.cargarMas(this.filtros());
  }

  onTablaChange(ev: Event): void {
    const v = (ev.target as HTMLSelectElement).value;
    this.filtroTabla.set(v || null);
    this.recargar();
  }

  onAccionChange(ev: Event): void {
    const v = (ev.target as HTMLSelectElement).value;
    this.filtroAccion.set((v || null) as AccionTimeline | null);
    this.recargar();
  }

  aplicarBusqueda(): void {
    this.busquedaActiva.set(this.busquedaInput().trim() || null);
    this.recargar();
  }

  limpiarFiltros(): void {
    this.filtroTabla.set(null);
    this.filtroAccion.set(null);
    this.busquedaInput.set('');
    this.busquedaActiva.set(null);
    this.recargar();
  }

  cambiosVisibles(ev: EventoAuditoria): EventoAuditoria['cambios'] {
    return (ev.cambios ?? []).filter(c => esCampoVisible(c.campo));
  }

  accionLabel(a: AccionTimeline): string {
    return ACCION_LABELS[a] ?? a;
  }

  /** Verbo narrativo según la acción y la entidad. */
  verbo(ev: EventoAuditoria): string {
    switch (ev.accion) {
      case 'CREACION':    return ev.tabla === 'pagos' ? 'Registró el' : 'Registró:';
      case 'EDICION':     return 'Modificó:';
      case 'ANULACION':   return 'Anuló:';
      case 'RETIRO':      return 'Retiró:';
      case 'ELIMINACION': return 'Eliminó:';
    }
  }

  nodoClass(a: AccionTimeline): string {
    switch (a) {
      case 'CREACION':    return 'bg-green-500';
      case 'EDICION':     return 'bg-amber-400';
      case 'ANULACION':   return 'bg-red-500';
      case 'RETIRO':      return 'bg-orange-500';
      case 'ELIMINACION': return 'bg-red-600';
    }
  }

  badgeClass(a: AccionTimeline): string {
    switch (a) {
      case 'CREACION':    return 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400';
      case 'EDICION':     return 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400';
      case 'ANULACION':   return 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400';
      case 'RETIRO':      return 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400';
      case 'ELIMINACION': return 'bg-red-100 text-red-800 dark:bg-red-900/40 dark:text-red-300';
    }
  }
}
