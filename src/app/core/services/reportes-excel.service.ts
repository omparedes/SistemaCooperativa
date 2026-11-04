import { Injectable } from '@angular/core';

export interface ReporteExcelExportDatos {
  institucion: string;
  ruc?: string;
  titulo?: string;
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

  // Desglose por concepto
  conceptos?: {
    concepto: string;
    cantidad: number;
    monto: number;
    montoSocios: number;
    montoInquilinos: number;
    montoOtros: number;
    porcentaje: number;
  }[];

  // Desglose por categoría de egreso
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
}

@Injectable({ providedIn: 'root' })
export class ReportesExcelService {
  async exportarLibroFinanciero(datos: ReporteExcelExportDatos, nombreArchivo?: string): Promise<void> {
    const XLSX = await import('xlsx');
    const wb = XLSX.utils.book_new();

    const formatearMoneda = (cell: Record<string, unknown> | undefined) => {
      if (!cell || typeof cell['v'] !== 'number') return;
      cell['t'] = 'n';
      cell['z'] = '"S/ "#,##0.00';
    };

    const formatearEntero = (cell: Record<string, unknown> | undefined) => {
      if (!cell || typeof cell['v'] !== 'number') return;
      cell['t'] = 'n';
      cell['z'] = '#,##0';
    };

    const formatearPorcentaje = (cell: Record<string, unknown> | undefined) => {
      if (!cell || typeof cell['v'] !== 'number') return;
      cell['t'] = 'n';
      cell['z'] = '0.0%';
    };

    const autoAjustarCols = (ws: Record<string, unknown>, minCols = 10) => {
      const ref = ws['!ref'] as string | undefined;
      if (!ref) return;
      const range = XLSX.utils.decode_range(ref);
      const cols: { wch: number }[] = [];
      for (let C = range.s.c; C <= range.e.c; ++C) {
        let maxLen = 0;
        for (let R = range.s.r; R <= range.e.r; ++R) {
          const cellRef = XLSX.utils.encode_cell({ c: C, r: R });
          const cell = ws[cellRef] as { v?: unknown } | undefined;
          if (cell && cell.v !== undefined && cell.v !== null) {
            const str = String(cell.v);
            if (str.length > maxLen) maxLen = str.length;
          }
        }
        cols.push({ wch: Math.min(Math.max(maxLen + 3, minCols), 50) });
      }
      ws['!cols'] = cols;
    };

    // ═════════════════════════════════════════════════════════════════════════
    // HOJA 1: RESUMEN FINANCIERO
    // ═════════════════════════════════════════════════════════════════════════
    const rc = datos.resumenCaja;
    const aoaResumen: (string | number)[][] = [
      ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.'],
      ['RUC: 20100000000 | CENTRAL DE REPORTES — RESUMEN FINANCIERO'],
      [''],
      ['PARÁMETROS DEL REPORTE'],
      ['Período Consultado:', `${datos.periodoEtiqueta} (${datos.periodoDesde} al ${datos.periodoHasta})`],
      ['Filtro Concepto:', datos.filtroConcepto || 'Todos los conceptos'],
      ['Filtro Categoría Gasto:', datos.filtroCategoria || 'Todas las categorías'],
      ['Origen de Fondos:', datos.filtroTipoPagador === 'todos' ? 'Todos (Socios, Inquilinos, Otros)' : datos.filtroTipoPagador],
      ['Método de Pago:', datos.filtroMetodoPago === 'todos' ? 'Todos los métodos' : datos.filtroMetodoPago],
      ['Fecha de Generación:', datos.generadoEn],
      ['Usuario Emisor:', datos.usuario || 'Administración'],
      [''],
      ['CONTROL OPERATIVO DE CAJA', 'MONTO (S/)', 'OBSERVACIONES'],
      ['Total Recaudación de Caja (Efectivo + Transferencia)', rc.totalIngresos, 'Ingresos netos operativos de caja'],
      ['• Recaudación en Efectivo', rc.efectivo, 'Fondos físicos en caja'],
      ['• Recaudación por Transferencia / QR', rc.transferencia, 'Abonos directos bancarios verificados'],
      ['• Ingresos Internos (Caja Rápida)', rc.ingresosInternos, 'Servicios higiénicos, parqueo, etc.'],
      ['• Recaudación Tarjeta Prepago', rc.recaudacionTarjeta, 'Recargas y consumos asociados'],
      ['Total Egresos Operativos Ejecutados', rc.egresos, 'Gastos de administración, obras y servicios'],
      ['Saldo Neto Operativo de Caja', rc.saldoNeto, 'Superávit / Déficit del período'],
      [''],
      ['CONTROL DE COMPROBANTES', 'CANTIDAD', 'ESTADO'],
      ['Recibos Válidos Emitidos', rc.countRecibos, 'Contabilizados'],
      ['Operaciones Caja Rápida', rc.countInternos, 'Contabilizados'],
      ['Recibos Anulados (Excluidos)', rc.countAnulados, 'Excluidos formalmente (S/ 0.00)'],
    ];

    if (datos.conceptos && datos.conceptos.length > 0) {
      aoaResumen.push(['']);
      aoaResumen.push(['DESGLOSE POR CONCEPTO DE RECAUDACIÓN']);
      aoaResumen.push(['Concepto', 'N° Cobros', 'Monto Total (S/)', 'Socios (S/)', 'Inquilinos (S/)', 'Otros (S/)', '% Participación']);
      for (const c of datos.conceptos) {
        aoaResumen.push([
          c.concepto,
          c.cantidad,
          c.monto,
          c.montoSocios,
          c.montoInquilinos,
          c.montoOtros,
          c.porcentaje / 100,
        ]);
      }
    }

    if (datos.categoriasEgreso && datos.categoriasEgreso.length > 0) {
      aoaResumen.push(['']);
      aoaResumen.push(['DESGLOSE POR CATEGORÍA DE GASTO']);
      aoaResumen.push(['Categoría de Gasto', 'N° Operaciones', 'Monto Ejecutado (S/)', '% Egresos']);
      for (const e of datos.categoriasEgreso) {
        aoaResumen.push([
          e.categoria,
          e.cantidad,
          e.monto,
          e.porcentaje / 100,
        ]);
      }
    }

    const wsResumen = XLSX.utils.aoa_to_sheet(aoaResumen);

    // Formatear celdas numéricas de Caja
    for (let r = 14; r <= 20; r++) {
      formatearMoneda(wsResumen[`B${r}`] as Record<string, unknown>);
    }
    formatearEntero(wsResumen['B23'] as Record<string, unknown>);
    formatearEntero(wsResumen['B24'] as Record<string, unknown>);
    formatearEntero(wsResumen['B25'] as Record<string, unknown>);

    autoAjustarCols(wsResumen as unknown as Record<string, unknown>, 12);
    XLSX.utils.book_append_sheet(wb, wsResumen, 'Resumen Financiero');

    // ═════════════════════════════════════════════════════════════════════════
    // HOJA 2: DETALLE DE MOVIMIENTOS
    // ═════════════════════════════════════════════════════════════════════════
    const aoaDetalle: (string | number)[][] = [
      ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.'],
      ['DETALLE COMPLETO DE OPERACIONES REGISTRADAS'],
      ['Período:', `${datos.periodoEtiqueta} (${datos.periodoDesde} al ${datos.periodoHasta})`],
      ['Filtro Concepto:', datos.filtroConcepto || 'Todos los conceptos'],
      ['Filtro Categoría:', datos.filtroCategoria || 'Todas las categorías'],
      [''],
    ];

    if (datos.movimientosIngreso && datos.movimientosIngreso.length > 0) {
      aoaDetalle.push(['MOVIMIENTOS DE INGRESO Y RECAUDACIÓN']);
      aoaDetalle.push(['Fecha / Hora', 'N° Comprobante', 'Concepto', 'Pagador', 'Tipo Pagador', 'Puesto', 'Período', 'Método de Pago', 'Monto (S/)', 'Cajero']);
      for (const m of datos.movimientosIngreso) {
        aoaDetalle.push([
          m.fecha ? m.fecha.replace('T', ' ').slice(0, 19) : '',
          m.recibo,
          m.concepto,
          m.pagador,
          m.tipoPagador,
          m.puesto || '-',
          m.periodo || '-',
          m.metodoPago,
          m.monto,
          m.cajero || '-',
        ]);
      }
    }

    if (datos.movimientosEgreso && datos.movimientosEgreso.length > 0) {
      aoaDetalle.push(['']);
      aoaDetalle.push(['MOVIMIENTOS DE EGRESO Y GASTOS']);
      aoaDetalle.push(['Fecha', 'Categoría de Gasto', 'N° Comprobante Ref.', 'Responsable / Proveedor', 'Descripción / Glosa', 'Monto (S/)']);
      for (const g of datos.movimientosEgreso) {
        aoaDetalle.push([
          g.fecha,
          g.categoria,
          g.comprobante || '-',
          g.responsable || '-',
          g.descripcion || '-',
          g.monto,
        ]);
      }
    }

    const wsDetalle = XLSX.utils.aoa_to_sheet(aoaDetalle);

    if (datos.movimientosIngreso && datos.movimientosIngreso.length > 0) {
      for (let i = 0; i < datos.movimientosIngreso.length; i++) {
        const rowIdx = 9 + i;
        formatearMoneda(wsDetalle[`I${rowIdx}`] as Record<string, unknown>);
      }
    }

    autoAjustarCols(wsDetalle as unknown as Record<string, unknown>, 12);
    XLSX.utils.book_append_sheet(wb, wsDetalle, 'Detalle de Movimientos');

    // ═════════════════════════════════════════════════════════════════════════
    // HOJA 3: EVOLUCIÓN TEMPORAL
    // ═════════════════════════════════════════════════════════════════════════
    if (datos.evolucionTemporal) {
      const evo = datos.evolucionTemporal;
      const diasSemana = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];

      const aoaEvo: (string | number)[][] = [
        ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.'],
        [`EVOLUCIÓN TEMPORAL DIARIA: ${evo.conceptoNombre.toUpperCase()}`],
        ['Período:', `${datos.periodoEtiqueta} (${datos.periodoDesde} al ${datos.periodoHasta})`],
        ['Total Recaudado:', evo.total],
        ['Promedio Diario (Días Calendario):', evo.promedioDiario],
        ['Día Pico (Máxima Recaudación):', `${evo.diaPico.fecha} (S/ ${evo.diaPico.monto.toFixed(2)})`],
        ['Día Mínimo (con cobro):', `${evo.diaMinimo.fecha} (S/ ${evo.diaMinimo.monto.toFixed(2)})`],
        ['Días con Actividad:', `${evo.diasConCobro} de ${evo.diasTotales} días`],
        ['Días en S/ 0.00:', `${evo.diasCero} días`],
        [''],
        ['Fecha', 'Día', 'Día Semana', 'N° Cobros', 'Recaudación (S/)', 'Clasificación'],
      ];

      for (const d of evo.serie) {
        const dt = new Date(d.fecha + 'T12:00:00');
        const nomDia = diasSemana[dt.getDay()];
        let clasif = 'Normal';
        if (d.monto === evo.diaPico.monto && d.monto > 0) clasif = '★ DÍA PICO';
        else if (d.monto === evo.diaMinimo.monto && d.monto > 0) clasif = '▼ DÍA MÍNIMO';
        else if (d.monto === 0) clasif = 'Sin recaudación (S/ 0.00)';

        aoaEvo.push([
          d.fecha,
          d.dia,
          nomDia,
          d.cantidad,
          d.monto,
          clasif,
        ]);
      }

      const wsEvo = XLSX.utils.aoa_to_sheet(aoaEvo);
      formatearMoneda(wsEvo['B4'] as Record<string, unknown>);
      formatearMoneda(wsEvo['B5'] as Record<string, unknown>);

      for (let i = 0; i < evo.serie.length; i++) {
        const rowIdx = 12 + i;
        formatearEntero(wsEvo[`D${rowIdx}`] as Record<string, unknown>);
        formatearMoneda(wsEvo[`E${rowIdx}`] as Record<string, unknown>);
      }

      autoAjustarCols(wsEvo as unknown as Record<string, unknown>, 12);
      XLSX.utils.book_append_sheet(wb, wsEvo, 'Evolución Temporal');
    }

    // ═════════════════════════════════════════════════════════════════════════
    // HOJA 4: COMPARACIÓN DE PERÍODOS
    // ═════════════════════════════════════════════════════════════════════════
    if (datos.comparacion) {
      const comp = datos.comparacion;
      const aoaComp: (string | number)[][] = [
        ['COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.'],
        ['ANÁLISIS COMPARATIVO DE PERÍODOS'],
        ['Período Actual:', `${datos.periodoEtiqueta} (${datos.periodoDesde} al ${datos.periodoHasta})`],
        ['Período Anterior:', `${comp.periodoAnteriorEtiqueta} (${comp.periodoAnteriorDesde} al ${comp.periodoAnteriorHasta})`],
        ['Estado Período Actual:', comp.esIncompleto ? 'En curso / Incompleto (preliminar)' : 'Cerrado / Completo'],
        [''],
        ['Rubro Financiero / Métrica', 'Período Actual (S/)', 'Período Anterior (S/)', 'Variación Nominal (Δ S/)', 'Variación Porcentual (Δ %)', 'Diagnóstico'],
        [
          'Total Recaudación de Ingresos',
          comp.ingresos.actual,
          comp.ingresos.anterior,
          comp.ingresos.diferencia,
          comp.ingresos.porcentaje / 100,
          comp.ingresos.diferencia >= 0 ? 'Favorable (Crecimiento)' : 'Desfavorable (Contracción)',
        ],
        [
          'Total Egresos Operativos Ejecutados',
          comp.egresos.actual,
          comp.egresos.anterior,
          comp.egresos.diferencia,
          comp.egresos.porcentaje / 100,
          comp.egresos.diferencia <= 0 ? 'Favorable (Ahorro)' : 'Incremento de gasto',
        ],
        [
          'Saldo Neto Operativo de Caja',
          comp.saldoNeto.actual,
          comp.saldoNeto.anterior,
          comp.saldoNeto.diferencia,
          comp.saldoNeto.porcentaje / 100,
          comp.saldoNeto.diferencia >= 0 ? 'Favorable (Mayor superávit)' : 'Menor margen operativo',
        ],
      ];

      const wsComp = XLSX.utils.aoa_to_sheet(aoaComp);

      for (let r = 8; r <= 10; r++) {
        formatearMoneda(wsComp[`B${r}`] as Record<string, unknown>);
        formatearMoneda(wsComp[`C${r}`] as Record<string, unknown>);
        formatearMoneda(wsComp[`D${r}`] as Record<string, unknown>);
        formatearPorcentaje(wsComp[`E${r}`] as Record<string, unknown>);
      }

      autoAjustarCols(wsComp as unknown as Record<string, unknown>, 15);
      XLSX.utils.book_append_sheet(wb, wsComp, 'Comparación de Períodos');
    }

    const sufijo = datos.filtroConcepto ? `_${datos.filtroConcepto.replace(/[^a-zA-Z0-9]/g, '_')}` : '';
    const filename = nombreArchivo ?? `reporte_financiero_${datos.periodoDesde}_a_${datos.periodoHasta}${sufijo}.xlsx`;
    XLSX.writeFile(wb, filename.endsWith('.xlsx') ? filename : `${filename}.xlsx`);
  }
}
