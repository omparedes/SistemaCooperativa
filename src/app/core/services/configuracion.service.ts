import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export interface Configuracion {
  clave: string;
  valor: number;
  descripcion: string;
  updated_at: string | null;
}

@Injectable({ providedIn: 'root' })
export class ConfiguracionService {
  private readonly db = inject(SUPABASE_CLIENT);

  async getAll(): Promise<Configuracion[]> {
    const { data, error } = await this.db
      .from('configuraciones')
      .select('clave, valor, descripcion, updated_at')
      .order('clave');
    if (error) throw new Error(error.message);
    return (data ?? []) as Configuracion[];
  }

  async getValor(clave: string): Promise<number> {
    const { data, error } = await this.db
      .from('configuraciones')
      .select('valor')
      .eq('clave', clave)
      .single();
    if (error) throw new Error(error.message);
    return Number((data as { valor: number }).valor);
  }

  async updateValores(cambios: Array<{ clave: string; valor: number }>): Promise<void> {
    for (const c of cambios) {
      const { error } = await this.db
        .from('configuraciones')
        .update({ valor: c.valor })
        .eq('clave', c.clave);
      if (error) throw new Error(`Error al actualizar ${c.clave}: ${error.message}`);
    }
  }
}
