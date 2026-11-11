// ============================================================================
// MODELO DE DATOS Y REGLAS PURAS — MÓDULO REPORTE CONTABLE (/reportes/contable)
// ERP Cooperativa Primero de Mayo
// ============================================================================

export type ModoPeriodoContable = 'mes_anio' | 'personalizado';

export type FiltroOrigenContable = 'TODOS' | 'SOCIOS' | 'INQUILINOS' | 'OTROS';

export type FiltroCanalContable = 'TODOS' | 'EFECTIVO' | 'BANCO' | 'SALDO_FAVOR' | 'MIXTO';

export type FiltroEstadoComprobante = 'VIGENTES' | 'ANULADOS' | 'TODOS';

export type FiltroDocumentoContable = 'TODOS' | 'REGISTRADOS' | 'SIN_REGISTRAR' | 'POR_VALIDAR';

export type EstadoDocumentoContable = 'REGISTRADO' | 'SIN REGISTRAR' | 'POR VALIDAR' | 'NO APLICA';

export type TipoDocumentoContable = 'DNI' | 'RUC' | 'CE' | 'SIN REGISTRAR' | 'POR VALIDAR' | 'NO APLICA';

export type OrigenContable = 'SOCIOS' | 'INQUILINOS' | 'OTROS';

export type CanalContable = 'EFECTIVO' | 'BANCO' | 'SALDO_FAVOR' | 'MIXTO';

export type TipoAbonoDeuda =
  | 'Total'
  | 'Liquidación (Completa saldo)'
  | 'Parcial (A cuenta)'
  | 'Directo';

export type EstadoObligacionActual = 'Pagado' | 'Pendiente' | 'Cancelado' | 'Directo';

export interface FiltroReporteContable {
  modoPeriodo: ModoPeriodoContable;
  mes: number;
  anio: number;
  fechaDesde: string;
  fechaHasta: string;
  origen: FiltroOrigenContable;
  canal: FiltroCanalContable;
  concepto: string;
  estado: FiltroEstadoComprobante;
  documento: FiltroDocumentoContable;
  busqueda: string;
}

export interface ClasificacionDocumento {
  estado: EstadoDocumentoContable;
  tipoDocumento: TipoDocumentoContable;
  /** Texto seguro para mostrar/exportar (nunca expone placeholders TEMP_* como DNI reales) */
  numeroMostrar: string;
  /** Valor crudo almacenado en la base de datos para revisión administrativa */
  valorOriginalBd: string | null;
  /** Detalle diagnóstico sobre la clasificación del documento */
  observacionValidacion: string;
}

export interface LineaConceptoContable {
  id: string;
  numeroLinea: number;
  totalLineasComprobante: number;
  /** True únicamente en la línea 1 del comprobante (evita duplicar montos de cabecera en Excel) */
  esPrimeraLinea: boolean;
  concepto: string;
  periodo: string;
  puestoLinea: string;
  esPuestoReferencial: boolean;
  importeAplicado: number;
  cargoOriginalDeuda: number | null;
  abonadoPrevioDeuda: number | null;
  acumuladoTrasAbono: number | null;
  saldoRestanteTrasAbono: number | null;
  tipoAbonoDeuda: TipoAbonoDeuda;
  estadoActualObligacion: EstadoObligacionActual;
  etiquetaEstadoDeuda: string;
}

export interface ComprobanteContableItem {
  uid: string;
  fuenteTabla: 'pagos' | 'ingresos_internos' | 'recaudacion_abonos';
  registroId: number;
  numeroComprobante: string;
  referenciaExterna: string | null;
  fechaIso: string;
  fechaLima: string;
  horaLima: string;
  estado: 'VIGENTE' | 'ANULADO';
  motivoAnulacion: string | null;
  origen: OrigenContable;
  tipoPersona: 'SOCIO' | 'INQUILINO' | 'OTRO';
  personaId: number | null;
  personaKey: string | null;
  /** Persona registrada contablemente en la operación (Socio o Inquilino en BD) */
  personaRegistradaNombre: string;
  documento: ClasificacionDocumento;
  /** Titular registrado del puesto cuando difiere o aplica */
  titularPuestoNombre: string | null;
  titularPuestoDocumento: string | null;
  esPersonaDistintaAlTitular: boolean;
  puestoMostrar: string;
  esPuestoActualReferencial: boolean;
  cajero: string;
  metodoPagoBase: 'Efectivo' | 'Transferencia' | 'Saldo a favor';
  canal: CanalContable;
  canalEtiqueta: string;
  /** Dinero nuevo real ingresado a caja o banco en este comprobante */
  dineroNuevoCajaBanco: number;
  dineroNuevoEfectivo: number;
  dineroNuevoBanco: number;
  /** Saldo a favor aplicado en este comprobante */
  saldoAFavorUtilizado: number;
  /** Excedente abonado a saldo a favor cuando dineroNuevoCajaBanco > suma(detalle_pagos) */
  excedenteGenerado: number;
  /** Suma de importes aplicados a líneas de conceptos (incluye Recaudación Tarjeta en REC-*) */
  totalAplicadoConceptos: number;
  /** Suma de importes aplicados solo a deudas de padrón e ingresos internos (sin abonos tarjeta) */
  totalAplicadoDeudasInternos: number;
  lineas: LineaConceptoContable[];
}

export interface GrupoDiarioComprobantes {
  fechaLima: string;
  fechaFormateada: string;
  cantidadComprobantes: number;
  cantidadVigentes: number;
  cantidadAnulados: number;
  subtotalDineroNuevo: number;
  subtotalEfectivo: number;
  subtotalBanco: number;
  subtotalSaldoAFavorUtilizado: number;
  subtotalExcedenteGenerado: number;
  subtotalAplicadoConceptos: number;
  comprobantes: ComprobanteContableItem[];
}

export interface KpisReporteContable {
  comprobantesUnicos: number;
  comprobantesVigentes: number;
  comprobantesAnulados: number;
  totalLineasConceptos: number;

  dineroNuevoTotal: number;
  dineroNuevoEfectivo: number;
  dineroNuevoBanco: number;
  recaudacionTarjetaEfectivo: number;

  saldoAFavorUtilizado: number;
  excedenteGenerado: number;

  totalAplicadoConceptos: number;
  totalAplicadoDeudasInternos: number;

  personasSinDocumentoTotal: number;
  personasSinRegistrarCount: number;
  personasPorValidarCount: number;
}

export interface PersonaDocumentoPendiente {
  personaKey: string;
  tipoPersona: 'SOCIO' | 'INQUILINO';
  personaId: number;
  nombreCompleto: string;
  estadoDocumento: 'SIN REGISTRAR' | 'POR VALIDAR';
  valorOriginalBd: string;
  motivoObservacion: string;
  puestosRelacionados: string;
  cantidadComprobantesPeriodo: number;
  totalOperacionesPeriodo: number;
}

export interface FilaMatrizConcepto {
  uid: string;
  fechaLima: string;
  horaLima: string;
  numeroComprobante: string;
  estado: 'VIGENTE' | 'ANULADO';
  origen: OrigenContable;
  personaRegistradaNombre: string;
  tipoDocumento: TipoDocumentoContable;
  numeroDocumento: string;
  estadoDocumento: EstadoDocumentoContable;
  titularPuestoNombre: string;
  puestoMostrar: string;
  periodosResumen: string;
  canalEtiqueta: string;
  cajero: string;
  montosPorConcepto: Record<string, number>;
  totalAplicadoConceptos: number;
  saldoAFavorUtilizado: number;
  excedenteGenerado: number;
  dineroNuevoCajaBanco: number;
  dineroNuevoEfectivo: number;
  dineroNuevoBanco: number;
}

export interface ConciliacionReporteContable {
  // 1. Fuentes de Dinero Nuevo (Reporte Contable)
  pagosEfectivoSocios: number;
  pagosEfectivoInquilinos: number;
  recaudacionTarjetaSocios: number;
  ingresosInternosEfectivo: number;
  totalDineroNuevoEfectivo: number;

  pagosBancoSocios: number;
  pagosBancoInquilinos: number;
  ingresosInternosBanco: number;
  totalDineroNuevoBanco: number;

  totalDineroNuevoCajaBanco: number;

  // 2. Conciliación por Hojas Clasificadas (02 a 06)
  hoja02SociosOficina: number;
  hoja03SociosBanco: number;
  hoja04InquilinosOficina: number;
  hoja05InquilinosBanco: number;
  hoja06OtrosIngresos: number;
  sumaHojasClasificadas: number;
  diferenciaHojasVsDineroNuevo: number;

  // 3. Ecuación Maestra de Imputación a Conceptos
  saldoAFavorUtilizado: number;
  excedenteGenerado: number;
  totalImputadoDeudasPagos: number;
  totalIngresosInternos: number;
  totalAplicadoDeudasYOtros: number;
  totalAplicadoConRecaudacionTarjeta: number;

  // 4. Comparación contra Central de Reportes (rpc_reporte_resumen)
  centralEfectivo: number | null;
  centralTransferencia: number | null;
  centralTotalIngresos: number | null;
  centralTotalConceptos: number | null;
  diferenciaEfectivoVsCentral: number | null;
  diferenciaBancoVsCentral: number | null;
  diferenciaTotalVsCentral: number | null;
  diferenciaConceptosVsCentral: number | null;
  notasConciliacion: string[];
}

export interface ResultadoReporteContable {
  periodoDesde: string;
  periodoHasta: string;
  periodoEtiqueta: string;
  generadoEn: string;
  usuarioEmisor: string;
  rolEmisor: string;
  universoComprobantes: ComprobanteContableItem[];
  conceptosDisponibles: string[];
  resumenCentralOficial: {
    efectivo: number;
    transferencia: number;
    ingresosInternos: number;
    recaudacionTarjeta: number;
    totalConceptos: number;
    countRecibos: number;
    countInternos: number;
    countRecaudacion: number;
    countAnulados: number;
  } | null;
}

// ============================================================================
// FUNCIONES PURAS DE CLASIFICACIÓN DE DOCUMENTOS (SECCIÓN 3 Y DECISIÓN 1.B)
// ============================================================================

/**
 * Clasifica el documento de identidad de forma determinista según la relación real
 * en base de datos, sin asignar nunca por coincidencia de nombres y sin exponer
 * placeholders sintéticos (TEMP_*, SOC-*, INQ-*, DEP-*) como DNI reales.
 */
export function clasificarDocumentoPersona(
  rawDni: string | null | undefined,
  tienePersonaRelacionada: boolean,
): ClasificacionDocumento {
  if (!tienePersonaRelacionada) {
    return {
      estado: 'NO APLICA',
      tipoDocumento: 'NO APLICA',
      numeroMostrar: 'NO APLICA',
      valorOriginalBd: null,
      observacionValidacion: 'Operación institucional o de Caja Rápida sin persona de padrón vinculada.',
    };
  }

  const limpio = (rawDni ?? '').trim();

  // Caso 1: Vacío o nulo
  if (!limpio) {
    return {
      estado: 'SIN REGISTRAR',
      tipoDocumento: 'SIN REGISTRAR',
      numeroMostrar: 'SIN REGISTRAR',
      valorOriginalBd: '',
      observacionValidacion: 'Campo de documento vacío en padrón.',
    };
  }

  // Caso 2: Registro institucional de la propia Cooperativa
  if (/^(COOP[-_]|0{8}$)/i.test(limpio)) {
    return {
      estado: 'NO APLICA',
      tipoDocumento: 'NO APLICA',
      numeroMostrar: 'NO APLICA',
      valorOriginalBd: limpio,
      observacionValidacion: `Código institucional de la Cooperativa (${limpio}).`,
    };
  }

  // Caso 3: Placeholders sintéticos generados por formularios o migraciones
  if (/^(TEMP[-_]|SOC-|INQ-|DEP-|S\/D|SIN[-_\s]|PEND)/i.test(limpio)) {
    return {
      estado: 'SIN REGISTRAR',
      tipoDocumento: 'SIN REGISTRAR',
      numeroMostrar: 'SIN REGISTRAR',
      valorOriginalBd: limpio,
      observacionValidacion: `Placeholder sintético de sistema (${limpio}). Requiere registrar DNI real.`,
    };
  }

  // Caso 4: Sufijo explícito de duplicado u observación (-DUP, etc.)
  if (/dup/i.test(limpio)) {
    return {
      estado: 'POR VALIDAR',
      tipoDocumento: 'POR VALIDAR',
      numeroMostrar: limpio,
      valorOriginalBd: limpio,
      observacionValidacion: `Marcado con sufijo de duplicidad (${limpio}). Requiere validación administrativa.`,
    };
  }

  // Caso 5: DNI estándar de 8 dígitos numéricos
  if (/^\d{8}$/.test(limpio)) {
    // Verificar que no sean 8 dígitos todos iguales (ej. 11111111, 99999999)
    if (/^(\d)\1{7}$/.test(limpio)) {
      return {
        estado: 'POR VALIDAR',
        tipoDocumento: 'POR VALIDAR',
        numeroMostrar: limpio,
        valorOriginalBd: limpio,
        observacionValidacion: `Secuencia numérica repetitiva (${limpio}). Verificar documento físico.`,
      };
    }
    return {
      estado: 'REGISTRADO',
      tipoDocumento: 'DNI',
      numeroMostrar: limpio,
      valorOriginalBd: limpio,
      observacionValidacion: 'Formato DNI de 8 dígitos registrado en padrón.',
    };
  }

  // Caso 6: RUC estándar de 11 dígitos numéricos (prefijos oficiales SUNAT 10, 15, 17, 20)
  if (/^(10|15|17|20)\d{9}$/.test(limpio)) {
    return {
      estado: 'REGISTRADO',
      tipoDocumento: 'RUC',
      numeroMostrar: limpio,
      valorOriginalBd: limpio,
      observacionValidacion: 'Formato RUC de 11 dígitos registrado en padrón.',
    };
  }

  // Caso 7: Carnet de Extranjería de 9 dígitos numéricos
  if (/^\d{9}$/.test(limpio)) {
    return {
      estado: 'REGISTRADO',
      tipoDocumento: 'CE',
      numeroMostrar: limpio,
      valorOriginalBd: limpio,
      observacionValidacion: 'Formato CE de 9 dígitos registrado en padrón.',
    };
  }

  // Caso 8: Cualquier otro valor existente con longitud/formato atípico -> POR VALIDAR conservando dato original
  return {
    estado: 'POR VALIDAR',
    tipoDocumento: 'POR VALIDAR',
    numeroMostrar: limpio,
    valorOriginalBd: limpio,
    observacionValidacion: `Formato o longitud atípica (${limpio.length} caracteres: "${limpio}"). Conservar y validar.`,
  };
}

/**
 * Redondeo financiero a 2 decimales evitando imprecisiones IEEE 754.
 */
export function round2(val: number): number {
  return Math.round((Number(val) + Number.EPSILON) * 100) / 100;
}
