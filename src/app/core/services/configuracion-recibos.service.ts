import { inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export type FormatoImpresion = 'A4' | 'TICKET_80MM';

export interface ConfiguracionRecibos {
  id: 1;
  nombre_institucion: string;
  subtitulo: string;
  mensaje_pie: string;
  color_principal: string;
  formato_impresion: FormatoImpresion;
}

const DEFAULTS: ConfiguracionRecibos = {
  id: 1,
  nombre_institucion: 'COOPERATIVA DE COMERCIANTES PRIMERO DE MAYO',
  subtitulo: 'Mercado Municipal — Sistema de Recaudación',
  mensaje_pie: 'Gracias por su puntualidad.',
  color_principal: '#166534',
  formato_impresion: 'A4',
};

interface ConfiguracionRecibosRow {
  id: number;
  nombre_institucion: string;
  subtitulo: string;
  mensaje_pie: string;
  color_principal: string;
  formato_impresion: string;
}

@Injectable({ providedIn: 'root' })
export class ConfiguracionRecibosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _config = signal<ConfiguracionRecibos>({ ...DEFAULTS });
  /** Signal de solo lectura expuesto para componentes (reactivo en tiempo real). */
  readonly config = this._config.asReadonly();

  private _cargado = false;

  /** Carga desde BD (idempotente: si ya cargó devuelve el valor en memoria). */
  async cargar(): Promise<ConfiguracionRecibos> {
    if (this._cargado) return this._config();

    const { data, error } = await this.db
      .from('configuracion_recibos')
      .select('id, nombre_institucion, subtitulo, mensaje_pie, color_principal, formato_impresion')
      .eq('id', 1)
      .single();

    if (!error && data) {
      const row = data as ConfiguracionRecibosRow;
      this._config.set({
        id: 1,
        nombre_institucion: row.nombre_institucion,
        subtitulo:          row.subtitulo,
        mensaje_pie:        row.mensaje_pie,
        color_principal:    row.color_principal,
        formato_impresion:  row.formato_impresion as FormatoImpresion,
      });
      this._cargado = true;
    }

    return this._config();
  }

  /**
   * Guarda cambios en BD y actualiza el signal local.
   * Solo Administrador puede llamar este método (RLS lo refuerza en BD).
   */
  async actualizar(cambios: Partial<Omit<ConfiguracionRecibos, 'id'>>): Promise<void> {
    const { error } = await this.db
      .from('configuracion_recibos')
      .update(cambios)
      .eq('id', 1);

    if (error) throw new Error(error.message);

    this._config.set({ ...this._config(), ...cambios });
  }

  /** Invalida la caché para forzar recarga en la próxima llamada a cargar(). */
  invalidarCache(): void {
    this._cargado = false;
  }
}
