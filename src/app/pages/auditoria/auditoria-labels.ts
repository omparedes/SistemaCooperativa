/**
 * Diccionario de presentación del módulo de Auditoría.
 * Traduce nombres técnicos (tablas, columnas, valores) a etiquetas humanas.
 * Vive en el frontend a propósito: cambiar un rótulo no debe requerir migración.
 */

export const TABLA_LABELS: Record<string, string> = {
  socios:                   'Socio',
  inquilinos:               'Inquilino',
  puestos:                  'Puesto / Espacio',
  pagos:                    'Pago',
  ocupaciones_almacenes:    'Almacén',
  gastos:                   'Gasto',
  caja_ajustes:             'Ajuste de Caja',
  distribuciones_mensuales: 'Distribución Mensual',
};

export const COLUMN_LABELS: Record<string, string> = {
  // Identidad
  nombres:           'Nombres',
  apellidos:         'Apellidos',
  dni:               'DNI',
  telefono:          'Teléfono',
  email:             'Correo electrónico',
  direccion:         'Dirección',
  fecha_ingreso:     'Fecha de ingreso',
  estado:            'Estado',
  habilitado:        'Habilitado',
  tipo_inquilino:    'Tipo de inquilino',
  // Puestos / espacios
  codigo_puesto:     'Código de puesto',
  tipo_espacio:      'Tipo de espacio',
  area_m2:           'Área (m²)',
  giro_id:           'Giro comercial',
  tiene_medidor_luz: 'Tiene medidor de luz',
  tiene_medidor_agua:'Tiene medidor de agua',
  cobro_luz_activo:  'Cobro de luz activo',
  cobro_agua_activo: 'Cobro de agua activo',
  cobro_admin_activo:'Cobro administrativo activo',
  cobro_prev_social_activo: 'Cobro de previsión social activo',
  costo_alquiler:    'Costo de alquiler',
  // Pagos
  monto_total:       'Monto total',
  metodo_pago:       'Método de pago',
  comprobante:       'Comprobante',
  fecha_pago:        'Fecha de pago',
  observacion:       'Observación',
  codigo_transaccion:'Código de recibo',
  saldo_a_favor:     'Saldo a favor',
  // Ocupaciones de almacén
  fecha_inicio:      'Fecha de inicio',
  fecha_fin:         'Fecha de fin',
  tipo_ocupante:     'Tipo de ocupante',
  motivo_cierre:     'Motivo de cierre',
  socio_id:          'Socio',
  inquilino_id:      'Inquilino',
  puesto_id:         'Puesto',
  // Gastos / caja
  monto:             'Monto',
  descripcion:       'Descripción',
  comprobante_ref:   'Comprobante',
  responsable:       'Responsable',
  fecha:             'Fecha',
  tipo:              'Tipo',
  categoria_gasto_id:'Categoría',
  // Soft delete
  deleted_at:        'Estado del registro',
  anulado_por:       'Anulado por',
  motivo_anulacion:  'Motivo de anulación',
};

export const ACCION_LABELS: Record<string, string> = {
  CREACION:    'Creación',
  EDICION:     'Edición',
  ANULACION:   'Anulación',
  RETIRO:      'Retiro',
  ELIMINACION: 'Eliminación',
};

/** Campos cuyo delta no aporta a un lector de negocio (se ocultan de la lista). */
const CAMPOS_OCULTOS = new Set(['anulado_por']);

export function etiquetaTabla(tabla: string): string {
  return TABLA_LABELS[tabla] ?? tabla;
}

export function etiquetaCampo(campo: string): string {
  return COLUMN_LABELS[campo] ?? campo.replace(/_/g, ' ').replace(/^\w/, c => c.toUpperCase());
}

export function esCampoVisible(campo: string): boolean {
  return !CAMPOS_OCULTOS.has(campo);
}

/** Formatea un valor crudo del delta según el campo. */
export function formatearValor(campo: string, valor: string | null): string {
  if (valor === null || valor === '') return '—';

  // deleted_at: el timestamp es ruido — lo que importa es el estado
  if (campo === 'deleted_at') return 'Anulado';

  // Booleanos
  if (valor === 'true')  return 'Sí';
  if (valor === 'false') return 'No';

  // Montos
  if (/^(monto|costo|saldo)/.test(campo) && !isNaN(Number(valor))) {
    return `S/ ${Number(valor).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
  }

  // Timestamps ISO → fecha/hora local corta
  if (/^\d{4}-\d{2}-\d{2}T\d{2}:/.test(valor)) {
    const d = new Date(valor);
    return d.toLocaleString('es-PE', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' });
  }

  return valor;
}

/** Caso especial: deleted_at null → Activo (el "antes" de una anulación). */
export function formatearAntes(campo: string, valor: string | null): string {
  if (campo === 'deleted_at' && (valor === null || valor === '')) return 'Activo';
  return formatearValor(campo, valor);
}
