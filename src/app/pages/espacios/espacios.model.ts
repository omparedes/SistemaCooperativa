export type TipoEspacio    = 'Principal' | 'Almacen';
export type TipoInquilino  = 'Inquilino' | 'Tercero';
export type EstadoEspacio  = 'Activo' | 'Inactivo';

/** Fila de la vista vw_espacios_con_ocupacion. */
export interface EspacioOcupacion {
  puesto_id:         number;
  codigo_puesto:     string;
  tipo_espacio:      TipoEspacio;
  estado:            EstadoEspacio;
  giro_id:           number | null;
  giro_nombre:       string | null;
  area_m2:           number | null;
  tiene_medidor_luz: boolean;
  tiene_medidor_agua: boolean;
  cobro_luz_activo:  boolean;
  cobro_agua_activo: boolean;
  // Titular socio
  titular_id:        number | null;
  titular_nombres:   string | null;
  titular_apellidos: string | null;
  titular_dni:       string | null;
  titular_estado:    string | null;
  titularidad_inicio: string | null;
  // Arrendatario (Inquilino o Tercero)
  inquilino_id:      number | null;
  inquilino_nombres: string | null;
  inquilino_apellidos: string | null;
  tipo_inquilino:    TipoInquilino | null;
  arriendo_inicio:   string | null;
}

/** Espacio Principal con sus Almacenes relacionados agrupados. */
export interface EspacioJerarquia {
  principal: EspacioOcupacion;
  almacenes: EspacioOcupacion[];
}

/** Nombre completo del titular o inquilino para mostrar en tabla. */
export function nombreCompleto(
  nombres: string | null,
  apellidos: string | null,
): string {
  if (!nombres && !apellidos) return '—';
  return [nombres, apellidos].filter(Boolean).join(' ');
}

/** Badge label + CSS class para tipo_espacio. */
export function badgeTipoEspacio(tipo: TipoEspacio): { label: string; cls: string } {
  return tipo === 'Principal'
    ? { label: 'Principal', cls: 'bg-blue-100 text-blue-800 dark:bg-blue-900/40 dark:text-blue-300' }
    : { label: 'Almacén',   cls: 'bg-amber-100 text-amber-800 dark:bg-amber-900/40 dark:text-amber-300' };
}

/** Badge label + CSS class para tipo_inquilino. */
export function badgeTipoInquilino(tipo: TipoInquilino): { label: string; cls: string } {
  return tipo === 'Inquilino'
    ? { label: 'Inquilino', cls: 'bg-purple-100 text-purple-800 dark:bg-purple-900/40 dark:text-purple-300' }
    : { label: 'Tercero',   cls: 'bg-orange-100 text-orange-800 dark:bg-orange-900/40 dark:text-orange-300' };
}
