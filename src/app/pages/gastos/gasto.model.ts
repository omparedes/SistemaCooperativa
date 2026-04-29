export interface CategoriaGasto {
  id: number;
  nombre: string;
  activo: boolean;
}

export interface Gasto {
  id: number;
  categoria_gasto_id: number;
  fecha: string;
  monto: number;
  descripcion: string | null;
  comprobante_ref: string | null;
  responsable: string | null;
  created_at: string;
  updated_at: string;
  created_by: string | null;
  deleted_at: string | null;
  anulado_por: string | null;
  motivo_anulacion: string | null;
}

export interface GastoInput {
  categoria_gasto_id: number;
  fecha: string;
  monto: number;
  descripcion: string | null;
  comprobante_ref: string | null;
  responsable: string | null;
}

export const gastoInputVacio = (): GastoInput => ({
  categoria_gasto_id: 0,
  fecha: new Date().toISOString().slice(0, 10),
  monto: 0,
  descripcion: null,
  comprobante_ref: null,
  responsable: null,
});
