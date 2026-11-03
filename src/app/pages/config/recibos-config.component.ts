import { Component, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import {
  ConfiguracionRecibos,
  ConfiguracionRecibosService,
  FormatoImpresion,
} from '../../core/services/configuracion-recibos.service';
import {
  PdfGeneratorService,
  ReciboDatos,
} from '../../core/services/pdf-generator.service';

const DATOS_MOCK_PREVIEW: ReciboDatos = {
  codigo_transaccion: 'REC-20261102-0042',
  fecha_pago: new Date(),
  cajero: 'Caja Principal (D. Quispe)',
  nombre_pagador: 'PÉREZ GARCÍA JUAN CARLOS',
  tipo_pagador: 'Socio titular',
  dni_pagador: '10234567',
  codigo_puesto: 'STAND A-12',
  metodo_pago: 'Efectivo',
  comprobante: null,
  observacion: 'Demostración de ajustes de impresión',
  detalle: [
    {
      concepto: 'Cuota de Mantenimiento y Guardianía de Mercado',
      periodo: '10/2026',
      saldo_original: 50.0,
      aplicado: 50.0,
      cubierto_completo: true,
    },
    {
      concepto: 'Servicio de Agua y Saneamiento Ambiental',
      periodo: '10/2026',
      saldo_original: 30.0,
      aplicado: 30.0,
      cubierto_completo: true,
    },
  ],
  total_pagado: 80.0,
  saldo_a_favor: 0,
  monto_recibido: 80.0,
  saldo_utilizado: 0,
};

@Component({
  selector: 'app-recibos-config',
  standalone: true,
  imports: [FormsModule],
  template: `
    <div class="mx-auto max-w-4xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ──────────────────────────────────────────────────── -->
      <div class="mb-8">
        <div class="flex items-center gap-3 mb-1">
          <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-emerald-100 dark:bg-emerald-900/30">
            <svg class="h-5 w-5 text-emerald-700 dark:text-emerald-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
            </svg>
          </div>
          <div>
            <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Ajustes de Impresión y Recibos</h2>
            <p class="text-sm text-gray-500 dark:text-gray-400">
              Personaliza la identidad institucional, formato por defecto y previsualiza en vivo el diseño A4 y Ticket térmico (80 mm).
            </p>
          </div>
        </div>
      </div>

      <!-- ── Mensajes de Estado ─────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-5 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      @if (guardado()) {
        <div class="mb-5 flex items-center gap-2 rounded-xl border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-700 dark:border-green-800 dark:bg-green-900/20 dark:text-green-400">
          <svg class="h-4 w-4 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
          </svg>
          <span><strong>Configuración guardada correctamente.</strong> Todos los recibos y tickets generados usarán estos valores.</span>
        </div>
      }

      <!-- ── Loading ───────────────────────────────────────────────────── -->
      @if (cargando()) {
        <div class="flex items-center justify-center py-20 text-gray-400 dark:text-gray-600">
          <svg class="h-8 w-8 animate-spin" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
          </svg>
        </div>
      } @else {

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">

          <!-- ══════════════════════════════════════════════════════════════ -->
          <!-- COLUMNA IZQUIERDA: FORMULARIO DE AJUSTES                      -->
          <!-- ══════════════════════════════════════════════════════════════ -->
          <div class="lg:col-span-6 space-y-6">

            <div class="rounded-2xl border border-gray-200 bg-white shadow-xs dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
              
              <!-- Encabezado de sección -->
              <div class="border-b border-gray-100 bg-gray-50/50 px-5 py-3.5 dark:border-gray-700 dark:bg-gray-800/40">
                <h3 class="text-sm font-semibold uppercase tracking-wider text-gray-600 dark:text-gray-300">
                  Identidad y Textos Institucionales
                </h3>
              </div>

              <!-- Nombre institución -->
              <div class="border-b border-gray-100 dark:border-gray-700 px-5 py-4">
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Nombre de la Institución
                  <span class="ml-1 text-xs font-normal text-gray-400">(encabezado principal)</span>
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
                  Subtítulo / Descripción
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

              <!-- Mensajes en el pie del recibo -->
              <div class="border-b border-gray-100 dark:border-gray-700 px-5 py-4">
                <div class="flex items-center justify-between mb-1.5">
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                    Mensaje / Recordatorios en Pie de Recibo
                  </label>
                  <span class="text-xs text-gray-400">Multilínea</span>
                </div>
                <textarea
                  name="mensaje_pie"
                  [(ngModel)]="form.mensaje_pie"
                  rows="3"
                  maxlength="300"
                  class="w-full rounded-lg border border-gray-300 bg-gray-50 px-3 py-2 text-sm text-gray-800 outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white resize-none"
                  placeholder="Gracias por su puntualidad.&#10;Conserve su comprobante para todo trámite."
                ></textarea>

                <!-- Chips sugeridos rápidos -->
                <div class="mt-2 flex flex-wrap gap-1.5 text-xs">
                  <span class="text-gray-400 self-center text-[11px]">Sugerencias:</span>
                  <button
                    type="button"
                    (click)="agregarTextoPie('Gracias por su puntualidad.')"
                    class="rounded-md border border-gray-200 bg-gray-50 px-2 py-0.5 text-[11px] text-gray-600 hover:border-emerald-500 hover:bg-emerald-50 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300">
                    + Agradecimiento
                  </button>
                  <button
                    type="button"
                    (click)="agregarTextoPie('Conserve su comprobante para reclamos o trámites.')"
                    class="rounded-md border border-gray-200 bg-gray-50 px-2 py-0.5 text-[11px] text-gray-600 hover:border-emerald-500 hover:bg-emerald-50 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300">
                    + Conservación
                  </button>
                  <button
                    type="button"
                    (click)="agregarTextoPie('Horario de atención: Lun a Sáb 7:00 a 14:00 hrs.')"
                    class="rounded-md border border-gray-200 bg-gray-50 px-2 py-0.5 text-[11px] text-gray-600 hover:border-emerald-500 hover:bg-emerald-50 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300">
                    + Horario
                  </button>
                </div>
              </div>

              <!-- Color principal -->
              <div class="border-b border-gray-100 dark:border-gray-700 px-5 py-4">
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Color Corporativo Principal
                  <span class="ml-1 text-xs font-normal text-gray-400">(franjas y banners en formato A4)</span>
                </label>
                <div class="flex items-center gap-3">
                  <input
                    type="color"
                    name="color_principal"
                    [(ngModel)]="form.color_principal"
                    class="h-10 w-16 cursor-pointer rounded-lg border border-gray-300 bg-white p-1 dark:border-gray-600"
                  />
                  <span class="font-mono text-sm font-medium text-gray-700 dark:text-gray-300">{{ form.color_principal }}</span>
                  <div class="flex gap-1.5 ml-auto">
                    @for (c of coloresSugeridos; track c.hex) {
                      <button
                        type="button"
                        (click)="form.color_principal = c.hex"
                        class="h-7 w-7 rounded-full border-2 transition hover:scale-110"
                        [style.background-color]="c.hex"
                        [class]="form.color_principal === c.hex ? 'border-gray-700 dark:border-white scale-110' : 'border-transparent'"
                        [title]="c.nombre"
                      ></button>
                    }
                  </div>
                </div>
              </div>

              <!-- Formato predeterminado institucional -->
              <div class="px-5 py-4">
                <label class="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Formato Predeterminado del Sistema
                </label>
                <p class="text-xs text-gray-400 dark:text-gray-500 mb-3">
                  Formato inicial de respaldo. En cada cobro o consulta, el usuario puede elegir libremente A4 o Ticket 80 mm sin afectar este ajuste.
                </p>
                <div class="grid grid-cols-2 gap-3">
                  @for (fmt of formatos; track fmt.value) {
                    <label
                      class="flex cursor-pointer items-start gap-3 rounded-xl border-2 p-3.5 transition"
                      [class]="form.formato_impresion === fmt.value
                        ? 'border-emerald-500 bg-emerald-50/70 dark:border-emerald-600 dark:bg-emerald-900/20'
                        : 'border-gray-200 bg-gray-50 hover:border-gray-300 dark:border-gray-700 dark:bg-gray-800'">
                      <input
                        type="radio"
                        [name]="'formato_impresion'"
                        [value]="fmt.value"
                        [(ngModel)]="form.formato_impresion"
                        (change)="tabPreview.set(fmt.value)"
                        class="mt-0.5 accent-emerald-600"
                      />
                      <div>
                        <p class="text-xs font-semibold text-gray-800 dark:text-white">{{ fmt.label }}</p>
                        <p class="text-[11px] text-gray-500 dark:text-gray-400 leading-snug">{{ fmt.desc }}</p>
                      </div>
                    </label>
                  }
                </div>
              </div>

            </div>

            <!-- Botones de Acción Formulario -->
            <div class="space-y-3">
              <button
                type="button"
                (click)="guardar()"
                [disabled]="guardando()"
                class="flex w-full items-center justify-center gap-2 rounded-xl bg-emerald-700 py-3.5 text-sm font-semibold text-white shadow-md transition hover:bg-emerald-800 active:scale-[0.99] disabled:opacity-50">
                @if (guardando()) {
                  <svg class="h-5 w-5 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Guardando cambios…
                } @else {
                  <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  Guardar Ajustes Institucionales
                }
              </button>

              <!-- Botones de Prueba en PDF Real -->
              <div class="flex gap-2">
                <button
                  type="button"
                  (click)="probarGeneracionPdf('A4')"
                  [disabled]="probandoPdf()"
                  class="flex-1 flex items-center justify-center gap-1.5 rounded-lg border border-gray-300 bg-white py-2 px-3 text-xs font-medium text-gray-700 hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-200 dark:hover:bg-gray-700">
                  <svg class="h-3.5 w-3.5 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                  </svg>
                  Probar PDF Real (A4)
                </button>
                <button
                  type="button"
                  (click)="probarGeneracionPdf('TICKET_80MM')"
                  [disabled]="probandoPdf()"
                  class="flex-1 flex items-center justify-center gap-1.5 rounded-lg border border-gray-300 bg-white py-2 px-3 text-xs font-medium text-gray-700 hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-200 dark:hover:bg-gray-700">
                  <svg class="h-3.5 w-3.5 text-emerald-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                  </svg>
                  Probar Ticket Real (80mm)
                </button>
              </div>
            </div>

          </div>

          <!-- ══════════════════════════════════════════════════════════════ -->
          <!-- COLUMNA DERECHA: PREVISUALIZACIÓN EN VIVO (A4 / TICKET 80MM)  -->
          <!-- ══════════════════════════════════════════════════════════════ -->
          <div class="lg:col-span-6">
            
            <div class="rounded-2xl border border-gray-200 bg-gray-50/70 p-4 dark:border-gray-700 dark:bg-gray-800/40">
              
              <!-- Conmutador de previsualización -->
              <div class="flex items-center justify-between mb-4">
                <span class="text-xs font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                  Vista Previa Interactiva
                </span>
                <div class="inline-flex rounded-lg border border-gray-200 bg-white p-0.5 shadow-2xs dark:border-gray-700 dark:bg-gray-800">
                  <button
                    type="button"
                    (click)="tabPreview.set('A4')"
                    class="rounded-md px-3 py-1 text-xs font-semibold transition"
                    [class]="tabPreview() === 'A4'
                      ? 'bg-emerald-600 text-white shadow-2xs'
                      : 'text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white'">
                    Hoja A4
                  </button>
                  <button
                    type="button"
                    (click)="tabPreview.set('TICKET_80MM')"
                    class="rounded-md px-3 py-1 text-xs font-semibold transition"
                    [class]="tabPreview() === 'TICKET_80MM'
                      ? 'bg-emerald-600 text-white shadow-2xs'
                      : 'text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white'">
                    Ticket 80 mm
                  </button>
                </div>
              </div>

              <!-- ========================================================= -->
              <!-- SUB-VISTA 1: HOJA A4                                      -->
              <!-- ========================================================= -->
              @if (tabPreview() === 'A4') {
                <div class="mx-auto max-w-[420px] rounded-xl border border-gray-300 bg-white p-5 shadow-md dark:border-gray-600 dark:bg-gray-900 text-gray-800 dark:text-gray-100 text-[10px] leading-tight select-none">
                  
                  <!-- Logo y Encabezado -->
                  <div class="text-center mb-2">
                    <img src="/images/logo/logo2.png" alt="Logo" class="mx-auto h-9 object-contain mb-1.5" onerror="this.style.display='none'" />
                    <p class="font-bold text-[11px] leading-snug" [style.color]="form.color_principal">
                      {{ form.nombre_institucion || 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO' }}
                    </p>
                    <p class="text-[9px] text-gray-500 dark:text-gray-400 mt-0.5">
                      {{ form.subtitulo || 'Mercado Municipal — Control Interno' }}
                    </p>
                  </div>

                  <!-- Doble línea corporativa -->
                  <div class="h-1 rounded-xs mb-1" [style.background-color]="form.color_principal"></div>
                  <div class="h-0.5 rounded-xs mb-3 bg-amber-400"></div>

                  <!-- Banner Título -->
                  <div class="rounded border-2 border-amber-400 px-3 py-1 mb-2 text-center text-[10px] font-bold tracking-widest text-white shadow-2xs"
                       [style.background-color]="form.color_principal">
                    R E C I B O &nbsp; D E &nbsp; P A G O
                  </div>

                  <!-- Código de Transacción -->
                  <div class="text-center mb-3">
                    <p class="font-bold text-xs" [style.color]="form.color_principal">REC-20261102-0042</p>
                    <p class="text-[8px] text-gray-400">02 de noviembre de 2026 — 18:30 hrs</p>
                  </div>

                  <!-- Datos del Pagador -->
                  <div class="mb-2.5">
                    <p class="text-[8.5px] font-bold underline mb-1" [style.color]="form.color_principal">DATOS DEL PAGADOR</p>
                    <div class="rounded border border-gray-200 dark:border-gray-700 divide-y divide-gray-100 dark:divide-gray-800 text-[8.5px]">
                      <div class="flex px-2 py-0.5 bg-gray-50/60 dark:bg-gray-800/40">
                        <span class="w-28 text-gray-500 font-medium">Nombre:</span>
                        <span class="font-semibold text-gray-800 dark:text-white">PÉREZ GARCÍA JUAN CARLOS</span>
                      </div>
                      <div class="flex px-2 py-0.5">
                        <span class="w-28 text-gray-500 font-medium">DNI:</span>
                        <span>10234567</span>
                      </div>
                      <div class="flex px-2 py-0.5 bg-gray-50/60 dark:bg-gray-800/40">
                        <span class="w-28 text-gray-500 font-medium">Puesto:</span>
                        <span class="font-semibold text-gray-800 dark:text-white">STAND A-12</span>
                      </div>
                      <div class="flex px-2 py-0.5 bg-gray-50/60 dark:bg-gray-800/40">
                        <span class="w-28 text-gray-500 font-medium">Método de pago:</span>
                        <span>Efectivo</span>
                      </div>
                    </div>
                  </div>

                  <!-- Detalle de Cobros -->
                  <div class="mb-3">
                    <p class="text-[8.5px] font-bold underline mb-1" [style.color]="form.color_principal">DETALLE DE COBROS APLICADOS</p>
                    <table class="w-full text-[8px] border border-gray-200 dark:border-gray-700">
                      <thead>
                        <tr class="text-white" [style.background-color]="'#15803D'">
                          <th class="p-1 text-left">Concepto</th>
                          <th class="p-1 text-center">Período</th>
                          <th class="p-1 text-right">Abonado S/</th>
                          <th class="p-1 text-center">Estado</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                        <tr class="bg-emerald-50/30 dark:bg-emerald-950/20">
                          <td class="p-1">Cuota Mantenimiento</td>
                          <td class="p-1 text-center">10/2026</td>
                          <td class="p-1 text-right font-semibold">50.00</td>
                          <td class="p-1 text-center font-bold text-emerald-700">CANCELADO</td>
                        </tr>
                        <tr>
                          <td class="p-1">Servicio de Agua</td>
                          <td class="p-1 text-center">10/2026</td>
                          <td class="p-1 text-right font-semibold">30.00</td>
                          <td class="p-1 text-center font-bold text-emerald-700">CANCELADO</td>
                        </tr>
                        <tr class="border-t-2 border-emerald-800 font-bold bg-gray-50 dark:bg-gray-800">
                          <td colspan="2" class="p-1 text-right" [style.color]="form.color_principal">TOTAL COBRADO:</td>
                          <td class="p-1 text-right text-emerald-700 font-black text-[9px]">S/ 80.00</td>
                          <td></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>

                  <!-- Firma y Sello -->
                  <div class="grid grid-cols-2 gap-2 pt-2 items-end">
                    <div class="text-center border-t border-dashed border-gray-300 pt-1 text-[7.5px] text-gray-400">
                      Firma / Sello cajero<br>
                      <strong class="text-gray-700 dark:text-gray-300">Caja Principal</strong>
                    </div>
                    <div class="border-2 border-amber-400 rounded p-1 text-center" [style.color]="form.color_principal">
                      <div class="text-[10px] font-black tracking-widest">P A G A D O</div>
                      <div class="text-[6px] text-gray-400 uppercase">Mercado Cooperativo</div>
                    </div>
                  </div>

                  <!-- Pie del Documento -->
                  <div class="mt-4 border-t border-gray-200 dark:border-gray-700 pt-2 text-center text-[7.5px] text-gray-400 italic">
                    {{ form.mensaje_pie || 'Gracias por su puntualidad.' }}
                  </div>

                </div>
              }

              <!-- ========================================================= -->
              <!-- SUB-VISTA 2: TICKET TÉRMICO 80 MM (EPSON TM-T20)          -->
              <!-- ========================================================= -->
              @if (tabPreview() === 'TICKET_80MM') {
                <div class="mx-auto max-w-[270px] rounded-lg border border-gray-300 bg-white p-4 shadow-md font-mono text-[9px] leading-tight text-black select-none">
                  
                  <!-- Encabezado térmico monocromático -->
                  <div class="text-center mb-1">
                    <img src="/images/logo/logo2.png" alt="Logo" class="mx-auto h-8 grayscale object-contain mb-1" onerror="this.style.display='none'" />
                    <p class="font-bold text-[10px] uppercase leading-tight">
                      {{ form.nombre_institucion || 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO' }}
                    </p>
                    <p class="text-[7.5px] text-gray-600 mt-0.5">
                      {{ form.subtitulo || 'Mercado Municipal — Recaudación' }}
                    </p>
                  </div>

                  <!-- Línea discontinua -->
                  <div class="my-2 border-t border-dashed border-black"></div>

                  <div class="text-center mb-1">
                    <p class="font-bold text-[10.5px]">RECIBO DE PAGO</p>
                    <p class="font-bold text-[9.5px]">REC-20261102-0042</p>
                  </div>

                  <div class="my-1.5 border-t border-black"></div>

                  <div class="space-y-0.5 text-[8px]">
                    <div class="flex justify-between">
                      <span class="text-gray-600">Fecha/Hora:</span>
                      <span class="font-bold">02/11/2026 18:30</span>
                    </div>
                    <div class="flex justify-between">
                      <span class="text-gray-600">Pagador:</span>
                      <span class="font-bold truncate max-w-[150px]">PÉREZ GARCÍA JUAN</span>
                    </div>
                    <div class="flex justify-between">
                      <span class="text-gray-600">DNI:</span>
                      <span>10234567</span>
                    </div>
                    <div class="flex justify-between">
                      <span class="text-gray-600">Puesto:</span>
                      <span class="font-bold">STAND A-12</span>
                    </div>
                    <div class="flex justify-between">
                      <span class="text-gray-600">Método:</span>
                      <span>Efectivo</span>
                    </div>
                  </div>

                  <div class="my-2 border-t border-dashed border-black"></div>

                  <!-- Detalle Conceptos térmico vertical -->
                  <div class="mb-1 text-[8px]">
                    <p class="font-bold mb-1">DETALLE DE COBROS</p>
                    <div class="space-y-1.5">
                      <div>
                        <p class="font-bold leading-none">Cuota Mantenimiento</p>
                        <div class="flex justify-between text-gray-700">
                          <span>10/2026 · [CANCELADO]</span>
                          <span class="font-bold text-black">S/ 50.00</span>
                        </div>
                      </div>
                      <div class="border-t border-dotted border-gray-300 pt-1">
                        <p class="font-bold leading-none">Servicio de Agua</p>
                        <div class="flex justify-between text-gray-700">
                          <span>10/2026 · [CANCELADO]</span>
                          <span class="font-bold text-black">S/ 30.00</span>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="my-1.5 border-t-2 border-black"></div>

                  <!-- Total -->
                  <div class="flex justify-between items-center text-[10.5px] font-black my-1">
                    <span>TOTAL COBRADO:</span>
                    <span>S/ 80.00</span>
                  </div>
                  <div class="text-[7.5px] text-gray-700">
                    Importe recibido (Efectivo): S/ 80.00
                  </div>

                  <div class="my-2 border-t border-dashed border-black"></div>

                  <!-- Pie -->
                  <div class="text-center text-[7.5px] space-y-1">
                    <p>Cajero: Caja Principal (D. Quispe)</p>
                    <p class="italic text-gray-700 whitespace-pre-line">{{ form.mensaje_pie || 'Gracias por su puntualidad.' }}</p>
                  </div>

                </div>
              }

            </div>

          </div>

        </div>

      }
    </div>
  `,
})
export class RecibosConfigComponent implements OnInit {
  private readonly svc    = inject(ConfiguracionRecibosService);
  private readonly pdfSvc = inject(PdfGeneratorService);

  readonly cargando    = signal(true);
  readonly guardando   = signal(false);
  readonly probandoPdf = signal(false);
  readonly error       = signal<string | null>(null);
  readonly guardado    = signal(false);
  readonly tabPreview  = signal<FormatoImpresion>('A4');

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
    { value: 'A4',          label: 'Hoja A4 Estándar', desc: 'Documento completo para archivador y oficina' },
    { value: 'TICKET_80MM', label: 'Ticket Térmico 80 mm', desc: 'Rollo continuo para Epson TM-T20 y similares' },
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
      this.tabPreview.set(cfg.formato_impresion);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar la configuración');
    } finally {
      this.cargando.set(false);
    }
  }

  agregarTextoPie(texto: string): void {
    if (!this.form.mensaje_pie.trim()) {
      this.form.mensaje_pie = texto;
    } else if (!this.form.mensaje_pie.includes(texto)) {
      this.form.mensaje_pie = `${this.form.mensaje_pie.trim()}\n${texto}`;
    }
  }

  async probarGeneracionPdf(formato: FormatoImpresion): Promise<void> {
    this.probandoPdf.set(true);
    this.error.set(null);
    try {
      const cfgMock: ConfiguracionRecibos = {
        id: 1,
        nombre_institucion: this.form.nombre_institucion || 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO',
        subtitulo:          this.form.subtitulo || 'Mercado Municipal — Control Interno',
        mensaje_pie:        this.form.mensaje_pie || 'Gracias por su puntualidad.',
        color_principal:    this.form.color_principal || '#166534',
        formato_impresion:  formato,
      };
      await this.pdfSvc.generarYAbrir(DATOS_MOCK_PREVIEW, formato, cfgMock);
    } catch (e: unknown) {
      this.error.set(`Error al probar generación en PDF: ${e instanceof Error ? e.message : 'desconocido'}`);
    } finally {
      this.probandoPdf.set(false);
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
