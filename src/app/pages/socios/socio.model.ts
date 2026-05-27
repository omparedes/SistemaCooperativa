export type EstadoSocio = 'Activo' | 'Inactivo';
export type TipoEspacioPuesto = 'Regular' | 'Pequeño' | 'Almacen';

export interface Socio {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  direccion: string | null;
  telefono: string | null;
  email: string | null;
  fecha_ingreso: string;
  estado: EstadoSocio;
  habilitado: boolean;
  cobro_admin_activo: boolean;
  cobro_prev_social_activo: boolean;
}

export interface PuestoVigente {
  id: number;
  codigo: string;
  estado: string;
  tipo_espacio: TipoEspacioPuesto;
  fecha_inicio_titularidad: string;
}

/**
 * Socio con su Puesto Principal vigente y, de forma separada, sus Almacenes
 * adicionales (depósitos, 2do piso, espacios). La lista nunca mezcla Principal
 * con Almacén en el campo `puesto`.
 */
export interface SocioConPuesto extends Socio {
  puesto: PuestoVigente | null;        // solo tipo_espacio = 'Principal'
  almacenes: PuestoVigente[];          // tipo_espacio = 'Almacen'
  es_institucional: boolean;
}

export interface PuestoConGiro {
  id: number;
  codigo: string;
  estado: string;
  tipo_espacio: TipoEspacioPuesto;
  giro: string | null;
}

export interface TitularidadHistorial {
  id: number;
  fecha_inicio: string;
  fecha_fin: string | null;
  motivo_cambio: string | null;
  puesto: PuestoConGiro;
  vigente: boolean;
}

export interface SocioDetalle extends Socio {
  es_institucional: boolean;
  titularidades: TitularidadHistorial[];
  puesto_vigente: PuestoConGiro | null;          // Principal vigente
  almacenes_vigentes: PuestoConGiro[];           // Almacenes vigentes
}

export const DNI_INSTITUCIONAL = 'COOP-00000';

export interface DeudaPendiente {
  id: number;
  concepto: string;
  periodo_anio: number;
  periodo_mes: number;
  monto: number;
  monto_pagado: number;
  saldo: number;
  origen: string;
}
