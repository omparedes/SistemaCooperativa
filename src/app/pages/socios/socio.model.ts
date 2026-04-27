export type EstadoSocio = 'Activo' | 'Inactivo';

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
}

export interface PuestoVigente {
  id: number;
  codigo: string;
  estado: string;
  fecha_inicio_titularidad: string;
}

export interface SocioConPuesto extends Socio {
  puesto: PuestoVigente | null;
  es_institucional: boolean;
}

export interface PuestoConGiro {
  id: number;
  codigo: string;
  estado: string;
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
  puesto_vigente: PuestoConGiro | null;
}

export const DNI_INSTITUCIONAL = 'COOP-00000';
