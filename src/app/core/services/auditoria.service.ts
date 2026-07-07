import { computed, inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export type AccionTimeline = 'CREACION' | 'EDICION' | 'ANULACION' | 'RETIRO' | 'ELIMINACION';

export interface CambioCampo {
  campo: string;
  antes: string | null;
  despues: string | null;
}

export interface EventoAuditoria {
  id: string;
  fecha: string;
  tabla: string;
  registro_id: string;
  accion: AccionTimeline;
  actor: { nombre: string; rol: string };
  entidad: string;
  resumen: { monto: number | null; metodo: string | null; conceptos: string[] } | null;
  cambios: CambioCampo[];
  motivo: string | null;
}

export interface FiltrosAuditoria {
  tabla: string | null;
  accion: AccionTimeline | null;
  busqueda: string | null;
}

const PAGE_SIZE = 50;

/**
 * Auditoría narrativa: consume `rpc_auditoria_timeline` (00086), que resuelve
 * server-side actor+rol, entidad legible, deltas y motivo. Keyset pagination.
 */
@Injectable({ providedIn: 'root' })
export class AuditoriaService {
  private readonly db = inject(SUPABASE_CLIENT);

  readonly eventos  = signal<EventoAuditoria[]>([]);
  readonly cargando = signal(false);
  readonly error    = signal<string | null>(null);
  /** true si la última página vino completa (probablemente hay más). */
  readonly hayMas   = signal(false);

  readonly total = computed(() => this.eventos().length);

  /** Recarga desde el evento más reciente con los filtros dados. */
  async cargar(filtros: FiltrosAuditoria): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    try {
      const pagina = await this.pedirPagina(filtros, null);
      this.eventos.set(pagina);
      this.hayMas.set(pagina.length === PAGE_SIZE);
    } catch (e) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar la auditoría.');
    } finally {
      this.cargando.set(false);
    }
  }

  /** Página siguiente (eventos más antiguos que el último cargado). */
  async cargarMas(filtros: FiltrosAuditoria): Promise<void> {
    const actuales = this.eventos();
    const ultimo = actuales[actuales.length - 1];
    if (!ultimo || this.cargando()) return;

    this.cargando.set(true);
    this.error.set(null);
    try {
      const pagina = await this.pedirPagina(filtros, ultimo.fecha);
      this.eventos.set([...actuales, ...pagina]);
      this.hayMas.set(pagina.length === PAGE_SIZE);
    } catch (e) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar más eventos.');
    } finally {
      this.cargando.set(false);
    }
  }

  private async pedirPagina(
    filtros: FiltrosAuditoria,
    before: string | null,
  ): Promise<EventoAuditoria[]> {
    const { data, error } = await this.db.rpc('rpc_auditoria_timeline', {
      p_limit:    PAGE_SIZE,
      p_before:   before,
      p_tabla:    filtros.tabla,
      p_accion:   filtros.accion,
      p_busqueda: filtros.busqueda?.trim() || null,
    });
    if (error) throw new Error(error.message);
    return (data ?? []) as unknown as EventoAuditoria[];
  }
}
