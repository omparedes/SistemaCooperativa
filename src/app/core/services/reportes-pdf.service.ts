import { Injectable } from '@angular/core';
import type * as PdfMakeNS from 'pdfmake/build/pdfmake';
import type { CustomTableLayout, TableCell } from 'pdfmake/build/pdfmake';

type DocDefinition = Parameters<typeof PdfMakeNS.createPdf>[0];
type VirtualFs = Parameters<typeof PdfMakeNS.addVirtualFileSystem>[0];

export interface ReportePdfExportDatos {
  titulo: string;
  subtitulo?: string;
  institucion: string;
  ruc?: string;
  periodoEtiqueta: string;
  periodoDesde: string;
  periodoHasta: string;
  generadoEn: string;
  usuario?: string;

  // Filtros aplicados
  filtroConcepto: string | null;
  filtroCategoria: string | null;
  filtroTipoPagador: string;
  filtroMetodoPago: string;
  vistaActiva: 'ingresos' | 'egresos' | 'combinado';

  // Resumen de Caja
  resumenCaja: {
    totalIngresos: number;
    efectivo: number;
    transferencia: number;
    ingresosInternos: number;
    recaudacionTarjeta: number;
    egresos: number;
    saldoNeto: number;
    countRecibos: number;
    countInternos: number;
    countAnulados: number;
  };

  // Comparación con período anterior (opcional)
  comparacion?: {
    periodoAnteriorEtiqueta: string;
    periodoAnteriorDesde: string;
    periodoAnteriorHasta: string;
    esIncompleto: boolean;
    ingresos: { actual: number; anterior: number; diferencia: number; porcentaje: number };
    egresos: { actual: number; anterior: number; diferencia: number; porcentaje: number };
    saldoNeto: { actual: number; anterior: number; diferencia: number; porcentaje: number };
  } | null;

  // Evolución temporal del concepto/total
  evolucionTemporal?: {
    conceptoNombre: string;
    total: number;
    diasTotales: number;
    diasConCobro: number;
    diasCero: number;
    promedioDiario: number;
    diaPico: { fecha: string; monto: number };
    diaMinimo: { fecha: string; monto: number };
    serie: { fecha: string; dia: string; diaSemana?: string; monto: number; cantidad: number }[];
  } | null;

  // Desglose de conceptos de ingreso
  conceptos?: {
    concepto: string;
    cantidad: number;
    monto: number;
    montoSocios: number;
    montoInquilinos: number;
    montoOtros: number;
    porcentaje: number;
  }[];

  // Desglose de categorías de egreso
  categoriasEgreso?: {
    categoria: string;
    cantidad: number;
    monto: number;
    porcentaje: number;
  }[];

  // Detalle de movimientos
  movimientosIngreso?: {
    fecha: string;
    recibo: string;
    concepto: string;
    pagador: string;
    tipoPagador: string;
    puesto: string;
    periodo: string;
    metodoPago: string;
    monto: number;
    cajero: string;
  }[];

  movimientosEgreso?: {
    fecha: string;
    categoria: string;
    comprobante: string;
    responsable: string;
    descripcion: string;
    monto: number;
  }[];

  // Gráfico capturado de ApexCharts como imagen base64 (opcional)
  graficoBase64?: string | null;
}

const C = {
  azul: '#1E3A8A',
  azulClaro: '#2563EB',
  azulFondo: '#EFF6FF',
  verde: '#059669',
  verdeFondo: '#ECFDF5',
  rojo: '#DC2626',
  rojoFondo: '#FEF2F2',
  amber: '#D97706',
  amberFondo: '#FFFBEB',
  grisOsc: '#1F2937',
  grisTxt: '#4B5563',
  grisClaro: '#9CA3AF',
  grisBorde: '#E5E7EB',
  grisFondo: '#F9FAFB',
  blanco: '#FFFFFF',
} as const;

function fmtSoles(n: number | undefined | null): string {
  const val = Number(n || 0);
  return 'S/ ' + val.toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function fmtNum(n: number | undefined | null): string {
  return Number(n || 0).toLocaleString('es-PE');
}

@Injectable({ providedIn: 'root' })
export class ReportesPdfService {
  private pdfMakeInstance: typeof PdfMakeNS | null = null;
  private fontsRegistered = false;

  private async cargarModulo(): Promise<typeof PdfMakeNS> {
    if (this.pdfMakeInstance) return this.pdfMakeInstance;

    const [pmNs, vfsNs] = await Promise.all([
      import('pdfmake/build/pdfmake'),
      import('pdfmake/build/vfs_fonts'),
    ]);

    type PmType = typeof pmNs;
    const pm: PmType = typeof pmNs.createPdf === 'function'
      ? pmNs
      : (pmNs as unknown as { default: PmType }).default;

    if (!this.fontsRegistered) {
      const vfsDefault = (vfsNs as unknown as { default: VirtualFs }).default;
      const vfs = vfsDefault ?? (vfsNs as unknown as VirtualFs);
      pm.addVirtualFileSystem(vfs);
      this.fontsRegistered = true;
    }

    this.pdfMakeInstance = pm;
    return pm;
  }

  private async fetchImageAsBase64(url: string): Promise<string | null> {
    try {
      const res = await fetch(url);
      if (!res.ok) return null;
      const blob = await res.blob();
      return await new Promise<string>((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result as string);
        reader.onerror = reject;
        reader.readAsDataURL(blob);
      });
    } catch {
      return null;
    }
  }

  async generarYAbrir(datos: ReportePdfExportDatos): Promise<void> {
    const [pm, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    const docDef = this.construirDocumento(datos, logoB64);
    await pm.createPdf(docDef).open();
  }

  async descargar(datos: ReportePdfExportDatos, nombreArchivo?: string): Promise<void> {
    const [pm, logoB64] = await Promise.all([
      this.cargarModulo(),
      this.fetchImageAsBase64('/images/logo/logo2.png'),
    ]);
    const docDef = this.construirDocumento(datos, logoB64);
    const sufijo = datos.filtroConcepto ? `_${datos.filtroConcepto.replace(/[^a-zA-Z0-9]/g, '_')}` : '';
    const filename = nombreArchivo ?? `reporte_financiero_${datos.periodoDesde}_a_${datos.periodoHasta}${sufijo}.pdf`;
    await pm.createPdf(docDef).download(filename);
  }

  private construirDocumento(datos: ReportePdfExportDatos, logoB64: string | null): DocDefinition {
    const content: unknown[] = [];

    // 1. ENCABEZADO INSTITUCIONAL
    content.push({
      columns: [
        logoB64 ? { image: logoB64, width: 48, height: 48 } : { text: '' },
        {
          width: '*',
          margin: [12, 0, 0, 0],
          stack: [
            { text: datos.institucion, style: 'instTitulo' },
            { text: datos.subtitulo ?? 'COOPERATIVA DE SERVICIOS ESPECIALES — RUC: 20100000000', style: 'instSub' },
            { text: datos.titulo, style: 'docTitulo' },
          ],
        },
        {
          width: 145,
          alignment: 'right',
          margin: [0, 0, 0, 0],
          stack: [
            { text: 'CENTRAL DE REPORTES', style: 'badgeModulo' },
            { text: `Emisión: ${datos.generadoEn}`, style: 'metaTexto' },
            { text: `Usuario: ${datos.usuario ?? 'Administración'}`, style: 'metaTexto' },
            { text: 'Formato: A4 Institucional', style: 'metaTexto' },
          ],
        },
      ],
    });

    content.push({
      canvas: [{ type: 'line', x1: 0, y1: 8, x2: 523, y2: 8, lineWidth: 1.5, lineColor: C.azul }],
      margin: [0, 0, 0, 8],
    });

    // 2. PARÁMETROS Y FILTROS APLICADOS
    const infoFiltros = [
      [
        { text: 'Período Consultado:', bold: true, color: C.azul, fontSize: 8 },
        { text: `${datos.periodoEtiqueta} (${datos.periodoDesde} al ${datos.periodoHasta})`, fontSize: 8 },
        { text: 'Concepto:', bold: true, color: C.azul, fontSize: 8 },
        { text: datos.filtroConcepto ?? 'Todos los conceptos', fontSize: 8 },
      ],
      [
        { text: 'Origen de Fondos:', bold: true, color: C.azul, fontSize: 8 },
        { text: datos.filtroTipoPagador === 'todos' ? 'Todos (Socios, Inquilinos, Otros)' : datos.filtroTipoPagador, fontSize: 8 },
        { text: 'Categoría Gasto:', bold: true, color: C.azul, fontSize: 8 },
        { text: datos.filtroCategoria ?? 'Todas las categorías', fontSize: 8 },
      ],
      [
        { text: 'Método de Pago:', bold: true, color: C.azul, fontSize: 8 },
        { text: datos.filtroMetodoPago === 'todos' ? 'Todos los métodos' : datos.filtroMetodoPago, fontSize: 8 },
        { text: 'Vista Seleccionada:', bold: true, color: C.azul, fontSize: 8 },
        { text: datos.vistaActiva.toUpperCase(), fontSize: 8 },
      ],
    ];

    content.push({
      margin: [0, 0, 0, 10],
      table: {
        widths: [95, 160, 95, '*'],
        body: infoFiltros.map(row => row.map(cell => ({
          ...cell,
          fillColor: C.grisFondo,
          border: [false, false, false, false],
          margin: [3, 2, 3, 2],
        }))),
      },
      layout: {
        defaultBorder: false,
        paddingTop: () => 2.5,
        paddingBottom: () => 2.5,
        paddingLeft: () => 4,
        paddingRight: () => 4,
      },
    });

    // 3. TARJETAS RESUMEN FINANCIERO (Caja)
    const rc = datos.resumenCaja;
    content.push({
      margin: [0, 0, 0, 10],
      table: {
        widths: ['*', '*', '*', '*', '*'],
        body: [
          [
            { text: 'TOTAL INGRESOS', style: 'kpiTitulo' },
            { text: 'EFECTIVO', style: 'kpiTitulo' },
            { text: 'TRANSFERENCIA', style: 'kpiTitulo' },
            { text: 'TOTAL EGRESOS', style: 'kpiTitulo' },
            { text: 'SALDO NETO', style: 'kpiTitulo' },
          ],
          [
            { text: fmtSoles(rc.totalIngresos), style: 'kpiValorVerde' },
            { text: fmtSoles(rc.efectivo), style: 'kpiValor' },
            { text: fmtSoles(rc.transferencia), style: 'kpiValor' },
            { text: fmtSoles(rc.egresos), style: 'kpiValorRojo' },
            { text: fmtSoles(rc.saldoNeto), style: rc.saldoNeto >= 0 ? 'kpiValorAzul' : 'kpiValorRojo' },
          ],
          [
            { text: `${fmtNum(rc.countRecibos)} recibos`, style: 'kpiSub' },
            { text: `${rc.totalIngresos > 0 ? ((rc.efectivo / rc.totalIngresos) * 100).toFixed(0) : 0}% total`, style: 'kpiSub' },
            { text: `${rc.totalIngresos > 0 ? ((rc.transferencia / rc.totalIngresos) * 100).toFixed(0) : 0}% total`, style: 'kpiSub' },
            { text: 'Gastos de caja', style: 'kpiSub' },
            { text: `${fmtNum(rc.countAnulados)} anulados (0 S/)`, style: 'kpiSub' },
          ],
        ],
      },
      layout: {
        hLineWidth: () => 0.5,
        vLineWidth: () => 0.5,
        hLineColor: () => C.grisBorde,
        vLineColor: () => C.grisBorde,
        fillColor: (i: number) => (i === 0 ? C.azulFondo : null),
        paddingTop: () => 4,
        paddingBottom: () => 4,
      },
    });

    // 4. SECCIÓN COMPARATIVA (si está activa)
    if (datos.comparacion) {
      const comp = datos.comparacion;
      content.push({ text: 'COMPARACIÓN CON PERÍODO ANTERIOR', style: 'seccionTitulo' });
      if (comp.esIncompleto) {
        content.push({
          text: '⚠ ADVERTENCIA: El período actual se encuentra en curso (incompleto). Los resultados comparativos son preliminares.',
          style: 'alertaIncompleto',
        });
      }

      const fmtDif = (dif: number) => (dif >= 0 ? '+' : '') + fmtSoles(dif);
      const fmtPct = (pct: number) => (pct >= 0 ? '+' : '') + pct.toFixed(1) + '%';

      content.push({
        margin: [0, 4, 0, 10],
        table: {
          widths: [150, 85, 85, 95, 75],
          headerRows: 1,
          body: [
            [
              { text: 'Rubro / Métrica de Caja', style: 'thCol' },
              { text: 'Período Actual', style: 'thCol', alignment: 'right' },
              { text: 'Período Anterior', style: 'thCol', alignment: 'right' },
              { text: 'Diferencia (Δ S/)', style: 'thCol', alignment: 'right' },
              { text: 'Variación %', style: 'thCol', alignment: 'right' },
            ],
            [
              { text: 'Total Recaudación de Ingresos', bold: true },
              { text: fmtSoles(comp.ingresos.actual), alignment: 'right' },
              { text: fmtSoles(comp.ingresos.anterior), alignment: 'right' },
              { text: fmtDif(comp.ingresos.diferencia), alignment: 'right', bold: true, color: comp.ingresos.diferencia >= 0 ? C.verde : C.rojo },
              { text: fmtPct(comp.ingresos.porcentaje), alignment: 'right', bold: true, color: comp.ingresos.porcentaje >= 0 ? C.verde : C.rojo },
            ],
            [
              { text: 'Total Egresos Operativos', bold: true },
              { text: fmtSoles(comp.egresos.actual), alignment: 'right' },
              { text: fmtSoles(comp.egresos.anterior), alignment: 'right' },
              { text: fmtDif(comp.egresos.diferencia), alignment: 'right', bold: true, color: comp.egresos.diferencia <= 0 ? C.verde : C.rojo },
              { text: fmtPct(comp.egresos.porcentaje), alignment: 'right', bold: true, color: comp.egresos.porcentaje <= 0 ? C.verde : C.rojo },
            ],
            [
              { text: 'Saldo Neto Operativo', bold: true },
              { text: fmtSoles(comp.saldoNeto.actual), alignment: 'right', bold: true },
              { text: fmtSoles(comp.saldoNeto.anterior), alignment: 'right' },
              { text: fmtDif(comp.saldoNeto.diferencia), alignment: 'right', bold: true, color: comp.saldoNeto.diferencia >= 0 ? C.verde : C.rojo },
              { text: fmtPct(comp.saldoNeto.porcentaje), alignment: 'right', bold: true, color: comp.saldoNeto.porcentaje >= 0 ? C.verde : C.rojo },
            ],
          ],
        },
        layout: {
          hLineWidth: () => 0.5,
          vLineWidth: () => 0.5,
          hLineColor: () => C.grisBorde,
          vLineColor: () => C.grisBorde,
          fillColor: (i: number) => (i === 0 ? C.grisFondo : i % 2 === 0 ? '#FAFAFA' : null),
          paddingTop: () => 3.5,
          paddingBottom: () => 3.5,
          paddingLeft: () => 5,
          paddingRight: () => 5,
        },
      });
    }

    // 5. EVOLUCIÓN TEMPORAL Y KPIS ANALÍTICOS
    if (datos.evolucionTemporal) {
      const evo = datos.evolucionTemporal;
      content.push({
        text: `EVOLUCIÓN TEMPORAL: ${evo.conceptoNombre.toUpperCase()}`,
        style: 'seccionTitulo',
      });

      content.push({
        margin: [0, 4, 0, 8],
        table: {
          widths: ['*', '*', '*', '*', '*'],
          body: [
            [
              { text: 'TOTAL RECAUDADO', style: 'kpiTitulo' },
              { text: 'DÍA PICO (MÁXIMO)', style: 'kpiTitulo' },
              { text: 'DÍA MÍNIMO (COBRO)', style: 'kpiTitulo' },
              { text: 'PROMEDIO DIARIO', style: 'kpiTitulo' },
              { text: 'DÍAS CON ACTIVIDAD', style: 'kpiTitulo' },
            ],
            [
              { text: fmtSoles(evo.total), style: 'kpiValorVerde' },
              { text: fmtSoles(evo.diaPico.monto), style: 'kpiValorAzul' },
              { text: fmtSoles(evo.diaMinimo.monto), style: 'kpiValor' },
              { text: fmtSoles(evo.promedioDiario), style: 'kpiValor' },
              { text: `${evo.diasConCobro} de ${evo.diasTotales} días`, style: 'kpiValor' },
            ],
            [
              { text: 'Total acumulado', style: 'kpiSub' },
              { text: evo.diaPico.fecha || '-', style: 'kpiSub' },
              { text: evo.diaMinimo.fecha || '-', style: 'kpiSub' },
              { text: 'Días calendario', style: 'kpiSub' },
              { text: `${evo.diasCero} días en S/ 0.00`, style: 'kpiSub' },
            ],
          ],
        },
        layout: {
          hLineWidth: () => 0.5,
          vLineWidth: () => 0.5,
          hLineColor: () => C.grisBorde,
          vLineColor: () => C.grisBorde,
          fillColor: (i: number) => (i === 0 ? C.verdeFondo : null),
          paddingTop: () => 4,
          paddingBottom: () => 4,
        },
      });

      // Gráfico base64 si está presente
      if (datos.graficoBase64) {
        content.push({
          image: datos.graficoBase64,
          width: 520,
          alignment: 'center',
          margin: [0, 4, 0, 8],
        });
      }
    }

    // 6. DESGLOSE POR CONCEPTO DE INGRESOS
    if (datos.conceptos && datos.conceptos.length > 0 && datos.vistaActiva !== 'egresos') {
      content.push({ text: 'DESGLOSE DE INGRESOS POR CONCEPTO (DEVENGADO Y COBRANZAS)', style: 'seccionTitulo' });
      content.push({
        text: 'Nota: Comprende los cargos amortizados en el período (cobros en efectivo, banco y aplicaciones con saldo a favor existente en cuenta corriente).',
        style: 'metaTexto',
        margin: [0, 0, 0, 4],
      });
      const cFilas: TableCell[][] = [
        [
          { text: 'Concepto de Recaudación', style: 'thCol' },
          { text: 'N° Cobros', style: 'thCol', alignment: 'center' },
          { text: 'Socios (S/)', style: 'thCol', alignment: 'right' },
          { text: 'Inquilinos (S/)', style: 'thCol', alignment: 'right' },
          { text: 'Otros (S/)', style: 'thCol', alignment: 'right' },
          { text: 'Monto Total (S/)', style: 'thCol', alignment: 'right' },
          { text: '% Total', style: 'thCol', alignment: 'right' },
        ],
      ];

      let sumCobros = 0;
      let sumSocios = 0;
      let sumInquilinos = 0;
      let sumOtros = 0;
      let sumMonto = 0;

      for (const c of datos.conceptos) {
        sumCobros += c.cantidad;
        sumSocios += c.montoSocios;
        sumInquilinos += c.montoInquilinos;
        sumOtros += c.montoOtros;
        sumMonto += c.monto;

        cFilas.push([
          { text: c.concepto, fontSize: 8 },
          { text: fmtNum(c.cantidad), alignment: 'center', fontSize: 8 },
          { text: fmtSoles(c.montoSocios), alignment: 'right', fontSize: 8 },
          { text: fmtSoles(c.montoInquilinos), alignment: 'right', fontSize: 8 },
          { text: fmtSoles(c.montoOtros), alignment: 'right', fontSize: 8 },
          { text: fmtSoles(c.monto), alignment: 'right', bold: true, fontSize: 8 },
          { text: `${c.porcentaje.toFixed(1)}%`, alignment: 'right', fontSize: 8 },
        ]);
      }

      cFilas.push([
        { text: 'TOTALES CONSOLIDADOS', bold: true, fontSize: 8, color: C.azul },
        { text: fmtNum(sumCobros), alignment: 'center', bold: true, fontSize: 8 },
        { text: fmtSoles(sumSocios), alignment: 'right', bold: true, fontSize: 8 },
        { text: fmtSoles(sumInquilinos), alignment: 'right', bold: true, fontSize: 8 },
        { text: fmtSoles(sumOtros), alignment: 'right', bold: true, fontSize: 8 },
        { text: fmtSoles(sumMonto), alignment: 'right', bold: true, fontSize: 8, color: C.verde },
        { text: '100.0%', alignment: 'right', bold: true, fontSize: 8 },
      ]);

      content.push({
        margin: [0, 4, 0, 10],
        table: {
          widths: [130, 45, 65, 65, 65, 75, 40],
          headerRows: 1,
          body: cFilas,
        },
        layout: {
          hLineWidth: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 || i === 1 || i === node.table.body.length - 1 || i === node.table.body.length ? 1 : 0.5),
          vLineWidth: () => 0.5,
          hLineColor: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 || i === node.table.body.length ? C.azul : C.grisBorde),
          vLineColor: () => C.grisBorde,
          fillColor: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 ? C.grisFondo : i === node.table.body.length - 1 ? C.azulFondo : i % 2 === 0 ? '#FAFAFA' : null),
          paddingTop: () => 3,
          paddingBottom: () => 3,
          paddingLeft: () => 4,
          paddingRight: () => 4,
        },
      });
    }

    // 7. DESGLOSE POR CATEGORÍA DE EGRESOS
    if (datos.categoriasEgreso && datos.categoriasEgreso.length > 0 && datos.vistaActiva !== 'ingresos') {
      content.push({ text: 'DESGLOSE DE EGRESOS POR CATEGORÍA', style: 'seccionTitulo' });
      const eFilas: TableCell[][] = [
        [
          { text: 'Categoría de Gasto', style: 'thCol' },
          { text: 'N° Operaciones', style: 'thCol', alignment: 'center' },
          { text: 'Monto Ejecutado (S/)', style: 'thCol', alignment: 'right' },
          { text: '% Egresos', style: 'thCol', alignment: 'right' },
        ],
      ];

      let sumEgrCant = 0;
      let sumEgrMonto = 0;

      for (const e of datos.categoriasEgreso) {
        sumEgrCant += e.cantidad;
        sumEgrMonto += e.monto;

        eFilas.push([
          { text: e.categoria, fontSize: 8 },
          { text: fmtNum(e.cantidad), alignment: 'center', fontSize: 8 },
          { text: fmtSoles(e.monto), alignment: 'right', bold: true, fontSize: 8, color: C.rojo },
          { text: `${e.porcentaje.toFixed(1)}%`, alignment: 'right', fontSize: 8 },
        ]);
      }

      eFilas.push([
        { text: 'TOTAL EGRESOS EJECUTADOS', bold: true, fontSize: 8, color: C.azul },
        { text: fmtNum(sumEgrCant), alignment: 'center', bold: true, fontSize: 8 },
        { text: fmtSoles(sumEgrMonto), alignment: 'right', bold: true, fontSize: 8, color: C.rojo },
        { text: '100.0%', alignment: 'right', bold: true, fontSize: 8 },
      ]);

      content.push({
        margin: [0, 4, 0, 10],
        table: {
          widths: ['*', 100, 120, 80],
          headerRows: 1,
          body: eFilas,
        },
        layout: {
          hLineWidth: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 || i === 1 || i === node.table.body.length - 1 || i === node.table.body.length ? 1 : 0.5),
          vLineWidth: () => 0.5,
          hLineColor: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 || i === node.table.body.length ? C.azul : C.grisBorde),
          vLineColor: () => C.grisBorde,
          fillColor: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 ? C.grisFondo : i === node.table.body.length - 1 ? C.rojoFondo : i % 2 === 0 ? '#FAFAFA' : null),
          paddingTop: () => 3,
          paddingBottom: () => 3,
          paddingLeft: () => 6,
          paddingRight: () => 6,
        },
      });
    }

    // 8. DETALLE DE MOVIMIENTOS DE INGRESO
    if (datos.movimientosIngreso && datos.movimientosIngreso.length > 0) {
      const totalRegs = datos.movimientosIngreso.length;
      const esMuestra = totalRegs > 300;
      const listaIng = esMuestra ? datos.movimientosIngreso.slice(0, 300) : datos.movimientosIngreso;

      content.push({
        text: esMuestra
          ? `DETALLE DE OPERACIONES DE INGRESO (Muestra de 300 de ${fmtNum(totalRegs)} registros)`
          : `DETALLE DE OPERACIONES DE INGRESO (${totalRegs} registros)`,
        style: 'seccionTitulo',
        pageBreak: 'before',
      });

      if (esMuestra) {
        content.push({
          text: `ℹ NOTA EJECUTIVA: Mostrando las primeras 300 operaciones para preservar la legibilidad y agilidad del documento PDF para el Consejo de Administración. El detalle completo de los ${fmtNum(totalRegs)} registros se encuentra disponible en la exportación Excel correspondiente.`,
          style: 'metaTexto',
          color: C.azulClaro,
          margin: [0, 0, 0, 4],
        });
      }

      const mFilas: TableCell[][] = [
        [
          { text: 'Fecha / Hora', style: 'thCol' },
          { text: 'Recibo', style: 'thCol' },
          { text: 'Concepto', style: 'thCol' },
          { text: 'Pagador', style: 'thCol' },
          { text: 'Puesto', style: 'thCol', alignment: 'center' },
          { text: 'Método', style: 'thCol' },
          { text: 'Monto S/', style: 'thCol', alignment: 'right' },
        ],
      ];

      let sumMovIng = 0;
      for (const m of listaIng) {
        sumMovIng += m.monto;
        mFilas.push([
          { text: m.fecha ? m.fecha.replace('T', ' ').slice(0, 16) : '-', fontSize: 7 },
          { text: m.recibo, fontSize: 7, bold: true },
          { text: m.concepto, fontSize: 7 },
          { text: m.pagador, fontSize: 7 },
          { text: m.puesto || '-', fontSize: 7, alignment: 'center' },
          { text: m.metodoPago, fontSize: 7 },
          { text: fmtSoles(m.monto), fontSize: 7, alignment: 'right', bold: true },
        ]);
      }

      const sumTotalReal = datos.movimientosIngreso.reduce((acc, x) => acc + x.monto, 0);

      mFilas.push([
        { text: esMuestra ? 'SUBTOTAL MUESTRA PRESENTADA (300 REGISTROS)' : 'TOTAL DETALLE INGRESOS', colSpan: 6, bold: true, fontSize: 7, color: C.azul },
        {}, {}, {}, {}, {},
        { text: fmtSoles(sumMovIng), alignment: 'right', bold: true, fontSize: 7, color: C.verde },
      ]);

      if (esMuestra) {
        mFilas.push([
          { text: `TOTAL CONSOLIDADO DEL PERÍODO (${fmtNum(totalRegs)} REGISTROS EN EXCEL)`, colSpan: 6, bold: true, fontSize: 7, color: C.azul },
          {}, {}, {}, {}, {},
          { text: fmtSoles(sumTotalReal), alignment: 'right', bold: true, fontSize: 7, color: C.verde },
        ]);
      }

      content.push({
        margin: [0, 4, 0, 10],
        table: {
          widths: [65, 50, 80, '*', 30, 48, 65],
          headerRows: 1,
          dontBreakRows: true,
          body: mFilas,
        },
        layout: {
          hLineWidth: () => 0.5,
          vLineWidth: () => 0.5,
          hLineColor: () => C.grisBorde,
          vLineColor: () => C.grisBorde,
          fillColor: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 ? C.grisFondo : i >= node.table.body.length - (esMuestra ? 2 : 1) ? C.azulFondo : i % 2 === 0 ? '#FAFAFA' : null),
          paddingTop: () => 2.5,
          paddingBottom: () => 2.5,
          paddingLeft: () => 3,
          paddingRight: () => 3,
        },
      });
    }

    // 9. DETALLE DE MOVIMIENTOS DE EGRESO
    if (datos.movimientosEgreso && datos.movimientosEgreso.length > 0) {
      const totalRegsEg = datos.movimientosEgreso.length;
      const esMuestraEg = totalRegsEg > 300;
      const listaEg = esMuestraEg ? datos.movimientosEgreso.slice(0, 300) : datos.movimientosEgreso;

      content.push({
        text: esMuestraEg
          ? `DETALLE DE OPERACIONES DE EGRESO (Muestra de 300 de ${fmtNum(totalRegsEg)} registros)`
          : `DETALLE DE OPERACIONES DE EGRESO (${totalRegsEg} registros)`,
        style: 'seccionTitulo',
        pageBreak: datos.movimientosIngreso && datos.movimientosIngreso.length > 0 ? 'before' : undefined,
      });

      if (esMuestraEg) {
        content.push({
          text: `ℹ NOTA EJECUTIVA: Mostrando los primeros 300 comprobantes para preservar la agilidad del informe PDF. El detalle completo de los ${fmtNum(totalRegsEg)} egresos se encuentra disponible en la exportación Excel correspondiente.`,
          style: 'metaTexto',
          color: C.azulClaro,
          margin: [0, 0, 0, 4],
        });
      }

      const eMovFilas: TableCell[][] = [
        [
          { text: 'Fecha', style: 'thCol' },
          { text: 'Categoría', style: 'thCol' },
          { text: 'Comprobante', style: 'thCol' },
          { text: 'Responsable', style: 'thCol' },
          { text: 'Descripción / Glosa', style: 'thCol' },
          { text: 'Monto S/', style: 'thCol', alignment: 'right' },
        ],
      ];

      let sumMovEg = 0;
      for (const g of listaEg) {
        sumMovEg += g.monto;
        eMovFilas.push([
          { text: g.fecha, fontSize: 7 },
          { text: g.categoria, fontSize: 7 },
          { text: g.comprobante || '-', fontSize: 7 },
          { text: g.responsable || '-', fontSize: 7 },
          { text: g.descripcion || '-', fontSize: 7 },
          { text: fmtSoles(g.monto), fontSize: 7, alignment: 'right', bold: true, color: C.rojo },
        ]);
      }

      const sumTotalRealEg = datos.movimientosEgreso.reduce((acc, x) => acc + x.monto, 0);

      eMovFilas.push([
        { text: esMuestraEg ? 'SUBTOTAL MUESTRA PRESENTADA (300 REGISTROS)' : 'TOTAL DETALLE EGRESOS', colSpan: 5, bold: true, fontSize: 7, color: C.azul },
        {}, {}, {}, {},
        { text: fmtSoles(sumMovEg), alignment: 'right', bold: true, fontSize: 7, color: C.rojo },
      ]);

      if (esMuestraEg) {
        eMovFilas.push([
          { text: `TOTAL CONSOLIDADO DEL PERÍODO (${fmtNum(totalRegsEg)} REGISTROS EN EXCEL)`, colSpan: 5, bold: true, fontSize: 7, color: C.azul },
          {}, {}, {}, {},
          { text: fmtSoles(sumTotalRealEg), alignment: 'right', bold: true, fontSize: 7, color: C.rojo },
        ]);
      }

      content.push({
        margin: [0, 4, 0, 10],
        table: {
          widths: [55, 80, 70, 95, '*', 65],
          headerRows: 1,
          dontBreakRows: true,
          body: eMovFilas,
        },
        layout: {
          hLineWidth: () => 0.5,
          vLineWidth: () => 0.5,
          hLineColor: () => C.grisBorde,
          vLineColor: () => C.grisBorde,
          fillColor: (i: number, node: { table: { body: unknown[] } }) =>
            (i === 0 ? C.grisFondo : i >= node.table.body.length - (esMuestraEg ? 2 : 1) ? C.rojoFondo : i % 2 === 0 ? '#FAFAFA' : null),
          paddingTop: () => 2.5,
          paddingBottom: () => 2.5,
          paddingLeft: () => 3,
          paddingRight: () => 3,
        },
      });
    }

    return {
      pageSize: 'A4',
      pageOrientation: 'portrait',
      pageMargins: [36, 36, 36, 45],
      content: content as unknown as DocDefinition['content'],
      footer: (currentPage: number, pageCount: number) => ({
        columns: [
          {
            text: 'Cooperativa de Servicios Especiales Primero de Mayo Ltda. — ERP Institucional',
            fontSize: 7,
            color: C.grisClaro,
            margin: [36, 12, 0, 0],
          },
          {
            text: `Página ${currentPage} de ${pageCount}`,
            alignment: 'right',
            fontSize: 7,
            color: C.grisClaro,
            margin: [0, 12, 36, 0],
          },
        ],
      }),
      styles: {
        instTitulo: { fontSize: 11, bold: true, color: C.azul },
        instSub: { fontSize: 7.5, color: C.grisTxt, margin: [0, 1, 0, 2] },
        docTitulo: { fontSize: 9.5, bold: true, color: C.grisOsc },
        badgeModulo: { fontSize: 8, bold: true, color: C.azul, margin: [0, 0, 0, 2] },
        metaTexto: { fontSize: 7, color: C.grisTxt },
        seccionTitulo: { fontSize: 9.5, bold: true, color: C.azul, margin: [0, 10, 0, 4] },
        alertaIncompleto: { fontSize: 7.5, bold: true, color: C.amber, margin: [0, 2, 0, 6] },
        thCol: { fontSize: 8, bold: true, color: C.grisOsc, fillColor: C.grisFondo },
        kpiTitulo: { fontSize: 7, bold: true, color: C.grisTxt, alignment: 'center' },
        kpiValor: { fontSize: 9, bold: true, color: C.grisOsc, alignment: 'center', margin: [0, 2, 0, 1] },
        kpiValorVerde: { fontSize: 9.5, bold: true, color: C.verde, alignment: 'center', margin: [0, 2, 0, 1] },
        kpiValorRojo: { fontSize: 9.5, bold: true, color: C.rojo, alignment: 'center', margin: [0, 2, 0, 1] },
        kpiValorAzul: { fontSize: 9.5, bold: true, color: C.azul, alignment: 'center', margin: [0, 2, 0, 1] },
        kpiSub: { fontSize: 6.5, color: C.grisClaro, alignment: 'center' },
      },
      defaultStyle: {
        fontSize: 8,
        color: C.grisOsc,
      },
    };
  }
}
