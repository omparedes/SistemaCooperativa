import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from '../../core/services/supabase.client';
import { AuthService } from '../../core/services/auth.service';
import {
  EditarPagoForm,
  ModificarCargoForm,
  NuevoAbonoForm,
  NuevoCargoForm,
  PersonaDetalle,
  PersonaResumen,
  TipoPersona,
} from './cuenta-corriente.model';

@Injectable({ providedIn: 'root' })
export class CuentaCorrienteService {
  private readonly db   = inject(SUPABASE_CLIENT);
  private readonly auth = inject(AuthService);

  // ── Listado ──────────────────────────────────────────────────────────────
  async listarPersonas(): Promise<PersonaResumen[]> {
    const { data, error } = await this.db.rpc('rpc_cc_listar_personas');
    if (error) throw new Error(error.message);
    return ((data ?? []) as unknown as PersonaResumen[]).map(p => ({
      ...p,
      saldo_a_favor:   Number(p.saldo_a_favor ?? 0),
      deuda_pendiente: Number(p.deuda_pendiente ?? 0),
    }));
  }

  // ── Detalle ───────────────────────────────────────────────────────────────
  async obtenerDetalle(tipo: TipoPersona, id: number): Promise<PersonaDetalle> {
    const { data, error } = await this.db.rpc('rpc_cc_detalle_persona', {
      p_tipo: tipo,
      p_id:   id,
    });
    if (error) throw new Error(error.message);
    const raw = data as unknown as {
      persona: PersonaResumen;
      deudas:  unknown[];
      pagos:   unknown[];
    };
    // Calcular saldo_pendiente por deuda
    const deudas = ((raw.deudas ?? []) as unknown as {
      id: number; concepto: string; periodo_anio: number; periodo_mes: number;
      monto: number; ya_pagado: number; estado: string;
      fecha_generacion: string; observacion?: string;
    }[]).map(d => ({
      ...d,
      monto:           Number(d.monto),
      ya_pagado:       Number(d.ya_pagado ?? 0),
      saldo_pendiente: Math.round((Number(d.monto) - Number(d.ya_pagado ?? 0)) * 100) / 100,
    }));
    return { persona: raw.persona, deudas, pagos: raw.pagos as PersonaDetalle['pagos'] };
  }

  // ── Cargo nuevo ───────────────────────────────────────────────────────────
  async crearCargo(
    tipo:     TipoPersona,
    personaId: number,
    puestoId:  number | null,
    form:      NuevoCargoForm,
  ): Promise<void> {
    if (!form.concepto_id || form.monto <= 0) {
      throw new Error('Concepto y monto son requeridos.');
    }
    const userId = (await this.db.auth.getUser()).data.user?.id ?? null;
    const payload: Record<string, unknown> = {
      concepto_id:    form.concepto_id,
      periodo_anio:   form.periodo_anio,
      periodo_mes:    form.periodo_mes,
      monto:          form.monto,
      estado:         'Pendiente',
      metodo_calculo: 'Manual',
      fecha_generacion: new Date().toISOString().slice(0, 10),
      observacion:    form.observacion || null,
      created_by:     userId,
    };
    // XOR: puesto o socio
    if (puestoId && tipo !== 'socio') {
      payload['puesto_id'] = puestoId;
    } else if (tipo === 'socio') {
      // Para socios, cargos de puesto van a puesto_id si existe, personales a socio_id
      payload[puestoId ? 'puesto_id' : 'socio_id'] = puestoId ?? personaId;
    } else {
      payload['puesto_id'] = puestoId;
    }

    const { error } = await this.db.from('montos_por_cobrar').insert(payload);
    if (error) throw new Error(error.message);
  }

  // ── Abono manual ──────────────────────────────────────────────────────────
  async crearAbono(
    tipo:     TipoPersona,
    personaId: number,
    puestoId:  number | null,
    form:      NuevoAbonoForm,
  ): Promise<{ codigo_transaccion: string }> {
    if (!form.monto_deuda_id || form.monto <= 0) {
      throw new Error('Selecciona una deuda y un monto válido.');
    }
    const userId = (await this.db.auth.getUser()).data.user?.id ?? null;
    const fechaPago = form.fecha_pago
      ? new Date(form.fecha_pago + 'T12:00:00').toISOString()
      : new Date().toISOString();

    const { data, error } = await this.db.rpc('rpc_procesar_pago', {
      p_puesto_id:    puestoId,
      p_socio_id:     tipo === 'socio'     ? personaId : null,
      p_inquilino_id: tipo === 'inquilino' ? personaId : null,
      p_monto_total:  form.monto,
      p_metodo_pago:  form.metodo_pago,
      p_comprobante:  form.comprobante || null,
      p_observacion:  form.observacion || null,
      p_usuario_id:   userId,
      p_distribucion: [{
        monto_id:          form.monto_deuda_id,
        monto_aplicado:    form.monto,
        cubierto_completo: false,
      }],
      p_saldo_utilizado: 0,
      p_fecha_pago:       fechaPago,
    });
    if (error) throw new Error(error.message);
    return data as unknown as { codigo_transaccion: string };
  }

  // ── Editar pago ───────────────────────────────────────────────────────────
  async editarPago(pagoId: number, form: EditarPagoForm): Promise<void> {
    const fechaPago = form.fecha_pago
      ? new Date(form.fecha_pago + 'T12:00:00').toISOString()
      : null;
    const { error } = await this.db.rpc('rpc_cc_editar_pago', {
      p_pago_id:    pagoId,
      p_comprobante: form.comprobante || null,
      p_fecha_pago:  fechaPago,
    });
    if (error) throw new Error(error.message);
  }

  // ── Modificar cargo ───────────────────────────────────────────────────────
  async modificarCargo(montoId: number, form: ModificarCargoForm, yaPagado: number): Promise<void> {
    if (form.monto <= 0) throw new Error('El monto debe ser mayor a cero.');
    if (form.monto < yaPagado) {
      throw new Error(`El monto no puede ser menor al importe ya pagado (S/ ${yaPagado.toFixed(2)}).`);
    }
    const { error } = await this.db
      .from('montos_por_cobrar')
      .update({ monto: form.monto, observacion: form.observacion || null })
      .eq('id', montoId)
      .is('deleted_at', null);
    if (error) throw new Error(error.message);
  }

  // ── Anular cargo ──────────────────────────────────────────────────────────
  async anularCargo(montoId: number, motivo: string): Promise<void> {
    const userId = (await this.db.auth.getUser()).data.user?.id;
    if (!userId) throw new Error('No autenticado');
    const { error } = await this.db.rpc('rpc_anular_cargo', {
      p_monto_id:   montoId,
      p_motivo:     motivo,
      p_usuario_id: userId,
    });
    if (error) throw new Error(error.message);
  }

  // ── Anular pago ───────────────────────────────────────────────────────────
  async anularPago(pagoId: number, motivo: string): Promise<void> {
    const userId = (await this.db.auth.getUser()).data.user?.id;
    if (!userId) throw new Error('No autenticado');
    const { error } = await this.db.rpc('anular_pago', {
      p_pago_id:    pagoId,
      p_motivo:     motivo,
      p_usuario_id: userId,
    });
    if (error) throw new Error(error.message);
  }

  // ── Catálogo de conceptos ─────────────────────────────────────────────────
  async obtenerConceptos(): Promise<{ id: number; nombre: string }[]> {
    const { data, error } = await this.db
      .from('conceptos')
      .select('id, nombre')
      .is('deleted_at', null)
      .eq('activo', true)
      .order('nombre');
    if (error) throw new Error(error.message);
    return (data ?? []) as unknown as { id: number; nombre: string }[];
  }
}
