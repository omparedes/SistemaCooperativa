export interface SocioTarjeta {
  id: number;
  apellidos: string;
  dni: string;
  estado: string;
  saldo_a_favor: number;
  usa_recaudacion_tarjeta: boolean;
  codigo_puesto?: string;
  puesto_id?: number;
}

export interface AbonoItem {
  socio_id: number;
  monto: number;
}

export interface ResultadoRecaudacion {
  insertados: number;
  omitidos: number;
  total_abonado: number;
  fecha: string;
}

export interface AbonoLog {
  id: number;
  socio_id: number;
  nombre_socio: string;
  monto: number;
  fecha: string;
  deleted_at: string | null;
}
