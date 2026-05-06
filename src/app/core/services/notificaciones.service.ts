import { computed, inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos
// ---------------------------------------------------------------------------
export type TipoNotificacion = 'auditoria' | 'inventario' | 'morosidad' | 'caja';

export interface NotificacionUI {
  id: string;
  titulo: string;
  mensaje: string;
  tipo: TipoNotificacion;
  leido: boolean;
  created_at: string;
  /** true → existe en BD · false → calculada en memoria (no se persiste como leída) */
  persistente: boolean;
}

// Shapes de las respuestas crudas de Supabase
interface NotificacionRow {
  id: string;
  titulo: string;
  mensaje: string;
  tipo: string;
  leido: boolean;
  created_at: string;
}

interface MontoPendienteRow {
  puesto_id: number | null;
  socio_id: number | null;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class NotificacionesService {
  private readonly db = inject(SUPABASE_CLIENT);

  /** Notificaciones persistidas en BD (anulaciones, stock bajo). */
  private readonly _persistentes = signal<NotificacionUI[]>([]);
  /** Alertas calculadas en tiempo real (morosidad, cierre de caja). */
  private readonly _dinamicas    = signal<NotificacionUI[]>([]);

  readonly cargando = signal(false);

  /** Lista unificada: dinámicas primero (más urgentes), luego persistentes. */
  readonly todas = computed<NotificacionUI[]>(() => [
    ...this._dinamicas(),
    ...this._persistentes(),
  ]);

  /** Número de notificaciones no leídas (para el badge de la campana). */
  readonly noLeidas = computed<number>(() =>
    this.todas().filter(n => !n.leido).length
  );

  constructor() {
    void this.cargar();
  }

  // ── Carga completa ──────────────────────────────────────────────────────────

  async cargar(): Promise<void> {
    this.cargando.set(true);
    try {
      await Promise.all([
        this._cargarPersistentes(),
        this._calcularDinamicas(),
      ]);
    } finally {
      this.cargando.set(false);
    }
  }

  // ── Persistentes desde Supabase ─────────────────────────────────────────────

  private async _cargarPersistentes(): Promise<void> {
    const { data, error } = await this.db
      .from('notificaciones')
      .select('id, titulo, mensaje, tipo, leido, created_at')
      .eq('leido', false)
      .order('created_at', { ascending: false })
      .limit(30);

    if (error) {
      console.error('[Notificaciones] Error al cargar:', error.message);
      return;
    }

    this._persistentes.set(
      ((data ?? []) as NotificacionRow[]).map(n => ({
        ...n,
        tipo: n.tipo as TipoNotificacion,
        persistente: true,
      }))
    );
  }

  // ── Alertas dinámicas (sin BD) ───────────────────────────────────────────────

  private async _calcularDinamicas(): Promise<void> {
    const dinamicas: NotificacionUI[] = [];
    const ahora = new Date().toISOString();

    // -- Alerta Morosidad --
    // Cuenta puestos/socios con más de 3 cuotas Pendientes acumuladas.
    try {
      const { data: deudas } = await this.db
        .from('montos_por_cobrar')
        .select('puesto_id, socio_id')
        .eq('estado', 'Pendiente')
        .is('deleted_at', null);

      if (deudas && deudas.length > 0) {
        const rows = deudas as MontoPendienteRow[];
        const countMap = new Map<string, number>();

        for (const d of rows) {
          const key = d.puesto_id != null
            ? `p-${d.puesto_id}`
            : `s-${d.socio_id}`;
          countMap.set(key, (countMap.get(key) ?? 0) + 1);
        }

        const morosos = [...countMap.values()].filter(c => c > 3).length;
        if (morosos > 0) {
          dinamicas.push({
            id: 'dyn-morosidad',
            titulo: 'Morosidad Crítica',
            mensaje: `Hay ${morosos} puesto${morosos > 1 ? 's' : ''} con más de 3 cuotas pendientes acumuladas.`,
            tipo: 'morosidad',
            leido: false,
            created_at: ahora,
            persistente: false,
          });
        }
      }
    } catch {
      // Alerta dinámica opcional — silencioso si falla la consulta
    }

    // -- Alerta Cierre de Caja (a partir de las 18:00 h) --
    if (new Date().getHours() >= 18) {
      dinamicas.push({
        id: 'dyn-cierre-caja',
        titulo: 'Cierre de Día',
        mensaje: 'No olvides revisar el Arqueo de Caja de hoy antes de cerrar.',
        tipo: 'caja',
        leido: false,
        created_at: ahora,
        persistente: false,
      });
    }

    this._dinamicas.set(dinamicas);
  }

  // ── Marcar como leídas ───────────────────────────────────────────────────────

  /**
   * Marca como leídas en BD las notificaciones persistentes no leídas.
   * Las alertas dinámicas se descartan de la vista local (no van a BD).
   */
  async marcarTodasLeidas(): Promise<void> {
    const ids = this._persistentes()
      .filter(n => !n.leido)
      .map(n => n.id);

    if (ids.length > 0) {
      const { error } = await this.db
        .from('notificaciones')
        .update({ leido: true })
        .in('id', ids);

      if (error) {
        console.error('[Notificaciones] Error al marcar como leídas:', error.message);
        return;
      }

      this._persistentes.set(
        this._persistentes().map(n => ({ ...n, leido: true }))
      );
    }

    // Limpiar dinámicas de la vista (se re-calculan en la próxima carga)
    this._dinamicas.set([]);
  }
}
