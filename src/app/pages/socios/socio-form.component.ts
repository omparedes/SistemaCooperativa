import { Component, computed, effect, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { toSignal } from '@angular/core/rxjs-interop';
import { SociosService } from '../../core/services/socios.service';
import { PuestosService, PuestoDisponible, Giro } from '../../core/services/puestos.service';
import { EstadoSocio } from './socio.model';

// ---------------------------------------------------------------------------
// Validación
// ---------------------------------------------------------------------------
interface FormErrores {
  apellidos?: string;
  nombres?: string;
  dni?: string;
  email?: string;
  fecha_ingreso?: string;
}

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const DNI_RE   = /^\d{8}$/;

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-socio-form',
  standalone: true,
  imports: [NgClass, RouterModule],
  template: `
    <div class="mx-auto max-w-3xl p-4 md:p-6">

      <!-- Breadcrumb -->
      <a routerLink="/socios"
        class="inline-flex items-center text-sm text-brand-600 dark:text-brand-400 hover:underline mb-5">
        ← Volver al directorio
      </a>

      <!-- Título -->
      <div class="mb-6">
        <h2 class="text-2xl font-bold text-gray-800 dark:text-white">
          {{ editMode() ? 'Editar Socio' : 'Nuevo Socio' }}
        </h2>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          {{ editMode() ? 'Modifica los datos del padrón. Los cambios quedan registrados en la auditoría.' : 'Completa los datos para registrar un nuevo socio en el padrón.' }}
        </p>
      </div>

      <!-- Error global -->
      @if (errorGlobal()) {
        <div class="mb-5 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ errorGlobal() }}
        </div>
      }

      <!-- Skeleton de carga -->
      @if (cargando()) {
        <div class="rounded-2xl border border-gray-200 bg-white p-8 dark:border-gray-700 dark:bg-gray-800 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
          <span class="h-5 w-5 animate-spin rounded-full border-2 border-brand-600 border-t-transparent"></span>
          Cargando datos...
        </div>
      } @else {

        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-800">

          <!-- ─── Sección: Datos personales ────────────────────────────── -->
          <div class="border-b border-gray-100 px-6 py-4 dark:border-gray-700">
            <h3 class="text-sm font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
              Datos personales
            </h3>
          </div>

          <div class="grid grid-cols-1 gap-5 p-6 md:grid-cols-2">

            <!-- Apellidos -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Apellidos <span class="text-red-500">*</span>
              </label>
              <input type="text" [value]="apellidos()" (input)="apellidos.set(inp($event))"
                placeholder="Ej. García Quispe"
                [ngClass]="errores().apellidos ? 'border-red-400 focus:ring-red-500/20 focus:border-red-400' : 'border-gray-300 dark:border-gray-600 focus:border-brand-500 focus:ring-brand-500/20'"
                class="w-full rounded-xl border bg-white px-3.5 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
              @if (errores().apellidos) {
                <p class="mt-1 text-xs text-red-500">{{ errores().apellidos }}</p>
              }
            </div>

            <!-- Nombres -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Nombres <span class="text-red-500">*</span>
              </label>
              <input type="text" [value]="nombres()" (input)="nombres.set(inp($event))"
                placeholder="Ej. Juan Carlos"
                [ngClass]="errores().nombres ? 'border-red-400 focus:ring-red-500/20 focus:border-red-400' : 'border-gray-300 dark:border-gray-600 focus:border-brand-500 focus:ring-brand-500/20'"
                class="w-full rounded-xl border bg-white px-3.5 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
              @if (errores().nombres) {
                <p class="mt-1 text-xs text-red-500">{{ errores().nombres }}</p>
              }
            </div>

            <!-- DNI -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                DNI
              </label>
              <input type="text" [value]="dni()" (input)="dni.set(inp($event))"
                placeholder="12345678" maxlength="8"
                [ngClass]="errores().dni ? 'border-red-400 focus:ring-red-500/20 focus:border-red-400' : 'border-gray-300 dark:border-gray-600 focus:border-brand-500 focus:ring-brand-500/20'"
                class="w-full rounded-xl border bg-white px-3.5 py-2.5 font-mono text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
              @if (errores().dni) {
                <p class="mt-1 text-xs text-red-500">{{ errores().dni }}</p>
              }
            </div>

            <!-- Fecha de ingreso -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Fecha de ingreso
              </label>
              <input type="date" [value]="fechaIngreso()" (change)="fechaIngreso.set(inp($event))"
                [ngClass]="errores().fecha_ingreso ? 'border-red-400 focus:ring-red-500/20 focus:border-red-400' : 'border-gray-300 dark:border-gray-600 focus:border-brand-500 focus:ring-brand-500/20'"
                class="w-full rounded-xl border bg-white px-3.5 py-2.5 text-sm text-gray-900 focus:outline-none focus:ring-2 dark:bg-gray-700 dark:text-white" />
              @if (errores().fecha_ingreso) {
                <p class="mt-1 text-xs text-red-500">{{ errores().fecha_ingreso }}</p>
              }
            </div>

            <!-- Email -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Correo electrónico
              </label>
              <input type="email" [value]="email()" (input)="email.set(inp($event))"
                placeholder="juan@ejemplo.com"
                [ngClass]="errores().email ? 'border-red-400 focus:ring-red-500/20 focus:border-red-400' : 'border-gray-300 dark:border-gray-600 focus:border-brand-500 focus:ring-brand-500/20'"
                class="w-full rounded-xl border bg-white px-3.5 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
              @if (errores().email) {
                <p class="mt-1 text-xs text-red-500">{{ errores().email }}</p>
              }
            </div>

            <!-- Teléfono -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Teléfono
              </label>
              <input type="tel" [value]="telefono()" (input)="telefono.set(inp($event))"
                placeholder="999 888 777"
                class="w-full rounded-xl border border-gray-300 bg-white px-3.5 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
            </div>

            <!-- Dirección (full width) -->
            <div class="md:col-span-2">
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Dirección
              </label>
              <input type="text" [value]="direccion()" (input)="direccion.set(inp($event))"
                placeholder="Av. Principal 123, Trujillo"
                class="w-full rounded-xl border border-gray-300 bg-white px-3.5 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
            </div>

            <!-- Estado (full width) -->
            <div class="md:col-span-2">
              <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Estado
              </label>
              <div class="flex gap-4">
                <label class="flex cursor-pointer items-center gap-2">
                  <input type="radio" name="estado" value="Activo"
                    [checked]="estado() === 'Activo'"
                    (change)="estado.set('Activo')"
                    class="accent-brand-600" />
                  <span class="text-sm text-gray-700 dark:text-gray-300">Activo</span>
                </label>
                <label class="flex cursor-pointer items-center gap-2">
                  <input type="radio" name="estado" value="Inactivo"
                    [checked]="estado() === 'Inactivo'"
                    (change)="estado.set('Inactivo')"
                    class="accent-brand-600" />
                  <span class="text-sm text-gray-700 dark:text-gray-300">Inactivo</span>
                </label>
              </div>
            </div>
          </div>

          <!-- ─── Sección: Asignación de puesto ─────────────────────── -->
          <div class="border-t border-b border-gray-100 px-6 py-4 dark:border-gray-700">
            <h3 class="text-sm font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
              Asignación de puesto
            </h3>
          </div>

          <div class="p-6 space-y-4">

            @if (cargandoPuestos()) {
              <p class="text-sm text-gray-400 dark:text-gray-500">Cargando puestos disponibles...</p>
            } @else {
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Puesto asignado
                </label>
                <select (change)="puestoId.set(numOrNull($event))"
                  class="w-full rounded-xl border border-gray-300 bg-white px-3.5 py-2.5 text-sm text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white">
                  <option [value]="null" [selected]="puestoId() === null">Sin puesto asignado</option>
                  @for (p of puestos(); track p.id) {
                    <option [value]="p.id" [selected]="puestoId() === p.id">
                      {{ p.codigo_puesto }}{{ p.giro_nombre ? ' · ' + p.giro_nombre : '' }}
                    </option>
                  }
                </select>
              </div>

              @if (giroDelPuesto()) {
                <div class="flex items-center gap-2 text-sm">
                  <span class="text-gray-400 dark:text-gray-500">Giro del puesto:</span>
                  <span class="inline-flex items-center rounded-lg bg-brand-50 px-2.5 py-0.5 text-xs font-semibold text-brand-700 dark:bg-brand-900/30 dark:text-brand-300">
                    {{ giroDelPuesto() }}
                  </span>
                </div>
              }

              @if (editMode() && puestoIdCambio()) {
                <div class="rounded-xl border border-amber-200 bg-amber-50 px-3.5 py-3 text-xs text-amber-800 dark:border-amber-800 dark:bg-amber-900/20 dark:text-amber-300">
                  <strong>Cambio de puesto detectado.</strong> Se cerrará la titularidad anterior
                  y se creará una nueva a partir de hoy.
                </div>
              }
            }
          </div>

          <!-- ─── Botones ─────────────────────────────────────────────── -->
          <div class="flex items-center justify-end gap-3 border-t border-gray-100 px-6 py-4 dark:border-gray-700">
            <button type="button" routerLink="/socios"
              [disabled]="guardando()"
              class="rounded-xl border border-gray-300 px-5 py-2.5 text-sm font-medium text-gray-700 transition hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
              Cancelar
            </button>
            <button type="button" (click)="guardar()"
              [disabled]="!formularioValido() || guardando()"
              class="rounded-xl bg-brand-600 px-5 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-brand-700 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-brand-500 dark:hover:bg-brand-600">
              @if (guardando()) {
                <span class="inline-flex items-center gap-2">
                  <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Guardando...
                </span>
              } @else {
                {{ editMode() ? 'Guardar cambios' : 'Crear socio' }}
              }
            </button>
          </div>
        </div>
      }
    </div>
  `,
})
export class SocioFormComponent implements OnInit {
  private readonly route      = inject(ActivatedRoute);
  private readonly router     = inject(Router);
  private readonly sociosSvc  = inject(SociosService);
  private readonly puestosSvc = inject(PuestosService);

  private readonly idParam = toSignal(this.route.paramMap, { initialValue: null });

  readonly editId = computed<number | null>(() => {
    const p = this.idParam();
    if (!p) return null;
    const n = Number(p.get('id'));
    return Number.isFinite(n) && n > 0 ? n : null;
  });

  readonly editMode = computed(() => this.editId() !== null);

  // ── Campos del formulario ──────────────────────────────────────────────────
  readonly apellidos    = signal('');
  readonly nombres      = signal('');
  readonly dni          = signal('');
  readonly email        = signal('');
  readonly telefono     = signal('');
  readonly fechaIngreso = signal('');
  readonly direccion    = signal('');
  readonly estado       = signal<EstadoSocio>('Activo');
  readonly puestoId     = signal<number | null>(null);

  // Puesto original al entrar en modo edición (para detectar cambio)
  private puestoIdInicial: number | null = null;

  // ── Estado de la UI ────────────────────────────────────────────────────────
  readonly cargando        = signal(false);
  readonly cargandoPuestos = signal(false);
  readonly guardando       = signal(false);
  readonly errorGlobal     = signal<string | null>(null);
  readonly puestos         = signal<PuestoDisponible[]>([]);
  readonly giros           = signal<Giro[]>([]);

  // ── Computed ───────────────────────────────────────────────────────────────
  readonly giroDelPuesto = computed(() => {
    const id = this.puestoId();
    if (!id) return null;
    return this.puestos().find(p => p.id === id)?.giro_nombre ?? null;
  });

  readonly puestoIdCambio = computed(
    () => this.puestoId() !== this.puestoIdInicial,
  );

  readonly errores = computed<FormErrores>(() => {
    const e: FormErrores = {};
    if (!this.apellidos().trim()) e.apellidos = 'Los apellidos son obligatorios.';
    if (!this.nombres().trim())   e.nombres   = 'Los nombres son obligatorios.';
    const d = this.dni().trim();
    if (d && !DNI_RE.test(d))     e.dni = 'El DNI debe tener 8 dígitos numéricos.';
    const em = this.email().trim();
    if (em && !EMAIL_RE.test(em)) e.email = 'Formato de correo inválido.';
    return e;
  });

  readonly formularioValido = computed(() => Object.keys(this.errores()).length === 0);

  constructor() {
    effect(() => {
      const id = this.editId();
      if (id !== null) void this.cargarParaEdicion(id);
    });
  }

  ngOnInit(): void {
    void this.cargarPuestos();
  }

  // ── Carga inicial ──────────────────────────────────────────────────────────
  private async cargarPuestos(excluirSocioId?: number): Promise<void> {
    this.cargandoPuestos.set(true);
    try {
      this.puestos.set(await this.puestosSvc.getPuestosParaSocios(excluirSocioId));
    } catch (e: unknown) {
      this.errorGlobal.set(e instanceof Error ? e.message : 'Error al cargar puestos');
    } finally {
      this.cargandoPuestos.set(false);
    }
  }

  private async cargarParaEdicion(id: number): Promise<void> {
    this.cargando.set(true);
    this.errorGlobal.set(null);
    try {
      const [socio] = await Promise.all([
        this.sociosSvc.cargarDetalle(id),
        this.cargarPuestos(id),
      ]);
      this.apellidos.set(socio.apellidos);
      this.nombres.set(socio.nombres);
      this.dni.set(socio.dni);
      this.email.set(socio.email ?? '');
      this.telefono.set(socio.telefono ?? '');
      this.fechaIngreso.set(socio.fecha_ingreso);
      this.direccion.set(socio.direccion ?? '');
      this.estado.set(socio.estado);
      const pv = socio.puesto_vigente;
      if (pv) {
        this.puestoId.set(pv.id);
        this.puestoIdInicial = pv.id;
      }
    } catch (e: unknown) {
      this.errorGlobal.set(e instanceof Error ? e.message : 'Error al cargar el socio');
    } finally {
      this.cargando.set(false);
    }
  }

  // ── Guardar ────────────────────────────────────────────────────────────────
  async guardar(): Promise<void> {
    if (!this.formularioValido() || this.guardando()) return;

    this.guardando.set(true);
    this.errorGlobal.set(null);
    try {
      const generatedDni = this.dni().trim() || ('TEMP_' + Math.floor(10000000 + Math.random() * 90000000).toString());
      const generatedFecha = this.fechaIngreso() || new Date().toISOString().split('T')[0];

      const params = {
        apellidos:     this.apellidos().trim(),
        nombres:       this.nombres().trim(),
        dni:           generatedDni,
        email:         this.email().trim() || null,
        telefono:      this.telefono().trim() || null,
        direccion:     this.direccion().trim() || null,
        fecha_ingreso: generatedFecha,
        estado:        this.estado(),
      };

      let socioId: number;

      if (this.editMode()) {
        socioId = this.editId()!;
        await this.sociosSvc.actualizar(socioId, params);
      } else {
        socioId = await this.sociosSvc.crear(params);
      }

      // Gestionar cambio de puesto
      if (this.puestoIdCambio()) {
        await this.sociosSvc.gestionarTitularidad(
          socioId,
          this.puestoId(),
          this.puestoIdInicial,
        );
      }

      void this.router.navigate(['/socios', socioId]);
    } catch (e: unknown) {
      this.errorGlobal.set(e instanceof Error ? e.message : 'Error al guardar el socio');
    } finally {
      this.guardando.set(false);
    }
  }

  // ── Helpers de template ────────────────────────────────────────────────────
  inp(ev: Event): string {
    return (ev.target as HTMLInputElement).value;
  }

  numOrNull(ev: Event): number | null {
    const v = (ev.target as HTMLSelectElement).value;
    const n = Number(v);
    return v === '' || v === 'null' || !Number.isFinite(n) ? null : n;
  }
}
