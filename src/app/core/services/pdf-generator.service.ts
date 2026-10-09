import { inject, Injectable } from '@angular/core';
import {
  ConfiguracionRecibos,
  ConfiguracionRecibosService,
} from './configuracion-recibos.service';
import type { ArqueoConcepto, ArqueoPago, ArqueoResumen, GastoArqueoRow } from './reportes.service';
// @types/pdfmake no re-exporta TDocumentDefinitions ni TVirtualFileSystem desde
// su API pública, pero sí las usa en las firmas de sus funciones exportadas.
// Usamos `import type * as` para obtener el tipo del namespace y extraemos
// los parámetros con Parameters<> — sin necesidad de `any`.
import type * as PdfMakeNS from 'pdfmake/build/pdfmake';
import type { CustomTableLayout, TableCell } from 'pdfmake/build/pdfmake';

type DocDefinition  = Parameters<typeof PdfMakeNS.createPdf>[0];
type VirtualFs      = Parameters<typeof PdfMakeNS.addVirtualFileSystem>[0];
type FontDictionary = Parameters<typeof PdfMakeNS.addFonts>[0];

// ---------------------------------------------------------------------------
// Interfaces públicas para construir el recibo desde el Wizard
// ---------------------------------------------------------------------------
export interface LinhaRecibo {
  concepto: string;
  periodo: string;
  saldo_original: number;
  aplicado: number;
  cubierto_completo: boolean;
}

export interface PadronElectoralPersona {
  dni: string;
  nombres: string;
  apellidos: string;
  codigo_puesto: string | null;
}

export interface PadronElectoralMorosoPdf extends PadronElectoralPersona {
  deuda_total: number;
}

export interface PadronElectoralPdfDatos {
  generado_en: string;
  total_activos: number;
  habiles: PadronElectoralPersona[];
  inhabilitados: PadronElectoralMorosoPdf[];
}

export interface MovimientoBancarioPdfItem {
  fecha: string;
  banco: string;
  cuenta: string;
  tipo: 'Ingreso' | 'Egreso';
  motivo: string | null;
  nro_operacion: string | null;
  monto: number;
}

export interface ReporteMovimientosPdfDatos {
  periodo_desde: string;
  periodo_hasta: string;
  filtro_cuenta: string;
  filtro_tipo: string;
  generado_en: string;
  total_movimientos: number;
  total_ingresos: number;
  total_egresos: number;
  movimiento_neto: number;
  movimientos: MovimientoBancarioPdfItem[];
}

export interface ResumenDeudaPersonaPdfItem {
  tipo: 'Socio' | 'Inquilino';
  identificacion: string;
  nombre: string;
  puesto: string;
  cant_pendientes: number;
  total_pendiente: number;
}

export interface ResumenDeudasPdfDatos {
  generado_en: string;
  filtro_tipo: string;
  filtro_estado: string;
  total_personas: number;
  personas_con_deuda: number;
  deuda_socios: number;
  deuda_inquilinos: number;
  total_pendiente: number;
  personas: ResumenDeudaPersonaPdfItem[];
}

export interface EstadoCuentaFilaPendientePdf {
  periodo: string;
  concepto: string;
  puesto: string;
  monto_original: number;
  ya_pagado: number;
  saldo_pendiente: number;
}

export interface EstadoCuentaFilaPagoPdf {
  fecha: string;
  codigo_transaccion: string;
  metodo_pago: string;
  conceptos: string;
  comprobante: string;
  monto: number;
}

export interface EstadoCuentaFilaCompletoPdf {
  fecha: string;
  tipo: 'Cargo' | 'Pago';
  periodo: string;
  concepto: string;
  comprobante: string;
  cargo: number;
  pago: number;
}

export interface EstadoCuentaIndividualPdfDatos {
  generado_en: string;
  tipo_persona: 'Socio' | 'Inquilino';
  nombre: string;
  dni: string;
  puesto: string;
  sub_vista: 'pendientes' | 'pagos' | 'completo';
  periodo_label: string;
  saldo_pendiente_actual: number;
  saldo_a_favor?: number;
  total_cargos_periodo?: number;
  total_pagos_periodo?: number;
  filas_pendientes?: EstadoCuentaFilaPendientePdf[];
  filas_pagos?: EstadoCuentaFilaPagoPdf[];
  filas_completo?: EstadoCuentaFilaCompletoPdf[];
}

export interface ReciboDatos {
  codigo_transaccion: string;
  fecha_pago: Date;
  cajero: string;
  nombre_pagador: string;
  tipo_pagador: 'Socio titular' | 'Inquilino';
  dni_pagador: string;
  codigo_puesto: string;
  metodo_pago: 'Efectivo' | 'Transferencia';
  comprobante: string | null;
  observacion?: string | null;
  detalle: LinhaRecibo[];
  total_pagado: number;
  saldo_a_favor: number;
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
const MESES_ES = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
];

function formatFechaLarga(d: Date): string {
  const hh = d.getHours().toString().padStart(2, '0');
  const mm = d.getMinutes().toString().padStart(2, '0');
  return `${d.getDate()} de ${MESES_ES[d.getMonth()]} de ${d.getFullYear()} — ${hh}:${mm} hrs`;
}

const FUENTES: FontDictionary = {
  Roboto: {
    normal: 'Roboto-Regular.ttf',
    bold: 'Roboto-Medium.ttf',
    italics: 'Roboto-Italic.ttf',
    bolditalics: 'Roboto-MediumItalic.ttf',
  },
};

function formatFechaArqueo(fechaYYYYMMDD: string): string {
  const [y, m, d] = fechaYYYYMMDD.split('-').map(Number);
  return `${d} de ${MESES_ES[m - 1]} de ${y}`;
}

function formatHoraISO(iso: string): string {
  const d = new Date(iso);
  return `${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`;
}

// ---------------------------------------------------------------------------
// Colores del ARQUEO (azul institucional — no cambia con la config)
// ---------------------------------------------------------------------------
const C = {
  azul:      '#1E40AF',
  azulClaro: '#2563EB',
  verde:     '#16A34A',
  amber:     '#D97706',
  grisTxt:   '#6B7280',
  grisBorde: '#D1D5DB',
  fondoFila: '#F9FAFB',
  negro:     '#111827',
  grisOsc:   '#374151',
} as const;

// ---------------------------------------------------------------------------
// Colores del RECIBO (verde/dorado — derivados de la config corporativa)
// Se construyen por función para que reflejen color_principal dinámico.
// ---------------------------------------------------------------------------
interface ColoresRecibo {
  primario:   string;   // = color_principal (verde #166534 por defecto)
  acento:     string;   // verde intermedio para tablas
  dorado:     string;   // #D97706 amber-600 — acento cálido
  bordeOro:   string;   // #FBBF24 amber-400 — doble línea
  fondoVerde: string;   // #F0FDF4 green-50  — filas pares
  grisTxt:    string;
  grisBorde:  string;
  negro:      string;
  grisOsc:    string;
}

function coloresRecibo(colorPrincipal: string): ColoresRecibo {
  return {
    primario:   colorPrincipal,
    acento:     '#15803D',  // green-700 — headers de tabla
    dorado:     '#D97706',
    bordeOro:   '#FBBF24',
    fondoVerde: '#F0FDF4',
    grisTxt:    '#6B7280',
    grisBorde:  '#D1D5DB',
    negro:      '#111827',
    grisOsc:    '#374151',
  };
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class PdfGeneratorService {
  private readonly configSvc = inject(ConfiguracionRecibosService);
  private fontsRegistered = false;

  /** Genera el recibo y lo abre en nueva pestaña del navegador. */
  async generarYAbrir(datos: ReciboDatos): Promise<void> {
    const [pm, cfg, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.configSvc.cargar(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    await pm.createPdf(this.construirDocumento(datos, cfg, logoB64)).open();
  }

  /** Genera el recibo y lo descarga automáticamente. */
  async descargar(datos: ReciboDatos): Promise<void> {
    const [pm, cfg, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.configSvc.cargar(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    await pm.createPdf(this.construirDocumento(datos, cfg, logoB64))
      .download(`recibo-${datos.codigo_transaccion}.pdf`);
  }

  /** Convierte una imagen local en base64 para pdfmake. Devuelve null si falla. */
  private async fetchImageAsBase64(url: string): Promise<string | null> {
    try {
      const res = await fetch(url);
      if (!res.ok) return null;
      const blob = await res.blob();
      return await new Promise<string>((resolve, reject) => {
        const reader = new FileReader();
        reader.onload  = () => resolve(reader.result as string);
        reader.onerror = reject;
        reader.readAsDataURL(blob);
      });
    } catch {
      return null;
    }
  }

  // -------------------------------------------------------------------------
  // Arqueo de caja
  // -------------------------------------------------------------------------

  /** Genera el arqueo diario y lo abre en nueva pestaña. */
  async generarArqueoYAbrir(resumen: ArqueoResumen, cajero: string): Promise<void> {
    const pm = await this.cargarModulo();
    await pm.createPdf(this.construirDocumentoArqueo(resumen, cajero)).open();
  }

  /** Genera el arqueo diario y lo descarga. */
  async descargarArqueo(resumen: ArqueoResumen, cajero: string): Promise<void> {
    const pm = await this.cargarModulo();
    await pm.createPdf(this.construirDocumentoArqueo(resumen, cajero))
      .download(`arqueo-${resumen.fecha}.pdf`);
  }

  private construirDocumentoArqueo(r: ArqueoResumen, cajero: string): DocDefinition {
    const pct = (n: number) =>
      r.total_dia > 0 ? `${((n / r.total_dia) * 100).toFixed(0)}%` : '0%';

    // ── Layouts reutilizables ──────────────────────────────────────────────
    const layoutBordes: CustomTableLayout = {
      hLineWidth: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? 1.5 : 0.5,
      vLineWidth: () => 0.5,
      hLineColor: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? C.azul : C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? null : row % 2 === 0 ? C.fondoFila : null),
      paddingTop: () => 4,
      paddingBottom: () => 4,
      paddingLeft: () => 6,
      paddingRight: () => 6,
    };

    const layoutResumen: CustomTableLayout = {
      hLineWidth: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length || i === node.table.body.length - 1 ? 1.5 : 0.5,
      vLineWidth: () => 0.5,
      hLineColor: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length || i === node.table.body.length - 1 ? C.azul : C.grisBorde,
      vLineColor: () => C.grisBorde,
      paddingTop: () => 5,
      paddingBottom: () => 5,
      paddingLeft: () => 8,
      paddingRight: () => 8,
    };

    const encTH = (t: string, al: 'left' | 'center' | 'right' = 'left'): TableCell =>
      ({ text: t, fontSize: 7.5, bold: true, color: 'white', fillColor: C.azulClaro, alignment: al });

    const encTHRojo = (t: string, al: 'left' | 'center' | 'right' = 'left'): TableCell =>
      ({ text: t, fontSize: 7.5, bold: true, color: 'white', fillColor: '#B91C1C', alignment: al });

    // ── Tabla KPI (4 columnas: Ingresos, Efectivo, Transferencia, Saldo Neto) ─
    const saldoColor = r.saldo_neto >= 0 ? C.verde : '#B91C1C';
    const saldoBg    = r.saldo_neto >= 0 ? '#F0FDF4' : '#FEF2F2';
    const kpiTable: DocDefinition = {
      table: {
        widths: ['*', '*', '*', '*'],
        body: [[
          {
            stack: [
              { text: 'INGRESOS TOTALES', fontSize: 8, bold: true, color: C.grisTxt },
              { text: `S/ ${r.total_dia.toFixed(2)}`, fontSize: 18, bold: true, color: C.azul, margin: [0, 4, 0, 2] },
              { text: `${r.cantidad_recibos} recibo${r.cantidad_recibos !== 1 ? 's' : ''}`, fontSize: 8, color: C.grisTxt },
            ],
            fillColor: '#F0F4FF', margin: [8, 8, 8, 8],
          },
          {
            stack: [
              { text: 'EFECTIVO (GAVETA)', fontSize: 8, bold: true, color: '#166534' },
              { text: `S/ ${r.total_efectivo.toFixed(2)}`, fontSize: 18, bold: true, color: C.verde, margin: [0, 4, 0, 2] },
              { text: pct(r.total_efectivo), fontSize: 8, color: '#166534' },
            ],
            fillColor: '#F0FDF4', margin: [8, 8, 8, 8],
          },
          {
            stack: [
              { text: 'EGRESOS DEL DÍA', fontSize: 8, bold: true, color: '#92400E' },
              { text: `S/ ${r.total_gastos.toFixed(2)}`, fontSize: 18, bold: true, color: '#D97706', margin: [0, 4, 0, 2] },
              { text: `${r.gastos.length} egreso${r.gastos.length !== 1 ? 's' : ''}`, fontSize: 8, color: '#92400E' },
            ],
            fillColor: '#FFFBEB', margin: [8, 8, 8, 8],
          },
          {
            stack: [
              { text: 'SALDO NETO EN CAJA', fontSize: 8, bold: true, color: saldoColor },
              { text: `S/ ${r.saldo_neto.toFixed(2)}`, fontSize: 18, bold: true, color: saldoColor, margin: [0, 4, 0, 2] },
              { text: 'Ingresos − Egresos', fontSize: 8, color: saldoColor },
            ],
            fillColor: saldoBg, margin: [8, 8, 8, 8],
          },
        ]],
      },
      layout: {
        hLineWidth: () => 1, vLineWidth: () => 1,
        hLineColor: () => C.grisBorde, vLineColor: () => C.grisBorde,
      },
      margin: [0, 0, 0, 16],
    } as unknown as DocDefinition;

    // ── Tabla Resumen Financiero ───────────────────────────────────────────
    const resumenFinanciero: DocDefinition = {
      table: {
        widths: ['*', '30%'],
        body: [
          [
            { text: 'Ingresos totales del día', fontSize: 9, color: C.grisOsc },
            { text: `S/ ${r.total_dia.toFixed(2)}`, fontSize: 9, bold: true, color: C.negro, alignment: 'right' as const },
          ],
          [
            { text: '(−) Egresos del día', fontSize: 9, color: '#B91C1C' },
            { text: `S/ ${r.total_gastos.toFixed(2)}`, fontSize: 9, bold: true, color: '#B91C1C', alignment: 'right' as const },
          ],
          [
            { text: '(=) SALDO NETO EN CAJA', fontSize: 10, bold: true, color: saldoColor, fillColor: saldoBg },
            { text: `S/ ${r.saldo_neto.toFixed(2)}`, fontSize: 11, bold: true, color: saldoColor, alignment: 'right' as const, fillColor: saldoBg },
          ],
        ],
      },
      layout: layoutResumen,
      margin: [0, 0, 0, 20],
    } as unknown as DocDefinition;

    // ── Tabla desglose por concepto ────────────────────────────────────────
    const filasConcepto: TableCell[][] = r.por_concepto.map((c: ArqueoConcepto) => [
      { text: c.concepto, fontSize: 9, color: C.grisOsc },
      { text: String(c.cantidad), fontSize: 9, color: C.grisOsc, alignment: 'center' as const },
      { text: `S/ ${c.monto.toFixed(2)}`, fontSize: 9, bold: true, color: C.negro, alignment: 'right' as const },
      { text: pct(c.monto), fontSize: 9, color: C.grisTxt, alignment: 'right' as const },
    ]);

    const filaTotalConcepto: TableCell[] = [
      { text: 'TOTAL', fontSize: 9, bold: true, color: C.azul },
      { text: String(r.por_concepto.reduce((s, c) => s + c.cantidad, 0)),
        fontSize: 9, bold: true, color: C.azul, alignment: 'center' as const },
      { text: `S/ ${r.total_dia.toFixed(2)}`, fontSize: 11, bold: true, color: C.azulClaro, alignment: 'right' as const },
      { text: '100%', fontSize: 9, color: C.grisTxt, alignment: 'right' as const },
    ];

    // ── Tabla recibos ──────────────────────────────────────────────────────
    const filasRecibos: TableCell[][] = r.recibos.map((p: ArqueoPago) => [
      { text: formatHoraISO(p.fecha_pago), fontSize: 8, color: C.grisOsc },
      { text: p.codigo_transaccion, fontSize: 7.5, color: C.azulClaro },
      { text: p.pagador, fontSize: 8, color: C.grisOsc },
      { text: p.codigo_puesto, fontSize: 8, color: C.grisOsc, alignment: 'center' as const },
      { text: p.conceptos.join(', '), fontSize: 7.5, color: C.grisTxt },
      { text: p.metodo_pago, fontSize: 8, color: p.metodo_pago === 'Efectivo' ? C.verde : '#1D4ED8', alignment: 'center' as const },
      { text: `S/ ${p.monto_total.toFixed(2)}`, fontSize: 8, bold: true, color: C.negro, alignment: 'right' as const },
    ]);

    const filaTotalRecibos: TableCell[] = [
      { text: 'TOTAL INGRESOS', fontSize: 9, bold: true, color: C.azul, colSpan: 6, alignment: 'right' as const },
      {}, {}, {}, {}, {},
      { text: `S/ ${r.total_dia.toFixed(2)}`, fontSize: 10, bold: true, color: C.azulClaro, alignment: 'right' as const },
    ];

    // ── Sección de Egresos (condicional) ───────────────────────────────────
    const filasGastos: TableCell[][] = r.gastos.map((g: GastoArqueoRow) => [
      { text: g.fecha, fontSize: 8, color: C.grisOsc },
      { text: g.comprobante_ref ?? '—', fontSize: 8, color: C.grisOsc },
      { text: g.responsable ?? '—', fontSize: 8, color: C.grisOsc },
      { text: g.categoria_nombre, fontSize: 8, color: C.grisOsc },
      { text: g.descripcion ?? '—', fontSize: 7.5, color: C.grisTxt },
      { text: `S/ ${g.monto.toFixed(2)}`, fontSize: 8, bold: true, color: '#B91C1C', alignment: 'right' as const },
    ]);

    const filaTotalGastos: TableCell[] = [
      { text: 'TOTAL EGRESOS', fontSize: 9, bold: true, color: '#B91C1C', colSpan: 5, alignment: 'right' as const },
      {}, {}, {}, {},
      { text: `S/ ${r.total_gastos.toFixed(2)}`, fontSize: 10, bold: true, color: '#B91C1C', alignment: 'right' as const },
    ];

    const seccionGastos = r.gastos.length > 0
      ? [
          { text: 'EGRESOS DEL DÍA', fontSize: 9, bold: true, decoration: 'underline', color: '#B91C1C', margin: [0, 0, 0, 5] },
          {
            table: {
              headerRows: 1,
              widths: ['12%', '14%', '18%', '16%', '*', '14%'],
              body: [
                [
                  encTHRojo('Fecha'),
                  encTHRojo('Comprobante'),
                  encTHRojo('Responsable'),
                  encTHRojo('Categoría'),
                  encTHRojo('Detalle'),
                  encTHRojo('Monto', 'right'),
                ],
                ...filasGastos,
                filaTotalGastos,
              ],
            },
            layout: {
              ...layoutBordes,
              hLineColor: (i: number, node: { table: { body: unknown[] } }) =>
                i === 0 || i === node.table.body.length ? '#B91C1C' : C.grisBorde,
            } as CustomTableLayout,
            margin: [0, 0, 0, 20],
          },
        ]
      : [];

    // ── Documento ──────────────────────────────────────────────────────────
    return {
      pageSize: 'A4',
      pageMargins: [40, 48, 40, 60],
      defaultStyle: { font: 'Roboto', fontSize: 9, lineHeight: 1.3 },

      content: [

        // Encabezado
        {
          alignment: 'center',
          stack: [
            { text: 'COOPERATIVA DE COMERCIANTES', fontSize: 12, color: C.grisTxt },
            { text: 'PRIMERO DE MAYO', fontSize: 20, bold: true, color: C.azul, margin: [0, 2, 0, 3] },
            { text: 'Mercado Municipal', fontSize: 9, color: C.grisTxt },
          ],
        },
        {
          canvas: [{ type: 'line', x1: 0, y1: 4, x2: 515, y2: 4, lineWidth: 2.5, lineColor: C.azulClaro }],
          margin: [0, 8, 0, 10],
        },
        {
          table: { widths: ['*'], body: [[{
            text: 'A R Q U E O   D E   C A J A   D I A R I O',
            fontSize: 14, bold: true, alignment: 'center', color: 'white',
            fillColor: C.azulClaro, margin: [0, 8, 0, 8],
          }]] },
          layout: 'noBorders',
          margin: [0, 0, 0, 10],
        },
        {
          columns: [
            { text: `Fecha: ${formatFechaArqueo(r.fecha)}`, fontSize: 10, bold: true, color: C.negro },
            { text: `Cajero: ${cajero}`, fontSize: 9, color: C.grisOsc, alignment: 'center' as const },
            { text: `Impreso: ${new Date().toLocaleString('es-PE')}`, fontSize: 8, color: C.grisTxt, alignment: 'right' as const },
          ],
          margin: [0, 0, 0, 16],
        },

        // KPIs (4 bloques: Ingresos, Efectivo, Egresos, Saldo Neto)
        kpiTable,

        // Resumen financiero (tabla de deducción)
        { text: 'RESUMEN FINANCIERO', fontSize: 9, bold: true, decoration: 'underline', color: C.azul, margin: [0, 0, 0, 5] },
        resumenFinanciero,

        // Desglose por concepto
        { text: 'DESGLOSE POR CONCEPTO DE INGRESOS', fontSize: 9, bold: true, decoration: 'underline', color: C.azul, margin: [0, 0, 0, 5] },
        r.por_concepto.length > 0
          ? {
              table: {
                headerRows: 1,
                widths: ['*', '12%', '18%', '12%'],
                body: [
                  [encTH('Concepto'), encTH('Recibos', 'center'), encTH('Monto', 'right'), encTH('% Día', 'right')],
                  ...filasConcepto,
                  filaTotalConcepto,
                ],
              },
              layout: layoutBordes,
              margin: [0, 0, 0, 20],
            }
          : { text: 'Sin cobros en esta fecha.', fontSize: 9, color: C.grisTxt, margin: [0, 0, 0, 20], italics: true },

        // Lista de recibos
        { text: 'DETALLE DE RECIBOS EMITIDOS', fontSize: 9, bold: true, decoration: 'underline', color: C.azul, margin: [0, 0, 0, 5] },
        r.recibos.length > 0
          ? {
              table: {
                headerRows: 1,
                widths: ['7%', '22%', '22%', '8%', '*', '10%', '12%'],
                body: [
                  [
                    encTH('Hora'), encTH('Código'), encTH('Pagador'),
                    encTH('Puesto', 'center'), encTH('Conceptos'),
                    encTH('Método', 'center'), encTH('Monto', 'right'),
                  ],
                  ...filasRecibos,
                  filaTotalRecibos,
                ],
              },
              layout: layoutBordes,
              margin: [0, 0, 0, r.gastos.length > 0 ? 16 : 24],
            }
          : { text: 'Sin recibos registrados.', fontSize: 9, color: C.grisTxt, margin: [0, 0, 0, 16], italics: true },

        // Sección egresos (condicional)
        ...seccionGastos,

        // Firma
        {
          columns: [
            {
              width: '55%',
              stack: [
                { text: '\n\n' },
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 0.75, lineColor: '#9CA3AF', dash: { length: 4 } }] },
                { text: 'Firma del cajero responsable', fontSize: 7.5, color: '#9CA3AF', margin: [0, 3, 0, 0] },
                { text: cajero, fontSize: 9, bold: true, color: C.grisOsc, margin: [0, 2, 0, 0] },
              ],
            },
            {
              width: '45%',
              alignment: 'center',
              stack: [{
                table: { widths: ['*'], body: [[{
                  text: '☐  Conforme\n☐  Con observaciones',
                  fontSize: 9, color: C.grisOsc, margin: [12, 8, 12, 8],
                }]] },
                layout: { hLineWidth: () => 1, vLineWidth: () => 1,
                          hLineColor: () => C.grisBorde, vLineColor: () => C.grisBorde },
                margin: [20, 0, 0, 0],
              }],
            },
          ],
        },
      ],

      footer: (currentPage: number, pageCount: number, _ps: unknown) => ({
        stack: [
          { canvas: [{ type: 'line', x1: 40, y1: 0, x2: 555, y2: 0, lineWidth: 0.5, lineColor: C.grisBorde }] },
          {
            columns: [
              { text: `Arqueo de Caja — ${formatFechaArqueo(r.fecha)} — Cooperativa Primero de Mayo`, fontSize: 7, color: '#9CA3AF', margin: [40, 4, 0, 0] },
              { text: `Página ${currentPage} de ${pageCount}`, fontSize: 7, color: '#9CA3AF', alignment: 'right', margin: [0, 4, 40, 0] },
            ],
          },
        ],
      }),

    } as unknown as DocDefinition;
  }

  // -------------------------------------------------------------------------
  // Padrón Electoral (Asambleas)
  // -------------------------------------------------------------------------

  /** Genera el padrón electoral (hábiles/inhabilitados) y lo abre en nueva pestaña. */
  async generarPadronElectoralYAbrir(datos: PadronElectoralPdfDatos): Promise<void> {
    const pm = await this.cargarModulo();
    await pm.createPdf(this.construirDocumentoPadronElectoral(datos)).open();
  }

  /** Genera el padrón electoral y lo descarga. */
  async descargarPadronElectoral(datos: PadronElectoralPdfDatos): Promise<void> {
    const pm = await this.cargarModulo();
    await pm.createPdf(this.construirDocumentoPadronElectoral(datos))
      .download(`padron-electoral-${new Date().toISOString().slice(0, 10)}.pdf`);
  }

  private construirDocumentoPadronElectoral(d: PadronElectoralPdfDatos): DocDefinition {
    const layoutBordes: CustomTableLayout = {
      hLineWidth: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? 1.5 : 0.5,
      vLineWidth: () => 0.5,
      hLineColor: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? C.azul : C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? null : row % 2 === 0 ? C.fondoFila : null),
      paddingTop: () => 4,
      paddingBottom: () => 4,
      paddingLeft: () => 6,
      paddingRight: () => 6,
    };

    const encTH = (t: string, al: 'left' | 'center' | 'right' = 'left'): TableCell =>
      ({ text: t, fontSize: 7.5, bold: true, color: 'white', fillColor: C.azulClaro, alignment: al });

    const encTHRojo = (t: string, al: 'left' | 'center' | 'right' = 'left'): TableCell =>
      ({ text: t, fontSize: 7.5, bold: true, color: 'white', fillColor: '#B91C1C', alignment: al });

    const filasHabiles: TableCell[][] = d.habiles.map(s => [
      { text: `${s.apellidos}, ${s.nombres}`, fontSize: 8, color: C.negro },
      { text: s.dni, fontSize: 8, color: C.grisTxt, alignment: 'center' as const },
      { text: s.codigo_puesto ?? '—', fontSize: 8, color: C.grisTxt, alignment: 'center' as const },
    ]);

    const filasInhabilitados: TableCell[][] = d.inhabilitados.map(s => [
      { text: `${s.apellidos}, ${s.nombres}`, fontSize: 8, color: C.negro },
      { text: s.dni, fontSize: 8, color: C.grisTxt, alignment: 'center' as const },
      { text: s.codigo_puesto ?? '—', fontSize: 8, color: C.grisTxt, alignment: 'center' as const },
      { text: `S/ ${s.deuda_total.toFixed(2)}`, fontSize: 8, bold: true, color: '#B91C1C', alignment: 'right' as const },
    ]);

    const totalDeuda = d.inhabilitados.reduce((s, r) => s + r.deuda_total, 0);
    const filaTotalDeuda: TableCell[] = [
      { text: 'TOTAL DEUDA PENDIENTE', fontSize: 8.5, bold: true, color: C.negro, colSpan: 3, fillColor: '#FEF2F2' },
      {}, {},
      { text: `S/ ${totalDeuda.toFixed(2)}`, fontSize: 8.5, bold: true, color: '#B91C1C', alignment: 'right' as const, fillColor: '#FEF2F2' },
    ];

    return {
      pageSize: 'A4',
      pageMargins: [40, 48, 40, 60],
      defaultStyle: { font: 'Roboto', fontSize: 9, lineHeight: 1.3 },

      content: [
        {
          alignment: 'center',
          stack: [
            { text: 'COOPERATIVA DE COMERCIANTES', fontSize: 12, color: C.grisTxt },
            { text: 'PRIMERO DE MAYO', fontSize: 20, bold: true, color: C.azul, margin: [0, 2, 0, 3] },
            { text: 'Mercado Municipal', fontSize: 9, color: C.grisTxt },
          ],
        },
        {
          canvas: [{ type: 'line', x1: 0, y1: 4, x2: 515, y2: 4, lineWidth: 2.5, lineColor: C.azulClaro }],
          margin: [0, 8, 0, 10],
        },
        {
          table: { widths: ['*'], body: [[{
            text: 'P A D R Ó N   E L E C T O R A L   —   A S A M B L E A',
            fontSize: 13, bold: true, alignment: 'center', color: 'white',
            fillColor: C.azulClaro, margin: [0, 8, 0, 8],
          }]] },
          layout: 'noBorders',
          margin: [0, 0, 0, 10],
        },
        {
          columns: [
            { text: `Socios activos: ${d.total_activos}`, fontSize: 10, bold: true, color: C.negro },
            { text: `Hábiles: ${d.habiles.length}  ·  Inhabilitados: ${d.inhabilitados.length}`, fontSize: 9, color: C.grisOsc, alignment: 'center' as const },
            { text: `Generado: ${new Date(d.generado_en).toLocaleString('es-PE')}`, fontSize: 8, color: C.grisTxt, alignment: 'right' as const },
          ],
          margin: [0, 0, 0, 16],
        },

        { text: `SOCIOS HÁBILES (AL DÍA) — ${d.habiles.length}`, fontSize: 9, bold: true, decoration: 'underline', color: C.verde, margin: [0, 0, 0, 5] },
        d.habiles.length > 0
          ? {
              table: {
                headerRows: 1,
                widths: ['*', '22%', '18%'],
                body: [
                  [encTH('Socio'), encTH('DNI', 'center'), encTH('Puesto', 'center')],
                  ...filasHabiles,
                ],
              },
              layout: layoutBordes,
              margin: [0, 0, 0, 20],
            }
          : { text: 'Sin socios hábiles.', fontSize: 9, color: C.grisTxt, margin: [0, 0, 0, 20], italics: true },

        { text: `SOCIOS INHABILITADOS (MOROSOS) — ${d.inhabilitados.length}`, fontSize: 9, bold: true, decoration: 'underline', color: '#B91C1C', margin: [0, 0, 0, 5] },
        d.inhabilitados.length > 0
          ? {
              table: {
                headerRows: 1,
                widths: ['*', '18%', '15%', '18%'],
                body: [
                  [encTHRojo('Socio'), encTHRojo('DNI', 'center'), encTHRojo('Puesto', 'center'), encTHRojo('Deuda', 'right')],
                  ...filasInhabilitados,
                  filaTotalDeuda,
                ],
              },
              layout: layoutBordes,
            }
          : { text: 'Sin socios inhabilitados. Padrón al día.', fontSize: 9, color: C.verde, italics: true },
      ],

      footer: (currentPage: number, pageCount: number, _ps: unknown) => ({
        stack: [
          { canvas: [{ type: 'line', x1: 40, y1: 0, x2: 555, y2: 0, lineWidth: 0.5, lineColor: C.grisBorde }] },
          {
            columns: [
              { text: 'Padrón Electoral — Cooperativa Primero de Mayo', fontSize: 7, color: '#9CA3AF', margin: [40, 4, 0, 0] },
              { text: `Página ${currentPage} de ${pageCount}`, fontSize: 7, color: '#9CA3AF', alignment: 'right', margin: [0, 4, 40, 0] },
            ],
          },
        ],
      }),

    } as unknown as DocDefinition;
  }

  // -------------------------------------------------------------------------
  // Reporte de Movimientos Bancarios
  // -------------------------------------------------------------------------

  /** Genera el reporte de movimientos bancarios y lo abre en nueva pestaña. */
  async generarReporteMovimientosYAbrir(datos: ReporteMovimientosPdfDatos): Promise<void> {
    const [pm, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    await pm.createPdf(this.construirDocumentoReporteMovimientos(datos, logoB64)).open();
  }

  /** Genera el reporte de movimientos bancarios y lo descarga. */
  async descargarReporteMovimientos(datos: ReporteMovimientosPdfDatos): Promise<void> {
    const [pm, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    const filename = `reporte-movimientos-${datos.periodo_desde}-a-${datos.periodo_hasta}.pdf`;
    await pm.createPdf(this.construirDocumentoReporteMovimientos(datos, logoB64)).download(filename);
  }

  private construirDocumentoReporteMovimientos(d: ReporteMovimientosPdfDatos, logoB64: string | null): DocDefinition {
    const layoutBordes: CustomTableLayout = {
      hLineWidth: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? 1.5 : 0.5,
      vLineWidth: () => 0.5,
      hLineColor: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? C.azul : C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? null : row % 2 === 0 ? C.fondoFila : null),
      paddingTop: () => 4,
      paddingBottom: () => 4,
      paddingLeft: () => 6,
      paddingRight: () => 6,
    };

    const layoutBordesResumen: CustomTableLayout = {
      hLineWidth: () => 0.5,
      vLineWidth: () => 0.5,
      hLineColor: () => C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? '#F3F4F6' : null),
      paddingTop: () => 4,
      paddingBottom: () => 4,
      paddingLeft: () => 6,
      paddingRight: () => 6,
    };

    const encTH = (t: string, al: 'left' | 'center' | 'right' = 'left'): TableCell =>
      ({ text: t, fontSize: 8, bold: true, color: 'white', fillColor: C.azulClaro, alignment: al });

    const filasMovimientos: TableCell[][] = d.movimientos.map(m => [
      { text: m.fecha, fontSize: 8, color: C.grisTxt, alignment: 'center' as const },
      {
        stack: [
          { text: m.banco, fontSize: 8, bold: true, color: C.negro },
          { text: m.cuenta, fontSize: 7, color: C.grisTxt },
        ],
      },
      {
        text: m.tipo,
        fontSize: 7.5,
        bold: true,
        alignment: 'center' as const,
        color: m.tipo === 'Ingreso' ? C.verde : '#B91C1C',
      },
      { text: m.motivo || '—', fontSize: 8, color: C.grisOsc },
      { text: m.nro_operacion || '—', fontSize: 7.5, alignment: 'center' as const, color: C.grisTxt },
      {
        text: `${m.tipo === 'Ingreso' ? '+' : '−'} S/ ${m.monto.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`,
        fontSize: 8,
        bold: true,
        alignment: 'right' as const,
        color: m.tipo === 'Ingreso' ? C.verde : '#B91C1C',
      },
    ]);

    const headerColumns: unknown[] = [];
    if (logoB64) {
      headerColumns.push({
        image: logoB64,
        width: 48,
        fit: [48, 48],
        margin: [0, 0, 12, 0],
      });
    }
    headerColumns.push({
      width: '*',
      stack: [
        { text: 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.', fontSize: 13, bold: true, color: C.azul },
        { text: 'REPORTE DE MOVIMIENTOS BANCARIOS', fontSize: 11, bold: true, color: C.negro, margin: [0, 2, 0, 2] },
        { text: `Período: ${d.periodo_desde} al ${d.periodo_hasta}   ·   Cuenta: ${d.filtro_cuenta}   ·   Tipo: ${d.filtro_tipo}`, fontSize: 8.5, color: C.grisTxt },
      ],
    });
    headerColumns.push({
      width: 'auto',
      alignment: 'right',
      stack: [
        { text: `Generado: ${d.generado_en}`, fontSize: 8, color: C.grisTxt },
      ],
    });

    const bodyTabla: TableCell[][] = [
      [
        encTH('Fecha', 'center'),
        encTH('Banco / Cuenta'),
        encTH('Tipo', 'center'),
        encTH('Motivo / Detalle'),
        encTH('N.º Operación', 'center'),
        encTH('Monto', 'right'),
      ],
    ];

    if (filasMovimientos.length > 0) {
      bodyTabla.push(...filasMovimientos);
    } else {
      bodyTabla.push([
        {
          text: 'No se encontraron movimientos bancarios para el período seleccionado.',
          colSpan: 6,
          alignment: 'center' as const,
          fontSize: 8.5,
          color: C.grisTxt,
          italics: true,
          margin: [0, 10, 0, 10],
        },
        {}, {}, {}, {}, {},
      ]);
    }

    return {
      pageSize: 'A4',
      pageOrientation: 'landscape',
      pageMargins: [35, 35, 35, 45],
      defaultStyle: { font: 'Roboto', fontSize: 8.5, lineHeight: 1.25 },

      content: [
        { columns: headerColumns, margin: [0, 0, 0, 8] },
        {
          canvas: [{ type: 'line', x1: 0, y1: 0, x2: 772, y2: 0, lineWidth: 1.5, lineColor: C.azulClaro }],
          margin: [0, 0, 0, 10],
        },
        // Resumen
        {
          table: {
            widths: ['25%', '25%', '25%', '25%'],
            body: [
              [
                { text: 'TOTAL MOVIMIENTOS', fontSize: 7.5, bold: true, color: C.grisTxt, alignment: 'center' },
                { text: 'TOTAL INGRESOS', fontSize: 7.5, bold: true, color: C.verde, alignment: 'center' },
                { text: 'TOTAL EGRESOS', fontSize: 7.5, bold: true, color: '#B91C1C', alignment: 'center' },
                { text: 'MOVIMIENTO NETO DEL PERÍODO', fontSize: 7.5, bold: true, color: C.azul, alignment: 'center' },
              ],
              [
                { text: `${d.total_movimientos}`, fontSize: 11, bold: true, color: C.negro, alignment: 'center' },
                { text: `+ S/ ${d.total_ingresos.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 11, bold: true, color: C.verde, alignment: 'center' },
                { text: `− S/ ${d.total_egresos.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 11, bold: true, color: '#B91C1C', alignment: 'center' },
                { text: `${d.movimiento_neto >= 0 ? '+' : '−'} S/ ${Math.abs(d.movimiento_neto).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 11, bold: true, color: d.movimiento_neto >= 0 ? C.azul : '#B91C1C', alignment: 'center' },
              ],
            ],
          },
          layout: layoutBordesResumen,
          margin: [0, 0, 0, 12],
        },
        // Tabla de datos
        {
          table: {
            headerRows: 1,
            widths: ['9%', '21%', '9%', '38%', '11%', '12%'],
            body: bodyTabla,
          },
          layout: layoutBordes,
        },
      ],

      footer: (currentPage: number, pageCount: number, _ps: unknown) => ({
        stack: [
          { canvas: [{ type: 'line', x1: 35, y1: 0, x2: 807, y2: 0, lineWidth: 0.5, lineColor: C.grisBorde }] },
          {
            columns: [
              { text: 'Reporte de Movimientos Bancarios — Cooperativa Primero de Mayo', fontSize: 7, color: '#9CA3AF', margin: [35, 4, 0, 0] },
              { text: `Página ${currentPage} de ${pageCount}`, fontSize: 7, color: '#9CA3AF', alignment: 'right', margin: [0, 4, 35, 0] },
            ],
          },
        ],
      }),

    } as unknown as DocDefinition;
  }

  // -------------------------------------------------------------------------
  // Reporte de Estados de Cuenta — Resumen Consolidado de Deudas
  // -------------------------------------------------------------------------

  /** Genera el resumen consolidado de deudas en PDF y lo descarga. */
  async descargarPdfResumenDeudas(datos: ResumenDeudasPdfDatos): Promise<void> {
    const [pm, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    const cleanFecha = datos.generado_en.replace(/[^a-zA-Z0-9-]/g, '_');
    const filename = `resumen-deudas-${datos.filtro_tipo.toLowerCase()}-${cleanFecha}.pdf`;
    await pm.createPdf(this.construirDocumentoResumenDeudas(datos, logoB64)).download(filename);
  }

  private construirDocumentoResumenDeudas(d: ResumenDeudasPdfDatos, logoB64: string | null): DocDefinition {
    const layoutBordes: CustomTableLayout = {
      hLineWidth: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? 1.5 : 0.5,
      vLineWidth: () => 0.5,
      hLineColor: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? C.azul : C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? null : row % 2 === 0 ? C.fondoFila : null),
      paddingTop: () => 4,
      paddingBottom: () => 4,
      paddingLeft: () => 5,
      paddingRight: () => 5,
    };

    const layoutResumen: CustomTableLayout = {
      hLineWidth: () => 0.5,
      vLineWidth: () => 0.5,
      hLineColor: () => C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? '#F3F4F6' : null),
      paddingTop: () => 4,
      paddingBottom: () => 4,
      paddingLeft: () => 6,
      paddingRight: () => 6,
    };

    const encTH = (t: string, al: 'left' | 'center' | 'right' = 'left'): TableCell =>
      ({ text: t, fontSize: 8, bold: true, color: 'white', fillColor: C.azul, alignment: al });

    const headerColumns: unknown[] = [];
    if (logoB64) {
      headerColumns.push({
        image: logoB64,
        width: 44,
        fit: [44, 44],
        margin: [0, 0, 10, 0],
      });
    }

    headerColumns.push({
      stack: [
        { text: 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.', fontSize: 11, bold: true, color: C.azul },
        { text: 'REPORTE DE CUENTAS PENDIENTES — RESUMEN DE DEUDAS', fontSize: 13, bold: true, color: C.negro, margin: [0, 2, 0, 2] },
        { text: `Tipo: ${d.filtro_tipo}   ·   Filtro: ${d.filtro_estado}   ·   Emisión: ${d.generado_en}`, fontSize: 8, color: C.grisTxt },
      ],
    });

    const bodyTabla: TableCell[][] = [
      [
        encTH('Tipo', 'center'),
        encTH('Identificación', 'center'),
        encTH('Persona / Razón Social', 'left'),
        encTH('Puesto / Ref', 'center'),
        encTH('Pendientes', 'center'),
        encTH('Total Deuda', 'right'),
      ],
    ];

    if (d.personas.length > 0) {
      for (const p of d.personas) {
        bodyTabla.push([
          { text: p.tipo, fontSize: 8, alignment: 'center', color: p.tipo === 'Socio' ? C.azul : C.amber, bold: true },
          { text: p.identificacion || '—', fontSize: 8, alignment: 'center' },
          { text: p.nombre, fontSize: 8, bold: true },
          { text: p.puesto || '—', fontSize: 8, alignment: 'center' },
          { text: `${p.cant_pendientes}`, fontSize: 8, alignment: 'center' },
          {
            text: p.total_pendiente > 0 ? `S/ ${p.total_pendiente.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : 'S/ 0.00',
            fontSize: 8,
            alignment: 'right',
            bold: p.total_pendiente > 0,
            color: p.total_pendiente > 0 ? '#B91C1C' : C.grisTxt,
          },
        ]);
      }

      // Fila total consolidado
      bodyTabla.push([
        { text: 'TOTAL GENERAL CONSOLIDADO', colSpan: 5, alignment: 'right', fontSize: 8.5, bold: true, fillColor: '#F3F4F6' },
        {}, {}, {}, {},
        {
          text: `S/ ${d.total_pendiente.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`,
          fontSize: 9,
          bold: true,
          alignment: 'right',
          color: '#B91C1C',
          fillColor: '#F3F4F6',
        },
      ]);
    } else {
      bodyTabla.push([
        {
          text: 'No se encontraron personas con los filtros seleccionados.',
          colSpan: 6,
          alignment: 'center',
          fontSize: 8.5,
          color: C.grisTxt,
          italics: true,
          margin: [0, 10, 0, 10],
        },
        {}, {}, {}, {}, {},
      ]);
    }

    return {
      pageSize: 'A4',
      pageOrientation: 'landscape',
      pageMargins: [35, 30, 35, 40],
      defaultStyle: { font: 'Roboto', fontSize: 8.5, lineHeight: 1.25 },

      content: [
        { columns: headerColumns, margin: [0, 0, 0, 8] },
        {
          canvas: [{ type: 'line', x1: 0, y1: 0, x2: 772, y2: 0, lineWidth: 1.5, lineColor: C.azulClaro }],
          margin: [0, 0, 0, 10],
        },
        // Bloque de KPIs
        {
          table: {
            widths: d.filtro_tipo === 'Socios' || d.filtro_tipo === 'Inquilinos'
              ? ['34%', '33%', '33%']
              : ['25%', '25%', '25%', '25%'],
            body: d.filtro_tipo === 'Socios'
              ? [
                  [
                    { text: 'SOCIOS CON DEUDA', fontSize: 7.5, bold: true, color: C.azul, alignment: 'center' },
                    { text: 'DEUDA DE SOCIOS', fontSize: 7.5, bold: true, color: C.azul, alignment: 'center' },
                    { text: 'TOTAL PENDIENTE', fontSize: 7.5, bold: true, color: '#B91C1C', alignment: 'center' },
                  ],
                  [
                    { text: `${d.personas_con_deuda} de ${d.total_personas} socios`, fontSize: 10.5, bold: true, color: C.negro, alignment: 'center' },
                    { text: `S/ ${d.deuda_socios.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 10.5, bold: true, color: C.azul, alignment: 'center' },
                    { text: `S/ ${d.total_pendiente.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 10.5, bold: true, color: '#B91C1C', alignment: 'center' },
                  ],
                ]
              : d.filtro_tipo === 'Inquilinos'
              ? [
                  [
                    { text: 'INQUILINOS CON DEUDA', fontSize: 7.5, bold: true, color: C.amber, alignment: 'center' },
                    { text: 'DEUDA DE INQUILINOS', fontSize: 7.5, bold: true, color: C.amber, alignment: 'center' },
                    { text: 'TOTAL PENDIENTE', fontSize: 7.5, bold: true, color: '#B91C1C', alignment: 'center' },
                  ],
                  [
                    { text: `${d.personas_con_deuda} de ${d.total_personas} inquilinos`, fontSize: 10.5, bold: true, color: C.negro, alignment: 'center' },
                    { text: `S/ ${d.deuda_inquilinos.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 10.5, bold: true, color: C.amber, alignment: 'center' },
                    { text: `S/ ${d.total_pendiente.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 10.5, bold: true, color: '#B91C1C', alignment: 'center' },
                  ],
                ]
              : [
                  [
                    { text: 'PERSONAS CON DEUDA', fontSize: 7.5, bold: true, color: C.grisTxt, alignment: 'center' },
                    { text: 'DEUDA DE SOCIOS', fontSize: 7.5, bold: true, color: C.azul, alignment: 'center' },
                    { text: 'DEUDA DE INQUILINOS', fontSize: 7.5, bold: true, color: C.amber, alignment: 'center' },
                    { text: 'TOTAL PENDIENTE', fontSize: 7.5, bold: true, color: '#B91C1C', alignment: 'center' },
                  ],
                  [
                    { text: `${d.personas_con_deuda} de ${d.total_personas}`, fontSize: 10.5, bold: true, color: C.negro, alignment: 'center' },
                    { text: `S/ ${d.deuda_socios.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 10.5, bold: true, color: C.azul, alignment: 'center' },
                    { text: `S/ ${d.deuda_inquilinos.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 10.5, bold: true, color: C.amber, alignment: 'center' },
                    { text: `S/ ${d.total_pendiente.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 10.5, bold: true, color: '#B91C1C', alignment: 'center' },
                  ],
                ],
          },
          layout: layoutResumen,
          margin: [0, 0, 0, 12],
        },
        // Tabla de personas
        {
          table: {
            headerRows: 1,
            widths: ['10%', '13%', '38%', '13%', '11%', '15%'],
            body: bodyTabla,
          },
          layout: layoutBordes,
        },
      ],

      footer: (currentPage: number, pageCount: number) => ({
        stack: [
          { canvas: [{ type: 'line', x1: 35, y1: 0, x2: 807, y2: 0, lineWidth: 0.5, lineColor: C.grisBorde }] },
          {
            columns: [
              { text: 'Reporte de Cuentas Pendientes — Cooperativa Primero de Mayo', fontSize: 7, color: '#9CA3AF', margin: [35, 4, 0, 0] },
              { text: `Página ${currentPage} de ${pageCount}`, fontSize: 7, color: '#9CA3AF', alignment: 'right', margin: [0, 4, 35, 0] },
            ],
          },
        ],
      }),
    } as unknown as DocDefinition;
  }

  // -------------------------------------------------------------------------
  // Reporte de Estado de Cuenta Individual
  // -------------------------------------------------------------------------

  /** Genera el estado de cuenta individual en PDF y lo descarga. */
  async descargarPdfEstadoCuentaIndividual(datos: EstadoCuentaIndividualPdfDatos): Promise<void> {
    const [pm, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    const cleanNombre = datos.nombre.replace(/[^a-zA-Z0-9-]/g, '_').slice(0, 25);
    const filename = `estado-cuenta-${datos.tipo_persona.toLowerCase()}-${cleanNombre}-${datos.sub_vista}.pdf`;
    await pm.createPdf(this.construirDocumentoEstadoCuentaIndividual(datos, logoB64)).download(filename);
  }

  private construirDocumentoEstadoCuentaIndividual(d: EstadoCuentaIndividualPdfDatos, logoB64: string | null): DocDefinition {
    const layoutBordes: CustomTableLayout = {
      hLineWidth: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? 1.5 : 0.5,
      vLineWidth: () => 0.5,
      hLineColor: (i, node: { table: { body: unknown[] } }) =>
        i === 0 || i === node.table.body.length ? C.azul : C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? null : row % 2 === 0 ? C.fondoFila : null),
      paddingTop: () => 4,
      paddingBottom: () => 4,
      paddingLeft: () => 5,
      paddingRight: () => 5,
    };

    const encTH = (t: string, al: 'left' | 'center' | 'right' = 'left'): TableCell =>
      ({ text: t, fontSize: 8, bold: true, color: 'white', fillColor: C.azul, alignment: al });

    const headerColumns: unknown[] = [];
    if (logoB64) {
      headerColumns.push({
        image: logoB64,
        width: 44,
        fit: [44, 44],
        margin: [0, 0, 10, 0],
      });
    }

    const subVistaTitulo =
      d.sub_vista === 'pendientes' ? 'DEUDAS PENDIENTES' :
      d.sub_vista === 'pagos' ? 'HISTORIAL DE PAGOS' : 'ESTADO COMPLETO DE CUENTA';

    headerColumns.push({
      stack: [
        { text: 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.', fontSize: 10, bold: true, color: C.azul },
        { text: `ESTADO DE CUENTA — ${subVistaTitulo}`, fontSize: 12, bold: true, color: C.negro, margin: [0, 2, 0, 2] },
        { text: `Período: ${d.periodo_label}   ·   Fecha de Emisión: ${d.generado_en}`, fontSize: 8, color: C.grisTxt },
      ],
    });

    // Ficha Persona + Saldo
    const stackDerecha: TableCell[] = [
      { text: 'SALDO PENDIENTE ACTUAL', fontSize: 7.5, bold: true, color: '#B91C1C', alignment: 'right' },
      { text: `S/ ${d.saldo_pendiente_actual.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`, fontSize: 13, bold: true, color: '#B91C1C', alignment: 'right' },
    ];
    if (d.saldo_a_favor && d.saldo_a_favor > 0) {
      stackDerecha.push({ text: `Saldo a favor: S/ ${d.saldo_a_favor.toFixed(2)}`, fontSize: 7.5, color: C.verde, alignment: 'right' });
    }

    const infoPersonaTabla: TableCell[][] = [
      [
        {
          stack: [
            { text: `${d.tipo_persona.toUpperCase()}: ${d.nombre}`, fontSize: 9.5, bold: true, color: C.negro },
            { text: `Documento / DNI: ${d.dni || '—'}    ·    Puesto / Referencia: ${d.puesto || '—'}`, fontSize: 8, color: C.grisTxt, margin: [0, 2, 0, 0] },
          ],
          border: [false, false, false, false],
        },
        {
          stack: stackDerecha,
          border: [false, false, false, false],
        } as unknown as TableCell,
      ],
    ];

    // Construcción de la tabla según sub_vista
    let bodyTabla: TableCell[][] = [];
    let tableWidths: (string | number)[] = [];

    if (d.sub_vista === 'pendientes') {
      tableWidths = ['16%', '34%', '14%', '12%', '12%', '12%'];
      bodyTabla.push([
        encTH('Período', 'center'),
        encTH('Concepto / Cargo', 'left'),
        encTH('Puesto / Ref', 'center'),
        encTH('Importe', 'right'),
        encTH('Ya Pagado', 'right'),
        encTH('Saldo Pend.', 'right'),
      ]);

      const filas = d.filas_pendientes ?? [];
      if (filas.length > 0) {
        for (const f of filas) {
          bodyTabla.push([
            { text: f.periodo, fontSize: 8, alignment: 'center' },
            { text: f.concepto, fontSize: 8, bold: true },
            { text: f.puesto || '—', fontSize: 8, alignment: 'center' },
            { text: `S/ ${f.monto_original.toFixed(2)}`, fontSize: 8, alignment: 'right' },
            { text: f.ya_pagado > 0 ? `S/ ${f.ya_pagado.toFixed(2)}` : '—', fontSize: 8, alignment: 'right', color: f.ya_pagado > 0 ? C.verde : C.grisTxt },
            { text: `S/ ${f.saldo_pendiente.toFixed(2)}`, fontSize: 8, alignment: 'right', bold: true, color: '#B91C1C' },
          ]);
        }
        bodyTabla.push([
          { text: 'TOTAL DEUDA PENDIENTE', colSpan: 5, alignment: 'right', fontSize: 8.5, bold: true, fillColor: '#F3F4F6' },
          {}, {}, {}, {},
          { text: `S/ ${d.saldo_pendiente_actual.toFixed(2)}`, fontSize: 9, bold: true, alignment: 'right', color: '#B91C1C', fillColor: '#F3F4F6' },
        ]);
      } else {
        bodyTabla.push([
          { text: 'No se encontraron obligaciones pendientes.', colSpan: 6, alignment: 'center', fontSize: 8.5, color: C.grisTxt, italics: true, margin: [0, 8, 0, 8] },
          {}, {}, {}, {}, {},
        ]);
      }
    } else if (d.sub_vista === 'pagos') {
      tableWidths = ['14%', '17%', '13%', '30%', '12%', '14%'];
      bodyTabla.push([
        encTH('Fecha', 'center'),
        encTH('N.º Transacción', 'left'),
        encTH('Método', 'center'),
        encTH('Conceptos Cubiertos', 'left'),
        encTH('Comprobante', 'center'),
        encTH('Monto', 'right'),
      ]);

      const filas = d.filas_pagos ?? [];
      if (filas.length > 0) {
        for (const f of filas) {
          bodyTabla.push([
            { text: f.fecha, fontSize: 8, alignment: 'center' },
            { text: f.codigo_transaccion, fontSize: 8, bold: true },
            { text: f.metodo_pago, fontSize: 8, alignment: 'center' },
            { text: f.conceptos || '—', fontSize: 8 },
            { text: f.comprobante || '—', fontSize: 8, alignment: 'center' },
            { text: `S/ ${f.monto.toFixed(2)}`, fontSize: 8, alignment: 'right', bold: true, color: C.verde },
          ]);
        }
        bodyTabla.push([
          { text: 'TOTAL PAGOS DEL PERÍODO', colSpan: 5, alignment: 'right', fontSize: 8.5, bold: true, fillColor: '#F3F4F6' },
          {}, {}, {}, {},
          { text: `S/ ${(d.total_pagos_periodo ?? 0).toFixed(2)}`, fontSize: 9, bold: true, alignment: 'right', color: C.verde, fillColor: '#F3F4F6' },
        ]);
      } else {
        bodyTabla.push([
          { text: 'No se encontraron pagos para el período seleccionado.', colSpan: 6, alignment: 'center', fontSize: 8.5, color: C.grisTxt, italics: true, margin: [0, 8, 0, 8] },
          {}, {}, {}, {}, {},
        ]);
      }
    } else {
      // completo
      tableWidths = ['13%', '11%', '13%', '31%', '12%', '10%', '10%'];
      bodyTabla.push([
        encTH('Fecha', 'center'),
        encTH('Tipo', 'center'),
        encTH('Período', 'center'),
        encTH('Concepto / Detalle', 'left'),
        encTH('Doc / Ref', 'center'),
        encTH('Cargo', 'right'),
        encTH('Pago', 'right'),
      ]);

      const filas = d.filas_completo ?? [];
      if (filas.length > 0) {
        for (const f of filas) {
          bodyTabla.push([
            { text: f.fecha, fontSize: 8, alignment: 'center' },
            { text: f.tipo, fontSize: 8, alignment: 'center', bold: true, color: f.tipo === 'Cargo' ? '#B91C1C' : C.verde },
            { text: f.periodo || '—', fontSize: 8, alignment: 'center' },
            { text: f.concepto, fontSize: 8 },
            { text: f.comprobante || '—', fontSize: 8, alignment: 'center' },
            { text: f.cargo > 0 ? `S/ ${f.cargo.toFixed(2)}` : '—', fontSize: 8, alignment: 'right', color: f.cargo > 0 ? '#B91C1C' : C.grisTxt },
            { text: f.pago > 0 ? `S/ ${f.pago.toFixed(2)}` : '—', fontSize: 8, alignment: 'right', color: f.pago > 0 ? C.verde : C.grisTxt },
          ]);
        }
        bodyTabla.push([
          { text: 'TOTALES DEL PERÍODO', colSpan: 5, alignment: 'right', fontSize: 8.5, bold: true, fillColor: '#F3F4F6' },
          {}, {}, {}, {},
          { text: `S/ ${(d.total_cargos_periodo ?? 0).toFixed(2)}`, fontSize: 8.5, bold: true, alignment: 'right', color: '#B91C1C', fillColor: '#F3F4F6' },
          { text: `S/ ${(d.total_pagos_periodo ?? 0).toFixed(2)}`, fontSize: 8.5, bold: true, alignment: 'right', color: C.verde, fillColor: '#F3F4F6' },
        ]);
      } else {
        bodyTabla.push([
          { text: 'No se encontraron movimientos para el período seleccionado.', colSpan: 7, alignment: 'center', fontSize: 8.5, color: C.grisTxt, italics: true, margin: [0, 8, 0, 8] },
          {}, {}, {}, {}, {}, {},
        ]);
      }
    }

    return {
      pageSize: 'A4',
      pageOrientation: 'portrait',
      pageMargins: [40, 35, 40, 45],
      defaultStyle: { font: 'Roboto', fontSize: 8.5, lineHeight: 1.25 },

      content: [
        { columns: headerColumns, margin: [0, 0, 0, 8] },
        {
          canvas: [{ type: 'line', x1: 0, y1: 0, x2: 515, y2: 0, lineWidth: 1.5, lineColor: C.azulClaro }],
          margin: [0, 0, 0, 10],
        },
        // Tarjeta Persona
        {
          table: {
            widths: ['60%', '40%'],
            body: infoPersonaTabla,
          },
          layout: {
            hLineWidth: () => 1,
            vLineWidth: () => 1,
            hLineColor: () => C.grisBorde,
            vLineColor: () => C.grisBorde,
            fillColor: () => '#F9FAFB',
            paddingTop: () => 8,
            paddingBottom: () => 8,
            paddingLeft: () => 10,
            paddingRight: () => 10,
          },
          margin: [0, 0, 0, 14],
        },
        // Tabla de Datos
        {
          table: {
            headerRows: 1,
            widths: tableWidths,
            body: bodyTabla,
          },
          layout: layoutBordes,
        },
      ],

      footer: (currentPage: number, pageCount: number) => ({
        stack: [
          { canvas: [{ type: 'line', x1: 40, y1: 0, x2: 555, y2: 0, lineWidth: 0.5, lineColor: C.grisBorde }] },
          {
            columns: [
              { text: 'Cooperativa de Servicios Especiales Primero de Mayo Ltda. — Estado de Cuenta', fontSize: 7, color: '#9CA3AF', margin: [40, 4, 0, 0] },
              { text: `Página ${currentPage} de ${pageCount}`, fontSize: 7, color: '#9CA3AF', alignment: 'right', margin: [0, 4, 40, 0] },
            ],
          },
        ],
      }),
    } as unknown as DocDefinition;
  }

  // -------------------------------------------------------------------------
  // Carga lazy de pdfmake + fonts (solo la primera vez)
  // -------------------------------------------------------------------------
  private async cargarModulo() {
    const [pmNs, vfsNs] = await Promise.all([
      import('pdfmake/build/pdfmake'),
      import('pdfmake/build/vfs_fonts'),
    ]);

    // Angular/esbuild envuelve módulos CJS/UMD en un namespace ESM.
    // Las funciones exportadas llegan en `.default` en el browser,
    // pero directamente en el namespace en entornos Node.js/SSR.
    // Detectamos cuál aplica con una comprobación de runtime.
    type PmType = typeof pmNs;
    const pm: PmType = typeof pmNs.createPdf === 'function'
      ? pmNs
      : (pmNs as unknown as { default: PmType }).default;

    if (!this.fontsRegistered) {
      // vfs_fonts también es CJS; misma estrategia de interop.
      const vfsDefault = (vfsNs as unknown as { default: VirtualFs }).default;
      const vfs = (vfsDefault ?? vfsNs) as VirtualFs;

      pm.addVirtualFileSystem(vfs);
      pm.addFonts(FUENTES);
      this.fontsRegistered = true;
    }

    return pm;
  }

  // -------------------------------------------------------------------------
  // Construcción del documento PDF (diseño verde/dorado corporativo)
  // -------------------------------------------------------------------------
  private construirDocumento(
    d:      ReciboDatos,
    cfg:    ConfiguracionRecibos,
    logoB64: string | null,
  ): DocDefinition {
    const R = coloresRecibo(cfg.color_principal);
    const pageSize = cfg.formato_impresion === 'TICKET_80MM'
      ? ({ width: 226.77, height: 'auto' } as const)   // 80 mm en puntos (1 mm = 2.8346 pt)
      : ('A4' as const);
    const margins: [number, number, number, number] =
      cfg.formato_impresion === 'TICKET_80MM' ? [10, 12, 10, 36] : [48, 48, 48, 72];
    const lineaAncho = cfg.formato_impresion === 'TICKET_80MM' ? 206 : 499;

    // ── Layouts ────────────────────────────────────────────────────────────────
    const layoutSimple: CustomTableLayout = {
      hLineWidth: (i) => (i === 0 ? 1 : 0.5),
      vLineWidth: () => 0.5,
      hLineColor: () => R.grisBorde,
      vLineColor: () => R.grisBorde,
      fillColor: (row) => (row % 2 === 0 ? R.fondoVerde : null),
      paddingTop:    () => 5,
      paddingBottom: () => 5,
      paddingLeft:   () => 8,
      paddingRight:  () => 8,
    };

    const totalFilas = d.detalle.length + 2;
    const layoutDetalle: CustomTableLayout = {
      hLineWidth: (i) => (i === 0 || i === 1 || i === totalFilas ? 1.5 : 0.5),
      vLineWidth: () => 0.5,
      hLineColor: (i) => (i === 0 || i === totalFilas ? R.primario : R.grisBorde),
      vLineColor: () => R.grisBorde,
      fillColor: (row) => (row === 0 ? null : row % 2 === 0 ? R.fondoVerde : null),
      paddingTop:    () => 5,
      paddingBottom: () => 5,
      paddingLeft:   () => 8,
      paddingRight:  () => 8,
    };

    // ── Encabezado del documento (logo + textos dinámicos) ────────────────────
    const stackEncabezado: DocDefinition[] = [];
    if (logoB64) {
      stackEncabezado.push(
        { image: logoB64, width: 72, alignment: 'center', margin: [0, 0, 0, 6] } as unknown as DocDefinition,
      );
    }
    stackEncabezado.push(
      { text: cfg.nombre_institucion, fontSize: 13, bold: true, color: R.primario, alignment: 'center' } as unknown as DocDefinition,
      { text: cfg.subtitulo, fontSize: 9, color: R.grisTxt, alignment: 'center', margin: [0, 2, 0, 0] } as unknown as DocDefinition,
    );

    // ── Tabla de datos del pagador ────────────────────────────────────────────
    const filasPagador = [
      [etqR('Nombre completo', R), valR(d.nombre_pagador, R)],
      [etqR('DNI',             R), valR(d.dni_pagador, R)],
      [etqR('Condición',       R), valR(d.tipo_pagador, R)],
      [etqR('Puesto / Módulo', R), valR(d.codigo_puesto, R)],
      [etqR('Método de pago',  R), valR(
        d.comprobante ? `${d.metodo_pago}  —  Ref: ${d.comprobante}` : d.metodo_pago, R,
      )],
      ...(d.observacion ? [[etqR('Observaciones', R), valR(d.observacion, R)]] : []),
    ];

    // ── Tabla detalle FIFO ────────────────────────────────────────────────────
    const filasDetalle = d.detalle.map(linea => [
      { text: linea.concepto,                     fontSize: 9,  color: R.grisOsc },
      { text: linea.periodo,                       fontSize: 9,  color: R.grisOsc,  alignment: 'center' as const },
      { text: linea.saldo_original.toFixed(2),    fontSize: 9,  color: R.grisOsc,  alignment: 'right'  as const },
      { text: linea.aplicado.toFixed(2),           fontSize: 9,  bold: true, color: R.negro, alignment: 'right' as const },
      {
        text: linea.cubierto_completo ? '✓ Cancelado' : '~ Parcial',
        fontSize: 8, alignment: 'center' as const,
        color: linea.cubierto_completo ? R.primario : R.dorado,
      },
    ]);

    const filaTotalDetalle = [
      { text: 'TOTAL COBRADO', fontSize: 10, bold: true, color: R.primario, colSpan: 3, alignment: 'right' as const },
      {}, {},
      { text: d.total_pagado.toFixed(2), fontSize: 13, bold: true, color: R.acento, alignment: 'right' as const },
      {},
    ];

    const bloquesSaldoFavor = d.saldo_a_favor > 0
      ? [{ text: `Saldo a favor del pagador: S/ ${d.saldo_a_favor.toFixed(2)} (excedente no aplicado en esta operación)`, fontSize: 8.5, italics: true, color: R.primario, margin: [0, 0, 0, 24] as [number, number, number, number] }]
      : [];

    // ── Helpers de celda con color dinámico ───────────────────────────────────
    function encTH_R(text: string, al: 'left' | 'center' | 'right' = 'left'): TableCell {
      return { text, fontSize: 8, bold: true, color: 'white', fillColor: R.acento, alignment: al };
    }

    // ── Documento ─────────────────────────────────────────────────────────────
    return {
      pageSize,
      pageMargins: margins,
      defaultStyle: { font: 'Roboto', fontSize: 10, lineHeight: 1.35 },

      content: [

        // ════ ENCABEZADO (logo + nombre institución + subtítulo) ══════════════
        { alignment: 'center', stack: stackEncabezado },

        // Doble línea decorativa: verde primario + dorada
        {
          canvas: [
            { type: 'line', x1: 0, y1: 3,   x2: lineaAncho, y2: 3,   lineWidth: 3,   lineColor: R.primario },
            { type: 'line', x1: 0, y1: 8.5, x2: lineaAncho, y2: 8.5, lineWidth: 1.5, lineColor: R.bordeOro },
          ],
          margin: [0, 10, 0, 12],
        },

        // ════ BANNER DE TÍTULO ════════════════════════════════════════════════
        {
          table: {
            widths: ['*'],
            body: [[{
              text: 'R E C I B O   D E   P A G O',
              fontSize: 15, bold: true, alignment: 'center',
              color: 'white', fillColor: R.primario,
              margin: [0, 9, 0, 9],
            }]],
          },
          layout: {
            hLineWidth: () => 2, vLineWidth: () => 2,
            hLineColor: () => R.bordeOro, vLineColor: () => R.bordeOro,
          },
          margin: [50, 0, 50, 14],
        },

        // ════ CÓDIGO DE TRANSACCIÓN ═══════════════════════════════════════════
        {
          alignment: 'center',
          stack: [
            { text: d.codigo_transaccion, fontSize: 15, bold: true, color: R.primario },
            { text: formatFechaLarga(d.fecha_pago), fontSize: 9, color: R.grisTxt, margin: [0, 3, 0, 0] },
          ],
          margin: [0, 0, 0, 20],
        },

        // ════ DATOS DEL PAGADOR ═══════════════════════════════════════════════
        { text: 'DATOS DEL PAGADOR', fontSize: 10, bold: true, decoration: 'underline', color: R.primario, margin: [0, 0, 0, 6] },
        {
          table: { widths: ['33%', '67%'], body: filasPagador },
          layout: layoutSimple,
          margin: [0, 0, 0, 20],
        },

        // ════ DETALLE DE COBROS ═══════════════════════════════════════════════
        { text: 'DETALLE DE COBROS APLICADOS', fontSize: 10, bold: true, decoration: 'underline', color: R.primario, margin: [0, 0, 0, 6] },
        {
          table: {
            headerRows: 1,
            widths: ['*', '12%', '15%', '15%', '13%'],
            body: [
              [
                encTH_R('Concepto'),
                encTH_R('Período',    'center'),
                encTH_R('Deuda S/',   'right'),
                encTH_R('Abonado S/', 'right'),
                encTH_R('Estado',     'center'),
              ],
              ...filasDetalle,
              filaTotalDetalle,
            ],
          },
          layout: layoutDetalle,
          margin: [0, 0, 0, d.saldo_a_favor > 0 ? 8 : 24],
        },

        ...bloquesSaldoFavor,

        // ════ FIRMA Y SELLO "PAGADO" ══════════════════════════════════════════
        {
          columns: [
            {
              width: '55%',
              stack: [
                { text: '\n\n' },
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 195, y2: 0, lineWidth: 0.75, lineColor: '#9CA3AF', dash: { length: 4 } }] },
                { text: 'Firma / Sello del cajero responsable', fontSize: 7.5, color: '#9CA3AF', margin: [0, 3, 0, 0] },
                { text: d.cajero, fontSize: 9, bold: true, color: R.grisOsc, margin: [0, 2, 0, 0] },
              ],
            },
            {
              width: '45%',
              alignment: 'center',
              stack: [{
                table: {
                  widths: ['*'],
                  body: [[{
                    stack: [
                      { text: '✓', fontSize: 26, bold: true, color: R.primario, alignment: 'center' },
                      { text: 'P  A  G  A  D  O', fontSize: 13, bold: true, color: R.primario, alignment: 'center' },
                    ],
                    margin: [12, 10, 12, 10],
                  }]],
                },
                layout: {
                  hLineWidth: () => 2.5, vLineWidth: () => 2.5,
                  // Borde del sello en dorado (identidad corporativa)
                  hLineColor: () => R.bordeOro, vLineColor: () => R.bordeOro,
                },
                margin: [20, 0, 0, 0],
              }],
            },
          ],
        },
      ],

      // ── Footer dinámico ────────────────────────────────────────────────────
      footer: (currentPage: number, pageCount: number, _pageSize: unknown) => ({
        stack: [
          { canvas: [{ type: 'line', x1: margins[0], y1: 0, x2: 595 - margins[2], y2: 0, lineWidth: 0.5, lineColor: R.grisBorde }] },
          {
            text: cfg.mensaje_pie,
            fontSize: 7.5, color: '#9CA3AF', alignment: 'center',
            margin: [margins[0], 4, margins[2], 0],
          },
          {
            columns: [
              { text: cfg.nombre_institucion, fontSize: 7, color: '#9CA3AF', margin: [margins[0], 2, 0, 0] },
              { text: `Página ${currentPage} de ${pageCount}`, fontSize: 7, color: '#9CA3AF', alignment: 'right', margin: [0, 2, margins[2], 0] },
            ],
          },
        ],
      }),

    } as unknown as DocDefinition;
  }
}

// ---------------------------------------------------------------------------
// Helpers de celda — ARQUEO (azul fijo)
// ---------------------------------------------------------------------------
function etq(text: string): TableCell {
  return { text, fontSize: 8.5, bold: true, color: C.grisTxt };
}
function val(text: string): TableCell {
  return { text, fontSize: 10, color: C.negro };
}
function encTH(text: string, alignment: 'left' | 'center' | 'right' = 'left'): TableCell {
  return { text, fontSize: 8, bold: true, color: 'white', fillColor: C.azulClaro, alignment };
}

// ---------------------------------------------------------------------------
// Helpers de celda — RECIBO (colores dinámicos desde ColoresRecibo)
// ---------------------------------------------------------------------------
function etqR(text: string, R: ColoresRecibo): TableCell {
  return { text, fontSize: 8.5, bold: true, color: R.grisTxt };
}
function valR(text: string, R: ColoresRecibo): TableCell {
  return { text, fontSize: 10, color: R.negro };
}
