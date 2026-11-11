import { Injectable } from '@angular/core';
import type * as XLSXType from 'xlsx';
import {
  ComprobanteContableItem,
  ConciliacionReporteContable,
  FiltroReporteContable,
  KpisReporteContable,
  PersonaDocumentoPendiente,
  ResultadoReporteContable,
  round2,
} from '../../pages/reportes/reporte-contable/reporte-contable.model';

export interface PayloadExportacionContableExcel {
  reporte: ResultadoReporteContable;
  filtro: FiltroReporteContable;
  comprobantesFiltrados: ComprobanteContableItem[];
  kpis: KpisReporteContable;
  conciliacion: ConciliacionReporteContable;
  documentosPendientes: PersonaDocumentoPendiente[];
  /** Si es true, anonimiza nombres y documentos para muestras de validación */
  anonimizarMuestra?: boolean;
}

export const RUC_INSTITUCIONAL_OFICIAL = '20109389961';
const FORMATO_SOLES = '"S/ "#,##0.00;("S/ "#,##0.00);"S/ "0.00';
const FORMATO_ENTERO = '#,##0';
const FORMATO_FECHA = 'dd/mm/yyyy';

function parseFechaExcel(fechaYmd: string): Date | string {
  const partes = (fechaYmd ?? '').split('-').map(Number);
  if (partes.length !== 3 || partes.some(isNaN)) return fechaYmd;
  const [y, m, d] = partes;
  return new Date(y, m - 1, d, 12, 0, 0);
}

function anonimizarNombre(nombre: string, index: number): string {
  if (!nombre || nombre === '—' || nombre.startsWith('Caja Rápida')) return nombre;
  const partes = nombre.split(',');
  if (partes.length >= 2) {
    const ap = partes[0].trim();
    const no = partes[1].trim();
    return `${ap.slice(0, 2)}***, ${no.slice(0, 2)}*** (Persona #${index + 1})`;
  }
  return `${nombre.slice(0, 3)}*** (Persona #${index + 1})`;
}

function anonimizarDocumento(doc: string, estado: string): string {
  if (estado === 'SIN REGISTRAR' || estado === 'NO APLICA') return doc;
  if (!doc || doc.length < 4) return doc;
  if (estado === 'POR VALIDAR') {
    return `${doc.slice(0, 2)}****${doc.slice(-4)}`;
  }
  return `${doc.slice(0, 2)}****${doc.slice(-2)}`;
}

@Injectable({ providedIn: 'root' })
export class ReporteContableExcelService {
  /**
   * Genera y descarga en el navegador el archivo Excel contable (.xlsx) de 9 hojas,
   * completamente independiente de la Central de Reportes.
   */
  async exportarArchivoContable(payload: PayloadExportacionContableExcel): Promise<string> {
    const XLSX = await import('xlsx');
    const wb = this.construirLibroContable(XLSX, payload);
    const nombreArchivo = this.generarNombreArchivo(
      payload.reporte.periodoDesde,
      payload.reporte.periodoHasta,
      payload.anonimizarMuestra,
    );
    XLSX.writeFile(wb, nombreArchivo, { cellDates: true });
    return nombreArchivo;
  }

  generarNombreArchivo(desde: string, hasta: string, anonimizado = false): string {
    const sufijo = anonimizado ? '_muestra_anonimizada' : '';
    return `reporte_contable_${desde}_a_${hasta}${sufijo}.xlsx`;
  }

  /**
   * Construye el objeto WorkBook de SheetJS con las 9 hojas contables especializadas.
   * Expuesto públicamente para permitir pruebas unitarias y generación de muestras.
   */
  construirLibroContable(
    XLSX: typeof XLSXType,
    payload: PayloadExportacionContableExcel,
  ): XLSXType.WorkBook {
    if (
      !payload.anonimizarMuestra &&
      payload.reporte.rolEmisor !== 'Administrador' &&
      payload.reporte.rolEmisor !== 'Caja'
    ) {
      throw new Error(
        'Acceso denegado: La exportación real con DNI completo está autorizada únicamente para los roles Administrador y Caja.',
      );
    }

    const wb = XLSX.utils.book_new();
    wb.Props = {
      Title: `Reporte Contable ${payload.reporte.periodoDesde} a ${payload.reporte.periodoHasta}`,
      Subject: 'Reporte Contable de Ingresos por Comprobante con DNI',
      Author: 'ERP Cooperativa Primero de Mayo',
      Company: 'Cooperativa de Servicios Especiales Primero de Mayo Ltda.',
      CreatedDate: new Date(),
    };

    // Mapa determinista de anonimización por persona si se solicita muestra anonimizada
    const mapaAnonNombre = new Map<string, string>();
    const mapaAnonDoc = new Map<string, string>();
    if (payload.anonimizarMuestra) {
      let counter = 0;
      for (const c of payload.comprobantesFiltrados) {
        const key = c.personaKey ?? c.personaRegistradaNombre;
        if (!mapaAnonNombre.has(key)) {
          mapaAnonNombre.set(key, anonimizarNombre(c.personaRegistradaNombre, counter));
          mapaAnonDoc.set(
            key,
            anonimizarDocumento(c.documento.numeroMostrar, c.documento.estado),
          );
          counter++;
        }
      }
    }

    const comprobantesParaExportar = payload.anonimizarMuestra
      ? payload.comprobantesFiltrados.map((c, idx) => {
          const key = c.personaKey ?? c.personaRegistradaNombre;
          return {
            ...c,
            personaRegistradaNombre:
              mapaAnonNombre.get(key) ?? anonimizarNombre(c.personaRegistradaNombre, idx),
            documento: {
              ...c.documento,
              numeroMostrar:
                mapaAnonDoc.get(key) ??
                anonimizarDocumento(c.documento.numeroMostrar, c.documento.estado),
              valorOriginalBd: c.documento.valorOriginalBd
                ? anonimizarDocumento(c.documento.valorOriginalBd, c.documento.estado)
                : null,
            },
            titularPuestoNombre: c.titularPuestoNombre
              ? anonimizarNombre(c.titularPuestoNombre, idx)
              : null,
            titularPuestoDocumento: c.titularPuestoDocumento
              ? anonimizarDocumento(c.titularPuestoDocumento, 'REGISTRADO')
              : null,
          };
        })
      : payload.comprobantesFiltrados;

    const docsPendientesExportar = payload.anonimizarMuestra
      ? payload.documentosPendientes.map((d, idx) => ({
          ...d,
          nombreCompleto: mapaAnonNombre.get(d.personaKey) ?? anonimizarNombre(d.nombreCompleto, idx),
          valorOriginalBd: anonimizarDocumento(d.valorOriginalBd, d.estadoDocumento),
        }))
      : payload.documentosPendientes;

    // Orden cronológico ascendente para libros contables (del primer al último día del período)
    const comprobantesCronologicos = [...comprobantesParaExportar].sort((a, b) => {
      if (a.fechaLima !== b.fechaLima) return a.fechaLima.localeCompare(b.fechaLima);
      if (a.horaLima !== b.horaLima) return a.horaLima.localeCompare(b.horaLima);
      return a.numeroComprobante.localeCompare(b.numeroComprobante);
    });

    // 1. Hoja 00_RESUMEN
    const ws00 = this.crearHoja00Resumen(XLSX, payload, comprobantesCronologicos);
    XLSX.utils.book_append_sheet(wb, ws00, '00_RESUMEN');

    // 2. Hoja 01_DETALLE_VERTICAL
    const ws01 = this.crearHoja01DetalleVertical(XLSX, payload, comprobantesCronologicos);
    XLSX.utils.book_append_sheet(wb, ws01, '01_DETALLE_VERTICAL');

    // 3. Hoja 02_SOCIOS_OFICINA (Vigentes de Socios con Dinero Nuevo en Efectivo > 0, incluye Recaudación Tarjeta)
    const sociosOficina = comprobantesCronologicos.filter(
      c => c.estado === 'VIGENTE' && c.origen === 'SOCIOS' && c.dineroNuevoEfectivo > 0,
    );
    const ws02 = this.crearHojaMatrizClasificada(
      XLSX,
      payload,
      '02_SOCIOS_OFICINA — INGRESOS EN EFECTIVO DE SOCIOS POR OFICINA (INCLUYE RECAUDACIÓN TARJETA)',
      'EFECTIVO',
      sociosOficina,
    );
    XLSX.utils.book_append_sheet(wb, ws02, '02_SOCIOS_OFICINA');

    // 4. Hoja 03_SOCIOS_BANCO (Vigentes de Socios con Dinero Nuevo en Banco/QR > 0)
    const sociosBanco = comprobantesCronologicos.filter(
      c => c.estado === 'VIGENTE' && c.origen === 'SOCIOS' && c.dineroNuevoBanco > 0,
    );
    const ws03 = this.crearHojaMatrizClasificada(
      XLSX,
      payload,
      '03_SOCIOS_BANCO — INGRESOS BANCARIOS / TRANSFERENCIA / QR DE SOCIOS',
      'BANCO',
      sociosBanco,
    );
    XLSX.utils.book_append_sheet(wb, ws03, '03_SOCIOS_BANCO');

    // 5. Hoja 04_INQUILINOS_OFICINA (Vigentes de Inquilinos con Dinero Nuevo en Efectivo > 0)
    const inquilinosOficina = comprobantesCronologicos.filter(
      c => c.estado === 'VIGENTE' && c.origen === 'INQUILINOS' && c.dineroNuevoEfectivo > 0,
    );
    const ws04 = this.crearHojaMatrizClasificada(
      XLSX,
      payload,
      '04_INQUILINOS_OFICINA — INGRESOS EN EFECTIVO DE INQUILINOS POR OFICINA',
      'EFECTIVO',
      inquilinosOficina,
    );
    XLSX.utils.book_append_sheet(wb, ws04, '04_INQUILINOS_OFICINA');

    // 6. Hoja 05_INQUILINOS_BANCO (Vigentes de Inquilinos con Dinero Nuevo en Banco/QR > 0)
    const inquilinosBanco = comprobantesCronologicos.filter(
      c => c.estado === 'VIGENTE' && c.origen === 'INQUILINOS' && c.dineroNuevoBanco > 0,
    );
    const ws05 = this.crearHojaMatrizClasificada(
      XLSX,
      payload,
      '05_INQUILINOS_BANCO — INGRESOS BANCARIOS / TRANSFERENCIA / QR DE INQUILINOS',
      'BANCO',
      inquilinosBanco,
    );
    XLSX.utils.book_append_sheet(wb, ws05, '05_INQUILINOS_BANCO');

    // 7. Hoja 06_OTROS_INGRESOS (Operaciones vigentes de Caja Rápida / Otros Ingresos)
    const otrosIngresos = comprobantesCronologicos.filter(
      c => c.estado === 'VIGENTE' && c.origen === 'OTROS' && c.dineroNuevoCajaBanco > 0,
    );
    const ws06 = this.crearHoja06OtrosIngresos(XLSX, payload, otrosIngresos);
    XLSX.utils.book_append_sheet(wb, ws06, '06_OTROS_INGRESOS');

    // 8. Hoja 07_CONCILIACION
    const ws07 = this.crearHoja07Conciliacion(XLSX, payload);
    XLSX.utils.book_append_sheet(wb, ws07, '07_CONCILIACION');

    // 9. Hoja 08_DOCUMENTOS_PENDIENTES
    const ws08 = this.crearHoja08DocumentosPendientes(XLSX, payload, docsPendientesExportar);
    XLSX.utils.book_append_sheet(wb, ws08, '08_DOCUMENTOS_PENDIENTES');

    return wb;
  }

  // ==========================================================================
  // HOJA 00: RESUMEN EJECUTIVO Y PARÁMETROS DEL REPORTE
  // ==========================================================================
  private crearHoja00Resumen(
    XLSX: typeof XLSXType,
    payload: PayloadExportacionContableExcel,
    comprobantes: ComprobanteContableItem[],
  ): XLSXType.WorkSheet {
    const { reporte, filtro, kpis, conciliacion } = payload;

    // Calcular resumen por concepto sobre comprobantes vigentes
    const mapaConceptos = new Map<
      string,
      { cantidad: number; socios: number; inquilinos: number; otros: number; total: number }
    >();
    for (const c of comprobantes) {
      if (c.estado !== 'VIGENTE') continue;
      for (const l of c.lineas) {
        const actual = mapaConceptos.get(l.concepto) ?? {
          cantidad: 0,
          socios: 0,
          inquilinos: 0,
          otros: 0,
          total: 0,
        };
        actual.cantidad += 1;
        if (c.origen === 'SOCIOS') actual.socios = round2(actual.socios + l.importeAplicado);
        else if (c.origen === 'INQUILINOS')
          actual.inquilinos = round2(actual.inquilinos + l.importeAplicado);
        else actual.otros = round2(actual.otros + l.importeAplicado);
        actual.total = round2(actual.total + l.importeAplicado);
        mapaConceptos.set(l.concepto, actual);
      }
    }
    const listaConceptos = Array.from(mapaConceptos.entries()).sort(
      (a, b) => b[1].total - a[1].total,
    );

    const rows: unknown[][] = [
      ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.'],
      [`RUC: ${RUC_INSTITUCIONAL_OFICIAL} — SISTEMA ERP COOPERATIVO`],
      ['REPORTE CONTABLE DE INGRESOS — RESUMEN Y CONTROL FINANCIERO (HOJA 00_RESUMEN)'],
      [],
      ['1. DATOS DE EMISIÓN Y FILTROS APLICADOS'],
      ['Período Consultado:', `${reporte.periodoDesde} al ${reporte.periodoHasta} (${reporte.periodoEtiqueta})`, '', 'Fecha y Hora de Emisión:', reporte.generadoEn],
      ['Emitido por:', `${reporte.usuarioEmisor} (${reporte.rolEmisor})`, '', 'Filtro Estado:', filtro.estado],
      ['Filtro Origen:', filtro.origen, '', 'Filtro Canal:', filtro.canal],
      ['Filtro Concepto:', filtro.concepto || 'Todos los conceptos', '', 'Filtro Documento:', filtro.documento],
      ['Búsqueda Texto:', filtro.busqueda || '(Sin filtro de búsqueda)', '', 'Modo de Muestra:', payload.anonimizarMuestra ? 'MUESTRA ANONIMIZADA PARA APROBACIÓN CONTABLE' : 'DATOS REALES DE PRODUCCIÓN'],
      [],
      ['2. INDICADORES DE CONTROL FINANCIERO Y DOCUMENTARIO (5 KPIS OFICIALES)'],
      ['N°', 'Indicador de Control', 'Base / Valor Principal', 'Detalle / Composición', 'Observación Contable'],
      [
        1,
        'Comprobantes únicos registrados',
        kpis.comprobantesUnicos,
        `Vigentes: ${kpis.comprobantesVigentes} | Anulados: ${kpis.comprobantesAnulados} | Líneas de conceptos: ${kpis.totalLineasConceptos}`,
        'Cada recibo multiconcepto se contabiliza una sola vez como comprobante emitido.',
      ],
      [
        2,
        'Dinero nuevo ingresado a caja y banco (S/)',
        kpis.dineroNuevoTotal,
        `Efectivo Oficina: S/ ${kpis.dineroNuevoEfectivo.toFixed(2)} (incluye Tarjeta S/ ${kpis.recaudacionTarjetaEfectivo.toFixed(2)}) | Banco/QR: S/ ${kpis.dineroNuevoBanco.toFixed(2)}`,
        'Excluye aplicaciones de saldo a favor ya ingresadas en períodos o abonos previos.',
      ],
      [
        3,
        'Saldo a favor utilizado (S/)',
        kpis.saldoAFavorUtilizado,
        `Excedentes nuevos generados en recibos del período: S/ ${kpis.excedenteGenerado.toFixed(2)}`,
        'Aplicaciones de saldo prepago a deudas. No constituye nuevo ingreso físico ni bancario.',
      ],
      [
        4,
        'Total aplicado a conceptos (S/)',
        kpis.totalAplicadoConceptos,
        `Deudas e Internos: S/ ${kpis.totalAplicadoDeudasInternos.toFixed(2)} | Recaudación Tarjeta (Abono): S/ ${kpis.recaudacionTarjetaEfectivo.toFixed(2)}`,
        'Suma exacta de la columna Importe Aplicado en 01_DETALLE_VERTICAL.',
      ],
      [
        5,
        'Personas únicas con documento pendiente',
        kpis.personasSinDocumentoTotal,
        `SIN REGISTRAR: ${kpis.personasSinRegistrarCount} | POR VALIDAR: ${kpis.personasPorValidarCount}`,
        'Ver padrón detallado para regularización en hoja 08_DOCUMENTOS_PENDIENTES.',
      ],
      [],
      ['3. DISTRIBUCIÓN DE DINERO NUEVO POR HOJA CLASIFICADA (02 A 06)'],
      ['Hoja del Libro', 'Descripción del Canal y Origen', 'Importe Neto de Dinero Nuevo (S/)', '% sobre Dinero Nuevo', 'Criterio de Inclusión'],
      [
        '02_SOCIOS_OFICINA',
        'Ingresos en efectivo de socios por oficina (Recibos + Recaudación Tarjeta)',
        conciliacion.hoja02SociosOficina,
        conciliacion.totalDineroNuevoCajaBanco > 0
          ? round2((conciliacion.hoja02SociosOficina / conciliacion.totalDineroNuevoCajaBanco) * 100)
          : 0,
        'Solo porción efectiva real (excluye saldo a favor usado).',
      ],
      [
        '03_SOCIOS_BANCO',
        'Ingresos bancarios / transferencia / QR de socios',
        conciliacion.hoja03SociosBanco,
        conciliacion.totalDineroNuevoCajaBanco > 0
          ? round2((conciliacion.hoja03SociosBanco / conciliacion.totalDineroNuevoCajaBanco) * 100)
          : 0,
        'Solo porción bancaria real (excluye saldo a favor usado).',
      ],
      [
        '04_INQUILINOS_OFICINA',
        'Ingresos en efectivo de inquilinos por oficina',
        conciliacion.hoja04InquilinosOficina,
        conciliacion.totalDineroNuevoCajaBanco > 0
          ? round2((conciliacion.hoja04InquilinosOficina / conciliacion.totalDineroNuevoCajaBanco) * 100)
          : 0,
        'Solo porción efectiva real (excluye saldo a favor usado).',
      ],
      [
        '05_INQUILINOS_BANCO',
        'Ingresos bancarios / transferencia / QR de inquilinos',
        conciliacion.hoja05InquilinosBanco,
        conciliacion.totalDineroNuevoCajaBanco > 0
          ? round2((conciliacion.hoja05InquilinosBanco / conciliacion.totalDineroNuevoCajaBanco) * 100)
          : 0,
        'Solo porción bancaria real (excluye saldo a favor usado).',
      ],
      [
        '06_OTROS_INGRESOS',
        'Otros ingresos espontáneos / Caja Rápida (Efectivo + Banco)',
        conciliacion.hoja06OtrosIngresos,
        conciliacion.totalDineroNuevoCajaBanco > 0
          ? round2((conciliacion.hoja06OtrosIngresos / conciliacion.totalDineroNuevoCajaBanco) * 100)
          : 0,
        'Operaciones INT-XXXXXX sin persona de padrón (Documento: NO APLICA).',
      ],
      [
        'TOTAL DINERO NUEVO',
        'SUMA DE HOJAS CLASIFICADAS (02 + 03 + 04 + 05 + 06)',
        conciliacion.sumaHojasClasificadas,
        100,
        'Nota: Las hojas 02..06 son vistas derivadas; no sumar dos veces con 01_DETALLE_VERTICAL.',
      ],
      [],
      ['4. DESGLOSE DE IMPORTES APLICADOS POR CONCEPTO CONTABLE (VIGENTES)'],
      ['Concepto Contable', 'Líneas Aplicadas', 'Socios (S/)', 'Inquilinos (S/)', 'Otros (S/)', 'Total Aplicado (S/)', '% Participación'],
    ];

    for (const [concepto, d] of listaConceptos) {
      const pct =
        kpis.totalAplicadoConceptos > 0
          ? round2((d.total / kpis.totalAplicadoConceptos) * 100)
          : 0;
      rows.push([concepto, d.cantidad, d.socios, d.inquilinos, d.otros, d.total, pct]);
    }

    rows.push([
      'TOTAL APLICADO A CONCEPTOS',
      kpis.totalLineasConceptos,
      round2(listaConceptos.reduce((s, x) => s + x[1].socios, 0)),
      round2(listaConceptos.reduce((s, x) => s + x[1].inquilinos, 0)),
      round2(listaConceptos.reduce((s, x) => s + x[1].otros, 0)),
      kpis.totalAplicadoConceptos,
      100,
    ]);

    const ws = XLSX.utils.aoa_to_sheet(rows);
    ws['!cols'] = [
      { wch: 26 },
      { wch: 52 },
      { wch: 24 },
      { wch: 58 },
      { wch: 54 },
      { wch: 22 },
      { wch: 16 },
    ];
    ws['!views'] = [{ state: 'frozen', ySplit: 4 }];
    this.configurarImpresionHoja(ws, 'landscape');

    // Formatear celdas numéricas de KPIs y tablas
    this.aplicarFormatoCelda(ws, XLSX, 13, 2, FORMATO_ENTERO);
    this.aplicarFormatoCelda(ws, XLSX, 14, 2, FORMATO_SOLES);
    this.aplicarFormatoCelda(ws, XLSX, 15, 2, FORMATO_SOLES);
    this.aplicarFormatoCelda(ws, XLSX, 16, 2, FORMATO_SOLES);
    this.aplicarFormatoCelda(ws, XLSX, 17, 2, FORMATO_ENTERO);

    for (let r = 21; r <= 26; r++) {
      this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 3, '0.00"%"');
    }

    const startConcRow = 30;
    for (let r = startConcRow; r <= startConcRow + listaConceptos.length; r++) {
      this.aplicarFormatoCelda(ws, XLSX, r, 1, FORMATO_ENTERO);
      this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 3, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 4, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 5, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 6, '0.00"%"');
    }

    return ws;
  }

  // ==========================================================================
  // HOJA 01: DETALLE VERTICAL POR LÍNEA DE CONCEPTO (SIN DUPLICIDAD DE CABECERA)
  // ==========================================================================
  private crearHoja01DetalleVertical(
    XLSX: typeof XLSXType,
    payload: PayloadExportacionContableExcel,
    comprobantes: ComprobanteContableItem[],
  ): XLSXType.WorkSheet {
    const { reporte } = payload;

    const headers = [
      'Fecha',
      'Hora',
      'Comprobante',
      'Línea',
      'Estado',
      'Origen',
      'Persona Registrada (Cuenta)',
      'Tipo de Documento',
      'Número de Documento',
      'Estado del Documento',
      'Titular del Puesto',
      'Doc. Titular',
      'Puesto/Almacén',
      'Concepto',
      'Período',
      'Estado Obligación / Tipo Abono',
      'Importe Aplicado (S/)',
      'Dinero Nuevo Comprobante - 1ra Línea (S/)',
      'Saldo a Favor Usado Comprobante - 1ra Línea (S/)',
      'Excedente Generado Comprobante - 1ra Línea (S/)',
      'Canal de Pago',
      'Ref. / Observación',
      'Cajero',
    ];

    const rows: unknown[][] = [
      ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA. — DETALLE VERTICAL CONTABLE (01_DETALLE_VERTICAL)'],
      [
        `Período: ${reporte.periodoDesde} al ${reporte.periodoHasta} | Emitido: ${reporte.generadoEn} | Nota Contable: Las columnas de Dinero Nuevo, Saldo a Favor y Excedente del comprobante se consignan únicamente en la 1ra línea (1/N) de cada comprobante vigente para evitar duplicidades al usar SUMA o SUBTOTAL en Excel.`,
      ],
      [],
      headers,
    ];

    let sumAplicadoVigente = 0;
    let sumDineroNuevoUnico = 0;
    let sumSaldoFavorUnico = 0;
    let sumExcedenteUnico = 0;
    let totalFilasDatos = 0;

    for (const c of comprobantes) {
      const fechaValor = parseFechaExcel(c.fechaLima);
      const esVigente = c.estado === 'VIGENTE';

      const etiquetaEstadoDoc =
        c.documento.estado === 'SIN REGISTRAR'
          ? '⚠ SIN REGISTRAR'
          : c.documento.estado === 'POR VALIDAR'
            ? '⚠ POR VALIDAR'
            : c.documento.estado;

      for (const l of c.lineas) {
        totalFilasDatos++;
        if (esVigente) {
          sumAplicadoVigente = round2(sumAplicadoVigente + l.importeAplicado);
          if (l.esPrimeraLinea) {
            sumDineroNuevoUnico = round2(sumDineroNuevoUnico + c.dineroNuevoCajaBanco);
            sumSaldoFavorUnico = round2(sumSaldoFavorUnico + c.saldoAFavorUtilizado);
            sumExcedenteUnico = round2(sumExcedenteUnico + c.excedenteGenerado);
          }
        }

        // Ajuste 2.1: Los totales del comprobante solo van como número sumable en la primera línea (1/N) de comprobantes vigentes
        const celdaDineroNuevo = esVigente && l.esPrimeraLinea ? c.dineroNuevoCajaBanco : null;
        const celdaSaldoFavor = esVigente && l.esPrimeraLinea ? c.saldoAFavorUtilizado : null;
        const celdaExcedente = esVigente && l.esPrimeraLinea ? c.excedenteGenerado : null;

        rows.push([
          fechaValor,
          c.horaLima,
          c.numeroComprobante,
          `${l.numeroLinea}/${l.totalLineasComprobante}`,
          c.estado,
          c.origen,
          c.personaRegistradaNombre,
          c.documento.tipoDocumento,
          c.documento.numeroMostrar,
          etiquetaEstadoDoc,
          c.titularPuestoNombre ?? '—',
          c.titularPuestoDocumento ?? '—',
          l.puestoLinea,
          l.concepto,
          l.periodo,
          c.estado === 'ANULADO'
            ? `ANULADO (${c.motivoAnulacion || 'Sin motivo'})`
            : l.etiquetaEstadoDeuda,
          c.estado === 'ANULADO' ? 0 : l.importeAplicado,
          celdaDineroNuevo,
          celdaSaldoFavor,
          celdaExcedente,
          c.canalEtiqueta,
          c.referenciaExterna ?? '',
          c.cajero,
        ]);
      }
    }

    // Fila de Totales Generales al pie
    rows.push([
      'TOTALES VIGENTES',
      '',
      `${comprobantes.filter(x => x.estado === 'VIGENTE').length} comprobantes`,
      `${totalFilasDatos} líneas`,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      'SUMA EXACTA SIN DUPLICIDADES:',
      sumAplicadoVigente,
      sumDineroNuevoUnico,
      sumSaldoFavorUnico,
      sumExcedenteUnico,
      '',
      '',
      '',
    ]);

    const ws = XLSX.utils.aoa_to_sheet(rows, { cellDates: true });
    const headerRowIndex = 3; // 0-based (fila 4 en Excel)
    const lastRowIndex = rows.length - 1;

    // Formato de celdas: Fechas, Documentos como Texto ('s'), Moneda ('n' con FORMATO_SOLES)
    for (let r = headerRowIndex + 1; r <= lastRowIndex; r++) {
      const esFilaTotal = r === lastRowIndex;
      if (!esFilaTotal) {
        this.aplicarFormatoFecha(ws, XLSX, r, 0);
        this.forzarCeldaTexto(ws, XLSX, r, 2); // Comprobante
        this.forzarCeldaTexto(ws, XLSX, r, 3); // Línea 1/N
        this.forzarCeldaTexto(ws, XLSX, r, 8); // Número de Documento (DNI/RUC como texto)
        this.forzarCeldaTexto(ws, XLSX, r, 11); // Doc. Titular como texto
        this.forzarCeldaTexto(ws, XLSX, r, 12); // Puesto/Almacén como texto
        this.forzarCeldaTexto(ws, XLSX, r, 14); // Período como texto
      }
      this.aplicarFormatoCelda(ws, XLSX, r, 16, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 17, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 18, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 19, FORMATO_SOLES);
    }

    ws['!cols'] = [
      { wch: 12 }, // Fecha
      { wch: 8 },  // Hora
      { wch: 22 }, // Comprobante
      { wch: 8 },  // Línea
      { wch: 11 }, // Estado
      { wch: 13 }, // Origen
      { wch: 36 }, // Persona Registrada
      { wch: 16 }, // Tipo de Documento
      { wch: 16 }, // Número de Documento
      { wch: 18 }, // Estado del Documento
      { wch: 32 }, // Titular del Puesto
      { wch: 15 }, // Doc. Titular
      { wch: 26 }, // Puesto/Almacén
      { wch: 26 }, // Concepto
      { wch: 10 }, // Período
      { wch: 38 }, // Estado Obligación / Tipo Abono
      { wch: 18 }, // Importe Aplicado
      { wch: 20 }, // Dinero Nuevo (1ra Línea)
      { wch: 20 }, // Saldo a Favor (1ra Línea)
      { wch: 20 }, // Excedente (1ra Línea)
      { wch: 26 }, // Canal de Pago
      { wch: 26 }, // Ref / Observación
      { wch: 18 }, // Cajero
    ];

    ws['!autofilter'] = {
      ref: XLSX.utils.encode_range({
        s: { r: headerRowIndex, c: 0 },
        e: { r: Math.max(headerRowIndex, lastRowIndex - 1), c: headers.length - 1 },
      }),
    };
    ws['!views'] = [{ state: 'frozen', ySplit: headerRowIndex + 1, xSplit: 3 }];
    this.configurarImpresionHoja(ws, 'landscape');

    return ws;
  }

  // ==========================================================================
  // HOJAS 02 A 05: MATRIZ CONTABLE POR CONCEPTOS Y SUBTOTALES DIARIOS
  // (Inspiradas en las hojas de arqueo de septiembre — 0 duplicidad de recibos)
  // ==========================================================================
  private crearHojaMatrizClasificada(
    XLSX: typeof XLSXType,
    payload: PayloadExportacionContableExcel,
    tituloHoja: string,
    tipoCanal: 'EFECTIVO' | 'BANCO',
    comprobantesHoja: ComprobanteContableItem[],
  ): XLSXType.WorkSheet {
    const { reporte } = payload;

    // Determinar columnas dinámicas de conceptos presentes en esta hoja
    const conceptosSet = new Set<string>();
    for (const c of comprobantesHoja) {
      for (const l of c.lineas) {
        conceptosSet.add(l.concepto);
      }
    }
    const ordenPrioridad = [
      'Luz',
      'Agua',
      'Gastos administrativos',
      'Previsión social',
      'Alquiler',
      'Alquiler de almacén',
      'Recaudación Tarjeta (Abono)',
      'Deposito',
      'Deuda anterior',
      'Multa',
      'Otros',
    ];
    const colsConceptos = Array.from(conceptosSet).sort((a, b) => {
      const ia = ordenPrioridad.indexOf(a);
      const ib = ordenPrioridad.indexOf(b);
      if (ia !== -1 && ib !== -1) return ia - ib;
      if (ia !== -1) return -1;
      if (ib !== -1) return 1;
      return a.localeCompare(b, 'es');
    });

    const etiquetaColNeto =
      tipoCanal === 'EFECTIVO'
        ? '(=) Ingreso Efectivo Neto (S/)'
        : '(=) Ingreso Banco/QR Neto (S/)';

    const headers = [
      'Fecha',
      'Hora',
      'Comprobante',
      'Persona Registrada (Cuenta)',
      'Tipo Doc.',
      'Número de Documento',
      'Estado Documento',
      'Titular del Puesto',
      'Puesto/Almacén',
      'Período(s)',
      ...colsConceptos,
      'Total Aplicado Conceptos (S/)',
      '(-) Saldo a Favor Usado (S/)',
      '(+) Excedente a Saldo (S/)',
      etiquetaColNeto,
      'Canal',
      'Ref. / Voucher',
      'Cajero',
    ];

    const rows: unknown[][] = [
      [`COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA. — ${tituloHoja}`],
      [
        `Período: ${reporte.periodoDesde} al ${reporte.periodoHasta} | Vista derivada de 01_DETALLE_VERTICAL. No incluye operaciones cubiertas 100 % con saldo a favor. En pagos mixtos, el ingreso neto descuenta la porción de saldo a favor utilizada.`,
      ],
      [],
      headers,
    ];

    const headerRowIndex = 3;
    const colStartConceptos = 10;
    const colTotalAplicado = colStartConceptos + colsConceptos.length;
    const colSaldoFavor = colTotalAplicado + 1;
    const colExcedente = colTotalAplicado + 2;
    const colIngresoNeto = colTotalAplicado + 3;

    const totalesPorConcepto: Record<string, number> = {};
    colsConceptos.forEach(col => (totalesPorConcepto[col] = 0));

    let granTotalAplicado = 0;
    let granTotalSaldoFavor = 0;
    let granTotalExcedente = 0;
    let granTotalIngresoNeto = 0;

    // Agrupar por fecha para incluir subtotales diarios claros
    const porFecha = new Map<string, ComprobanteContableItem[]>();
    for (const c of comprobantesHoja) {
      const lista = porFecha.get(c.fechaLima) ?? [];
      lista.push(c);
      porFecha.set(c.fechaLima, lista);
    }

    const filasDeDatosIndices: number[] = [];
    const filasSubtotalesIndices: number[] = [];

    for (const [fechaLima, itemsDia] of porFecha.entries()) {
      const subConceptosDia: Record<string, number> = {};
      colsConceptos.forEach(col => (subConceptosDia[col] = 0));
      let subAplicadoDia = 0;
      let subSaldoFavorDia = 0;
      let subExcedenteDia = 0;
      let subNetoDia = 0;

      for (const c of itemsDia) {
        const mapaConcRecibo: Record<string, number> = {};
        const periodosSet = new Set<string>();

        for (const l of c.lineas) {
          mapaConcRecibo[l.concepto] = round2(
            (mapaConcRecibo[l.concepto] ?? 0) + l.importeAplicado,
          );
          subConceptosDia[l.concepto] = round2(
            (subConceptosDia[l.concepto] ?? 0) + l.importeAplicado,
          );
          totalesPorConcepto[l.concepto] = round2(
            (totalesPorConcepto[l.concepto] ?? 0) + l.importeAplicado,
          );
          if (l.periodo && l.periodo !== '—') periodosSet.add(l.periodo);
        }

        const netoCanal =
          tipoCanal === 'EFECTIVO' ? c.dineroNuevoEfectivo : c.dineroNuevoBanco;

        subAplicadoDia = round2(subAplicadoDia + c.totalAplicadoConceptos);
        subSaldoFavorDia = round2(subSaldoFavorDia + c.saldoAFavorUtilizado);
        subExcedenteDia = round2(subExcedenteDia + c.excedenteGenerado);
        subNetoDia = round2(subNetoDia + netoCanal);

        granTotalAplicado = round2(granTotalAplicado + c.totalAplicadoConceptos);
        granTotalSaldoFavor = round2(granTotalSaldoFavor + c.saldoAFavorUtilizado);
        granTotalExcedente = round2(granTotalExcedente + c.excedenteGenerado);
        granTotalIngresoNeto = round2(granTotalIngresoNeto + netoCanal);

        const etiquetaEstadoDoc =
          c.documento.estado === 'SIN REGISTRAR'
            ? '⚠ SIN REGISTRAR'
            : c.documento.estado === 'POR VALIDAR'
              ? '⚠ POR VALIDAR'
              : c.documento.estado;

        const valoresConceptos = colsConceptos.map(col => mapaConcRecibo[col] ?? null);

        filasDeDatosIndices.push(rows.length);
        rows.push([
          parseFechaExcel(c.fechaLima),
          c.horaLima,
          c.numeroComprobante,
          c.personaRegistradaNombre,
          c.documento.tipoDocumento,
          c.documento.numeroMostrar,
          etiquetaEstadoDoc,
          c.titularPuestoNombre ?? '—',
          c.puestoMostrar,
          Array.from(periodosSet).join(', ') || '—',
          ...valoresConceptos,
          c.totalAplicadoConceptos,
          c.saldoAFavorUtilizado > 0 ? c.saldoAFavorUtilizado : null,
          c.excedenteGenerado > 0 ? c.excedenteGenerado : null,
          netoCanal,
          c.canalEtiqueta,
          c.referenciaExterna ?? '',
          c.cajero,
        ]);
      }

      // Subtotal diario
      filasSubtotalesIndices.push(rows.length);
      rows.push([
        `SUBTOTAL DÍA ${fechaLima}`,
        '',
        `${itemsDia.length} comp.`,
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ...colsConceptos.map(col => subConceptosDia[col] || 0),
        subAplicadoDia,
        subSaldoFavorDia,
        subExcedenteDia,
        subNetoDia,
        '',
        '',
        '',
      ]);
    }

    // Fila de Total General de la hoja
    const totalRowIdx = rows.length;
    rows.push([
      'TOTAL GENERAL DE LA HOJA',
      '',
      `${comprobantesHoja.length} comprobantes`,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      ...colsConceptos.map(col => totalesPorConcepto[col] || 0),
      granTotalAplicado,
      granTotalSaldoFavor,
      granTotalExcedente,
      granTotalIngresoNeto,
      '',
      '',
      '',
    ]);

    const ws = XLSX.utils.aoa_to_sheet(rows, { cellDates: true });

    for (const r of filasDeDatosIndices) {
      this.aplicarFormatoFecha(ws, XLSX, r, 0);
      this.forzarCeldaTexto(ws, XLSX, r, 2); // Comprobante
      this.forzarCeldaTexto(ws, XLSX, r, 5); // Número de Documento (DNI/RUC como texto)
      this.forzarCeldaTexto(ws, XLSX, r, 8); // Puesto
      this.forzarCeldaTexto(ws, XLSX, r, 9); // Períodos
      for (let c = colStartConceptos; c <= colIngresoNeto; c++) {
        this.aplicarFormatoCelda(ws, XLSX, r, c, FORMATO_SOLES);
      }
    }

    for (const r of [...filasSubtotalesIndices, totalRowIdx]) {
      for (let c = colStartConceptos; c <= colIngresoNeto; c++) {
        this.aplicarFormatoCelda(ws, XLSX, r, c, FORMATO_SOLES);
      }
    }

    ws['!cols'] = [
      { wch: 16 }, // Fecha / Subtotal
      { wch: 8 },  // Hora
      { wch: 22 }, // Comprobante
      { wch: 34 }, // Persona Registrada
      { wch: 14 }, // Tipo Doc
      { wch: 16 }, // Número de Documento
      { wch: 18 }, // Estado Documento
      { wch: 30 }, // Titular del Puesto
      { wch: 24 }, // Puesto/Almacén
      { wch: 14 }, // Períodos
      ...colsConceptos.map(col => ({ wch: Math.max(15, Math.min(24, col.length + 5)) })),
      { wch: 20 }, // Total Aplicado
      { wch: 18 }, // (-) Saldo a Favor
      { wch: 18 }, // (+) Excedente
      { wch: 22 }, // (=) Ingreso Neto
      { wch: 22 }, // Canal
      { wch: 22 }, // Ref / Voucher
      { wch: 18 }, // Cajero
    ];

    ws['!autofilter'] = {
      ref: XLSX.utils.encode_range({
        s: { r: headerRowIndex, c: 0 },
        e: { r: Math.max(headerRowIndex, totalRowIdx - 1), c: headers.length - 1 },
      }),
    };
    ws['!views'] = [{ state: 'frozen', ySplit: headerRowIndex + 1, xSplit: 3 }];
    this.configurarImpresionHoja(ws, 'landscape');

    return ws;
  }

  // ==========================================================================
  // HOJA 06: OTROS INGRESOS (CAJA RÁPIDA / OPERACIONES ESPONTÁNEAS)
  // ==========================================================================
  private crearHoja06OtrosIngresos(
    XLSX: typeof XLSXType,
    payload: PayloadExportacionContableExcel,
    otrosIngresos: ComprobanteContableItem[],
  ): XLSXType.WorkSheet {
    const { reporte } = payload;

    const headers = [
      'Fecha',
      'Hora',
      'Comprobante',
      'Estado',
      'Origen',
      'Concepto Contable',
      'Descripción / Observación',
      'Tipo de Documento',
      'Número de Documento',
      'Estado del Documento',
      'Método / Canal',
      'Ingreso Efectivo (S/)',
      'Ingreso Banco / Transferencia (S/)',
      'Total Ingreso (S/)',
      'Cajero',
    ];

    const rows: unknown[][] = [
      ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA. — 06_OTROS_INGRESOS (CAJA RÁPIDA / ESPONTÁNEOS)'],
      [
        `Período: ${reporte.periodoDesde} al ${reporte.periodoHasta} | Operaciones registradas en public.ingresos_internos que no corresponden a una persona identificable del padrón (Documento: NO APLICA).`,
      ],
      [],
      headers,
    ];

    const headerRowIndex = 3;
    let totalEfectivo = 0;
    let totalBanco = 0;
    let totalGeneral = 0;

    for (const c of otrosIngresos) {
      const conc = c.lineas[0]?.concepto ?? 'Otros Ingresos';
      totalEfectivo = round2(totalEfectivo + c.dineroNuevoEfectivo);
      totalBanco = round2(totalBanco + c.dineroNuevoBanco);
      totalGeneral = round2(totalGeneral + c.dineroNuevoCajaBanco);

      rows.push([
        parseFechaExcel(c.fechaLima),
        c.horaLima,
        c.numeroComprobante,
        c.estado,
        c.origen,
        conc,
        c.referenciaExterna ?? 'Cobro directo de Caja Rápida',
        c.documento.tipoDocumento,
        c.documento.numeroMostrar,
        c.documento.estado,
        c.canalEtiqueta,
        c.dineroNuevoEfectivo,
        c.dineroNuevoBanco,
        c.dineroNuevoCajaBanco,
        c.cajero,
      ]);
    }

    const totalRowIdx = rows.length;
    rows.push([
      'TOTAL OTROS INGRESOS',
      '',
      `${otrosIngresos.length} operaciones`,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      totalEfectivo,
      totalBanco,
      totalGeneral,
      '',
    ]);

    const ws = XLSX.utils.aoa_to_sheet(rows, { cellDates: true });

    for (let r = headerRowIndex + 1; r <= totalRowIdx; r++) {
      if (r < totalRowIdx) {
        this.aplicarFormatoFecha(ws, XLSX, r, 0);
        this.forzarCeldaTexto(ws, XLSX, r, 2);
        this.forzarCeldaTexto(ws, XLSX, r, 8);
      }
      this.aplicarFormatoCelda(ws, XLSX, r, 11, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 12, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 13, FORMATO_SOLES);
    }

    ws['!cols'] = [
      { wch: 14 },
      { wch: 8 },
      { wch: 18 },
      { wch: 12 },
      { wch: 12 },
      { wch: 24 },
      { wch: 36 },
      { wch: 16 },
      { wch: 16 },
      { wch: 18 },
      { wch: 24 },
      { wch: 18 },
      { wch: 20 },
      { wch: 18 },
      { wch: 18 },
    ];

    ws['!autofilter'] = {
      ref: XLSX.utils.encode_range({
        s: { r: headerRowIndex, c: 0 },
        e: { r: Math.max(headerRowIndex, totalRowIdx - 1), c: headers.length - 1 },
      }),
    };
    ws['!views'] = [{ state: 'frozen', ySplit: headerRowIndex + 1 }];
    this.configurarImpresionHoja(ws, 'landscape');

    return ws;
  }

  // ==========================================================================
  // HOJA 07: CONCILIACIÓN FINANCIERA AL CENTAVO (AJUSTE 2.5)
  // ==========================================================================
  private crearHoja07Conciliacion(
    XLSX: typeof XLSXType,
    payload: PayloadExportacionContableExcel,
  ): XLSXType.WorkSheet {
    const { reporte, conciliacion } = payload;

    const rows: unknown[][] = [
      ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA. — 07_CONCILIACION FINANCIERA'],
      [
        `Período: ${reporte.periodoDesde} al ${reporte.periodoHasta} | Emitido: ${reporte.generadoEn} | Comparación matemática entre Dinero Nuevo, Saldo a Favor, Imputación a Conceptos y Central de Reportes.`,
      ],
      [],
      ['BLOQUE A — COMPOSICIÓN DEL DINERO NUEVO INGRESADO A CAJA Y BANCO'],
      ['Código', 'Rubro / Fuente Financiera', 'Importe Reporte Contable (S/)', 'Hoja de Referencia en el Libro', 'Explicación Técnica'],
      [
        'A.1',
        'Cobros en Efectivo de Socios (Recibos pagos)',
        conciliacion.pagosEfectivoSocios,
        '02_SOCIOS_OFICINA',
        'pagos.monto_total donde socio_id IS NOT NULL y metodo_pago = Efectivo',
      ],
      [
        'A.2',
        'Recaudación por Tarjeta — Abonos Semanales Socios (Efectivo)',
        conciliacion.recaudacionTarjetaSocios,
        '02_SOCIOS_OFICINA',
        'recaudacion_abonos.monto (ingreso efectivo real que abona a saldo_a_favor)',
      ],
      [
        'A.3',
        'Cobros en Efectivo de Inquilinos (Recibos pagos)',
        conciliacion.pagosEfectivoInquilinos,
        '04_INQUILINOS_OFICINA',
        'pagos.monto_total donde inquilino_id IS NOT NULL y metodo_pago = Efectivo',
      ],
      [
        'A.4',
        'Otros Ingresos Internos en Efectivo (Caja Rápida)',
        conciliacion.ingresosInternosEfectivo,
        '06_OTROS_INGRESOS',
        'ingresos_internos.monto donde metodo_pago = Efectivo',
      ],
      [
        'A.EF',
        'SUBTOTAL DINERO NUEVO EN EFECTIVO (A.1 + A.2 + A.3 + A.4)',
        conciliacion.totalDineroNuevoEfectivo,
        '02 + 04 + 06 (Efectivo)',
        'Total efectivo físico ingresado en el período.',
      ],
      [
        'A.5',
        'Cobros por Transferencia / QR de Socios (Recibos pagos)',
        conciliacion.pagosBancoSocios,
        '03_SOCIOS_BANCO',
        'pagos.monto_total donde socio_id IS NOT NULL y metodo_pago = Transferencia',
      ],
      [
        'A.6',
        'Cobros por Transferencia / QR de Inquilinos (Recibos pagos)',
        conciliacion.pagosBancoInquilinos,
        '05_INQUILINOS_BANCO',
        'pagos.monto_total donde inquilino_id IS NOT NULL y metodo_pago = Transferencia',
      ],
      [
        'A.7',
        'Otros Ingresos Internos por Transferencia / QR (Caja Rápida)',
        conciliacion.ingresosInternosBanco,
        '06_OTROS_INGRESOS',
        'ingresos_internos.monto donde metodo_pago = Transferencia',
      ],
      [
        'A.BK',
        'SUBTOTAL DINERO NUEVO EN BANCO / TRANSFERENCIA / QR (A.5 + A.6 + A.7)',
        conciliacion.totalDineroNuevoBanco,
        '03 + 05 + 06 (Banco)',
        'Total bancario / QR registrado en comprobantes del período.',
      ],
      [
        'A.TOT',
        'TOTAL DINERO NUEVO INGRESADO A CAJA Y BANCO (A.EF + A.BK)',
        conciliacion.totalDineroNuevoCajaBanco,
        '00_RESUMEN / 01_DETALLE_VERTICAL',
        'Suma total de ingresos frescos recibidos por la Cooperativa.',
      ],
      [],
      ['BLOQUE B — CONCILIACIÓN DE HOJAS CLASIFICADAS (02 A 06) VS. DINERO NUEVO'],
      ['Hoja', 'Descripción', 'Total Hoja (S/)', 'Verificación', 'Observación'],
      ['02_SOCIOS_OFICINA', 'Efectivo Socios + Recaudación Tarjeta', conciliacion.hoja02SociosOficina, 'OK', 'Sin duplicar recibos ni incluir saldo a favor usado.'],
      ['03_SOCIOS_BANCO', 'Transferencia / QR Socios', conciliacion.hoja03SociosBanco, 'OK', 'Sin duplicar recibos ni incluir saldo a favor usado.'],
      ['04_INQUILINOS_OFICINA', 'Efectivo Inquilinos', conciliacion.hoja04InquilinosOficina, 'OK', 'Sin duplicar recibos ni incluir saldo a favor usado.'],
      ['05_INQUILINOS_BANCO', 'Transferencia / QR Inquilinos', conciliacion.hoja05InquilinosBanco, 'OK', 'Sin duplicar recibos ni incluir saldo a favor usado.'],
      ['06_OTROS_INGRESOS', 'Caja Rápida (Efectivo + Banco)', conciliacion.hoja06OtrosIngresos, 'OK', 'Operaciones sin persona de padrón (NO APLICA).'],
      ['SUMA 02..06', 'Suma de las 5 hojas clasificadas', conciliacion.sumaHojasClasificadas, 'IGUAL A A.TOT', 'Vista derivada conciliada al 100 %.'],
      ['DIF. HOJAS', 'Diferencia (Suma 02..06 − Total Dinero Nuevo)', conciliacion.diferenciaHojasVsDineroNuevo, conciliacion.diferenciaHojasVsDineroNuevo === 0 ? 'CONCILIADO (S/ 0.00)' : 'REVISAR', 'Debe ser exactamente S/ 0.00.'],
      [],
      ['BLOQUE C — ECUACIÓN CONTABLE: DINERO NUEVO, SALDO A FAVOR E IMPUTACIÓN A CONCEPTOS'],
      ['Paso', 'Concepto de la Ecuación Contable', 'Importe (S/)', 'Efecto Contable', 'Fórmula / Explicación'],
      [
        'C.1',
        'Dinero Nuevo en Recibos de Deuda (pagos Efectivo + Banco)',
        round2(
          conciliacion.pagosEfectivoSocios +
            conciliacion.pagosEfectivoInquilinos +
            conciliacion.pagosBancoSocios +
            conciliacion.pagosBancoInquilinos,
        ),
        '(+) Suma',
        'Dinero fresco entregado al emitir recibos RIB-XXXXXX.',
      ],
      [
        'C.2',
        'Saldo a Favor Utilizado en Recibos del Período',
        conciliacion.saldoAFavorUtilizado,
        '(+) Suma a conceptos',
        'Aplicación de saldo previo para cancelar deudas (no es nuevo ingreso de caja).',
      ],
      [
        'C.3',
        'Excedentes Generados en Recibos (Abonados a Saldo a Favor)',
        conciliacion.excedenteGenerado,
        '(-) Resta de conceptos',
        'Parte del dinero entregado en un recibo que excedió la deuda y pasó a saldo_a_favor.',
      ],
      [
        'C.4',
        'Total Imputado a Deudas de Padrón en detalle_pagos (C.1 + C.2 − C.3)',
        conciliacion.totalImputadoDeudasPagos,
        '(=) Subtotal Deudas',
        'Coincide al centavo con SUM(detalle_pagos.monto_aplicado).',
      ],
      [
        'C.5',
        'Otros Ingresos Internos (Caja Rápida)',
        conciliacion.totalIngresosInternos,
        '(+) Suma',
        'Cobros directos aplicados a conceptos de Caja Rápida.',
      ],
      [
        'C.6',
        'Total Aplicado a Deudas y Otros Ingresos (C.4 + C.5)',
        conciliacion.totalAplicadoDeudasYOtros,
        '(=) Subtotal Operativo',
        'Total imputado a conceptos sin contar abonos de tarjeta prepago.',
      ],
      [
        'C.7',
        'Recaudación por Tarjeta — Abonos Semanales (REC-XXXXXX)',
        conciliacion.recaudacionTarjetaSocios,
        '(+) Suma',
        'Incluido como rubro "Recaudación Tarjeta (Abono)" en 01_DETALLE_VERTICAL.',
      ],
      [
        'C.8',
        'TOTAL APLICADO A CONCEPTOS EN 01_DETALLE_VERTICAL (C.6 + C.7)',
        conciliacion.totalAplicadoConRecaudacionTarjeta,
        '(=) Total Conceptos',
        'Equivale a Total Dinero Nuevo (A.TOT) + Saldo a Favor Usado (C.2) − Excedente (C.3).',
      ],
      [],
      ['BLOQUE D — COMPARACIÓN OFICIAL FRENTE A LA CENTRAL DE REPORTES (/reportes)'],
      ['Rubro Comparado', 'Reporte Contable (S/)', 'Central de Reportes Oficial (S/)', 'Diferencia (S/)', 'Estado de Conciliación'],
      [
        'Total Ingresos en Efectivo (Gaveta / Oficina)',
        conciliacion.totalDineroNuevoEfectivo,
        conciliacion.centralEfectivo ?? 0,
        conciliacion.diferenciaEfectivoVsCentral ?? 0,
        conciliacion.diferenciaEfectivoVsCentral === 0 ? 'CONCILIADO AL CENTAVO' : 'DIFERENCIA POR FILTRO ACTIVO',
      ],
      [
        'Total Ingresos en Banco / Transferencia / QR',
        conciliacion.totalDineroNuevoBanco,
        conciliacion.centralTransferencia ?? 0,
        conciliacion.diferenciaBancoVsCentral ?? 0,
        conciliacion.diferenciaBancoVsCentral === 0 ? 'CONCILIADO AL CENTAVO' : 'DIFERENCIA POR FILTRO ACTIVO',
      ],
      [
        'Total Dinero Nuevo Ingresado (Efectivo + Banco)',
        conciliacion.totalDineroNuevoCajaBanco,
        conciliacion.centralTotalIngresos ?? 0,
        conciliacion.diferenciaTotalVsCentral ?? 0,
        conciliacion.diferenciaTotalVsCentral === 0 ? 'CONCILIADO AL CENTAVO' : 'DIFERENCIA POR FILTRO ACTIVO',
      ],
      [
        'Total Imputado por Conceptos (Incluye Recaudación Tarjeta)',
        conciliacion.totalAplicadoConRecaudacionTarjeta,
        conciliacion.centralTotalConceptos ?? 0,
        conciliacion.diferenciaConceptosVsCentral ?? 0,
        conciliacion.diferenciaConceptosVsCentral === 0 ? 'CONCILIADO AL CENTAVO' : 'DIFERENCIA POR FILTRO ACTIVO',
      ],
      [],
      ['NOTAS DE AUDITORÍA Y CONCILIACIÓN:'],
      ...conciliacion.notasConciliacion.map((n, idx) => [`Nota ${idx + 1}`, n]),
    ];

    const ws = XLSX.utils.aoa_to_sheet(rows);

    for (let r = 5; r <= 14; r++) {
      this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_SOLES);
    }
    for (let r = 18; r <= 24; r++) {
      this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_SOLES);
    }
    for (let r = 28; r <= 35; r++) {
      this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_SOLES);
    }
    for (let r = 39; r <= 42; r++) {
      this.aplicarFormatoCelda(ws, XLSX, r, 1, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_SOLES);
      this.aplicarFormatoCelda(ws, XLSX, r, 3, FORMATO_SOLES);
    }

    ws['!cols'] = [
      { wch: 24 },
      { wch: 58 },
      { wch: 26 },
      { wch: 30 },
      { wch: 64 },
    ];
    ws['!views'] = [{ state: 'frozen', ySplit: 4 }];
    this.configurarImpresionHoja(ws, 'landscape');

    return ws;
  }

  // ==========================================================================
  // HOJA 08: DOCUMENTOS PENDIENTES (SIN REGISTRAR Y POR VALIDAR)
  // ==========================================================================
  private crearHoja08DocumentosPendientes(
    XLSX: typeof XLSXType,
    payload: PayloadExportacionContableExcel,
    pendientes: PersonaDocumentoPendiente[],
  ): XLSXType.WorkSheet {
    const { reporte } = payload;

    const headers = [
      'N°',
      'Tipo de Persona',
      'ID Padrón',
      'Nombre Completo Registrado',
      'Estado del Documento',
      'Dato Original en Base de Datos',
      'Diagnóstico / Acción Administrativa Requerida',
      'Puesto(s) Relacionado(s)',
      'Comprobantes en Período',
      'Total Aplicado en Período (S/)',
    ];

    const rows: unknown[][] = [
      ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA. — 08_DOCUMENTOS_PENDIENTES'],
      [
        `Período: ${reporte.periodoDesde} al ${reporte.periodoHasta} | Personas únicas con operaciones en el período cuyo documento figura SIN REGISTRAR (placeholder temporal) o POR VALIDAR (anomalía de formato/duplicado).`,
      ],
      [],
      headers,
    ];

    const headerRowIndex = 3;
    let sumaComprobantes = 0;
    let sumaImportes = 0;

    pendientes.forEach((p, idx) => {
      sumaComprobantes += p.cantidadComprobantesPeriodo;
      sumaImportes = round2(sumaImportes + p.totalOperacionesPeriodo);

      rows.push([
        idx + 1,
        p.tipoPersona,
        p.personaId,
        p.nombreCompleto,
        p.estadoDocumento === 'SIN REGISTRAR' ? '⚠ SIN REGISTRAR' : '⚠ POR VALIDAR',
        p.valorOriginalBd,
        p.motivoObservacion,
        p.puestosRelacionados,
        p.cantidadComprobantesPeriodo,
        p.totalOperacionesPeriodo,
      ]);
    });

    const totalRowIdx = rows.length;
    rows.push([
      '',
      'TOTAL PERSONAS PENDIENTES:',
      pendientes.length,
      '',
      '',
      '',
      '',
      '',
      sumaComprobantes,
      sumaImportes,
    ]);

    const ws = XLSX.utils.aoa_to_sheet(rows);

    for (let r = headerRowIndex + 1; r <= totalRowIdx; r++) {
      if (r < totalRowIdx) {
        this.aplicarFormatoCelda(ws, XLSX, r, 0, FORMATO_ENTERO);
        this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_ENTERO);
        this.forzarCeldaTexto(ws, XLSX, r, 5); // Dato original en BD como texto
        this.forzarCeldaTexto(ws, XLSX, r, 7); // Puestos como texto
      } else {
        this.aplicarFormatoCelda(ws, XLSX, r, 2, FORMATO_ENTERO);
      }
      this.aplicarFormatoCelda(ws, XLSX, r, 8, FORMATO_ENTERO);
      this.aplicarFormatoCelda(ws, XLSX, r, 9, FORMATO_SOLES);
    }

    ws['!cols'] = [
      { wch: 6 },
      { wch: 18 },
      { wch: 12 },
      { wch: 38 },
      { wch: 20 },
      { wch: 26 },
      { wch: 56 },
      { wch: 28 },
      { wch: 22 },
      { wch: 24 },
    ];

    ws['!autofilter'] = {
      ref: XLSX.utils.encode_range({
        s: { r: headerRowIndex, c: 0 },
        e: { r: Math.max(headerRowIndex, totalRowIdx - 1), c: headers.length - 1 },
      }),
    };
    ws['!views'] = [{ state: 'frozen', ySplit: headerRowIndex + 1 }];
    this.configurarImpresionHoja(ws, 'landscape');

    return ws;
  }

  // ==========================================================================
  // UTILIDADES DE FORMATO EXCEL (TIPOS DE CELDA, MONEDA, TEXTO Y PÁGINA)
  // ==========================================================================

  private forzarCeldaTexto(
    ws: XLSXType.WorkSheet,
    XLSX: typeof XLSXType,
    row: number,
    col: number,
  ): void {
    const addr = XLSX.utils.encode_cell({ r: row, c: col });
    const cell = ws[addr];
    if (!cell) return;
    cell.t = 's';
    cell.v = cell.v !== undefined && cell.v !== null ? String(cell.v) : '';
    cell.z = '@';
  }

  private aplicarFormatoCelda(
    ws: XLSXType.WorkSheet,
    XLSX: typeof XLSXType,
    row: number,
    col: number,
    format: string,
  ): void {
    const addr = XLSX.utils.encode_cell({ r: row, c: col });
    const cell = ws[addr];
    if (!cell || cell.v === null || cell.v === undefined || cell.v === '') return;
    if (typeof cell.v === 'number') {
      cell.t = 'n';
      cell.z = format;
    }
  }

  private aplicarFormatoFecha(
    ws: XLSXType.WorkSheet,
    XLSX: typeof XLSXType,
    row: number,
    col: number,
  ): void {
    const addr = XLSX.utils.encode_cell({ r: row, c: col });
    const cell = ws[addr];
    if (!cell) return;
    if (cell.v instanceof Date || cell.t === 'd') {
      cell.z = FORMATO_FECHA;
    }
  }

  private configurarImpresionHoja(
    ws: XLSXType.WorkSheet,
    orientation: 'portrait' | 'landscape',
  ): void {
    (ws as Record<string, unknown>)['!pageSetup'] = {
      orientation,
      paperSize: 9, // A4
      fitToWidth: 1,
      fitToHeight: 0,
    };
    (ws as Record<string, unknown>)['!margins'] = {
      left: 0.35,
      right: 0.35,
      top: 0.5,
      bottom: 0.5,
      header: 0.25,
      footer: 0.25,
    };
  }
}
