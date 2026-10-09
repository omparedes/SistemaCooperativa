import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export type TipoPersona = 'socio' | 'inquilino';

export interface PersonaResumenDeuda {
  tipo:            TipoPersona;
  id:              number;
  nombre:          string;
  dni:             string;
  estado:          string;
  habilitado:      boolean | null;
  saldo_a_favor:   number;
  codigo_puesto:   string | null;
  puesto_id:       number | null;
  deuda_pendiente: number;
  cant_pendientes: number;
}

export interface EstadoCuentaDeudaItem {
  id:               number;
  concepto:         string;
  codigo_puesto:    string | null;
  periodo_anio:     number;
  periodo_mes:      number;
  monto:            number;
  ya_pagado:        number;
  saldo_pendiente:  number;
  estado:           string;
  fecha_generacion: string;
  observacion?:     string;
}

export interface EstadoCuentaPagoItem {
  id:                 number;
  codigo_transaccion: string;
  fecha_pago:         string;
  monto_total:        number;
  metodo_pago:        string;
  comprobante:        string | null;
  anulado:            boolean;
  motivo_anulacion?:  string | null;
  detalle:            Array<{ concepto: string; monto_aplicado: number }>;
}

export interface EstadoCuentaPersonaDetalle {
  persona: PersonaResumenDeuda;
  deudas:  EstadoCuentaDeudaItem[];
  pagos:   EstadoCuentaPagoItem[];
}

@Injectable({ providedIn: 'root' })
export class EstadosCuentaService {
  private readonly db = inject(SUPABASE_CLIENT);

  /**
   * Obtiene el listado consolidado de deudas de socios e inquilinos
   * desde la RPC canónica `rpc_reporte_resumen_deudas`.
   */
  async listarResumenDeudas(): Promise<PersonaResumenDeuda[]> {
    const { data, error } = await this.db.rpc('rpc_reporte_resumen_deudas');
    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PersonaResumenDeuda[]).map(p => ({
      ...p,
      saldo_a_favor:   Number(p.saldo_a_favor ?? 0),
      deuda_pendiente: Number(p.deuda_pendiente ?? 0),
      cant_pendientes: Number(p.cant_pendientes ?? 0),
    }));
  }

  /**
   * Obtiene el detalle financiero de una persona (perfil, cargos canónicos y pagos).
   */
  async obtenerDetalle(tipo: TipoPersona, id: number): Promise<EstadoCuentaPersonaDetalle> {
    const { data, error } = await this.db.rpc('rpc_cc_detalle_persona', {
      p_tipo: tipo,
      p_id:   id,
    });
    if (error) throw new Error(error.message);

    const raw = data as unknown as {
      persona: PersonaResumenDeuda;
      deudas:  unknown[];
      pagos:   unknown[];
    };

    const deudas: EstadoCuentaDeudaItem[] = ((raw.deudas ?? []) as unknown as {
      id: number; concepto: string; codigo_puesto?: string | null;
      periodo_anio: number; periodo_mes: number; monto: number;
      ya_pagado: number; estado: string; fecha_generacion: string; observacion?: string;
    }[]).map(d => {
      const monto = Number(d.monto);
      const ya_pagado = Number(d.ya_pagado ?? 0);
      return {
        ...d,
        codigo_puesto:   d.codigo_puesto ?? null,
        monto,
        ya_pagado,
        saldo_pendiente: Math.round((monto - ya_pagado) * 100) / 100,
      };
    });

    const pagos: EstadoCuentaPagoItem[] = ((raw.pagos ?? []) as unknown as {
      id: number; codigo_transaccion: string; fecha_pago: string; monto_total: number;
      metodo_pago: string; comprobante: string | null; anulado: boolean;
      motivo_anulacion?: string | null;
      detalle: Array<{ concepto: string; monto_aplicado: number }>;
    }[]).map(p => ({
      ...p,
      monto_total: Number(p.monto_total),
      detalle: (p.detalle ?? []).map(dt => ({
        concepto: dt.concepto,
        monto_aplicado: Number(dt.monto_aplicado),
      })),
    }));

    return {
      persona: {
        ...raw.persona,
        saldo_a_favor: Number(raw.persona.saldo_a_favor ?? 0),
        deuda_pendiente: deudas.filter(d => d.saldo_pendiente > 0).reduce((s, d) => s + d.saldo_pendiente, 0),
        cant_pendientes: deudas.filter(d => d.saldo_pendiente > 0).length,
      },
      deudas,
      pagos,
    };
  }
}
