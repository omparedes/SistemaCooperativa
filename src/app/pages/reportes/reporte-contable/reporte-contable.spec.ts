import * as XLSX from 'xlsx';
import {
  ComprobanteContableItem,
  FiltroReporteContable,
  ResultadoReporteContable,
  clasificarDocumentoPersona,
} from './reporte-contable.model';
import {
  RUC_INSTITUCIONAL_OFICIAL,
  ReporteContableExcelService,
} from '../../../core/services/reporte-contable-excel.service';

describe('Módulo Reporte Contable — Reglas de Dominio, Conciliación y Excel', () => {
  // ── 1. Clasificación de Documentos (Decisión 1.B y Sección 3) ─────────────
  describe('clasificarDocumentoPersona()', () => {
    it('clasifica como NO APLICA cuando no hay persona relacionada (ingresos_internos)', () => {
      const res = clasificarDocumentoPersona(null, false);
      expect(res.estado).toBe('NO APLICA');
      expect(res.tipoDocumento).toBe('NO APLICA');
      expect(res.numeroMostrar).toBe('NO APLICA');
    });

    it('clasifica códigos institucionales COOP-* y 00000000 como NO APLICA', () => {
      expect(clasificarDocumentoPersona('COOP-00000', true).estado).toBe('NO APLICA');
      expect(clasificarDocumentoPersona('00000000', true).estado).toBe('NO APLICA');
      expect(clasificarDocumentoPersona('COOP-1-D2', true).estado).toBe('NO APLICA');
    });

    it('clasifica placeholders sintéticos (TEMP_*, TEMP-*, SOC-*, INQ-*, DEP-*) como SIN REGISTRAR sin exponerlos como DNI', () => {
      for (const ph of ['TEMP_48291034', 'TEMP-58', 'TEMP-ROSA-QUISPE', 'SOC-001', 'INQ-012', 'DEP-1-D1', '']) {
        const res = clasificarDocumentoPersona(ph, true);
        expect(res.estado).toBe('SIN REGISTRAR');
        expect(res.numeroMostrar).toBe('SIN REGISTRAR');
        expect(res.valorOriginalBd).toBe(ph);
      }
    });

    it('clasifica DNI de 8 dígitos numéricos como REGISTRADO preservando ceros iniciales', () => {
      const res = clasificarDocumentoPersona('08386039', true);
      expect(res.estado).toBe('REGISTRADO');
      expect(res.tipoDocumento).toBe('DNI');
      expect(res.numeroMostrar).toBe('08386039');
    });

    it('clasifica RUC de 11 dígitos válidos (10, 15, 17, 20) como REGISTRADO tipo RUC', () => {
      const res = clasificarDocumentoPersona('10104498146', true);
      expect(res.estado).toBe('REGISTRADO');
      expect(res.tipoDocumento).toBe('RUC');
      expect(res.numeroMostrar).toBe('10104498146');
    });

    it('clasifica documentos con anomalías (-DUP, secuencias repetitivas, longitud atípica) como POR VALIDAR conservando el dato original', () => {
      const dup = clasificarDocumentoPersona('08386039-DUP', true);
      expect(dup.estado).toBe('POR VALIDAR');
      expect(dup.numeroMostrar).toBe('08386039-DUP');
      expect(dup.valorOriginalBd).toBe('08386039-DUP');

      const corto = clasificarDocumentoPersona('123456', true);
      expect(corto.estado).toBe('POR VALIDAR');
      expect(corto.numeroMostrar).toBe('123456');
    });
  });

  // ── 2. Generación de Libro Excel de 9 Hojas y No-Duplicidad (Ajuste 2.1) ──
  describe('ReporteContableExcelService.construirLibroContable()', () => {
    const excelSvc = new ReporteContableExcelService();

    const comprobantesPrueba: ComprobanteContableItem[] = [
      // Caso 1: Recibo multiconcepto (3 líneas) con pago MIXTO (Efectivo + Saldo a favor)
      {
        uid: 'PAG-101',
        fuenteTabla: 'pagos',
        registroId: 101,
        numeroComprobante: 'RIB-20261014-000101',
        referenciaExterna: null,
        fechaIso: '2026-10-14T15:30:00Z',
        fechaLima: '2026-10-14',
        horaLima: '10:30',
        estado: 'VIGENTE',
        motivoAnulacion: null,
        origen: 'SOCIOS',
        tipoPersona: 'SOCIO',
        personaId: 1,
        personaKey: 'socio:1',
        personaRegistradaNombre: 'PEREZ GOMEZ, JUAN',
        documento: clasificarDocumentoPersona('08386039', true),
        titularPuestoNombre: 'PEREZ GOMEZ, JUAN',
        titularPuestoDocumento: '08386039',
        esPersonaDistintaAlTitular: false,
        puestoMostrar: 'A-01',
        esPuestoActualReferencial: false,
        cajero: 'admin',
        metodoPagoBase: 'Efectivo',
        canal: 'MIXTO',
        canalEtiqueta: 'Mixto (Efectivo + Saldo a favor)',
        dineroNuevoCajaBanco: 100,
        dineroNuevoEfectivo: 100,
        dineroNuevoBanco: 0,
        saldoAFavorUtilizado: 30,
        excedenteGenerado: 0,
        totalAplicadoConceptos: 130,
        totalAplicadoDeudasInternos: 130,
        lineas: [
          {
            id: 'DP-1',
            numeroLinea: 1,
            totalLineasComprobante: 3,
            esPrimeraLinea: true,
            concepto: 'Luz',
            periodo: '2026-10',
            puestoLinea: 'A-01',
            esPuestoReferencial: false,
            importeAplicado: 50,
            cargoOriginalDeuda: 50,
            abonadoPrevioDeuda: 0,
            acumuladoTrasAbono: 50,
            saldoRestanteTrasAbono: 0,
            tipoAbonoDeuda: 'Total',
            estadoActualObligacion: 'Pagado',
            etiquetaEstadoDeuda: 'Pago Total (Obligación: Pagado)',
          },
          {
            id: 'DP-2',
            numeroLinea: 2,
            totalLineasComprobante: 3,
            esPrimeraLinea: false,
            concepto: 'Agua',
            periodo: '2026-10',
            puestoLinea: 'A-01',
            esPuestoReferencial: false,
            importeAplicado: 20,
            cargoOriginalDeuda: 20,
            abonadoPrevioDeuda: 0,
            acumuladoTrasAbono: 20,
            saldoRestanteTrasAbono: 0,
            tipoAbonoDeuda: 'Total',
            estadoActualObligacion: 'Pagado',
            etiquetaEstadoDeuda: 'Pago Total (Obligación: Pagado)',
          },
          {
            id: 'DP-3',
            numeroLinea: 3,
            totalLineasComprobante: 3,
            esPrimeraLinea: false,
            concepto: 'Gastos administrativos',
            periodo: '2026-10',
            puestoLinea: 'A-01',
            esPuestoReferencial: false,
            importeAplicado: 60,
            cargoOriginalDeuda: 60,
            abonadoPrevioDeuda: 0,
            acumuladoTrasAbono: 60,
            saldoRestanteTrasAbono: 0,
            tipoAbonoDeuda: 'Total',
            estadoActualObligacion: 'Pagado',
            etiquetaEstadoDeuda: 'Pago Total (Obligación: Pagado)',
          },
        ],
      },
      // Caso 2: Recibo 100 % Saldo a Favor (no debe entrar en hojas 02..05)
      {
        uid: 'PAG-102',
        fuenteTabla: 'pagos',
        registroId: 102,
        numeroComprobante: 'RIB-20261015-000102',
        referenciaExterna: null,
        fechaIso: '2026-10-15T16:00:00Z',
        fechaLima: '2026-10-15',
        horaLima: '11:00',
        estado: 'VIGENTE',
        motivoAnulacion: null,
        origen: 'SOCIOS',
        tipoPersona: 'SOCIO',
        personaId: 2,
        personaKey: 'socio:2',
        personaRegistradaNombre: 'QUISPE MAMANI, ROSA',
        documento: clasificarDocumentoPersona('TEMP-ROSA-QUISPE', true),
        titularPuestoNombre: 'QUISPE MAMANI, ROSA',
        titularPuestoDocumento: 'SIN REGISTRAR',
        esPersonaDistintaAlTitular: false,
        puestoMostrar: 'B-05',
        esPuestoActualReferencial: false,
        cajero: 'admin',
        metodoPagoBase: 'Saldo a favor',
        canal: 'SALDO_FAVOR',
        canalEtiqueta: 'Saldo a favor',
        dineroNuevoCajaBanco: 0,
        dineroNuevoEfectivo: 0,
        dineroNuevoBanco: 0,
        saldoAFavorUtilizado: 60,
        excedenteGenerado: 0,
        totalAplicadoConceptos: 60,
        totalAplicadoDeudasInternos: 60,
        lineas: [
          {
            id: 'DP-4',
            numeroLinea: 1,
            totalLineasComprobante: 1,
            esPrimeraLinea: true,
            concepto: 'Gastos administrativos',
            periodo: '2026-10',
            puestoLinea: 'B-05',
            esPuestoReferencial: false,
            importeAplicado: 60,
            cargoOriginalDeuda: 60,
            abonadoPrevioDeuda: 0,
            acumuladoTrasAbono: 60,
            saldoRestanteTrasAbono: 0,
            tipoAbonoDeuda: 'Total',
            estadoActualObligacion: 'Pagado',
            etiquetaEstadoDeuda: 'Pago Total (Obligación: Pagado)',
          },
        ],
      },
      // Caso 3: Recaudación Tarjeta (Abono) con puesto actual referencial
      {
        uid: 'REC-50',
        fuenteTabla: 'recaudacion_abonos',
        registroId: 50,
        numeroComprobante: 'REC-000050',
        referenciaExterna: 'Abono semanal de tarjeta prepago',
        fechaIso: '2026-10-16T14:00:00Z',
        fechaLima: '2026-10-16',
        horaLima: '09:00',
        estado: 'VIGENTE',
        motivoAnulacion: null,
        origen: 'SOCIOS',
        tipoPersona: 'SOCIO',
        personaId: 1,
        personaKey: 'socio:1',
        personaRegistradaNombre: 'PEREZ GOMEZ, JUAN',
        documento: clasificarDocumentoPersona('08386039', true),
        titularPuestoNombre: 'PEREZ GOMEZ, JUAN',
        titularPuestoDocumento: '08386039',
        esPersonaDistintaAlTitular: false,
        puestoMostrar: 'Puesto(s) actual(es): A-01',
        esPuestoActualReferencial: true,
        cajero: 'admin',
        metodoPagoBase: 'Efectivo',
        canal: 'EFECTIVO',
        canalEtiqueta: 'Efectivo',
        dineroNuevoCajaBanco: 25,
        dineroNuevoEfectivo: 25,
        dineroNuevoBanco: 0,
        saldoAFavorUtilizado: 0,
        excedenteGenerado: 0,
        totalAplicadoConceptos: 25,
        totalAplicadoDeudasInternos: 0,
        lineas: [
          {
            id: 'RECL-50',
            numeroLinea: 1,
            totalLineasComprobante: 1,
            esPrimeraLinea: true,
            concepto: 'Recaudación Tarjeta (Abono)',
            periodo: '2026-10',
            puestoLinea: 'Puesto(s) actual(es): A-01',
            esPuestoReferencial: true,
            importeAplicado: 25,
            cargoOriginalDeuda: null,
            abonadoPrevioDeuda: null,
            acumuladoTrasAbono: null,
            saldoRestanteTrasAbono: null,
            tipoAbonoDeuda: 'Directo',
            estadoActualObligacion: 'Directo',
            etiquetaEstadoDeuda: 'Abono a saldo a favor (Tarjeta)',
          },
        ],
      },
    ];

    const filtroMock: FiltroReporteContable = {
      modoPeriodo: 'mes_anio',
      mes: 10,
      anio: 2026,
      fechaDesde: '2026-10-01',
      fechaHasta: '2026-10-31',
      origen: 'TODOS',
      canal: 'TODOS',
      concepto: '',
      estado: 'VIGENTES',
      documento: 'TODOS',
      busqueda: '',
    };

    const reporteMock: ResultadoReporteContable = {
      periodoDesde: '2026-10-01',
      periodoHasta: '2026-10-31',
      periodoEtiqueta: 'Octubre 2026',
      generadoEn: '2026-11-11 16:00',
      usuarioEmisor: 'admin',
      rolEmisor: 'Administrador',
      universoComprobantes: comprobantesPrueba,
      conceptosDisponibles: ['Luz', 'Agua', 'Gastos administrativos', 'Recaudación Tarjeta (Abono)'],
      resumenCentralOficial: null,
    };

    it('genera las 9 hojas obligatorias y evita duplicar montos de cabecera en 01_DETALLE_VERTICAL', () => {
      const wb = excelSvc.construirLibroContable(XLSX, {
        reporte: reporteMock,
        filtro: filtroMock,
        comprobantesFiltrados: comprobantesPrueba,
        kpis: {
          comprobantesUnicos: 3,
          comprobantesVigentes: 3,
          comprobantesAnulados: 0,
          totalLineasConceptos: 5,
          dineroNuevoTotal: 125,
          dineroNuevoEfectivo: 125,
          dineroNuevoBanco: 0,
          recaudacionTarjetaEfectivo: 25,
          saldoAFavorUtilizado: 90,
          excedenteGenerado: 0,
          totalAplicadoConceptos: 215,
          totalAplicadoDeudasInternos: 190,
          personasSinDocumentoTotal: 1,
          personasSinRegistrarCount: 1,
          personasPorValidarCount: 0,
        },
        conciliacion: {
          pagosEfectivoSocios: 100,
          pagosEfectivoInquilinos: 0,
          recaudacionTarjetaSocios: 25,
          ingresosInternosEfectivo: 0,
          totalDineroNuevoEfectivo: 125,
          pagosBancoSocios: 0,
          pagosBancoInquilinos: 0,
          ingresosInternosBanco: 0,
          totalDineroNuevoBanco: 0,
          totalDineroNuevoCajaBanco: 125,
          hoja02SociosOficina: 125,
          hoja03SociosBanco: 0,
          hoja04InquilinosOficina: 0,
          hoja05InquilinosBanco: 0,
          hoja06OtrosIngresos: 0,
          sumaHojasClasificadas: 125,
          diferenciaHojasVsDineroNuevo: 0,
          saldoAFavorUtilizado: 90,
          excedenteGenerado: 0,
          totalImputadoDeudasPagos: 190,
          totalIngresosInternos: 0,
          totalAplicadoDeudasYOtros: 190,
          totalAplicadoConRecaudacionTarjeta: 215,
          centralEfectivo: 125,
          centralTransferencia: 0,
          centralTotalIngresos: 125,
          centralTotalConceptos: 215,
          diferenciaEfectivoVsCentral: 0,
          diferenciaBancoVsCentral: 0,
          diferenciaTotalVsCentral: 0,
          diferenciaConceptosVsCentral: 0,
          notasConciliacion: ['Conciliado'],
        },
        documentosPendientes: [
          {
            personaKey: 'socio:2',
            tipoPersona: 'SOCIO',
            personaId: 2,
            nombreCompleto: 'QUISPE MAMANI, ROSA',
            estadoDocumento: 'SIN REGISTRAR',
            valorOriginalBd: 'TEMP-ROSA-QUISPE',
            motivoObservacion: 'Placeholder sintético',
            puestosRelacionados: 'B-05',
            cantidadComprobantesPeriodo: 1,
            totalOperacionesPeriodo: 60,
          },
        ],
      });

      expect(wb.SheetNames).toEqual([
        '00_RESUMEN',
        '01_DETALLE_VERTICAL',
        '02_SOCIOS_OFICINA',
        '03_SOCIOS_BANCO',
        '04_INQUILINOS_OFICINA',
        '05_INQUILINOS_BANCO',
        '06_OTROS_INGRESOS',
        '07_CONCILIACION',
        '08_DOCUMENTOS_PENDIENTES',
      ]);

      // Verificar en 01_DETALLE_VERTICAL que las líneas 2 y 3 del recibo multiconcepto tengan null/vacío en Dinero Nuevo (col 17)
      const ws01 = wb.Sheets['01_DETALLE_VERTICAL'];
      const rows01 = XLSX.utils.sheet_to_json<unknown[]>(ws01, { header: 1 });
      // Filas 4, 5, 6 (0-based) corresponden a las 3 líneas de RIB-20261014-000101
      expect(rows01[4][16]).toBe(50);  // Línea 1: Luz S/ 50
      expect(rows01[4][17]).toBe(100); // Línea 1: Dinero Nuevo S/ 100
      expect(rows01[4][18]).toBe(30);  // Línea 1: Saldo a Favor S/ 30

      expect(rows01[5][16]).toBe(20);  // Línea 2: Agua S/ 20
      expect(rows01[5][17]).toBeUndefined(); // Línea 2: Dinero Nuevo NO se repite
      expect(rows01[5][18]).toBeUndefined(); // Línea 2: Saldo a Favor NO se repite

      expect(rows01[6][16]).toBe(60);  // Línea 3: Gastos adm. S/ 60
      expect(rows01[6][17]).toBeUndefined(); // Línea 3: Dinero Nuevo NO se repite

      // Verificar que el DNI con cero inicial ('08386039') esté almacenado como texto ('s')
      const cellDni = ws01[XLSX.utils.encode_cell({ r: 4, c: 8 })];
      expect(cellDni.t).toBe('s');
      expect(cellDni.v).toBe('08386039');

      // Verificar que 00_RESUMEN muestre el RUC institucional real (20109389961) y no un ejemplo
      const ws00 = wb.Sheets['00_RESUMEN'];
      const rows00 = XLSX.utils.sheet_to_json<unknown[]>(ws00, { header: 1 });
      expect(RUC_INSTITUCIONAL_OFICIAL).toBe('20109389961');
      expect(String(rows00[1][0])).toContain('20109389961');
      expect(String(rows00[1][0])).not.toContain('20100000000');
    });

    it('permite exportar DNI completo a roles Administrador y Caja, y bloquea la exportación real a roles no autorizados (Asistente)', () => {
      const payloadBase = {
        reporte: { ...reporteMock, rolEmisor: 'Caja' },
        filtro: filtroMock,
        comprobantesFiltrados: comprobantesPrueba,
        kpis: {
          comprobantesUnicos: 3,
          comprobantesVigentes: 3,
          comprobantesAnulados: 0,
          totalLineasConceptos: 5,
          dineroNuevoTotal: 125,
          dineroNuevoEfectivo: 125,
          dineroNuevoBanco: 0,
          recaudacionTarjetaEfectivo: 25,
          saldoAFavorUtilizado: 90,
          excedenteGenerado: 0,
          totalAplicadoConceptos: 215,
          totalAplicadoDeudasInternos: 190,
          personasSinDocumentoTotal: 1,
          personasSinRegistrarCount: 1,
          personasPorValidarCount: 0,
        },
        conciliacion: {
          pagosEfectivoSocios: 100,
          pagosEfectivoInquilinos: 0,
          recaudacionTarjetaSocios: 25,
          ingresosInternosEfectivo: 0,
          totalDineroNuevoEfectivo: 125,
          pagosBancoSocios: 0,
          pagosBancoInquilinos: 0,
          ingresosInternosBanco: 0,
          totalDineroNuevoBanco: 0,
          totalDineroNuevoCajaBanco: 125,
          hoja02SociosOficina: 125,
          hoja03SociosBanco: 0,
          hoja04InquilinosOficina: 0,
          hoja05InquilinosBanco: 0,
          hoja06OtrosIngresos: 0,
          sumaHojasClasificadas: 125,
          diferenciaHojasVsDineroNuevo: 0,
          saldoAFavorUtilizado: 90,
          excedenteGenerado: 0,
          totalImputadoDeudasPagos: 190,
          totalIngresosInternos: 0,
          totalAplicadoDeudasYOtros: 190,
          totalAplicadoConRecaudacionTarjeta: 215,
          centralEfectivo: 125,
          centralTransferencia: 0,
          centralTotalIngresos: 125,
          centralTotalConceptos: 215,
          diferenciaEfectivoVsCentral: 0,
          diferenciaBancoVsCentral: 0,
          diferenciaTotalVsCentral: 0,
          diferenciaConceptosVsCentral: 0,
          notasConciliacion: ['Conciliado'],
        },
        documentosPendientes: [],
        anonimizarMuestra: false,
      };

      const wbCaja = excelSvc.construirLibroContable(XLSX, payloadBase);
      const ws02 = wbCaja.Sheets['02_SOCIOS_OFICINA'];
      const cellDniCaja = ws02[XLSX.utils.encode_cell({ r: 4, c: 5 })];
      expect(cellDniCaja.t).toBe('s');
      expect(cellDniCaja.v).toBe('08386039');

      expect(() =>
        excelSvc.construirLibroContable(XLSX, {
          ...payloadBase,
          reporte: { ...reporteMock, rolEmisor: 'Asistente' },
          anonimizarMuestra: false,
        }),
      ).toThrowError(/Acceso denegado/);
    });
  });
});
