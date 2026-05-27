import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass, DecimalPipe } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { GirosService, Giro } from '../../core/services/giros.service';
import { AuthService } from '../../core/services/auth.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-giro-list',
  standalone: true,
  imports: [NgClass, DecimalPipe, RouterModule, FormsModule],
  template: `
    <div class="p-6 max-w-7xl mx-auto">
      <header class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Gestión de Giros Comerciales</h2>
          <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
            Catálogo de giros de negocio del mercado con sus respectivas tarifas base para Luz y Agua.
          </p>
        </div>
        @if (authSvc.esAdmin()) {
          <button (click)="abrirFormulario()"
            class="inline-flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-brand-700 dark:bg-brand-500 dark:hover:bg-brand-600 shrink-0">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/>
            </svg>
            Nuevo Giro
          </button>
        }
      </header>

      <!-- Buscador -->
      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-4 mb-6">
        <input type="text"
          [value]="busqueda()"
          (input)="busqueda.set($any($event.target).value)"
          placeholder="Buscar por nombre de giro..."
          class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500" />
      </div>

      <!-- Errores y Carga -->
      @if (errorLocal()) {
        <div class="mb-5 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ errorLocal() }}
        </div>
      }

      @if (svc.loading()) {
        <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
          <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
          Cargando catálogo de giros...
        </div>
      } @else if (girosFiltrados().length === 0) {
        <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl p-12 text-center text-gray-500 dark:text-gray-400">
          <svg class="h-12 w-12 mx-auto mb-3 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 21v-7.5a.75.75 0 01.75-.75h3a.75.75 0 01.75.75V21m-4.5 0H2.36m11.14 0H18m0 0h3.64m-1.39 0V9.349m-16.5 11.65V9.35m0 0a3.001 3.001 0 003.75-.615A2.993 2.993 0 009.75 9.75c.896 0 1.7-.393 2.25-1.016a2.993 2.993 0 002.25 1.016c.896 0 1.7-.393 2.25-1.015a3.001 3.001 0 003.75.614m-16.5 0a3.004 3.004 0 01-.621-4.72L4.318 3.44A1.5 1.5 0 015.378 3h13.243a1.5 1.5 0 011.06.44l1.19 1.189a3 3 0 01-.621 4.72M6.75 18h3.75a.75.75 0 00.75-.75V13.5a.75.75 0 00-.75-.75H6.75a.75.75 0 00-.75.75v3.75c0 .414.336.75.75.75z"/>
          </svg>
          <p class="font-medium text-gray-700 dark:text-gray-300">No se encontraron giros comerciales</p>
          <p class="text-sm mt-1">Intente cambiar el término de búsqueda o registre uno nuevo.</p>
        </div>
      } @else {
        <!-- Grid de Cards de Giros -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          @for (g of girosFiltrados(); track g.id) {
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-sm hover:shadow-md transition-shadow p-5 flex flex-col justify-between">
              <div>
                <!-- Header Card -->
                <div class="flex items-start justify-between gap-2 mb-3">
                  <h3 class="text-lg font-bold text-gray-900 dark:text-white capitalize">
                    {{ g.nombre }}
                  </h3>
                  <span [ngClass]="g.activo 
                    ? 'bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300' 
                    : 'bg-red-50 dark:bg-red-900/30 text-red-700 dark:text-red-300'"
                    class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold">
                    {{ g.activo ? 'Activo' : 'Inactivo' }}
                  </span>
                </div>

                <!-- Info Card -->
                <div class="space-y-2 border-t border-gray-100 dark:border-gray-700/60 pt-3 text-sm">
                  <div class="flex justify-between">
                    <span class="text-gray-500 dark:text-gray-400">Tarifa Agua Base:</span>
                    <span class="font-medium text-gray-900 dark:text-white tabular-nums">S/ {{ g.tarifa_agua_base | number:'1.2-2' }}</span>
                  </div>
                  <div class="flex justify-between">
                    <span class="text-gray-500 dark:text-gray-400">Tarifa Luz Base:</span>
                    <span class="font-medium text-gray-900 dark:text-white tabular-nums">S/ {{ g.tarifa_luz_base | number:'1.2-2' }}</span>
                  </div>
                  <div class="flex justify-between">
                    <span class="text-gray-500 dark:text-gray-400">Puestos Asignados:</span>
                    <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-semibold bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                      {{ g.total_puestos || 0 }} Puesto(s)
                    </span>
                  </div>
                </div>
              </div>

              <!-- Actions Card -->
              <div class="mt-5 border-t border-gray-100 dark:border-gray-700/60 pt-3 flex items-center justify-end gap-2">
                <a [routerLink]="['/giros', g.id]"
                  class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition">
                  Puestos
                </a>
                @if (authSvc.esAdmin()) {
                  <button (click)="abrirFormulario(g)"
                    class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 rounded-lg transition">
                    Editar
                  </button>
                  <button (click)="abrirModalConfirmacionEliminar(g)"
                    class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition">
                    Eliminar
                  </button>
                }
              </div>
            </div>
          }
        </div>
      }
    </div>

    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    <!-- DRAWER FORMULARIO CREAR / EDITAR                                        -->
    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    @if (formAbierto()) {
      <div class="fixed inset-0 bg-black/40 dark:bg-black/60 z-50 flex items-center justify-end p-0">
        <div class="bg-white dark:bg-gray-900 h-full w-full max-w-md shadow-2xl flex flex-col justify-between border-l border-gray-200 dark:border-gray-700 transform transition-transform animate-slide-in">
          
          <div>
            <!-- Header Form -->
            <div class="px-6 py-5 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between">
              <h3 class="text-lg font-bold text-gray-900 dark:text-white">
                {{ editingGiro() ? 'Editar Giro Comercial' : 'Nuevo Giro Comercial' }}
              </h3>
              <button (click)="cerrarFormulario()" class="text-gray-400 hover:text-gray-600 dark:hover:text-white">
                <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                </svg>
              </button>
            </div>

            <!-- Body Form -->
            <div class="px-6 py-5 space-y-4">
              @if (errorForm()) {
                <div class="p-3 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-300 text-sm">
                  {{ errorForm() }}
                </div>
              }

              <!-- Nombre -->
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                  Nombre del giro *
                </label>
                <input type="text" [(ngModel)]="formNombre" placeholder="Ej: Abarrotes, Verduras, Bazar"
                  class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3.5 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>

              <!-- Tarifa Agua -->
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                  Tarifa de Agua Base (S/) *
                </label>
                <input type="number" [(ngModel)]="formAgua" min="0" step="0.5"
                  class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3.5 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>

              <!-- Tarifa Luz -->
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                  Tarifa de Luz Base (S/) *
                </label>
                <input type="number" [(ngModel)]="formLuz" min="0" step="0.5"
                  class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3.5 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>

              <!-- Activo (Solo modo edición) -->
              @if (editingGiro()) {
                <div class="flex items-center justify-between p-3 rounded-lg border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-900/30">
                  <div>
                    <p class="text-sm font-medium text-gray-900 dark:text-white">Estado del giro</p>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">Determina si puede asignarse a nuevos puestos</p>
                  </div>
                  <button (click)="formActivo = !formActivo"
                    class="relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-1"
                    [ngClass]="formActivo ? 'bg-brand-600 dark:bg-brand-500' : 'bg-gray-300 dark:bg-gray-600'">
                    <span class="inline-block h-4 w-4 rounded-full bg-white shadow-sm transform transition-transform"
                      [ngClass]="formActivo ? 'translate-x-6' : 'translate-x-1'">
                    </span>
                  </button>
                </div>
              }
            </div>
          </div>

          <!-- Footer Form -->
          <div class="px-6 py-4 border-t border-gray-200 dark:border-gray-700 flex gap-3 bg-gray-50 dark:bg-gray-900/40">
            <button (click)="cerrarFormulario()"
              class="flex-1 px-4 py-2.5 rounded-xl border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-800 transition">
              Cancelar
            </button>
            <button (click)="guardarGiro()" [disabled]="!puedeGuardar() || guardando()"
              class="flex-1 px-4 py-2.5 rounded-xl bg-brand-600 hover:bg-brand-700 text-white text-sm font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition">
              @if (guardando()) {
                <span class="inline-flex items-center gap-2">
                  <span class="h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent"></span>
                  Guardando…
                </span>
              } @else {
                Guardar
              }
            </button>
          </div>

        </div>
      </div>
    }

    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    <!-- MODAL CONFIRMACION ELIMINAR (MOTIVO)                                    -->
    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    @if (giroAEliminar(); as g) {
      <div class="fixed inset-0 bg-black/40 dark:bg-black/60 z-50 flex items-center justify-center p-4">
        <div class="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md border border-gray-200 dark:border-gray-700 overflow-hidden">
          
          <div class="px-6 py-5 border-b border-gray-200 dark:border-gray-700">
            <h3 class="text-lg font-bold text-gray-900 dark:text-white">Dar de baja Giro Comercial</h3>
            <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
              Giro seleccionado: <span class="font-semibold text-gray-700 dark:text-gray-300 capitalize">{{ g.nombre }}</span>
            </p>
          </div>

          <div class="px-6 py-5 space-y-4">
            @if (errorEliminar()) {
              <div class="p-3 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-300 text-sm">
                {{ errorEliminar() }}
              </div>
            }

            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                Escriba el motivo de la baja *
              </label>
              <textarea [(ngModel)]="motivoBaja" rows="3" placeholder="Ej: Giro descontinuado, fusión de rubros, etc."
                class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500 resize-none">
              </textarea>
            </div>
          </div>

          <div class="px-6 py-4 border-t border-gray-200 dark:border-gray-700 flex gap-3 justify-end bg-gray-50 dark:bg-gray-900/40">
            <button (click)="cerrarModalEliminar()"
              class="px-4 py-2 rounded-xl border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-800 transition">
              Cancelar
            </button>
            <button (click)="confirmarEliminar()" [disabled]="!puedeEliminar() || eliminando()"
              class="px-4 py-2 rounded-xl bg-red-600 hover:bg-red-700 text-white text-sm font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition">
              @if (eliminando()) {
                <span class="inline-flex items-center gap-2">
                  <span class="h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent"></span>
                  Eliminando…
                </span>
              } @else {
                Confirmar Baja
              }
            </button>
          </div>

        </div>
      </div>
    }
  `,
  styles: `
    @keyframes slideIn {
      from { transform: translateX(100%); }
      to { transform: translateX(0); }
    }
    .animate-slide-in {
      animation: slideIn 0.25s ease-out forwards;
    }
  `
})
export class GiroListComponent implements OnInit {
  protected readonly svc     = inject(GirosService);
  protected readonly authSvc = inject(AuthService);

  readonly busqueda = signal('');
  readonly errorLocal = signal<string | null>(null);

  // Form Drawer
  readonly formAbierto = signal(false);
  readonly editingGiro = signal<Giro | null>(null);
  readonly guardando   = signal(false);
  readonly errorForm   = signal<string | null>(null);

  formNombre = '';
  formAgua   = 0;
  formLuz    = 0;
  formActivo = true;

  // Delete Modal
  readonly giroAEliminar  = signal<Giro | null>(null);
  readonly eliminando     = signal(false);
  readonly errorEliminar  = signal<string | null>(null);
  motivoBaja = '';

  readonly girosFiltrados = computed(() => {
    const list = this.svc.giros();
    const query = this.busqueda().toLowerCase().trim();
    if (!query) return list;
    return list.filter(g => g.nombre.toLowerCase().includes(query));
  });

  ngOnInit(): void {
    void this.cargar();
  }

  async cargar(): Promise<void> {
    this.errorLocal.set(null);
    try {
      await this.svc.cargar();
    } catch (e: unknown) {
      this.errorLocal.set(e instanceof Error ? e.message : 'Error al cargar giros');
    }
  }

  abrirFormulario(giro?: Giro): void {
    this.errorForm.set(null);
    if (giro) {
      this.editingGiro.set(giro);
      this.formNombre = giro.nombre;
      this.formAgua   = giro.tarifa_agua_base;
      this.formLuz    = giro.tarifa_luz_base;
      this.formActivo = giro.activo;
    } else {
      this.editingGiro.set(null);
      this.formNombre = '';
      this.formAgua   = 0;
      this.formLuz    = 0;
      this.formActivo = true;
    }
    this.formAbierto.set(true);
  }

  cerrarFormulario(): void {
    this.formAbierto.set(false);
    this.editingGiro.set(null);
  }

  puedeGuardar(): boolean {
    return this.formNombre.trim().length >= 3 && this.formAgua >= 0 && this.formLuz >= 0;
  }

  async guardarGiro(): Promise<void> {
    if (!this.puedeGuardar()) return;
    this.guardando.set(true);
    this.errorForm.set(null);
    try {
      const p = {
        nombre:            this.formNombre.trim().toLowerCase(),
        tarifa_agua_base:  this.formAgua,
        tarifa_luz_base:   this.formLuz,
      };

      if (this.editingGiro()) {
        await this.svc.actualizar(this.editingGiro()!.id, { ...p, activo: this.formActivo });
      } else {
        await this.svc.crear(p);
      }

      await this.svc.cargar();
      this.cerrarFormulario();
    } catch (e: unknown) {
      this.errorForm.set(e instanceof Error ? e.message : 'Error al guardar giro comercial');
    } finally {
      this.guardando.set(false);
    }
  }

  abrirModalConfirmacionEliminar(giro: Giro): void {
    this.giroAEliminar.set(giro);
    this.motivoBaja = '';
    this.errorEliminar.set(null);
  }

  cerrarModalEliminar(): void {
    this.giroAEliminar.set(null);
  }

  puedeEliminar(): boolean {
    return this.motivoBaja.trim().length >= 5;
  }

  async confirmarEliminar(): Promise<void> {
    const g = this.giroAEliminar();
    if (!g || !this.puedeEliminar()) return;
    this.eliminando.set(true);
    this.errorEliminar.set(null);
    try {
      await this.svc.eliminar(g.id, this.motivoBaja.trim());
      await this.svc.cargar();
      this.cerrarModalEliminar();
    } catch (e: unknown) {
      this.errorEliminar.set(e instanceof Error ? e.message : 'Error al dar de baja el giro');
    } finally {
      this.eliminando.set(false);
    }
  }
}
