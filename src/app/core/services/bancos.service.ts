import { inject, Injectable, signal } from '@angular/core';
import { RealtimeChannel } from '@supabase/supabase-js';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos
// ---------------------------------------------------------------------------
export type TipoMovimiento = 'Ingreso' | 'Egreso';
export type Moneda = 'PEN' | 'USD';

export interface BancoCuenta {
  id: number;
  nombre_banco: string;
  numero_cuenta: string;
  moneda: Moneda;
  saldo_actual: number;
  activo: boolean;
}

export interface MovimientoBancario {
  id: number;
  cuenta_id: number;
  fecha_operacion: string;   // YYYY-MM-DD
  tipo: TipoMovimiento;
  monto: number;
  motivo_detalle: string | null;
  nro_operacion: string | null;
  created_at: string;
  created_by: string | null;
  nombre_banco: string;       // join de bancos_cuentas
  numero_cuenta: string;      // join de bancos_cuentas
}

export interface MovimientoInput {
  cuenta_id: number;
  fecha_operacion: string;
  tipo: TipoMovimiento;
  monto: number;
  motivo_detalle: string | null;
  nro_operacion: string | null;
}

export const movimientoInputVacio = (): MovimientoInput => ({
  cuenta_id:       0,
  fecha_operacion: new Date().toISOString().slice(0, 10),
  tipo:            'Ingreso',
  monto:           0,
  motivo_detalle:  null,
  nro_operacion:   null,
});

// ---------------------------------------------------------------------------
// Tipos internos (raw Supabase rows)
// ---------------------------------------------------------------------------
interface MovimientoRawRow {
  id: number;
  cuenta_id: number;
  fecha_operacion: string;
  tipo: string;
  monto: number;
  motivo_detalle: string | null;
  nro_operacion: string | null;
  created_at: string;
  created_by: string | null;
  cuenta: { nombre_banco: string; numero_cuenta: string } | null;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class BancosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _cuentas     = signal<BancoCuenta[]>([]);
  private readonly _movimientos = signal<MovimientoBancario[]>([]);
  private readonly _loading     = signal(false);
  private readonly _error       = signal<string | null>(null);

  readonly cuentas     = this._cuentas.asReadonly();
  readonly movimientos = this._movimientos.asReadonly();
  readonly loading     = this._loading.asReadonly();
  readonly error       = this._error.asReadonly();

  private channel: RealtimeChannel | null = null;

  // ── Carga de datos ────────────────────────────────────────────────────────

  async cargarCuentas(): Promise<void> {
    const { data, error } = await this.db
      .from('bancos_cuentas')
      .select('id, nombre_banco, numero_cuenta, moneda, saldo_actual, activo')
      .eq('activo', true)
      .order('nombre_banco');

    if (error) throw new Error(error.message);
    this._cuentas.set((data ?? []) as BancoCuenta[]);
  }

  async cargarMovimientos(): Promise<void> {
    const { data, error } = await this.db
      .from('movimientos_bancarios')
      .select(`
        id, cuenta_id, fecha_operacion, tipo, monto,
        motivo_detalle, nro_operacion, created_at, created_by,
        cuenta:bancos_cuentas!cuenta_id(nombre_banco, numero_cuenta)
      `)
      .is('deleted_at', null)
      .order('fecha_operacion', { ascending: false })
      .order('created_at',      { ascending: false })
      .limit(300);

    if (error) throw new Error(error.message);

    this._movimientos.set(
      ((data ?? []) as unknown as MovimientoRawRow[]).map(r => ({
        id:              r.id,
        cuenta_id:       r.cuenta_id,
        fecha_operacion: r.fecha_operacion,
        tipo:            r.tipo as TipoMovimiento,
        monto:           Number(r.monto),
        motivo_detalle:  r.motivo_detalle,
        nro_operacion:   r.nro_operacion,
        created_at:      r.created_at,
        created_by:      r.created_by,
        nombre_banco:    r.cuenta?.nombre_banco    ?? '—',
        numero_cuenta:   r.cuenta?.numero_cuenta   ?? '—',
      })),
    );
  }

  async cargarTodo(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      await Promise.all([this.cargarCuentas(), this.cargarMovimientos()]);
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error al cargar movimientos bancarios');
    } finally {
      this._loading.set(false);
    }
  }

  // ── Mutaciones ────────────────────────────────────────────────────────────

  async crearMovimiento(input: MovimientoInput): Promise<void> {
    this._error.set(null);
    try {
      const { data: authData } = await this.db.auth.getUser();
      const userId = authData.user?.id ?? null;

      const { error } = await this.db.from('movimientos_bancarios').insert({
        cuenta_id:       input.cuenta_id,
        fecha_operacion: input.fecha_operacion,
        tipo:            input.tipo,
        monto:           input.monto,
        motivo_detalle:  input.motivo_detalle || null,
        nro_operacion:   input.nro_operacion  || null,
        created_by:      userId,
      });

      if (error) throw new Error(error.message);
      // Recarga cuentas para reflejar el nuevo saldo calculado por el trigger
      await this.cargarTodo();
    } catch (e: unknown) {
      const msg = e instanceof Error ? e.message : 'Error al registrar el movimiento';
      this._error.set(msg);
      throw e;
    }
  }

  // ── Realtime (saldo en vivo) ──────────────────────────────────────────────

  conectarRealtime(): void {
    if (this.channel) return;

    this.channel = this.db
      .channel('bancos-live')
      // INSERT: nuevo movimiento → recargar todo para reflejar saldo actualizado
      .on(
        'postgres_changes',
        { event: 'INSERT', schema: 'public', table: 'movimientos_bancarios' },
        () => void this.cargarTodo(),
      )
      // UPDATE: anulación de movimiento → recargar (saldo revertido por trigger)
      .on(
        'postgres_changes',
        { event: 'UPDATE', schema: 'public', table: 'movimientos_bancarios' },
        () => void this.cargarTodo(),
      )
      // UPDATE en cuentas: recibe saldo_actual actualizado por el trigger
      .on(
        'postgres_changes',
        { event: 'UPDATE', schema: 'public', table: 'bancos_cuentas' },
        ({ new: row }) => {
          const id     = typeof row['id']           === 'number' ? row['id']           : Number(row['id']);
          const saldo  = typeof row['saldo_actual'] === 'number' ? row['saldo_actual'] : Number(row['saldo_actual']);
          this._cuentas.update(list =>
            list.map(c => c.id === id ? { ...c, saldo_actual: saldo } : c),
          );
        },
      )
      .subscribe();
  }

  desconectarRealtime(): void {
    if (!this.channel) return;
    void this.db.removeChannel(this.channel);
    this.channel = null;
  }
}
