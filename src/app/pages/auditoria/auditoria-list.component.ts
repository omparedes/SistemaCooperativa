import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { AccionAudit, AuditLog, AuditoriaService } from '../../core/services/auditoria.service';

type FiltroAccion = AccionAudit | 'TODOS';

@Component({
  selector: 'app-auditoria-list',
  standalone: true,
  imports: [],
  template: `
    <div class="rounded-2xl border border-stroke bg-white px-5 pt-6 pb-2.5 shadow-default dark:border-strokedark dark:bg-boxdark sm:px-7.5 xl:pb-1">

      <!-- Cabecera -->
      <div class="flex flex-col gap-3 mb-6 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-xl font-semibold text-black dark:text-white">Auditoría de Cambios</h2>
          <p class="text-sm text-slate-500 dark:text-slate-400 mt-0.5">
            Últimos {{ svc.total() }} registros · solo lectura
          </p>
        </div>

        <div class="flex items-center gap-3 flex-wrap">
          <!-- Filtro por acción -->
          <div class="flex rounded-xl border border-stroke dark:border-strokedark overflow-hidden text-sm">
            @for (op of filtros; track op) {
              <button
                (click)="filtroActivo.set(op)"
                [class]="filtroClass(op)"
              >{{ op }}</button>
            }
          </div>

          <!-- Recargar -->
          <button
            (click)="recargar()"
            [disabled]="svc.cargando()"
            class="flex items-center gap-2 rounded-xl border border-stroke dark:border-strokedark px-4 py-2 text-sm font-medium text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-meta-4 transition disabled:opacity-50"
          >
            <svg class="w-4 h-4" [class.animate-spin]="svc.cargando()" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
            </svg>
            Recargar
          </button>
        </div>
      </div>

      <!-- Error -->
      @if (svc.error()) {
        <div class="mb-4 flex items-start gap-2 rounded-xl bg-red-50 border border-red-200 text-red-700 text-sm px-4 py-3 dark:bg-red-900/20 dark:border-red-800 dark:text-red-400">
          <svg class="w-4 h-4 mt-0.5 shrink-0" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
          </svg>
          {{ svc.error() }}
        </div>
      }

      <!-- Cargando skeleton -->
      @if (svc.cargando()) {
        <div class="flex flex-col gap-3 py-8">
          @for (i of [1,2,3,4,5]; track i) {
            <div class="h-10 w-full rounded-lg bg-slate-100 dark:bg-meta-4 animate-pulse"></div>
          }
        </div>
      } @else if (logsFiltrados().length === 0) {
        <div class="flex flex-col items-center gap-2 py-16 text-slate-400">
          <svg class="w-12 h-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
          </svg>
          <p class="text-sm font-medium">Sin registros de auditoría</p>
        </div>
      } @else {

        <!-- Tabla -->
        <div class="overflow-x-auto">
          <table class="w-full table-auto">
            <thead>
              <tr class="bg-gray-2 text-left dark:bg-meta-4">
                <th class="py-4 px-4 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wide">Fecha</th>
                <th class="py-4 px-4 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wide">Acción</th>
                <th class="py-4 px-4 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wide">Tabla</th>
                <th class="py-4 px-4 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wide">ID Registro</th>
                <th class="py-4 px-4 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wide">Usuario</th>
                <th class="py-4 px-4 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wide"></th>
              </tr>
            </thead>
            <tbody>
              @for (log of logsFiltrados(); track log.id) {
                <tr class="border-b border-stroke dark:border-strokedark hover:bg-slate-50 dark:hover:bg-meta-4/50 transition-colors">
                  <td class="py-3 px-4 text-sm text-slate-600 dark:text-slate-300 whitespace-nowrap">
                    {{ fecha(log.created_at) }}
                  </td>
                  <td class="py-3 px-4">
                    <span [class]="accionClass(log.action)">{{ log.action }}</span>
                  </td>
                  <td class="py-3 px-4 text-sm font-medium text-black dark:text-white">
                    {{ log.table_name }}
                  </td>
                  <td class="py-3 px-4 text-sm font-mono text-slate-500 dark:text-slate-400">
                    {{ log.record_id }}
                  </td>
                  <td class="py-3 px-4 text-sm font-mono text-slate-500 dark:text-slate-400" [title]="log.changed_by ?? ''">
                    {{ log.changed_by ? (log.changed_by.substring(0, 8) + '…') : '—' }}
                  </td>
                  <td class="py-3 px-4 text-right">
                    <button
                      (click)="detalle.set(log)"
                      class="text-xs font-medium text-brand-500 hover:text-brand-600 hover:underline transition"
                    >
                      Ver detalle
                    </button>
                  </td>
                </tr>
              }
            </tbody>
          </table>
        </div>
      }
    </div>

    <!-- ── Modal de detalle ─────────────────────────────────────────────────── -->
    @if (detalle(); as log) {
      <div
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
        (click)="detalle.set(null)"
      >
        <div
          class="relative w-full max-w-3xl max-h-[90vh] overflow-y-auto rounded-2xl bg-white dark:bg-boxdark shadow-xl border border-stroke dark:border-strokedark"
          (click)="$event.stopPropagation()"
        >
          <!-- Cabecera modal -->
          <div class="flex items-center justify-between px-6 py-4 border-b border-stroke dark:border-strokedark">
            <div class="flex items-center gap-3">
              <span [class]="accionClass(log.action)">{{ log.action }}</span>
              <span class="text-sm text-slate-600 dark:text-slate-300">
                <strong class="text-black dark:text-white">{{ log.table_name }}</strong>
                <span class="mx-1.5 text-slate-300">·</span>
                ID: <span class="font-mono">{{ log.record_id }}</span>
                <span class="mx-1.5 text-slate-300">·</span>
                {{ fecha(log.created_at) }}
              </span>
            </div>
            <button
              (click)="detalle.set(null)"
              class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition"
            >
              <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
              </svg>
            </button>
          </div>

          <!-- Cuerpo modal: two columns -->
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 p-6">

            <!-- old_data -->
            <div>
              <p class="text-xs font-semibold text-slate-500 uppercase tracking-wide mb-2">
                Antes
                @if (log.action === 'INSERT') { <span class="text-slate-300 normal-case font-normal">(nuevo registro)</span> }
              </p>
              <pre class="rounded-xl bg-slate-50 dark:bg-meta-4 border border-stroke dark:border-strokedark p-4 text-xs text-slate-700 dark:text-slate-300 overflow-x-auto whitespace-pre-wrap break-all">{{ prettify(log.old_data) }}</pre>
            </div>

            <!-- new_data -->
            <div>
              <p class="text-xs font-semibold text-slate-500 uppercase tracking-wide mb-2">
                Después
                @if (log.action === 'DELETE') { <span class="text-slate-300 normal-case font-normal">(registro eliminado)</span> }
              </p>
              <pre class="rounded-xl bg-slate-50 dark:bg-meta-4 border border-stroke dark:border-strokedark p-4 text-xs text-slate-700 dark:text-slate-300 overflow-x-auto whitespace-pre-wrap break-all">{{ prettify(log.new_data) }}</pre>
            </div>

          </div>

          <!-- Usuario -->
          @if (log.changed_by) {
            <div class="px-6 pb-5 text-xs text-slate-400 dark:text-slate-500">
              UUID usuario: <span class="font-mono">{{ log.changed_by }}</span>
            </div>
          }
        </div>
      </div>
    }
  `,
})
export class AuditoriaListComponent implements OnInit {
  readonly svc = inject(AuditoriaService);

  readonly filtros: FiltroAccion[] = ['TODOS', 'INSERT', 'UPDATE', 'DELETE'];
  readonly filtroActivo = signal<FiltroAccion>('TODOS');
  readonly detalle      = signal<AuditLog | null>(null);

  readonly logsFiltrados = computed(() => {
    const f = this.filtroActivo();
    if (f === 'TODOS') return this.svc.logs();
    return this.svc.logs().filter(l => l.action === f);
  });

  ngOnInit(): void {
    void this.svc.cargar();
  }

  recargar(): void {
    void this.svc.cargar();
  }

  filtroClass(op: FiltroAccion): string {
    const activo  = 'px-3 py-1.5 text-sm font-semibold bg-brand-500 text-white transition-colors';
    const inactivo = 'px-3 py-1.5 text-sm text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-meta-4 transition-colors';
    return this.filtroActivo() === op ? activo : inactivo;
  }

  accionClass(accion: AccionAudit): string {
    const base = 'inline-block px-2 py-0.5 rounded-full text-xs font-semibold';
    switch (accion) {
      case 'INSERT': return `${base} bg-green-100  text-green-700  dark:bg-green-900/30  dark:text-green-400`;
      case 'UPDATE': return `${base} bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400`;
      case 'DELETE': return `${base} bg-red-100    text-red-700    dark:bg-red-900/30    dark:text-red-400`;
    }
  }

  fecha(iso: string): string {
    return new Date(iso).toLocaleString('es-PE', {
      day: '2-digit', month: 'short', year: 'numeric',
      hour: '2-digit', minute: '2-digit',
    });
  }

  prettify(data: Record<string, unknown> | null): string {
    if (data === null) return '—';
    return JSON.stringify(data, null, 2);
  }
}
