export type MetodoPago = 'Efectivo' | 'Transferencia';
export type TipoPagador = 'socio' | 'inquilino';

export interface BusquedaResultado {
  tipo: TipoPagador;
  persona_id: number;
  dni: string;
  nombre_completo: string;
  puesto_id: number | null;
  codigo_puesto: string;
}

export interface DeudaItem {
  monto_id: number;
  concepto: string;
  /** Código del espacio al que pertenece el cargo (null = cargo personal). */
  codigo_puesto?: string | null;
  periodo_anio: number;
  periodo_mes: number;
  monto_original: number;
  ya_pagado: number;
  saldo_pendiente: number;
  fecha_generacion: string;
}

export interface LineaFifo {
  monto_id: number;
  concepto: string;
  codigo_puesto?: string | null;
  periodo_label: string;
  saldo_pendiente: number;
  monto_aplicado: number;
  cubierto_completo: boolean;
}

// ---------------------------------------------------------------------------
// Historial de pagos (para las fichas de socio / inquilino)
// ---------------------------------------------------------------------------
export interface PagoHistorialDetalle {
  monto_aplicado: number;
  concepto: string;
  /** Código del espacio al que pertenece el cargo pagado (para reimpresiones). */
  codigo_puesto?: string | null;
  periodo_anio: number;
  periodo_mes: number;
  monto_original: number;
}

export interface PagoHistorial {
  id: number;
  codigo_transaccion: string;
  fecha_pago: string;
  /** Dinero nuevo ingresado en caja/banco en esta operación (0 si fue 100 % con saldo a favor). */
  monto_total: number;
  /** Suma de importes aplicados a deudas en esta operación. */
  total_aplicado?: number;
  /** Saldo a favor previo consumido en esta operación. */
  saldo_utilizado?: number;
  metodo_pago: MetodoPago;
  comprobante: string | null;
  codigo_puesto: string;
  detalle: PagoHistorialDetalle[];
  anulado: boolean;
  motivo_anulacion: string | null;
  deleted_at: string | null;
}

/**
 * Calcula los importes y etiquetas de presentación de un pago,
 * distinguiendo pagos en efectivo/transferencia, pagos mixtos y
 * aplicaciones 100 % de saldo a favor (`monto_total === 0`).
 */
export function resumirPagoConSaldo(pago: {
  monto_total: number;
  metodo_pago: string;
  detalle?: ReadonlyArray<{ monto_aplicado: number }>;
}): {
  montoCaja: number;
  totalAplicado: number;
  saldoUtilizado: number;
  importeRecibo: number;
  esSoloSaldoFavor: boolean;
  esMixto: boolean;
  etiquetaMetodo: string;
  etiquetaMetodoRecibo: string;
} {
  const r2 = (n: number) => Math.round(n * 100) / 100;
  const montoCaja = r2(Number(pago.monto_total ?? 0));
  const totalAplicado = r2(
    (pago.detalle ?? []).reduce((sum, d) => sum + Number(d.monto_aplicado ?? 0), 0),
  );
  const saldoUtilizado = r2(Math.max(0, totalAplicado - montoCaja));
  const importeRecibo = totalAplicado > 0 ? Math.max(montoCaja, totalAplicado) : montoCaja;
  const esSoloSaldoFavor = montoCaja === 0 && saldoUtilizado > 0;
  const esMixto = montoCaja > 0 && saldoUtilizado > 0;

  let etiquetaMetodo = pago.metodo_pago;
  let etiquetaMetodoRecibo = pago.metodo_pago;

  if (esSoloSaldoFavor) {
    etiquetaMetodo = 'Saldo a favor';
    etiquetaMetodoRecibo = 'Aplicación de saldo a favor';
  } else if (esMixto) {
    etiquetaMetodo = `${pago.metodo_pago} + Saldo a favor`;
    etiquetaMetodoRecibo = `${pago.metodo_pago} (S/ ${montoCaja.toFixed(2)}) + Saldo a favor (S/ ${saldoUtilizado.toFixed(2)})`;
  }

  return {
    montoCaja,
    totalAplicado,
    saldoUtilizado,
    importeRecibo,
    esSoloSaldoFavor,
    esMixto,
    etiquetaMetodo,
    etiquetaMetodoRecibo,
  };
}
