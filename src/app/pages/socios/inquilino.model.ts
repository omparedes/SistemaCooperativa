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

export interface AlmacenOcupado {
  id: number;
  ocupacion_id: number;
  codigo: string;
  estado: string;
  fecha_inicio: string;
  costo_alquiler: number | null;
}

export interface InquilinoConPuesto extends Inquilino {
  puesto: PuestoArrendado | null;
  titular: TitularReferencia | null;
  almacenes?: AlmacenOcupado[];
}

export interface ArriendoHistorial {
  id: number;
  fecha_inicio: string;
  fecha_fin: string | null;
  monto_arriendo: number | null;
  motivo_termino: string | null;
  puesto: {
    id: number;
    codigo: string;
    estado: string;
    giro: string | null;
  };
  titular: TitularReferencia | null;
  vigente: boolean;
}

export interface InquilinoDetalle extends Inquilino {
  arriendos: ArriendoHistorial[];
  arriendo_vigente: ArriendoHistorial | null;
  almacenes_vigentes?: AlmacenOcupado[];
}
