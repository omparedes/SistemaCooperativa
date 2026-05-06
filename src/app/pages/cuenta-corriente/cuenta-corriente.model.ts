export type TipoPersona = 'socio' | 'inquilino';

export interface PersonaResumen {
  tipo: TipoPersona;
  id: number;
  nombre: string;
  dni: string;
  estado?: string;
  habilitado?: boolean;
  saldo_a_favor: number;
  codigo_puesto?: string;
  puesto_id?: number;
  deuda_pendiente: number;
}

export interface DeudaItem {
  id: number;
  concepto: string;
  periodo_anio: number;
  periodo_mes: number;
  monto: number;
  ya_pagado: number;
  saldo_pendiente: number;
  estado: string;
  fecha_generacion: string;
  observacion?: string;
}

export interface PagoResumen {
  id: number;
  codigo_transaccion: string;
  fecha_pago: string;
  monto_total: number;
  metodo_pago: string;
  comprobante?: string;
  anulado: boolean;
  motivo_anulacion?: string;
  detalle: { concepto: string; monto_aplicado: number }[];
}

export interface PersonaDetalle {
  persona: PersonaResumen;
  deudas: DeudaItem[];
  pagos: PagoResumen[];
}

export interface NuevoCargoForm {
  concepto_id: number | null;
  periodo_anio: number;
  periodo_mes: number;
  monto: number;
  observacion: string;
}

export interface NuevoAbonoForm {
  monto_deuda_id: number | null;
  monto: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  comprobante: string;
  observacion: string;
  fecha_pago: string;  // ISO date string YYYY-MM-DD
}

export interface EditarPagoForm {
  comprobante: string;
  fecha_pago: string;  // ISO date string YYYY-MM-DD
}

export const MESES_NOMBRES = [
  '', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
  'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
];
