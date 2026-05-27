import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass, DecimalPipe } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { toSignal } from '@angular/core/rxjs-interop';
import { GirosService, Giro, PuestoDeGiro } from '../../core/services/giros.service';
import { PuestosService } from '../../core/services/puestos.service';
import { AuthService } from '../../core/services/auth.service';
import { FormsModule } from '@angular/forms';
import { SUPABASE_CLIENT } from '../../core/services/supabase.client';

interface PuestoDisponibleMin {
  id: number;
  codigo_puesto: string;
  tipo_espacio: string;
}

@Component({
  selector: 'app-giro-detail',
  standalone: true,
  imports: [NgClass, DecimalPipe, RouterModule, FormsModule],
  template: `
    <div class="p-6 max-w-7xl mx-auto">
      <!-- Breadcrumb -->
      <a routerLink="/giros"
        class="inline-flex items-center text-sm text-brand-600 dark:text-brand-400 hover:underline mb-4">
        ← Volver a Giros Comerciales
      </a>

      @let g = giro();

      @if (loadingGiro()) {
        <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
          <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
          Cargando detalle del giro...
        </div>
      } @else if (errorGiro()) {
        <div class="p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
          <strong>Error:</strong> {{ errorGiro() }}
        </div>
      } @else if (g) {
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
          
          <!-- Column 1: Info Card -->
          <aside class="lg:col-span-1 space-y-6">
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-sm p-6">
              <div class="flex items-center justify-between gap-2 mb-4">
                <span class="text-xs font-bold uppercase tracking-wider text-gray-400 dark:text-gray-500">Detalle del Giro</span>
                <span [ngClass]="g.activo 
                  ? 'bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300' 
                  : 'bg-red-50 dark:bg-red-900/30 text-red-700 dark:text-red-300'"
                  class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium">
                  {{ g.activo ? 'Activo' : 'Inactivo' }}
                </span>
              </div>

              <h2 class="text-xl font-bold text-gray-900 dark:text-white capitalize mb-4">
                {{ g.nombre }}
              </h2>

              <dl class="space-y-4 text-sm border-t border-gray-100 dark:border-gray-700/60 pt-4">
                <div>
                  <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">Tarifa Agua Base</dt>
                  <dd class="text-base font-semibold text-gray-900 dark:text-white mt-0.5">S/ {{ g.tarifa_agua_base | number:'1.2-2' }}</dd>
                </div>
                <div>
                  <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">Tarifa Luz Base</dt>
                  <dd class="text-base font-semibold text-gray-900 dark:text-white mt-0.5">S/ {{ g.tarifa_luz_base | number:'1.2-2' }}</dd>
                </div>
                <div>
                  <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">Puestos Asignados</dt>
                  <dd class="text-base font-semibold text-gray-900 dark:text-white mt-0.5">{{ puestos().length }} Puesto(s)</dd>
                </div>
              </dl>

              @if (authSvc.esAdmin()) {
                <button (click)="abrirAsignacion()"
                  class="mt-6 w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-brand-600 hover:bg-brand-700 text-white rounded-lg font-medium shadow-sm transition">
                  🏪 Asignar Puesto a Giro
                </button>
              }
            </div>
          </aside>

          <!-- Column 2 & 3: Puestos Table -->
          <section class="lg:col-span-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-sm overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between">
              <h3 class="font-bold text-gray-900 dark:text-white">Puestos Asociados</h3>
              <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                {{ puestos().length }} puesto(s)
              </span>
            </div>

            @if (loadingPuestos()) {
              <div class="py-12 flex items-center justify-center gap-3 text-gray-400 dark:text-gray-500">
                <span class="inline-block h-4 w-4 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
                Cargando relación de puestos...
              </div>
            } @else if (puestos().length === 0) {
              <div class="py-16 text-center text-gray-500 dark:text-gray-400">
                <p class="font-medium text-gray-700 dark:text-gray-300">Sin puestos asociados</p>
                <p class="text-sm mt-1">Este giro no tiene puestos asignados actualmente.</p>
              </div>
            } @else {
              <div class="overflow-x-auto">
                <table class="w-full text-sm">
                  <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs">
                    <tr>
                      <th class="px-4 py-3 text-left font-medium">Puesto</th>
                      <th class="px-4 py-3 text-left font-medium">Tipo</th>
                      <th class="px-4 py-3 text-left font-medium">Ocupante / Responsable</th>
                      <th class="px-4 py-3 text-right font-medium">Área</th>
                      <th class="px-4 py-3 text-center font-medium">Servicios</th>
                      @if (authSvc.esAdmin()) {
                        <th class="px-4 py-3 text-right font-medium">Acciones</th>
                      }
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                    @for (p of puestos(); track p.id) {
                      <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition">
                        <!-- Código -->
                        <td class="px-4 py-3 font-semibold text-gray-900 dark:text-white">
                          <span class="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-semibold bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300">
                            {{ p.codigo_puesto }}
                          </span>
                        </td>
                        <!-- Tipo -->
                        <td class="px-4 py-3 text-gray-600 dark:text-gray-400 text-xs">
                          {{ p.tipo_espacio }}
                        </td>
                        <!-- Ocupante -->
                        <td class="px-4 py-3 text-gray-800 dark:text-gray-200">
                          @if (p.titular_apellidos) {
                            <div class="text-sm font-medium">
                              {{ p.titular_apellidos }} {{ p.titular_nombres }}
                            </div>
                            <div class="text-[10px] text-brand-600 dark:text-brand-400 font-semibold tracking-wide uppercase">Socio Titular</div>
                          } @else if (p.inquilino_apellidos) {
                            <div class="text-sm font-medium">
                              {{ p.inquilino_apellidos }} {{ p.inquilino_nombres }}
                            </div>
                            <div class="text-[10px] text-amber-600 dark:text-amber-400 font-semibold tracking-wide uppercase">Inquilino / Tercero</div>
                          } @else {
                            <span class="text-xs text-gray-400 italic">Desocupado</span>
                          }
                        </td>
                        <!-- Área -->
                        <td class="px-4 py-3 text-right tabular-nums text-gray-700 dark:text-gray-300">
                          {{ p.area_m2 ? (p.area_m2 + ' m²') : '—' }}
                        </td>
                        <!-- Servicios -->
                        <td class="px-4 py-3">
                          <div class="flex items-center justify-center gap-2">
                            <!-- Luz -->
                            <span [ngClass]="p.cobro_luz_activo 
                              ? 'bg-yellow-50 dark:bg-yellow-900/20 text-yellow-700 dark:text-yellow-400' 
                              : 'bg-gray-100 dark:bg-gray-700 text-gray-400 dark:text-gray-500'"
                              class="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-bold"
                              [title]="p.cobro_luz_activo ? 'Cobro de luz activo' : 'Cobro de luz inactivo'">
                              Luz
                            </span>
                            <!-- Agua -->
                            <span [ngClass]="p.cobro_agua_activo 
                              ? 'bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-400' 
                              : 'bg-gray-100 dark:bg-gray-700 text-gray-400 dark:text-gray-500'"
                              class="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-bold"
                              [title]="p.cobro_agua_activo ? 'Cobro de agua activo' : 'Cobro de agua inactivo'">
                              Agua
                            </span>
                          </div>
                        </td>
                        <!-- Acciones -->
                        @if (authSvc.esAdmin()) {
                          <td class="px-4 py-3 text-right">
                            <button (click)="desasignarPuesto(p)"
                              class="inline-flex items-center gap-1.5 px-2.5 py-1 text-xs font-semibold text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded transition">
                              Desasignar
                            </button>
                          </td>
                        }
                      </tr>
                    }
                  </tbody>
                </table>
              </div>
            }
          </section>
        </div>
      }
    </div>

    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    <!-- DIALOGO ASIGNAR PUESTO                                                  -->
    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    @if (modalAsignarAbierto()) {
      <div class="fixed inset-0 bg-black/40 dark:bg-black/60 z-50 flex items-center justify-center p-4">
        <div class="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md border border-gray-200 dark:border-gray-700 overflow-hidden">
          
          <div class="px-6 py-5 border-b border-gray-200 dark:border-gray-700">
            <h3 class="text-lg font-bold text-gray-900 dark:text-white">Asignar Puesto a Giro</h3>
            <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
              Asociar un puesto comercial al giro <span class="font-semibold text-gray-700 dark:text-gray-300 capitalize">"{{ g?.nombre }}"</span>.
            </p>
          </div>

          <div class="px-6 py-5 space-y-4">
            @if (errorAsignar()) {
              <div class="p-3 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-300 text-sm">
                {{ errorAsignar() }}
              </div>
            }

            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                Seleccione el puesto comercial *
              </label>
              @if (cargandoPuestosDisponibles()) {
                <div class="text-sm text-gray-400 dark:text-gray-500 py-2">Cargando puestos disponibles...</div>
              } @else {
                <select [(ngModel)]="puestoIdAAsignar"
                  class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                  <option [ngValue]="null">— Seleccionar Puesto —</option>
                  @for (p of puestosDisponibles(); track p.id) {
                    <option [ngValue]="p.id">{{ p.codigo_puesto }} ({{ p.tipo_espacio }})</option>
                  }
                </select>
              }
            </div>
          </div>

          <div class="px-6 py-4 border-t border-gray-200 dark:border-gray-700 flex gap-3 justify-end bg-gray-50 dark:bg-gray-900/40">
            <button (click)="cerrarAsignacion()"
              class="px-4 py-2 rounded-xl border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-800 transition">
              Cancelar
            </button>
            <button (click)="confirmarAsignacion()" [disabled]="puestoIdAAsignar === null || asignando()"
              class="px-4 py-2 rounded-xl bg-brand-600 hover:bg-brand-700 text-white text-sm font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition">
              @if (asignando()) {
                <span class="inline-flex items-center gap-2">
                  <span class="h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent"></span>
                  Asignando…
                </span>
              } @else {
                Confirmar Asignación
              }
            </button>
          </div>

        </div>
      </div>
    }
  `,
})
export class GiroDetailComponent implements OnInit {
  private readonly route    = inject(ActivatedRoute);
  private readonly router   = inject(Router);
  protected readonly svc    = inject(GirosService);
  protected readonly authSvc = inject(AuthService);
  private readonly db       = inject(SUPABASE_CLIENT);

  readonly giro        = signal<Giro | null>(null);
  readonly loadingGiro = signal(false);
  readonly errorGiro   = signal<string | null>(null);

  readonly puestos        = signal<PuestoDeGiro[]>([]);
  readonly loadingPuestos = signal(false);

  // Asignación Modal
  readonly modalAsignarAbierto           = signal(false);
  readonly puestosDisponibles            = signal<PuestoDisponibleMin[]>([]);
  readonly cargandoPuestosDisponibles    = signal(false);
  readonly asignando                     = signal(false);
  readonly errorAsignar                  = signal<string | null>(null);
  puestoIdAAsignar: number | null = null;

  private readonly idParam = toSignal(this.route.paramMap, { initialValue: null });

  readonly giroId = computed<number | null>(() => {
    const p = this.idParam();
    if (!p) return null;
    const n = Number(p.get('id'));
    return Number.isFinite(n) ? n : null;
  });

  ngOnInit(): void {
    const p = this.idParam();
    if (p) {
      const id = Number(p.get('id'));
      if (Number.isFinite(id)) {
        void this.cargarGiro(id);
      }
    }
  }

  async cargarGiro(id: number): Promise<void> {
    this.loadingGiro.set(true);
    this.errorGiro.set(null);
    this.loadingPuestos.set(true);
    try {
      // 1. Cargar Giro
      const { data: gData, error: gError } = await this.db
        .from('giros')
        .select('id, nombre, tarifa_agua_base, tarifa_luz_base, activo')
        .eq('id', id)
        .is('deleted_at', null)
        .single();
      if (gError) throw new Error(gError.message);
      this.giro.set(gData as Giro);

      // 2. Cargar puestos
      const pts = await this.svc.getPuestosPorGiro(id);
      this.puestos.set(pts);
    } catch (e: unknown) {
      this.errorGiro.set(e instanceof Error ? e.message : 'Error al cargar el giro comercial');
    } finally {
      this.loadingGiro.set(false);
      this.loadingPuestos.set(false);
    }
  }

  abrirAsignacion(): void {
    this.puestoIdAAsignar = null;
    this.errorAsignar.set(null);
    this.modalAsignarAbierto.set(true);
    void this.cargarPuestosDisponibles();
  }

  cerrarAsignacion(): void {
    this.modalAsignarAbierto.set(false);
  }

  async cargarPuestosDisponibles(): Promise<void> {
    this.cargandoPuestosDisponibles.set(true);
    try {
      // Puestos activos de cualquier tipo comerciales que no tengan este giro ya asignado
      const gId = this.giroId();
      let query = this.db
        .from('puestos')
        .select('id, codigo_puesto, tipo_espacio')
        .eq('estado', 'Activo')
        .is('deleted_at', null);

      if (gId !== null) {
        query = query.or(`giro_id.is.null,giro_id.neq.${gId}`);
      }

      const { data, error } = await query.order('codigo_puesto');
      if (error) throw new Error(error.message);
      this.puestosDisponibles.set(data as PuestoDisponibleMin[]);
    } catch (e: unknown) {
      this.errorAsignar.set(e instanceof Error ? e.message : 'Error al cargar puestos disponibles');
    } finally {
      this.cargandoPuestosDisponibles.set(false);
    }
  }

  async confirmarAsignacion(): Promise<void> {
    const pId = this.puestoIdAAsignar;
    const gId = this.giroId();
    if (pId === null || gId === null) return;
    this.asignando.set(true);
    this.errorAsignar.set(null);
    try {
      await this.svc.asignarPuestoAGiro(pId, gId);
      await this.cargarGiro(gId);
      this.cerrarAsignacion();
    } catch (e: unknown) {
      this.errorAsignar.set(e instanceof Error ? e.message : 'Error al asignar puesto');
    } finally {
      this.asignando.set(false);
    }
  }

  async desasignarPuesto(p: PuestoDeGiro): Promise<void> {
    const gId = this.giroId();
    if (!gId || !confirm(`¿Está seguro de quitar el giro a este puesto "${p.codigo_puesto}"?`)) return;
    try {
      await this.svc.asignarPuestoAGiro(p.id, null);
      await this.cargarGiro(gId);
    } catch (e: unknown) {
      alert(e instanceof Error ? e.message : 'Error al desasignar puesto');
    }
  }
}
