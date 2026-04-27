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
