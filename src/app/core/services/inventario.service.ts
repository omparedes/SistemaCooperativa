import { computed, inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos
// ---------------------------------------------------------------------------
export type TipoMovimiento   = 'Entrada' | 'Salida';
export type EstadoProducto   = 'Activo' | 'Inactivo';

export interface InventarioProducto {
  id: number;
  codigo: string;
  nombre: string;
  categoria: string | null;
  unidad_medida: string;
  stock_actual: number;
  stock_minimo: number;
  estado: EstadoProducto;
  created_at: string;
}

export interface InventarioMovimiento {
  id: number;
  producto_id: number;
  tipo_movimiento: TipoMovimiento;
  cantidad: number;
  responsable: string | null;
  observacion: string | null;
  fecha: string;
  created_at: string;
  created_by: string | null;
  producto_nombre: string;  // join
  producto_codigo: string;  // join
}

export interface ProductoInput {
  codigo: string;
  nombre: string;
  categoria: string | null;
  unidad_medida: string;
  stock_actual: number;
  stock_minimo: number;
}

export interface MovimientoInput {
  producto_id: number;
  tipo_movimiento: TipoMovimiento;
  cantidad: number;
  responsable: string | null;
  observacion: string | null;
  fecha: string;
}

export const movimientoInputVacio = (productoId = 0): MovimientoInput => ({
  producto_id:    productoId,
  tipo_movimiento: 'Entrada',
  cantidad:        1,
  responsable:     null,
  observacion:     null,
  fecha:           new Date().toISOString().slice(0, 10),
});

// ---------------------------------------------------------------------------
// Tipos internos
// ---------------------------------------------------------------------------
interface ProductoRawRow {
  id: number;
  codigo: string;
  nombre: string;
  categoria: string | null;
  unidad_medida: string;
  stock_actual: number | string;
  stock_minimo: number | string;
  estado: string;
  created_at: string;
}

interface MovimientoRawRow {
  id: number;
  producto_id: number;
  tipo_movimiento: string;
  cantidad: number;
  responsable: string | null;
  observacion: string | null;
  fecha: string;
  created_at: string;
  created_by: string | null;
  producto: { nombre: string; codigo: string } | null;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class InventarioService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _productos    = signal<InventarioProducto[]>([]);
  private readonly _movimientos  = signal<InventarioMovimiento[]>([]);
  private readonly _loading      = signal(false);
  private readonly _error        = signal<string | null>(null);

  readonly productos   = this._productos.asReadonly();
  readonly movimientos = this._movimientos.asReadonly();
  readonly loading     = this._loading.asReadonly();
  readonly error       = this._error.asReadonly();

  /** Productos con stock_actual <= stock_minimo y estado Activo. */
  readonly alertasStockBajo = computed(() =>
    this._productos().filter(
      p => p.estado === 'Activo' && p.stock_actual <= p.stock_minimo,
    ),
  );

  // ── Carga ─────────────────────────────────────────────────────────────────

  async cargarProductos(): Promise<void> {
    const { data, error } = await this.db
      .from('inventario_productos')
      .select('id, codigo, nombre, categoria, unidad_medida, stock_actual, stock_minimo, estado, created_at')
      .order('nombre');

    if (error) throw new Error(error.message);

    this._productos.set(
      ((data ?? []) as unknown as ProductoRawRow[]).map(r => ({
        id:            r.id,
        codigo:        r.codigo,
        nombre:        r.nombre,
        categoria:     r.categoria,
        unidad_medida: r.unidad_medida,
        stock_actual:  Number(r.stock_actual),
        stock_minimo:  Number(r.stock_minimo),
        estado:        r.estado as EstadoProducto,
        created_at:    r.created_at,
      })),
    );
  }

  async cargarMovimientos(): Promise<void> {
    const { data, error } = await this.db
      .from('inventario_movimientos')
      .select(`
        id, producto_id, tipo_movimiento, cantidad,
        responsable, observacion, fecha, created_at, created_by,
        producto:inventario_productos!producto_id(nombre, codigo)
      `)
      .order('fecha',      { ascending: false })
      .order('created_at', { ascending: false })
      .limit(200);

    if (error) throw new Error(error.message);

    this._movimientos.set(
      ((data ?? []) as unknown as MovimientoRawRow[]).map(r => ({
        id:              r.id,
        producto_id:     r.producto_id,
        tipo_movimiento: r.tipo_movimiento as TipoMovimiento,
        cantidad:        Number(r.cantidad),
        responsable:     r.responsable,
        observacion:     r.observacion,
        fecha:           r.fecha,
        created_at:      r.created_at,
        created_by:      r.created_by,
        producto_nombre: r.producto?.nombre ?? '—',
        producto_codigo: r.producto?.codigo ?? '—',
      })),
    );
  }

  async cargarTodo(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      await Promise.all([this.cargarProductos(), this.cargarMovimientos()]);
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error al cargar el inventario');
    } finally {
      this._loading.set(false);
    }
  }

  // ── Mutaciones ────────────────────────────────────────────────────────────

  async crearProducto(input: ProductoInput): Promise<void> {
    this._error.set(null);
    try {
      const { data: authData } = await this.db.auth.getUser();
      const userId = authData.user?.id ?? null;

      // Insertar con stock_actual = 0. Si hay stock inicial > 0, se registra
      // como movimiento de Entrada para que el historial sea completo.
      const { data: prod, error } = await this.db
        .from('inventario_productos')
        .insert({
          codigo:        input.codigo,
          nombre:        input.nombre,
          categoria:     input.categoria || null,
          unidad_medida: input.unidad_medida,
          stock_actual:  0,
          stock_minimo:  input.stock_minimo,
          created_by:    userId,
        })
        .select('id')
        .single();

      if (error) throw new Error(error.message);

      if (input.stock_actual > 0) {
        await this.crearMovimiento({
          producto_id:     (prod as { id: number }).id,
          tipo_movimiento: 'Entrada',
          cantidad:        input.stock_actual,
          responsable:     'Stock inicial',
          observacion:     null,
          fecha:           new Date().toISOString().slice(0, 10),
        });
        return; // crearMovimiento ya llama a cargarTodo()
      }

      await this.cargarProductos();
    } catch (e: unknown) {
      const msg = e instanceof Error ? e.message : 'Error al crear el producto';
      this._error.set(msg);
      throw e;
    }
  }

  async crearMovimiento(input: MovimientoInput): Promise<void> {
    this._error.set(null);
    try {
      const { data: authData } = await this.db.auth.getUser();
      const userId = authData.user?.id ?? null;

      const { error } = await this.db.from('inventario_movimientos').insert({
        producto_id:     input.producto_id,
        tipo_movimiento: input.tipo_movimiento,
        cantidad:        input.cantidad,
        responsable:     input.responsable  || null,
        observacion:     input.observacion  || null,
        fecha:           input.fecha,
        created_by:      userId,
      });

      if (error) throw new Error(error.message);
      // Recarga ambas listas: stock_actual se actualizó via trigger
      await this.cargarTodo();
    } catch (e: unknown) {
      const msg = e instanceof Error ? e.message : 'Error al registrar el movimiento';
      this._error.set(msg);
      throw e;
    }
  }
}
