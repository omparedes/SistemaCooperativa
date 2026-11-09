import { Component, effect, inject, input, output, signal } from '@angular/core';
import { CommonModule, DatePipe, DecimalPipe } from '@angular/common';
import { AuditoriaItem, GestionTarjetaService, RecaudacionTarjetaItem } from '../../../core/services/gestion-tarjeta.service';

@Component({
  selector: 'app-tarjeta-detalle-modal',
  standalone: true,
  imports: [CommonModule, DatePipe, DecimalPipe],
  template: `
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-xs p-4 overflow-y-auto">
      <div class="relative w-full max-w-2xl rounded-2xl bg-white p-6 shadow-2xl dark:bg-gray-800 dark:border dark:border-gray-700 animate-in fade-in zoom-in-95 duration-150">

        <!-- Cabecera -->
        <div class="flex items-start justify-between border-b border-gray-100 pb-4 dark:border-gray-700">
          <div>
            <div class="flex items-center gap-2">
              <span class="font-mono text-sm font-bold text-brand-600 dark:text-brand-400">
                {{ recaudacion().codigo_ref }}
              </span>
              @if (recaudacion().es_anulado) {
                <span class="inline-flex items-center rounded-full bg-red-100 px-2.5 py-0.5 text-xs font-semibold text-red-700 dark:bg-red-900/30 dark:text-red-400">
                  Anulado
                </span>
              } @else {
                <span class="inline-flex items-center rounded-full bg-emerald-100 px-2.5 py-0.5 text-xs font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400">
                  Vigente
                </span>
              }
            </div>
            <h3 class="mt-1 text-lg font-bold text-gray-900 dark:text-white">
              Detalle de Recaudación por Tarjeta
            </h3>
          </div>
          <button
            type="button"
            (click)="close.emit()"
            class="rounded-lg p-1.5 text-gray-400 hover:bg-gray-100 hover:text-gray-600 dark:hover:bg-gray-700 dark:hover:text-gray-300 transition">
            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>

        <!-- Contenido principal -->
        <div class="mt-5 space-y-4 text-sm max-h-[75vh] overflow-y-auto pr-1">

          <!-- Tarjeta de Importe y Socio -->
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 rounded-xl bg-gray-50 p-4 dark:bg-gray-900/50 dark:border dark:border-gray-700/50">
            <div>
              <p class="text-xs font-medium text-gray-500 dark:text-gray-400">Monto Recaudado</p>
              <p class="mt-0.5 text-2xl font-black text-gray-900 dark:text-white tabular-nums">
                S/ {{ recaudacion().monto | number:'1.2-2' }}
              </p>
              <p class="mt-1 text-xs text-emerald-600 dark:text-emerald-400 font-medium">
                Acreditado a Saldo a Favor del Socio
              </p>
            </div>
            <div>
              <p class="text-xs font-medium text-gray-500 dark:text-gray-400">Saldo a Favor Actual del Socio</p>
              <p class="mt-0.5 text-2xl font-black text-brand-600 dark:text-brand-400 tabular-nums">
                S/ {{ recaudacion().socio_saldo_a_favor | number:'1.2-2' }}
              </p>
              <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
                Disponible en Cuenta Corriente
              </p>
            </div>
          </div>

          <!-- Campos de datos del Socio y Operación -->
          <div class="grid grid-cols-1 gap-3 sm:grid-cols-2 rounded-xl border border-gray-100 bg-white p-4 dark:border-gray-700/60 dark:bg-gray-800">
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Socio Participante</p>
              <p class="font-semibold text-gray-900 dark:text-white">{{ recaudacion().socio_nombre }}</p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">DNI</p>
              <p class="font-mono font-medium text-gray-800 dark:text-gray-200">{{ recaudacion().socio_dni }}</p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Puesto Asignado</p>
              <p class="font-medium text-gray-800 dark:text-gray-200">
                <span class="inline-flex items-center rounded-md bg-gray-100 px-2 py-0.5 text-xs font-semibold text-gray-700 dark:bg-gray-700 dark:text-gray-300">
                  {{ recaudacion().codigo_puesto !== '—' ? 'Puesto ' + recaudacion().codigo_puesto : 'Sin puesto activo' }}
                </span>
              </p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Registrado por</p>
              <p class="font-medium text-gray-800 dark:text-gray-200">{{ recaudacion().cajero_nombre }}</p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Fecha Efectiva de Recaudación (Arqueo)</p>
              <p class="font-medium text-gray-900 dark:text-white font-mono">
                {{ recaudacion().fecha | date:'dd/MM/yyyy':'America/Lima' }}
              </p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Fecha de Creación en Sistema (Inmutable)</p>
              <p class="font-medium text-gray-800 dark:text-gray-200 font-mono">
                {{ recaudacion().created_at | date:'dd/MM/yyyy HH:mm:ss':'America/Lima' }}
              </p>
            </div>
          </div>

          <!-- Bloque de anulación si aplica -->
          @if (recaudacion().es_anulado) {
            <div class="rounded-xl border border-red-200 bg-red-50/70 p-4 dark:border-red-900/50 dark:bg-red-950/20">
              <div class="flex items-center gap-2 text-red-800 dark:text-red-300 font-semibold mb-2">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"/>
                </svg>
                Datos de Anulación
              </div>
              <div class="grid grid-cols-1 gap-2 sm:grid-cols-2 text-xs">
                <div>
                  <span class="text-gray-500 dark:text-gray-400">Anulado por:</span>
                  <span class="ml-1 font-medium text-gray-800 dark:text-gray-200">{{ recaudacion().anulado_por_nombre || 'Administrador' }}</span>
                </div>
                <div>
                  <span class="text-gray-500 dark:text-gray-400">Fecha de anulación:</span>
                  <span class="ml-1 font-mono font-medium text-gray-800 dark:text-gray-200">
                    {{ recaudacion().deleted_at | date:'dd/MM/yyyy HH:mm:ss':'America/Lima' }}
                  </span>
                </div>
              </div>
              <div class="mt-2 text-xs">
                <span class="text-gray-500 dark:text-gray-400">Motivo:</span>
                <p class="mt-0.5 font-medium text-red-900 dark:text-red-200 bg-white/70 dark:bg-black/20 p-2 rounded border border-red-200 dark:border-red-900/30">
                  {{ recaudacion().motivo_anulacion || 'Sin motivo registrado' }}
                </p>
              </div>
            </div>
          }

          <!-- Sección: Historial de Auditoría / Modificaciones -->
          <div class="rounded-xl border border-gray-200 bg-gray-50 p-4 dark:border-gray-700 dark:bg-gray-900/40">
            <h4 class="text-xs font-semibold uppercase tracking-wider text-gray-600 dark:text-gray-400 flex items-center gap-1.5 mb-3">
              <svg class="h-4 w-4 text-brand-600 dark:text-brand-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
              Historial de Auditoría y Trazabilidad
            </h4>

            @if (cargandoAuditoria()) {
              <div class="py-3 text-center text-xs text-gray-500">
                <span class="inline-block animate-spin mr-1.5">⏳</span> Cargando historial de auditoría...
              </div>
            } @else if (historial().length === 0) {
              <p class="text-xs text-gray-500 dark:text-gray-400 italic">
                Sin modificaciones posteriores registradas en la bitácora central de auditoría.
              </p>
            } @else {
              <div class="space-y-2.5">
                @for (log of historial(); track log.id) {
                  <div class="rounded-lg border border-gray-200 bg-white p-2.5 text-xs shadow-2xs dark:border-gray-700 dark:bg-gray-800">
                    <div class="flex items-center justify-between">
                      <span class="font-semibold text-gray-800 dark:text-gray-200">
                        {{ log.action === 'INSERT' ? 'Registro Inicial' : log.action === 'UPDATE' ? 'Modificación Administrativa' : log.action }}
                      </span>
                      <span class="font-mono text-gray-500 dark:text-gray-400">
                        {{ log.created_at | date:'dd/MM/yyyy HH:mm:ss':'America/Lima' }}
                      </span>
                    </div>
                    <p class="mt-1 text-gray-600 dark:text-gray-300">
                      <span class="text-gray-400">Responsable:</span> {{ log.usuario_nombre }}
                    </p>
                    @if (log.motivo) {
                      <p class="mt-1 text-gray-700 dark:text-gray-300">
                        <span class="text-gray-400">Motivo:</span> <span class="italic font-medium">"{{ log.motivo }}"</span>
                      </p>
                    }
                    @if (log.old_data && log.new_data && log.action === 'UPDATE') {
                      <div class="mt-1.5 pt-1.5 border-t border-gray-100 dark:border-gray-700 text-2xs text-gray-500 dark:text-gray-400">
                        @if (log.old_data['monto'] !== log.new_data['monto']) {
                          <div>Monto: S/ {{ log.old_data['monto'] }} → S/ {{ log.new_data['monto'] }}</div>
                        }
                        @if (log.old_data['fecha'] !== log.new_data['fecha']) {
                          <div>Fecha: {{ log.old_data['fecha'] | date:'dd/MM/yyyy':'America/Lima' }} → {{ log.new_data['fecha'] | date:'dd/MM/yyyy':'America/Lima' }}</div>
                        }
                        @if (log.old_data['deleted_at'] === null && log.new_data['deleted_at'] !== null) {
                          <div class="text-red-500 font-semibold">Estado: Transición a ANULADO</div>
                        }
                      </div>
                    }
                  </div>
                }
              </div>
            }
          </div>

        </div>

        <!-- Pie -->
        <div class="mt-6 flex justify-end border-t border-gray-100 pt-4 dark:border-gray-700">
          <button
            type="button"
            (click)="close.emit()"
            class="rounded-xl bg-gray-100 px-5 py-2.5 text-sm font-semibold text-gray-700 hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-200 dark:hover:bg-gray-600 transition">
            Cerrar
          </button>
        </div>

      </div>
    </div>
  `
})
export class TarjetaDetalleModalComponent {
  private readonly svc = inject(GestionTarjetaService);

  recaudacion = input.required<RecaudacionTarjetaItem>();
  close = output<void>();

  historial = signal<AuditoriaItem[]>([]);
  cargandoAuditoria = signal(false);

  constructor() {
    effect(async () => {
      const item = this.recaudacion();
      if (!item) return;

      this.cargandoAuditoria.set(true);
      try {
        const logs = await this.svc.getHistorialAuditoria(item.id);
        this.historial.set(logs);
      } catch {
        this.historial.set([]);
      } finally {
        this.cargandoAuditoria.set(false);
      }
    });
  }
}
