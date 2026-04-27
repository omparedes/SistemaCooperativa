import { Injectable } from '@angular/core';
import type { ArqueoConcepto, ArqueoPago, ArqueoResumen } from './reportes.service';
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
// Colores del recibo
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
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class PdfGeneratorService {
  private fontsRegistered = false;

  /** Genera el recibo y lo abre en nueva pestaña del navegador. */
  async generarYAbrir(datos: ReciboDatos): Promise<void> {
    const pm = await this.cargarModulo();
    await pm.createPdf(this.construirDocumento(datos)).open();
  }

  /** Genera el recibo y lo descarga automáticamente. */
  async descargar(datos: ReciboDatos): Promise<void> {
    const pm = await this.cargarModulo();
    await pm.createPdf(this.construirDocumento(datos))
      .download(`recibo-${datos.codigo_transaccion}.pdf`);
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

    // ── Layout reutilizable ────────────────────────────────────────────────
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

    // ── Tabla KPI (3 columnas) ─────────────────────────────────────────────
    const kpiTable: DocDefinition = {
      table: {
        widths: ['*', '*', '*'],
        body: [[
          {
            stack: [
              { text: 'TOTAL DEL DÍA', fontSize: 8, bold: true, color: C.grisTxt },
              { text: `S/ ${r.total_dia.toFixed(2)}`, fontSize: 20, bold: true, color: C.azul, margin: [0, 4, 0, 2] },
              { text: `${r.cantidad_recibos} recibo${r.cantidad_recibos !== 1 ? 's' : ''}`, fontSize: 8, color: C.grisTxt },
            ],
            fillColor: '#F0F4FF', margin: [8, 8, 8, 8],
          },
          {
            stack: [
              { text: 'EFECTIVO (GAVETA)', fontSize: 8, bold: true, color: '#166534' },
              { text: `S/ ${r.total_efectivo.toFixed(2)}`, fontSize: 20, bold: true, color: C.verde, margin: [0, 4, 0, 2] },
              { text: pct(r.total_efectivo), fontSize: 8, color: '#166534' },
            ],
            fillColor: '#F0FDF4', margin: [8, 8, 8, 8],
          },
          {
            stack: [
              { text: 'TRANSFERENCIA / QR', fontSize: 8, bold: true, color: '#1e3a8a' },
              { text: `S/ ${r.total_transferencia.toFixed(2)}`, fontSize: 20, bold: true, color: '#2563EB', margin: [0, 4, 0, 2] },
              { text: pct(r.total_transferencia), fontSize: 8, color: '#1e3a8a' },
            ],
            fillColor: '#EFF6FF', margin: [8, 8, 8, 8],
          },
        ]],
      },
      layout: {
        hLineWidth: () => 1, vLineWidth: () => 1,
        hLineColor: () => C.grisBorde, vLineColor: () => C.grisBorde,
      },
      margin: [0, 0, 0, 16],
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
      {
        text: p.metodo_pago,
        fontSize: 8,
        color: p.metodo_pago === 'Efectivo' ? C.verde : '#1D4ED8',
        alignment: 'center' as const,
      },
      { text: `S/ ${p.monto_total.toFixed(2)}`, fontSize: 8, bold: true, color: C.negro, alignment: 'right' as const },
    ]);

    const filaTotalRecibos: TableCell[] = [
      { text: 'TOTAL', fontSize: 9, bold: true, color: C.azul, colSpan: 6, alignment: 'right' as const },
      {}, {}, {}, {}, {},
      { text: `S/ ${r.total_dia.toFixed(2)}`, fontSize: 10, bold: true, color: C.azulClaro, alignment: 'right' as const },
    ];

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

        // KPIs
        kpiTable,

        // Desglose por concepto
        { text: 'DESGLOSE POR CONCEPTO', fontSize: 9, bold: true, decoration: 'underline', color: C.azul, margin: [0, 0, 0, 5] },
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
              margin: [0, 0, 0, 24],
            }
          : { text: 'Sin recibos registrados.', fontSize: 9, color: C.grisTxt, margin: [0, 0, 0, 24], italics: true },

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
  // Construcción del documento PDF
  // -------------------------------------------------------------------------
  private construirDocumento(d: ReciboDatos): DocDefinition {
    // ── Layouts de tabla ─────────────────────────────────────────────────────
    const layoutSimple: CustomTableLayout = {
      hLineWidth: (i) => (i === 0 ? 1 : 0.5),
      vLineWidth: () => 0.5,
      hLineColor: () => C.grisBorde,
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row % 2 === 0 ? C.fondoFila : null),
      paddingTop: () => 5,
      paddingBottom: () => 5,
      paddingLeft: () => 8,
      paddingRight: () => 8,
    };

    // hLineWidth/Color necesitan saber cuántas filas tiene el cuerpo
    // (encabezado + detalle + fila de total = d.detalle.length + 2)
    const totalFilas = d.detalle.length + 2;
    const layoutDetalle: CustomTableLayout = {
      hLineWidth: (i) => (i === 0 || i === 1 || i === totalFilas ? 1.5 : 0.5),
      vLineWidth: () => 0.5,
      hLineColor: (i) => (i === 0 || i === totalFilas ? C.azul : C.grisBorde),
      vLineColor: () => C.grisBorde,
      fillColor: (row) => (row === 0 ? null : row % 2 === 0 ? C.fondoFila : null),
      paddingTop: () => 5,
      paddingBottom: () => 5,
      paddingLeft: () => 8,
      paddingRight: () => 8,
    };

    // ── Filas de datos del pagador ────────────────────────────────────────────
    const filasPagador = [
      [etq('Nombre completo'), val(d.nombre_pagador)],
      [etq('DNI'), val(d.dni_pagador)],
      [etq('Condición'), val(d.tipo_pagador)],
      [etq('Puesto / Módulo'), val(d.codigo_puesto)],
      [etq('Método de pago'), val(d.comprobante ? `${d.metodo_pago}  —  Ref: ${d.comprobante}` : d.metodo_pago)],
    ];

    // ── Filas de detalle de cobros ────────────────────────────────────────────
    const filasDetalle = d.detalle.map(linea => [
      { text: linea.concepto, fontSize: 9, color: C.grisOsc },
      { text: linea.periodo, fontSize: 9, color: C.grisOsc, alignment: 'center' as const },
      { text: linea.saldo_original.toFixed(2), fontSize: 9, color: C.grisOsc, alignment: 'right' as const },
      { text: linea.aplicado.toFixed(2), fontSize: 9, bold: true, color: C.negro, alignment: 'right' as const },
      {
        text: linea.cubierto_completo ? '✓ Cancelado' : '~ Parcial',
        fontSize: 8,
        alignment: 'center' as const,
        color: linea.cubierto_completo ? C.verde : C.amber,
      },
    ]);

    const filaTotalDetalle = [
      { text: 'TOTAL COBRADO', fontSize: 10, bold: true, color: C.azul, colSpan: 3, alignment: 'right' as const },
      {},
      {},
      { text: d.total_pagado.toFixed(2), fontSize: 13, bold: true, color: C.azulClaro, alignment: 'right' as const },
      {},
    ];

    // ── Bloque condicional: saldo a favor ─────────────────────────────────────
    const bloquesSaldoFavor = d.saldo_a_favor > 0
      ? [{ text: `Saldo a favor del pagador: S/ ${d.saldo_a_favor.toFixed(2)} (excedente no aplicado en esta operación)`, fontSize: 8.5, italics: true, color: '#1D4ED8', margin: [0, 0, 0, 24] as [number, number, number, number] }]
      : [];

    // ── Documento ─────────────────────────────────────────────────────────────
    return {
      pageSize: 'A4',
      pageMargins: [48, 48, 48, 72],
      defaultStyle: { font: 'Roboto', fontSize: 10, lineHeight: 1.35 },

      content: [

        // ════════════════════════════════════════════════════════════════════
        // ENCABEZADO
        // ════════════════════════════════════════════════════════════════════
        {
          alignment: 'center',
          stack: [
            { text: 'COOPERATIVA DE COMERCIANTES', fontSize: 13, color: C.grisTxt },
            { text: 'PRIMERO DE MAYO', fontSize: 22, bold: true, color: C.azul, margin: [0, 2, 0, 3] },
            { text: 'Mercado Municipal — Sistema de Recaudación', fontSize: 9, color: C.grisTxt },
          ],
        },
        {
          canvas: [{ type: 'line', x1: 0, y1: 4, x2: 499, y2: 4, lineWidth: 2.5, lineColor: C.azulClaro }],
          margin: [0, 10, 0, 12],
        },

        // ════════════════════════════════════════════════════════════════════
        // TÍTULO
        // ════════════════════════════════════════════════════════════════════
        {
          table: {
            widths: ['*'],
            body: [[{
              text: 'R E C I B O   D E   P A G O',
              fontSize: 16, bold: true, alignment: 'center',
              color: 'white', fillColor: C.azulClaro,
              margin: [0, 10, 0, 10],
            }]],
          },
          layout: 'noBorders',
          margin: [60, 0, 60, 12],
        },

        // ════════════════════════════════════════════════════════════════════
        // CÓDIGO DE TRANSACCIÓN Y FECHA
        // ════════════════════════════════════════════════════════════════════
        {
          alignment: 'center',
          stack: [
            { text: d.codigo_transaccion, fontSize: 16, bold: true, color: C.azulClaro },
            { text: formatFechaLarga(d.fecha_pago), fontSize: 9, color: C.grisTxt, margin: [0, 3, 0, 0] },
          ],
          margin: [0, 0, 0, 20],
        },

        // ════════════════════════════════════════════════════════════════════
        // DATOS DEL PAGADOR
        // ════════════════════════════════════════════════════════════════════
        { text: 'DATOS DEL PAGADOR', fontSize: 10, bold: true, decoration: 'underline', color: C.azul, margin: [0, 0, 0, 6] },
        {
          table: { widths: ['33%', '67%'], body: filasPagador },
          layout: layoutSimple,
          margin: [0, 0, 0, 20],
        },

        // ════════════════════════════════════════════════════════════════════
        // DETALLE DE COBROS (tabla FIFO)
        // ════════════════════════════════════════════════════════════════════
        { text: 'DETALLE DE COBROS APLICADOS', fontSize: 10, bold: true, decoration: 'underline', color: C.azul, margin: [0, 0, 0, 6] },
        {
          table: {
            headerRows: 1,
            widths: ['*', '12%', '15%', '15%', '13%'],
            body: [
              [
                encTH('Concepto'),
                encTH('Período', 'center'),
                encTH('Deuda S/', 'right'),
                encTH('Abonado S/', 'right'),
                encTH('Estado', 'center'),
              ],
              ...filasDetalle,
              filaTotalDetalle,
            ],
          },
          layout: layoutDetalle,
          margin: [0, 0, 0, d.saldo_a_favor > 0 ? 8 : 24],
        },

        // Saldo a favor (condicional)
        ...bloquesSaldoFavor,

        // ════════════════════════════════════════════════════════════════════
        // FIRMA Y SELLO "PAGADO"
        // ════════════════════════════════════════════════════════════════════
        {
          columns: [
            {
              width: '55%',
              stack: [
                { text: '\n\n' },
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 195, y2: 0, lineWidth: 0.75, lineColor: '#9CA3AF', dash: { length: 4 } }] },
                { text: 'Firma / Sello del cajero responsable', fontSize: 7.5, color: '#9CA3AF', margin: [0, 3, 0, 0] },
                { text: d.cajero, fontSize: 9, bold: true, color: C.grisOsc, margin: [0, 2, 0, 0] },
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
                      { text: '✓', fontSize: 28, bold: true, color: C.verde, alignment: 'center' },
                      { text: 'P  A  G  A  D  O', fontSize: 12, bold: true, color: C.verde, alignment: 'center', margin: [0, 0, 0, 0] },
                    ],
                    margin: [12, 8, 12, 8],
                  }]],
                },
                layout: {
                  hLineWidth: () => 2, vLineWidth: () => 2,
                  hLineColor: () => C.verde, vLineColor: () => C.verde,
                },
                margin: [20, 0, 0, 0],
              }],
            },
          ],
        },
      ],

      // ── Footer ─────────────────────────────────────────────────────────────
      footer: (currentPage: number, pageCount: number, _pageSize: unknown) => ({
        stack: [
          { canvas: [{ type: 'line', x1: 48, y1: 0, x2: 547, y2: 0, lineWidth: 0.5, lineColor: C.grisBorde }] },
          {
            text: 'Este documento es un comprobante válido de pago emitido por la Cooperativa de Comerciantes Primero de Mayo. Consérvelo para sus registros.',
            fontSize: 7.5, color: '#9CA3AF', alignment: 'center', margin: [48, 4, 48, 0],
          },
          {
            columns: [
              { text: 'Cooperativa Primero de Mayo — Sistema de Recaudación', fontSize: 7, color: '#9CA3AF', margin: [48, 2, 0, 0] },
              { text: `Página ${currentPage} de ${pageCount}`, fontSize: 7, color: '#9CA3AF', alignment: 'right', margin: [0, 2, 48, 0] },
            ],
          },
        ],
      }),

    } as unknown as DocDefinition;
    // `as unknown as DocDefinition`: el tipo Content de pdfmake es un union muy
    // amplio; la estructura es correcta en runtime pero TypeScript no puede
    // verificar la compatibilidad estática de cada nodo inline sin hacer cada
    // elemento explícito. No se usa `any` en ningún punto.
  }
}

// ---------------------------------------------------------------------------
// Helpers privados de celda para reducir repetición en el template
// Tipados con TableCell para que el compilador valide la estructura.
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
