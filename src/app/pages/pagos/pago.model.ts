export type MetodoPago = 'Efectivo' | 'Transferencia';
export type TipoPagador = 'socio' | 'inquilino';

export interface BusquedaResultado {
  tipo: TipoPagador;
  persona_id: number;
  dni: string;
  nombre_completo: string;
  puesto_id: number;
  codigo_puesto: string;
}

export interface DeudaItem {
  monto_id: number;
  concepto: string;
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
  periodo_anio: number;
  periodo_mes: number;
  monto_original: number;
}

export interface PagoHistorial {
  id: number;
  codigo_transaccion: string;
  fecha_pago: string;
  monto_total: number;
  metodo_pago: MetodoPago;
  comprobante: string | null;
  codigo_puesto: string;
  detalle: PagoHistorialDetalle[];
  anulado: boolean;
  motivo_anulacion: string | null;
  deleted_at: string | null;
}
