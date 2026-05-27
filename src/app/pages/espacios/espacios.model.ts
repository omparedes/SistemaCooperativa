// ---------------------------------------------------------------------------
// Tipos de dominio — Gestión de Espacios (migración 00043)
// ---------------------------------------------------------------------------

export type TipoEspacio   = 'Regular' | 'Pequeño' | 'Almacen';
export type TipoOcupante  = 'Socio' | 'Inquilino' | 'Tercero';
export type TipoInquilino = 'Inquilino' | 'Tercero';
export type EstadoEspacio = 'Activo' | 'Inactivo';

/** Regular y Pequeño son puestos comerciales del padrón (usan historial_titularidad). */
export function esEspacioPrincipal(tipo: TipoEspacio): boolean {
  return tipo === 'Regular' || tipo === 'Pequeño';
}

// ---------------------------------------------------------------------------
// Interfaces de vistas
// ---------------------------------------------------------------------------

/** Fila de la vista vw_espacios_con_ocupacion (migración 00043). */
export interface EspacioOcupacion {
  puesto_id:            number;
  codigo_puesto:        string;
  tipo_espacio:         TipoEspacio;
  estado:               EstadoEspacio;
  giro_id:              number | null;
  giro_nombre:          string | null;
  area_m2:              number | null;
  tiene_medidor_luz:    boolean;
  tiene_medidor_agua:   boolean;
  cobro_luz_activo:     boolean;
  cobro_agua_activo:    boolean;
  // Titular socio (Regular/Pequeño vía historial_titularidad; Almacén Socio vía oa)
  titular_id:           number | null;
  titular_nombres:      string | null;
  titular_apellidos:    string | null;
  titular_dni:          string | null;
  titular_estado:       string | null;
  titularidad_inicio:   string | null;
  // Arrendatario (Regular/Pequeño vía historial_arriendos; Almacén Inquilino/Tercero vía oa)
  inquilino_id:         number | null;
  inquilino_nombres:    string | null;
  inquilino_apellidos:  string | null;
  tipo_inquilino:       TipoInquilino | null;
  arriendo_inicio:      string | null;
  // Tipo de ocupante unificado (nuevo 00043)
  tipo_ocupante:        TipoOcupante | null;
  // ID de ocupacion_almacen activa (solo para Almacén)
  ocupacion_almacen_id: number | null;
}

/** Espacio Regular/Pequeño con sus Almacenes agrupados por titular. */
export interface EspacioJerarquia {
  principal: EspacioOcupacion;
  almacenes: EspacioOcupacion[];
}

/** Ocupación de un Almacén (tabla ocupaciones_almacenes). */
export interface OcupacionAlmacen {
  id:                number;
  puesto_id:         number;
  codigo_puesto:     string;
  tipo_ocupante:     TipoOcupante;
  socio_id:          number | null;
  socio_nombres:     string | null;
  socio_apellidos:   string | null;
  inquilino_id:      number | null;
  inquilino_nombres:    string | null;
  inquilino_apellidos:  string | null;
  tipo_inquilino:    TipoInquilino | null;
  fecha_inicio:      string;
  fecha_fin:         string | null;
  motivo_cierre:     string | null;
}

// ---------------------------------------------------------------------------
// Helpers de presentación
// ---------------------------------------------------------------------------

export function nombreCompleto(
  nombres: string | null,
  apellidos: string | null,
): string {
  if (!nombres && !apellidos) return '—';
  return [apellidos, nombres].filter(Boolean).join(', ');
}

export function badgeTipoEspacio(tipo: TipoEspacio): { label: string; cls: string } {
  switch (tipo) {
    case 'Regular':  return { label: 'Regular',  cls: 'bg-blue-100 text-blue-800 dark:bg-blue-900/40 dark:text-blue-300' };
    case 'Pequeño':  return { label: 'Pequeño',  cls: 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900/40 dark:text-indigo-300' };
    case 'Almacen':  return { label: 'Almacén',  cls: 'bg-amber-100 text-amber-800 dark:bg-amber-900/40 dark:text-amber-300' };
  }
}

export function badgeTipoOcupante(tipo: TipoOcupante): { label: string; cls: string } {
  switch (tipo) {
    case 'Socio':     return { label: 'Socio',    cls: 'bg-emerald-100 text-emerald-800 dark:bg-emerald-900/40 dark:text-emerald-300' };
    case 'Inquilino': return { label: 'Inquilino', cls: 'bg-purple-100 text-purple-800 dark:bg-purple-900/40 dark:text-purple-300' };
    case 'Tercero':   return { label: 'Tercero',   cls: 'bg-orange-100 text-orange-800 dark:bg-orange-900/40 dark:text-orange-300' };
  }
}

/** @deprecated Use badgeTipoOcupante — kept for backward compat with inquilino fields */
export function badgeTipoInquilino(tipo: TipoInquilino): { label: string; cls: string } {
  return badgeTipoOcupante(tipo as TipoOcupante);
}
