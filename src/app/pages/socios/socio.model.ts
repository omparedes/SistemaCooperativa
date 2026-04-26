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
