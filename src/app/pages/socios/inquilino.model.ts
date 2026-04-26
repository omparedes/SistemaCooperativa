export interface Inquilino {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  direccion: string | null;
  telefono: string | null;
  email: string | null;
}

export interface PuestoArrendado {
  id: number;
  codigo: string;
  estado: string;
  fecha_inicio_arriendo: string;
  monto_arriendo: number | null;
}

export interface TitularReferencia {
  id: number;
  apellidos: string;
  dni: string;
}

export interface InquilinoConPuesto extends Inquilino {
  puesto: PuestoArrendado | null;
  titular: TitularReferencia | null;
}
