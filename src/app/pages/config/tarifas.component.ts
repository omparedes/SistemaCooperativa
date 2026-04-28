import { Component, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ConfiguracionService } from '../../core/services/configuracion.service';

// ---------------------------------------------------------------------------
// Metadata de visualización — define orden, etiquetas y agrupación
// ---------------------------------------------------------------------------
interface ClaveMeta {
  clave: string;
  label: string;
  decimales: number;
}

interface GrupoMeta {
  titulo: string;
  icono: string;   // SVG path d=""
  claves: ClaveMeta[];
}

const GRUPOS_META: GrupoMeta[] = [
  {
    titulo: 'Electricidad (Luz)',
    icono: 'M13 10V3L4 14h7v7l9-11h-7z',
    claves: [
      { clave: 'PRECIO_KWH_SOCIO',     label: 'Precio kWh — Titular Socio',  decimales: 4 },
      { clave: 'PRECIO_KWH_INQUILINO', label: 'Precio kWh — Inquilino',       decimales: 4 },
    ],
  },
  {
    titulo: 'Agua',
    icono: 'M12 2c-4 4-6 7-6 10a6 6 0 0012 0c0-3-2-6-6-10z',
    claves: [
      { clave: 'PRECIO_M3_AGUA', label: 'Precio por m³ de agua', decimales: 2 },
    ],
  },
  {
    titulo: 'Cargos Fijos Mensuales',
    icono: 'M9 14l6-6m-5.5.5h.01m4.99 5h.01M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5',
    claves: [
      { clave: 'MONTO_GASTOS_ADMIN',     label: 'Gastos Administrativos',  decimales: 2 },
      { clave: 'MONTO_PREVISION_SOCIAL', label: 'Previsión Social',         decimales: 2 },
      { clave: 'MONTO_MANTENIMIENTO',    label: 'Mantenimiento',            decimales: 2 },
    ],
  },
];

// ---------------------------------------------------------------------------
// Tipos de runtime
// ---------------------------------------------------------------------------
interface ItemDisplay {
  clave: string;
  label: string;
  descripcion: string;
  decimales: number;
  valor: number;
  updated_at: string | null;
}

interface GrupoDisplay {
  titulo: string;
  icono: string;
  items: ItemDisplay[];
}

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-tarifas',
  standalone: true,
  imports: [FormsModule],
  template: `
    <div class="mx-auto max-w-2xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-8">
        <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Configuración de Tarifas</h2>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          Precios y montos fijos que el sistema aplica al generar facturas y cargos mensuales.
        </p>
      </div>

      <!-- ── Aviso ───────────────────────────────────────────────────────── -->
      <div class="mb-6 flex items-start gap-3 rounded-xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-700 dark:border-amber-700/50 dark:bg-amber-900/20 dark:text-amber-400">
        <svg class="mt-0.5 h-4 w-4 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
        </svg>
        <span>
          Los cambios se aplican a partir de la <strong>próxima facturación</strong>.
          Los recibos ya emitidos son inmutables y no se ven afectados.
        </span>
      </div>

      <!-- ── Error ───────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Éxito ────────────────────────────────────────────────────────── -->
      @if (guardado()) {
        <div class="mb-4 flex items-center gap-2 rounded-xl border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-700 dark:border-green-800 dark:bg-green-900/20 dark:text-green-400">
          <svg class="h-4 w-4 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
          </svg>
          <span><strong>Tarifas guardadas.</strong> Se aplicarán en la siguiente facturación mensual.</span>
        </div>
      }

      <!-- ── Loading ──────────────────────────────────────────────────────── -->
      @if (cargando()) {
        <div class="flex items-center justify-center py-16 text-gray-400 dark:text-gray-600">
          <svg class="h-8 w-8 animate-spin" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
          </svg>
        </div>
      } @else {

        <!-- ── Grupos ──────────────────────────────────────────────────────── -->
        @for (grupo of grupos(); track grupo.titulo) {
          <div class="mb-6">

            <!-- Cabecera del grupo -->
            <div class="mb-3 flex items-center gap-2">
              <div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" [attr.d]="grupo.icono"/>
                </svg>
              </div>
              <h3 class="text-base font-semibold text-gray-800 dark:text-white">{{ grupo.titulo }}</h3>
            </div>

            <!-- Tarjeta de items -->
            <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
              @for (item of grupo.items; track item.clave; let last = $last) {
                <div [class]="'flex items-center gap-4 px-5 py-4' + (!last ? ' border-b border-gray-100 dark:border-gray-700' : '')">
                  <!-- Descripción -->
                  <div class="flex-1 min-w-0">
                    <p class="text-sm font-medium text-gray-800 dark:text-white">{{ item.label }}</p>
                    <p class="text-xs text-gray-400 dark:text-gray-500">{{ item.descripcion }}</p>
                    @if (item.updated_at) {
                      <p class="mt-0.5 text-xs text-gray-300 dark:text-gray-600">
                        Actualizado: {{ formatDate(item.updated_at) }}
                      </p>
                    }
                  </div>
                  <!-- Input editable -->
                  <div class="flex shrink-0 items-center gap-2">
                    <span class="text-sm font-medium text-gray-500 dark:text-gray-400">S/</span>
                    <input
                      type="number"
                      min="0.0001"
                      [step]="item.decimales === 4 ? '0.0001' : '0.01'"
                      [(ngModel)]="item.valor"
                      [name]="item.clave"
                      class="h-10 w-28 rounded-lg border border-gray-300 bg-gray-50 px-3 text-right text-sm tabular-nums dark:border-gray-600 dark:bg-gray-700 dark:text-white focus:border-brand-500 focus:outline-none"
                    />
                  </div>
                </div>
              }
            </div>

          </div>
        }

        <!-- ── Botón guardar ───────────────────────────────────────────────── -->
        <button
          (click)="guardar()"
          [disabled]="guardando()"
          class="flex w-full items-center justify-center gap-3 rounded-xl bg-brand-600 py-4 text-base font-semibold text-white shadow-md transition hover:bg-brand-700 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50">
          @if (guardando()) {
            <svg class="h-5 w-5 animate-spin" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
            </svg>
            Guardando…
          } @else {
            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
            Guardar cambios
          }
        </button>

      }
    </div>
  `,
})
export class TarifasComponent implements OnInit {
  private readonly svc = inject(ConfiguracionService);

  readonly cargando = signal(true);
  readonly grupos   = signal<GrupoDisplay[]>([]);

  readonly guardando = signal(false);
  readonly error     = signal<string | null>(null);
  readonly guardado  = signal(false);

  async ngOnInit(): Promise<void> {
    await this.cargar();
  }

  private async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    try {
      const configs = await this.svc.getAll();
      const mapaDB = new Map(configs.map(c => [c.clave, c]));

      this.grupos.set(GRUPOS_META.map(gm => ({
        titulo: gm.titulo,
        icono:  gm.icono,
        items:  gm.claves.map(cm => {
          const db = mapaDB.get(cm.clave);
          return {
            clave:       cm.clave,
            label:       cm.label,
            descripcion: db?.descripcion ?? '',
            decimales:   cm.decimales,
            valor:       db ? Number(db.valor) : 0,
            updated_at:  db?.updated_at ?? null,
          };
        }),
      })));
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar la configuración');
    } finally {
      this.cargando.set(false);
    }
  }

  async guardar(): Promise<void> {
    const todosItems = this.grupos().flatMap(g => g.items);
    const invalidos  = todosItems.filter(i => !(i.valor > 0));

    if (invalidos.length > 0) {
      this.error.set(`Todos los valores deben ser mayores a 0. Revisa: ${invalidos.map(i => i.label).join(', ')}`);
      return;
    }

    this.guardando.set(true);
    this.error.set(null);
    this.guardado.set(false);
    try {
      const cambios = todosItems.map(i => ({ clave: i.clave, valor: i.valor }));

      await this.svc.updateValores(cambios);
      this.guardado.set(true);

      // Refresca updated_at desde DB
      await this.cargar();
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al guardar los cambios');
    } finally {
      this.guardando.set(false);
    }
  }

  formatDate(iso: string): string {
    return new Date(iso).toLocaleString('es-PE', {
      day: '2-digit', month: '2-digit', year: 'numeric',
      hour: '2-digit', minute: '2-digit',
    });
  }
}
