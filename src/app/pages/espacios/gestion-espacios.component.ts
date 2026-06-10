import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';
import { EspaciosService } from './espacios.service';
import { EspacioOcupacion, esEspacioPrincipal } from './espacios.model';
import { EspacioTableComponent, ToggleServicioEvent } from './components/espacio-table.component';
import { EspacioDrawerComponent } from './components/espacio-drawer.component';
import { TransferirPuestoDialogComponent } from './components/transferir-puesto-dialog.component';
import { AsignarAlmacenDialogComponent } from './components/asignar-almacen-dialog.component';

type FiltroTipo = 'todos' | 'Regular' | 'Pequeño' | 'Almacen';

@Component({
  selector: 'app-gestion-espacios',
  standalone: true,
  imports: [
    FormsModule,
    EspacioTableComponent,
    EspacioDrawerComponent,
    TransferirPuestoDialogComponent,
    AsignarAlmacenDialogComponent,
  ],
  template: `
<div class="p-6 max-w-7xl mx-auto">

  <!-- Cabecera -->
  <header class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
    <div>
      <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Gestión de Espacios</h2>
      <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
        Padrón físico del mercado — Puestos comerciales y Almacenes con control de servicios.
      </p>
    </div>
    <!-- Contadores resumen -->
    <div class="flex gap-3 text-sm shrink-0">
      <span class="inline-flex items-center gap-1.5 rounded-lg bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 px-3 py-1.5 text-blue-700 dark:text-blue-300 font-medium">
        {{ totalPrincipales() }} Comerciales
      </span>
      <span class="inline-flex items-center gap-1.5 rounded-lg bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 px-3 py-1.5 text-amber-700 dark:text-amber-300 font-medium">
        {{ totalAlmacenes() }} Almacenes
      </span>
    </div>
  </header>

  <!-- Filtros -->
  <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-4 mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
    <input
      type="text"
      [(ngModel)]="busqueda"
      (ngModelChange)="onBusquedaChange($event)"
      placeholder="Buscar por código, ocupante, giro..."
      class="flex-1 border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500"
    />
    <div class="flex rounded-lg border border-gray-200 dark:border-gray-700 overflow-hidden shrink-0">
      @for (op of opcionesFiltro; track op.valor) {
        <button
          (click)="filtroTipo.set(op.valor)"
          [class.bg-brand-600]="filtroTipo() === op.valor"
          [class.text-white]="filtroTipo() === op.valor"
          [class.dark:bg-brand-500]="filtroTipo() === op.valor"
          [class.bg-white]="filtroTipo() !== op.valor"
          [class.dark:bg-gray-800]="filtroTipo() !== op.valor"
          [class.text-gray-600]="filtroTipo() !== op.valor"
          [class.dark:text-gray-300]="filtroTipo() !== op.valor"
          class="px-3 py-2 text-xs font-medium transition hover:bg-gray-50 dark:hover:bg-gray-700">
          {{ op.label }}
        </button>
      }
    </div>
  </div>

  <!-- Avisos -->
  @if (svc.error()) {
    <div class="mb-4 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
      <strong>Error:</strong> {{ svc.error() }}
    </div>
  }
  @if (errorLocal()) {
    <div class="mb-4 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
      <strong>Error:</strong> {{ errorLocal() }}
    </div>
  }
  @if (avisoDeudas()) {
    <div class="mb-4 p-4 rounded-lg bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-700 text-yellow-800 dark:text-yellow-300 text-sm">
      <strong>Atención:</strong> El puesto transferido tiene deudas pendientes. Las deudas siguen asociadas al puesto.
      <button (click)="avisoDeudas.set(false)" class="ml-3 text-xs underline">Cerrar</button>
    </div>
  }
  @if (!authSvc.esAdmin()) {
    <div class="mb-4 p-3 rounded-lg bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-700 text-yellow-700 dark:text-yellow-300 text-xs">
      Los controles de Luz y Agua son de solo lectura. Solo un Administrador puede modificarlos.
    </div>
  }

  <!-- Tabla (dumb) -->
  <app-espacio-table
    [espacios]="espaciosFiltrados()"
    [seleccionadoId]="seleccionado()?.puesto_id ?? null"
    [cargando]="svc.loading()"
    [esAdmin]="authSvc.esAdmin()"
    [toggling]="toggling()"
    [sortCol]="sortCol()"
    [sortAsc]="sortAsc()"
    (seleccionar)="onSeleccionar($event)"
    (toggleServicio)="onToggleServicio($event)"
    (sortChange)="onSortChange($event)"
  />

</div>

<!-- Drawer (dumb) — fuera del flujo principal -->
@if (seleccionado()) {
  <app-espacio-drawer
    [espacio]="seleccionado()!"
    [esAdmin]="authSvc.esAdmin()"
    [toggling]="toggling()"
    (cerrar)="seleccionado.set(null)"
    (toggleLuz)="onToggleServicio({ espacio: $event, servicio: 'luz' })"
    (toggleAgua)="onToggleServicio({ espacio: $event, servicio: 'agua' })"
    (requestTransferir)="abrirDialogoTransferir($event)"
    (requestAsignarAlmacen)="dialogoAsignarAlmacen.set($event)"
    (requestLiberarAlmacen)="onRequestLiberarAlmacen($event)"
    (requestEditarCosto)="onRequestEditarCosto($event)"
  />
}

<!-- Diálogo de transferencia (smart) -->
@if (dialogoTransferir()) {
  <app-transferir-puesto-dialog
    [puestoId]="dialogoTransferir()!.puesto_id"
    [codigoPuesto]="dialogoTransferir()!.codigo_puesto"
    (cancelar)="dialogoTransferir.set(null)"
    (transferido)="onTransferido($event)"
  />
}

<!-- Diálogo de asignación de almacén (smart) -->
@if (dialogoAsignarAlmacen()) {
  <app-asignar-almacen-dialog
    [puestoId]="dialogoAsignarAlmacen()!.puesto_id"
    [codigoPuesto]="dialogoAsignarAlmacen()!.codigo_puesto"
    [costoAlquilerBase]="dialogoAsignarAlmacen()!.costo_alquiler"
    (cancelar)="dialogoAsignarAlmacen.set(null)"
    (asignado)="onAlmacenAsignado()"
  />
}
  `,
})
export class GestionEspaciosComponent implements OnInit {
  protected readonly authSvc = inject(AuthService);
  protected readonly svc     = inject(EspaciosService);

  // ── Estado reactivo ───────────────────────────────────────────────────────
  protected readonly seleccionado    = signal<EspacioOcupacion | null>(null);
  protected readonly toggling        = signal<string | null>(null);
  protected readonly errorLocal      = signal<string | null>(null);
  protected readonly avisoDeudas     = signal(false);
  protected readonly dialogoTransferir = signal<EspacioOcupacion | null>(null);
  protected readonly dialogoAsignarAlmacen = signal<EspacioOcupacion | null>(null);

  protected readonly sortCol = signal<'codigo' | 'ocupante'>('codigo');
  protected readonly sortAsc = signal<boolean>(true);

  protected busqueda = '';
  private readonly _busqueda = signal('');
  protected readonly filtroTipo = signal<FiltroTipo>('Regular');

  protected readonly opcionesFiltro: { valor: FiltroTipo; label: string }[] = [
    { valor: 'todos',   label: 'Todos' },
    { valor: 'Regular', label: 'Regular' },
    { valor: 'Pequeño', label: 'Pequeño' },
    { valor: 'Almacen', label: 'Almacenes' },
  ];

  // ── Computed ──────────────────────────────────────────────────────────────
  protected readonly totalPrincipales = computed(
    () => this.svc.espacios().filter(e => esEspacioPrincipal(e.tipo_espacio)).length,
  );
  protected readonly totalAlmacenes = computed(
    () => this.svc.espacios().filter(e => e.tipo_espacio === 'Almacen').length,
  );

  protected readonly espaciosFiltrados = computed(() => {
    const q    = this._busqueda().toLowerCase().trim();
    const tipo = this.filtroTipo();
    const filtrados = this.svc.espacios().filter(e => {
      const pasaTipo =
        tipo === 'todos' ||
        (tipo === 'Regular' && e.tipo_espacio === 'Regular') ||
        (tipo === 'Pequeño' && e.tipo_espacio === 'Pequeño') ||
        (tipo === 'Almacen'   && e.tipo_espacio === 'Almacen');
      if (!q) return pasaTipo;
      const texto = [
        e.codigo_puesto, e.giro_nombre,
        e.titular_apellidos, e.titular_nombres, e.titular_dni,
        e.inquilino_apellidos, e.inquilino_nombres,
      ].filter(Boolean).join(' ').toLowerCase();
      return pasaTipo && texto.includes(q);
    });

    return filtrados.sort((a, b) => {
      if (this.sortCol() === 'codigo') {
        const cmp = a.codigo_puesto.localeCompare(b.codigo_puesto, undefined, { numeric: true });
        return this.sortAsc() ? cmp : -cmp;
      } else {
        const ocA = [a.titular_apellidos, a.titular_nombres, a.inquilino_apellidos, a.inquilino_nombres].filter(Boolean).join(' ').toLowerCase();
        const ocB = [b.titular_apellidos, b.titular_nombres, b.inquilino_apellidos, b.inquilino_nombres].filter(Boolean).join(' ').toLowerCase();
        const cmp = ocA.localeCompare(ocB);
        return this.sortAsc() ? cmp : -cmp;
      }
    });
  });

  // ── Ciclo de vida ─────────────────────────────────────────────────────────
  ngOnInit(): void { void this.svc.cargar(); }

  protected onBusquedaChange(val: string): void {
    this._busqueda.set(val);
  }

  protected onSortChange(col: 'codigo' | 'ocupante'): void {
    if (this.sortCol() === col) {
      this.sortAsc.set(!this.sortAsc());
    } else {
      this.sortCol.set(col);
      this.sortAsc.set(true);
    }
  }

  // ── Tabla events ─────────────────────────────────────────────────────────
  protected onSeleccionar(esp: EspacioOcupacion): void {
    this.seleccionado.set(
      this.seleccionado()?.puesto_id === esp.puesto_id ? null : esp,
    );
  }

  protected async onToggleServicio(ev: ToggleServicioEvent): Promise<void> {
    if (!this.authSvc.esAdmin()) return;
    const { espacio, servicio } = ev;
    const key = `${espacio.puesto_id}-${servicio}`;
    if (this.toggling() === key) return;
    this.toggling.set(key);
    this.errorLocal.set(null);
    try {
      await this.svc.toggleServicio(espacio.puesto_id, servicio, servicio === 'luz' ? !espacio.cobro_luz_activo : !espacio.cobro_agua_activo);
      const patch = servicio === 'luz'
        ? { cobro_luz_activo:  !espacio.cobro_luz_activo  }
        : { cobro_agua_activo: !espacio.cobro_agua_activo };
      this.svc.actualizarEspacio(espacio.puesto_id, patch);
      // Sync drawer
      if (this.seleccionado()?.puesto_id === espacio.puesto_id) {
        this.seleccionado.update(s => s ? { ...s, ...patch } : s);
      }
    } catch (e: unknown) {
      this.errorLocal.set(e instanceof Error ? e.message : `Error al cambiar cobro de ${servicio}.`);
    } finally {
      this.toggling.set(null);
    }
  }

  // ── Drawer events ─────────────────────────────────────────────────────────
  protected abrirDialogoTransferir(esp: EspacioOcupacion): void {
    this.dialogoTransferir.set(esp);
  }

  protected onTransferido(ev: { nuevoSocioId: number; deudas: boolean }): void {
    this.dialogoTransferir.set(null);
    this.seleccionado.set(null);
    if (ev.deudas) this.avisoDeudas.set(true);
    void this.svc.cargar();
  }

  protected onAlmacenAsignado(): void {
    this.dialogoAsignarAlmacen.set(null);
    this.seleccionado.set(null);
    void this.svc.cargar();
  }

  protected async onRequestLiberarAlmacen(
    ev: { espacio: EspacioOcupacion; ocupacionId: number },
  ): Promise<void> {
    const motivo = window.prompt(`Motivo para liberar ${ev.espacio.codigo_puesto}:`);
    if (!motivo?.trim()) return;
    this.errorLocal.set(null);
    try {
      await this.svc.liberarAlmacen(ev.ocupacionId, motivo.trim());
      this.seleccionado.set(null);
      void this.svc.cargar();
    } catch (e: unknown) {
      this.errorLocal.set(e instanceof Error ? e.message : 'Error al liberar almacén.');
    }
  }

  protected async onRequestEditarCosto(esp: EspacioOcupacion): Promise<void> {
    const actual = esp.costo_alquiler ?? 0;
    const input = window.prompt(
      `Nuevo costo mensual de alquiler para ${esp.codigo_puesto} (actual: S/ ${actual.toFixed(2)}):`,
      actual.toFixed(2),
    );
    if (input === null) return;
    const nuevo = parseFloat(input.replace(',', '.'));
    if (isNaN(nuevo) || nuevo < 0) {
      this.errorLocal.set('Monto inválido. Debe ser un número mayor o igual a 0.');
      return;
    }
    this.errorLocal.set(null);
    try {
      await this.svc.modificarCostoAlmacen(esp.puesto_id, nuevo);
      this.svc.actualizarEspacio(esp.puesto_id, { costo_alquiler: nuevo });
      if (this.seleccionado()?.puesto_id === esp.puesto_id) {
        this.seleccionado.update(s => s ? { ...s, costo_alquiler: nuevo } : s);
      }
    } catch (e: unknown) {
      this.errorLocal.set(e instanceof Error ? e.message : 'Error al actualizar el costo de alquiler.');
    }
  }
}
