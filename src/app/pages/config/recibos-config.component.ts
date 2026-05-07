import { Component, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import {
  ConfiguracionRecibos,
  ConfiguracionRecibosService,
  FormatoImpresion,
} from '../../core/services/configuracion-recibos.service';

@Component({
  selector: 'app-recibos-config',
  standalone: true,
  imports: [FormsModule],
  template: `
    <div class="mx-auto max-w-2xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-8">
        <div class="flex items-center gap-3 mb-1">
          <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-emerald-100 dark:bg-emerald-900/30">
            <svg class="h-5 w-5 text-emerald-700 dark:text-emerald-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
            </svg>
          </div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Ajustes de Impresión</h2>
        </div>
        <p class="ml-12 text-sm text-gray-500 dark:text-gray-400">
          Personaliza los textos e identidad visual que aparecen en cada recibo de pago emitido.
        </p>
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
          <span><strong>Configuración guardada.</strong> El próximo recibo generado usará estos valores.</span>
        </div>
      }

      <!-- ── Loading ───────────────────────────────────────────────────── -->
      @if (cargando()) {
        <div class="flex items-center justify-center py-16 text-gray-400 dark:text-gray-600">
          <svg class="h-8 w-8 animate-spin" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
          </svg>
        </div>
      } @else {

        <!-- ══════════════════════════════════════════════════════════════ -->
        <!-- PREVIEW EN VIVO                                               -->
        <!-- ══════════════════════════════════════════════════════════════ -->
        <div class="mb-6 overflow-hidden rounded-2xl border-2 border-dashed border-gray-300 dark:border-gray-600">
          <p class="bg-gray-50 dark:bg-gray-700/40 px-4 py-2 text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500">
            Previsualización del encabezado
          </p>

          <!-- Simulación del recibo -->
          <div class="px-6 py-5 bg-white dark:bg-gray-800">
            <div class="text-center mb-3">
              <img src="/images/logo/logo2.png" alt="Logo" class="mx-auto h-12 object-contain mb-2"
                   onerror="this.style.display='none'" />
              <p class="text-[11px] font-bold tracking-wide text-gray-600 dark:text-gray-300">
                {{ form.nombre_institucion || '—' }}
              </p>
              <p class="text-[10px] text-gray-400 dark:text-gray-500 mt-0.5">
                {{ form.subtitulo || '—' }}
              </p>
            </div>

            <!-- Barra de color -->
            <div class="h-1 rounded mb-2" [style.background-color]="form.color_principal"></div>
            <div class="h-0.5 rounded mb-3" style="background-color:#FBBF24"></div>

            <!-- Banner título simulado -->
            <div class="rounded px-4 py-2 mb-3 text-center text-xs font-bold tracking-widest text-white"
                 [style.background-color]="form.color_principal">
              R E C I B O &nbsp; D E &nbsp; P A G O
            </div>

            <p class="text-[9px] text-center text-gray-300 dark:text-gray-600 italic mt-3">
              {{ form.mensaje_pie || '—' }}
            </p>
          </div>
        </div>

        <!-- ══════════════════════════════════════════════════════════════ -->
        <!-- FORMULARIO                                                     -->
        <!-- ══════════════════════════════════════════════════════════════ -->
        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden mb-6">

          <!-- Nombre institución -->
          <div class="border-b border-gray-100 dark:border-gray-700 px-5 py-4">
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Nombre de la Institución
              <span class="ml-1 text-xs font-normal text-gray-400">(aparece en el encabezado del recibo)</span>
            </label>
            <input
              type="text"
              name="nombre_institucion"
              [(ngModel)]="form.nombre_institucion"
              maxlength="120"
              class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
              placeholder="COOPERATIVA DE COMERCIANTES PRIMERO DE MAYO"
            />
          </div>

          <!-- Subtítulo -->
          <div class="border-b border-gray-100 dark:border-gray-700 px-5 py-4">
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Subtítulo / Descripción corta
            </label>
            <input
              type="text"
              name="subtitulo"
              [(ngModel)]="form.subtitulo"
              maxlength="120"
              class="h-10 w-full rounded-lg border border-gray-300 bg-gray-50 px-3 text-sm text-gray-800 outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
              placeholder="Mercado Municipal — Sistema de Recaudación"
            />
          </div>

          <!-- Mensaje pie -->
          <div class="border-b border-gray-100 dark:border-gray-700 px-5 py-4">
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Mensaje en el Pie del Recibo
            </label>
            <textarea
              name="mensaje_pie"
              [(ngModel)]="form.mensaje_pie"
              rows="2"
              maxlength="300"
              class="w-full rounded-lg border border-gray-300 bg-gray-50 px-3 py-2.5 text-sm text-gray-800 outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white resize-none"
              placeholder="Gracias por su puntualidad."
            ></textarea>
          </div>

          <!-- Color principal -->
          <div class="border-b border-gray-100 dark:border-gray-700 px-5 py-4">
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Color Corporativo Principal
              <span class="ml-1 text-xs font-normal text-gray-400">(fondo del banner de título)</span>
            </label>
            <div class="flex items-center gap-3">
              <input
                type="color"
                name="color_principal"
                [(ngModel)]="form.color_principal"
                class="h-10 w-16 cursor-pointer rounded-lg border border-gray-300 bg-white p-1 dark:border-gray-600"
              />
              <span class="font-mono text-sm text-gray-600 dark:text-gray-400">{{ form.color_principal }}</span>
              <!-- Chips de colores sugeridos -->
              <div class="flex gap-1.5">
                @for (c of coloresSugeridos; track c.hex) {
                  <button
                    type="button"
                    (click)="form.color_principal = c.hex"
                    class="h-7 w-7 rounded-full border-2 transition hover:scale-110"
                    [style.background-color]="c.hex"
                    [class]="form.color_principal === c.hex
                      ? 'border-gray-700 dark:border-white scale-110'
                      : 'border-transparent'"
                    [title]="c.nombre"
                  ></button>
                }
              </div>
            </div>
          </div>

          <!-- Formato impresión -->
          <div class="px-5 py-4">
            <label class="mb-3 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Formato de Impresión
            </label>
            <div class="flex gap-3">
              @for (fmt of formatos; track fmt.value) {
                <label
                  class="flex flex-1 cursor-pointer items-center gap-3 rounded-xl border-2 p-4 transition"
                  [class]="form.formato_impresion === fmt.value
                    ? 'border-emerald-500 bg-emerald-50 dark:border-emerald-600 dark:bg-emerald-900/20'
                    : 'border-gray-200 bg-gray-50 hover:border-gray-300 dark:border-gray-700 dark:bg-gray-800'">
                  <input
                    type="radio"
                    [name]="'formato_impresion'"
                    [value]="fmt.value"
                    [(ngModel)]="form.formato_impresion"
                    class="accent-emerald-600"
                  />
                  <div>
                    <p class="text-sm font-semibold text-gray-800 dark:text-white">{{ fmt.label }}</p>
                    <p class="text-xs text-gray-400 dark:text-gray-500">{{ fmt.desc }}</p>
                  </div>
                </label>
              }
            </div>
          </div>

        </div>

        <!-- ── Botón guardar ───────────────────────────────────────────────── -->
        <button
          (click)="guardar()"
          [disabled]="guardando()"
          class="flex w-full items-center justify-center gap-3 rounded-xl bg-emerald-700 py-4 text-base font-semibold text-white shadow-md transition hover:bg-emerald-800 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50">
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
export class RecibosConfigComponent implements OnInit {
  private readonly svc = inject(ConfiguracionRecibosService);

  readonly cargando  = signal(true);
  readonly guardando = signal(false);
  readonly error     = signal<string | null>(null);
  readonly guardado  = signal(false);

  form: Omit<ConfiguracionRecibos, 'id'> = {
    nombre_institucion: '',
    subtitulo:          '',
    mensaje_pie:        '',
    color_principal:    '#166534',
    formato_impresion:  'A4',
  };

  readonly coloresSugeridos: { hex: string; nombre: string }[] = [
    { hex: '#166534', nombre: 'Verde Esmeralda' },
    { hex: '#1e40af', nombre: 'Azul Institucional' },
    { hex: '#7c2d12', nombre: 'Marrón Corporativo' },
    { hex: '#1e3a5f', nombre: 'Azul Marino' },
    { hex: '#4a1942', nombre: 'Púrpura Formal' },
  ];

  readonly formatos: { value: FormatoImpresion; label: string; desc: string }[] = [
    { value: 'A4',         label: 'Hoja A4',           desc: 'Hoja estándar de oficio / carta' },
    { value: 'TICKET_80MM', label: 'Ticket 80mm',      desc: 'Rollo para impresora térmica' },
  ];

  async ngOnInit(): Promise<void> {
    this.cargando.set(true);
    try {
      const cfg = await this.svc.cargar();
      this.form = {
        nombre_institucion: cfg.nombre_institucion,
        subtitulo:          cfg.subtitulo,
        mensaje_pie:        cfg.mensaje_pie,
        color_principal:    cfg.color_principal,
        formato_impresion:  cfg.formato_impresion,
      };
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar la configuración');
    } finally {
      this.cargando.set(false);
    }
  }

  async guardar(): Promise<void> {
    const { nombre_institucion, subtitulo, mensaje_pie, color_principal } = this.form;

    if (!nombre_institucion.trim()) {
      this.error.set('El nombre de la institución no puede estar vacío.');
      return;
    }
    if (!/^#[0-9A-Fa-f]{6}$/.test(color_principal)) {
      this.error.set('El color debe tener formato hexadecimal válido (#RRGGBB).');
      return;
    }

    this.guardando.set(true);
    this.error.set(null);
    this.guardado.set(false);
    try {
      await this.svc.actualizar({
        nombre_institucion: nombre_institucion.trim(),
        subtitulo:          subtitulo.trim(),
        mensaje_pie:        mensaje_pie.trim(),
        color_principal,
        formato_impresion:  this.form.formato_impresion,
      });
      this.svc.invalidarCache();
      this.guardado.set(true);
      setTimeout(() => this.guardado.set(false), 4000);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al guardar los cambios');
    } finally {
      this.guardando.set(false);
    }
  }
}
