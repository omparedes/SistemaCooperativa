import { inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import { InquilinoConPuesto } from '../../pages/socios/inquilino.model';

interface InquilinoRow {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  direccion: string | null;
  telefono: string | null;
  email: string | null;
  arriendo_vigente: Array<{
    fecha_inicio: string;
    fecha_fin: string | null;
    monto_arriendo: number | null;
    puesto: {
      id: number;
      codigo_puesto: string;
      estado: string;
    } | null;
    titular: {
      id: number;
      apellidos: string;
      dni: string;
    } | null;
  }>;
}

@Injectable({ providedIn: 'root' })
export class InquilinosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _inquilinos = signal<InquilinoConPuesto[]>([]);
  private readonly _loading = signal(false);
  private readonly _error = signal<string | null>(null);

  readonly inquilinos = this._inquilinos.asReadonly();
  readonly loading = this._loading.asReadonly();
  readonly error = this._error.asReadonly();

  private async garantizarSesion(): Promise<void> {
    const { data: actual } = await this.db.auth.getUser();
    if (actual.user) return;
    const { error } = await this.db.auth.signInAnonymously();
    if (error) throw new Error(`No se pudo iniciar sesión: ${error.message}`);
  }

  async cargar(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      await this.garantizarSesion();

      const { data, error } = await this.db
        .from('inquilinos')
        .select(`
          id, dni, nombres, apellidos, direccion, telefono, email,
          arriendo_vigente:historial_arriendos (
            fecha_inicio, fecha_fin, monto_arriendo,
            puesto:puestos ( id, codigo_puesto, estado ),
            titular:socios!socio_titular_id ( id, apellidos, dni )
          )
        `)
        .is('deleted_at', null)
        .is('arriendo_vigente.fecha_fin', null)
        .order('apellidos', { ascending: true });

      if (error) throw new Error(error.message);

      const filas = (data ?? []) as unknown as InquilinoRow[];
      this._inquilinos.set(filas.map(f => this.mapear(f)));
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error al cargar inquilinos');
    } finally {
      this._loading.set(false);
    }
  }

  private mapear(row: InquilinoRow): InquilinoConPuesto {
    const arriendo = row.arriendo_vigente[0] ?? null;
    const puesto = arriendo?.puesto ?? null;
    const titular = arriendo?.titular ?? null;
    return {
      id: row.id,
      dni: row.dni,
      nombres: row.nombres,
      apellidos: row.apellidos,
      direccion: row.direccion,
      telefono: row.telefono,
      email: row.email,
      puesto: puesto && arriendo
        ? {
            id: puesto.id,
            codigo: puesto.codigo_puesto,
            estado: puesto.estado,
            fecha_inicio_arriendo: arriendo.fecha_inicio,
            monto_arriendo: arriendo.monto_arriendo,
          }
        : null,
      titular: titular
        ? { id: titular.id, apellidos: titular.apellidos, dni: titular.dni }
        : null,
    };
  }
}
