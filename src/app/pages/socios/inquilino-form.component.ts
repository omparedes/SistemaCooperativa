import { Component, computed, effect, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { toSignal } from '@angular/core/rxjs-interop';
import { InquilinosService } from '../../core/services/inquilinos.service';
import { PuestosService, PuestoDisponible } from '../../core/services/puestos.service';

// ---------------------------------------------------------------------------
// Validación
// ---------------------------------------------------------------------------
interface FormErrores {
  apellidos?: string;
  nombres?: string;
  dni?: string;
  email?: string;
  monto_arriendo?: string;
}

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const DNI_RE   = /^\d{8}$/;

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-inquilino-form',
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
          {{ editMode() ? 'Editar Inquilino' : 'Nuevo Inquilino' }}
        </h2>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          {{ editMode()
            ? 'Modifica los datos del inquilino en el padrón.'
            : 'Registra un nuevo posesionario en el padrón de inquilinos.' }}
        </p>
      </div>

      <!-- Error global -->
      @if (errorGlobal()) {
        <div class="mb-5 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ errorGlobal() }}
        </div>
      }

      @if (cargando()) {
        <div class="rounded-2xl border border-gray-200 bg-white p-8 dark:border-gray-700 dark:bg-gray-800 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
          <span class="h-5 w-5 animate-spin rounded-full border-2 border-brand-600 border-t-transparent"></span>
          Cargando datos...
        </div>
      } @else {

        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-800">

          <!-- ─── Datos personales ──────────────────────────────────────── -->
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
                placeholder="Ej. María Elena"
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

            <!-- Email -->
            <div>
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Correo electrónico
              </label>
              <input type="email" [value]="email()" (input)="email.set(inp($event))"
                placeholder="nombre@ejemplo.com"
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

            <!-- Dirección -->
            <div class="md:col-span-2">
              <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Dirección
              </label>
              <input type="text" [value]="direccion()" (input)="direccion.set(inp($event))"
                placeholder="Av. Principal 123, Trujillo"
                class="w-full rounded-xl border border-gray-300 bg-white px-3.5 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
            </div>
          </div>

          <!-- ─── Arriendo ───────────────────────────────────────────────── -->
          <div class="border-t border-b border-gray-100 px-6 py-4 dark:border-gray-700">
            <h3 class="text-sm font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
              Arriendo de puesto
            </h3>
          </div>

          <div class="p-6 space-y-4">

            @if (cargandoPuestos()) {
              <p class="text-sm text-gray-400 dark:text-gray-500">Cargando puestos disponibles...</p>
            } @else {

              <!-- Puesto -->
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Puesto arrendado
                </label>
                <select (change)="onPuestoChange($event)"
                  class="w-full rounded-xl border border-gray-300 bg-white px-3.5 py-2.5 text-sm text-gray-900 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white">
                  <option [value]="null" [selected]="puestoId() === null">Sin puesto asignado</option>
                  @for (p of puestos(); track p.id) {
                    <option [value]="p.id" [selected]="puestoId() === p.id">
                      {{ p.codigo_puesto }}{{ p.giro_nombre ? ' · ' + p.giro_nombre : '' }}
                    </option>
                  }
                </select>
              </div>

              <!-- Monto de arriendo (visible solo si hay puesto seleccionado) -->
              @if (puestoId() !== null) {
                <div>
                  <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                    Monto de arriendo (S/mes) <span class="text-red-500">*</span>
                  </label>
                  <div class="relative">
                    <span class="absolute left-3.5 top-1/2 -translate-y-1/2 text-sm font-semibold text-gray-400 dark:text-gray-500 select-none">
                      S/
                    </span>
                    <input type="number" [value]="montoArriendo()" (input)="montoArriendo.set(inp($event))"
                      min="0.01" step="0.50" placeholder="0.00"
                      [ngClass]="errores().monto_arriendo ? 'border-red-400 focus:ring-red-500/20 focus:border-red-400' : 'border-gray-300 dark:border-gray-600 focus:border-brand-500 focus:ring-brand-500/20'"
                      class="w-full rounded-xl border bg-white pl-9 pr-3.5 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500" />
                  </div>
                  @if (errores().monto_arriendo) {
                    <p class="mt-1 text-xs text-red-500">{{ errores().monto_arriendo }}</p>
                  }
                </div>

                <!-- Titular del puesto (informativo) -->
                @if (titularDePuesto()) {
                  <div class="rounded-xl border border-blue-200 bg-blue-50 px-3.5 py-3 text-xs text-blue-700 dark:border-blue-800 dark:bg-blue-900/20 dark:text-blue-300">
                    Titular del puesto: <strong>{{ titularDePuesto() }}</strong>.
                    El arriendo quedará registrado bajo este socio.
                  </div>
                }
              }

              @if (editMode() && puestoIdCambio()) {
                <div class="rounded-xl border border-amber-200 bg-amber-50 px-3.5 py-3 text-xs text-amber-800 dark:border-amber-800 dark:bg-amber-900/20 dark:text-amber-300">
                  <strong>Cambio de puesto detectado.</strong> Se cerrará el arriendo anterior
                  y se creará uno nuevo a partir de hoy.
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
                {{ editMode() ? 'Guardar cambios' : 'Crear inquilino' }}
              }
            </button>
          </div>
        </div>
      }
    </div>
  `,
})
export class InquilinoFormComponent implements OnInit {
  private readonly route         = inject(ActivatedRoute);
  private readonly router        = inject(Router);
  private readonly inquilinosSvc = inject(InquilinosService);
  private readonly puestosSvc    = inject(PuestosService);

  private readonly idParam = toSignal(this.route.paramMap, { initialValue: null });

  readonly editId = computed<number | null>(() => {
    const p = this.idParam();
    if (!p) return null;
    const n = Number(p.get('id'));
    return Number.isFinite(n) && n > 0 ? n : null;
  });

  readonly editMode = computed(() => this.editId() !== null);

  // ── Campos ─────────────────────────────────────────────────────────────────
  readonly apellidos    = signal('');
  readonly nombres      = signal('');
  readonly dni          = signal('');
  readonly email        = signal('');
  readonly telefono     = signal('');
  readonly direccion    = signal('');
  readonly puestoId     = signal<number | null>(null);
  readonly montoArriendo = signal('');

  private puestoIdInicial: number | null = null;

  // ── Estado UI ──────────────────────────────────────────────────────────────
  readonly cargando        = signal(false);
  readonly cargandoPuestos = signal(false);
  readonly guardando       = signal(false);
  readonly errorGlobal     = signal<string | null>(null);
  readonly puestos         = signal<PuestoDisponible[]>([]);

  // ── Computed ───────────────────────────────────────────────────────────────
  readonly titularDePuesto = computed(() => {
    const id = this.puestoId();
    if (!id) return null;
    const p = this.puestos().find(x => x.id === id);
    return p?.socio_titular_id ? `socio id ${p.socio_titular_id}` : 'Cooperativa';
  });

  readonly puestoIdCambio = computed(
    () => this.puestoId() !== this.puestoIdInicial,
  );

  readonly errores = computed<FormErrores>(() => {
    const e: FormErrores = {};
    if (!this.apellidos().trim()) e.apellidos = 'Los apellidos son obligatorios.';
    if (!this.nombres().trim())   e.nombres   = 'Los nombres son obligatorios.';
    const d = this.dni().trim();
    if (d && !DNI_RE.test(d)) e.dni = 'El DNI debe tener 8 dígitos numéricos.';
    const em = this.email().trim();
    if (em && !EMAIL_RE.test(em)) e.email = 'Formato de correo inválido.';
    if (this.puestoId() !== null) {
      const m = Number(this.montoArriendo());
      if (!this.montoArriendo() || !Number.isFinite(m) || m <= 0) {
        e.monto_arriendo = 'Ingresa el monto de arriendo (mayor a 0).';
      }
    }
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
  private async cargarPuestos(excluirInquilinoId?: number): Promise<void> {
    this.cargandoPuestos.set(true);
    try {
      this.puestos.set(await this.puestosSvc.getPuestosParaInquilinos(excluirInquilinoId));
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
      const [inquilino] = await Promise.all([
        this.inquilinosSvc.cargarDetalle(id),
        this.cargarPuestos(id),
      ]);
      this.apellidos.set(inquilino.apellidos);
      this.nombres.set(inquilino.nombres);
      this.dni.set(inquilino.dni);
      this.email.set(inquilino.email ?? '');
      this.telefono.set(inquilino.telefono ?? '');
      this.direccion.set(inquilino.direccion ?? '');
      const av = inquilino.arriendo_vigente;
      if (av) {
        this.puestoId.set(av.puesto.id);
        this.puestoIdInicial = av.puesto.id;
        this.montoArriendo.set(av.monto_arriendo !== null ? String(av.monto_arriendo) : '');
      }
    } catch (e: unknown) {
      this.errorGlobal.set(e instanceof Error ? e.message : 'Error al cargar el inquilino');
    } finally {
      this.cargando.set(false);
    }
  }

  // ── Interacción ────────────────────────────────────────────────────────────
  onPuestoChange(ev: Event): void {
    const v = (ev.target as HTMLSelectElement).value;
    const n = Number(v);
    const newId = (v === '' || v === 'null' || !Number.isFinite(n)) ? null : n;
    this.puestoId.set(newId);
    if (newId === null) this.montoArriendo.set('');
  }

  // ── Guardar ────────────────────────────────────────────────────────────────
  async guardar(): Promise<void> {
    if (!this.formularioValido() || this.guardando()) return;

    this.guardando.set(true);
    this.errorGlobal.set(null);
    try {
      const generatedDni = this.dni().trim() || ('TEMP_' + Math.floor(10000000 + Math.random() * 90000000).toString());
      const params = {
        apellidos: this.apellidos().trim(),
        nombres:   this.nombres().trim(),
        dni:       generatedDni,
        email:     this.email().trim() || null,
        telefono:  this.telefono().trim() || null,
        direccion: this.direccion().trim() || null,
      };

      let inquilinoId: number;

      if (this.editMode()) {
        inquilinoId = this.editId()!;
        await this.inquilinosSvc.actualizar(inquilinoId, params);
      } else {
        inquilinoId = await this.inquilinosSvc.crear(params);
      }

      // Gestionar cambio de puesto/arriendo
      if (this.puestoIdCambio()) {
        const nuevoPuesto = this.puestos().find(p => p.id === this.puestoId()) ?? null;
        const socioTitularId = nuevoPuesto?.socio_titular_id ?? null;
        const monto = this.puestoId() !== null ? Number(this.montoArriendo()) : null;

        await this.inquilinosSvc.gestionarArriendo(
          inquilinoId,
          this.puestoId(),
          monto,
          this.puestoIdInicial,
          socioTitularId,
        );
      }

      void this.router.navigate(['/inquilinos', inquilinoId]);
    } catch (e: unknown) {
      this.errorGlobal.set(e instanceof Error ? e.message : 'Error al guardar el inquilino');
    } finally {
      this.guardando.set(false);
    }
  }

  inp(ev: Event): string {
    return (ev.target as HTMLInputElement).value;
  }
}
