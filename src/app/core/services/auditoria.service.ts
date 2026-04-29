import { computed, inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export type AccionAudit = 'INSERT' | 'UPDATE' | 'DELETE';

export interface AuditLog {
  id: string;
  table_name: string;
  record_id: string;
  action: AccionAudit;
  old_data: Record<string, unknown> | null;
  new_data: Record<string, unknown> | null;
  changed_by: string | null;
  created_at: string;
}

@Injectable({ providedIn: 'root' })
export class AuditoriaService {
  private readonly db = inject(SUPABASE_CLIENT);

  readonly logs     = signal<AuditLog[]>([]);
  readonly cargando = signal(false);
  readonly error    = signal<string | null>(null);

  readonly total = computed(() => this.logs().length);

  async cargar(limite = 100): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);

    try {
      const { data, error } = await this.db
        .from('audit_logs')
        .select('id, table_name, record_id, action, old_data, new_data, changed_by, created_at')
        .order('created_at', { ascending: false })
        .limit(limite);

      if (error) throw new Error(error.message);
      this.logs.set((data as unknown as AuditLog[]) ?? []);
    } catch (e) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el log de auditoría.');
    } finally {
      this.cargando.set(false);
    }
  }
}
