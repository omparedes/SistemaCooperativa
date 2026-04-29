import { inject, Injectable, signal } from '@angular/core';
import { RealtimeChannel } from '@supabase/supabase-js';
import { SUPABASE_CLIENT } from './supabase.client';
import {
  CategoriaGasto,
  Gasto,
  GastoInput,
} from '../../pages/gastos/gasto.model';

@Injectable({ providedIn: 'root' })
export class GastosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _gastos = signal<Gasto[]>([]);
  private readonly _categorias = signal<CategoriaGasto[]>([]);
  private readonly _loading = signal(false);
  private readonly _error = signal<string | null>(null);

  readonly gastos = this._gastos.asReadonly();
  readonly categorias = this._categorias.asReadonly();
  readonly loading = this._loading.asReadonly();
  readonly error = this._error.asReadonly();

  private channel: RealtimeChannel | null = null;

  async cargarTodo(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      const [gastosRes, catsRes] = await Promise.all([
        this.db.from('gastos')
          .select('id, categoria_gasto_id, fecha, monto, descripcion, comprobante_ref, responsable, created_at, updated_at, created_by, deleted_at, anulado_por, motivo_anulacion')
          .is('deleted_at', null)
          .order('fecha', { ascending: false }),
        this.db.from('categorias_gasto')
          .select('*')
          .eq('activo', true)
          .order('nombre'),
      ]);

      if (gastosRes.error) throw new Error(gastosRes.error.message);
      if (catsRes.error) throw new Error(catsRes.error.message);

      this._gastos.set((gastosRes.data ?? []) as Gasto[]);
      this._categorias.set((catsRes.data ?? []) as CategoriaGasto[]);
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error desconocido al cargar');
    } finally {
      this._loading.set(false);
    }
  }

  async crear(input: GastoInput): Promise<void> {
    this._error.set(null);
    try {
      const { data: { user } } = await this.db.auth.getUser();
      const userId = user?.id ?? null;
      const { error } = await this.db.from('gastos').insert({
        ...input,
        created_by: userId,
      });
      if (error) throw new Error(error.message);
    } catch (e: unknown) {
      const msg = e instanceof Error ? e.message : 'Error al crear el gasto';
      this._error.set(msg);
      throw e;
    }
  }

  async actualizar(id: number, input: GastoInput): Promise<void> {
    this._error.set(null);
    try {
      const { error } = await this.db.from('gastos')
        .update(input)
        .eq('id', id)
        .is('deleted_at', null);
      if (error) throw new Error(error.message);
    } catch (e: unknown) {
      const msg = e instanceof Error ? e.message : 'Error al actualizar el gasto';
      this._error.set(msg);
      throw e;
    }
  }

  async anular(id: number, motivo: string): Promise<void> {
    this._error.set(null);
    try {
      const { data: { user } } = await this.db.auth.getUser();
      const userId = user?.id ?? null;
      const { error } = await this.db.from('gastos')
        .update({
          deleted_at: new Date().toISOString(),
          anulado_por: userId,
          motivo_anulacion: motivo,
        })
        .eq('id', id)
        .is('deleted_at', null);
      if (error) throw new Error(error.message);
    } catch (e: unknown) {
      const msg = e instanceof Error ? e.message : 'Error al anular el gasto';
      this._error.set(msg);
      throw e;
    }
  }

  conectarRealtime(): void {
    if (this.channel) return;

    this.channel = this.db
      .channel('gastos-list-changes')
      .on(
        'postgres_changes',
        { event: 'INSERT', schema: 'public', table: 'gastos' },
        ({ new: row }) => {
          const g = row as Gasto;
          if (g.deleted_at) return;
          this._gastos.update(list =>
            list.some(x => x.id === g.id) ? list : [g, ...list]
          );
        }
      )
      .on(
        'postgres_changes',
        { event: 'UPDATE', schema: 'public', table: 'gastos' },
        ({ new: row }) => {
          const g = row as Gasto;
          this._gastos.update(list => {
            if (g.deleted_at) return list.filter(x => x.id !== g.id);
            const idx = list.findIndex(x => x.id === g.id);
            if (idx === -1) return [g, ...list];
            const copia = list.slice();
            copia[idx] = g;
            return copia;
          });
        }
      )
      .subscribe();
  }

  desconectarRealtime(): void {
    if (!this.channel) return;
    void this.db.removeChannel(this.channel);
    this.channel = null;
  }

  nombreCategoria(id: number): string {
    return this._categorias().find(c => c.id === id)?.nombre ?? '';
  }
}
