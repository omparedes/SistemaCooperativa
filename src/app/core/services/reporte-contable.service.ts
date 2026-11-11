import { Injectable, inject } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import { AuthService } from './auth.service';
import {
  CanalContable,
  ClasificacionDocumento,
  ComprobanteContableItem,
  ConciliacionReporteContable,
  EstadoObligacionActual,
  FilaMatrizConcepto,
  FiltroReporteContable,
  GrupoDiarioComprobantes,
  KpisReporteContable,
  LineaConceptoContable,
  OrigenContable,
  PersonaDocumentoPendiente,
  ResultadoReporteContable,
  TipoAbonoDeuda,
  clasificarDocumentoPersona,
  round2,
} from '../../pages/reportes/reporte-contable/reporte-contable.model';

interface SocioRaw {
  id: number;
  dni: string | null;
  nombres: string | null;
  apellidos: string | null;
}

interface InquilinoRaw {
  id: number;
  dni: string | null;
  nombres: string | null;
  apellidos: string | null;
}

interface PuestoRaw {
  id: number;
  codigo_puesto: string | null;
}

interface ConceptoRaw {
  id: number;
  nombre: string | null;
  grupo: string | null;
}

interface MontoPorCobrarRaw {
  id: number;
  concepto_id: number;
  puesto_id: number | null;
  socio_id: number | null;
  periodo_anio: number;
  periodo_mes: number;
  monto: number;
  estado: string;
  conceptos?: ConceptoRaw | ConceptoRaw[] | null;
  puestos?: PuestoRaw | PuestoRaw[] | null;
}

interface DetallePagoRaw {
  id: number;
  monto_id: number;
  monto_aplicado: number;
  fecha_aplicacion: string | null;
  deleted_at: string | null;
  montos_por_cobrar?: MontoPorCobrarRaw | MontoPorCobrarRaw[] | null;
}

interface PagoRaw {
  id: number;
  codigo_transaccion: string;
  socio_id: number | null;
  inquilino_id: number | null;
  puesto_id: number | null;
  fecha_pago: string;
  monto_total: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  comprobante: string | null;
  observacion: string | null;
  created_by: string | null;
  deleted_at: string | null;
  motivo_anulacion: string | null;
  socios?: SocioRaw | SocioRaw[] | null;
  inquilinos?: InquilinoRaw | InquilinoRaw[] | null;
  puestos?: PuestoRaw | PuestoRaw[] | null;
  detalle_pagos?: DetallePagoRaw[] | null;
}

interface IngresoInternoRaw {
  id: number;
  concepto_id: number;
  monto: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  observacion: string | null;
  fecha_ingreso: string;
  created_by: string | null;
  deleted_at: string | null;
  motivo_anulacion: string | null;
  conceptos?: ConceptoRaw | ConceptoRaw[] | null;
}

interface RecaudacionAbonoRaw {
  id: number;
  socio_id: number;
  monto: number;
  fecha: string;
  created_by: string | null;
  deleted_at: string | null;
  motivo_anulacion: string | null;
  socios?: SocioRaw | SocioRaw[] | null;
}

interface TitularidadVigenteRaw {
  id: number;
  puesto_id: number;
  socio_id: number;
  fecha_inicio: string;
  fecha_fin: string | null;
  puestos?: PuestoRaw | PuestoRaw[] | null;
  socios?: SocioRaw | SocioRaw[] | null;
}

interface DetalleHistoricoRaw {
  id: number;
  pago_id: number;
  monto_id: number;
  monto_aplicado: number;
  fecha_aplicacion: string | null;
  deleted_at: string | null;
  pagos?: { fecha_pago: string; deleted_at: string | null } | { fecha_pago: string; deleted_at: string | null }[] | null;
}

function unwrapRel<T>(rel: T | T[] | null | undefined): T | null {
  if (!rel) return null;
  return Array.isArray(rel) ? (rel[0] ?? null) : rel;
}

function formatearNombrePersona(apellidos?: string | null, nombres?: string | null): string {
  const ap = (apellidos ?? '').trim();
  const no = (nombres ?? '').trim();
  if (ap && no) return `${ap}, ${no}`;
  return ap || no || '—';
}

function extraerFechaHoraLima(isoString: string): { fechaLima: string; horaLima: string } {
  const dt = new Date(isoString);
  if (isNaN(dt.getTime())) {
    return { fechaLima: isoString.slice(0, 10), horaLima: '00:00' };
  }
  const fechaLima = new Intl.DateTimeFormat('en-CA', {
    timeZone: 'America/Lima',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
  }).format(dt);

  const horaLima = new Intl.DateTimeFormat('es-PE', {
    timeZone: 'America/Lima',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
  }).format(dt);

  return { fechaLima, horaLima };
}

@Injectable({ providedIn: 'root' })
export class ReporteContableService {
  private readonly db = inject(SUPABASE_CLIENT);
  private readonly auth = inject(AuthService);

  /**
   * Verifica que el usuario actual tenga autorización para consultar y exportar
   * el Reporte Contable con documentos personales (Roles: Administrador o Caja).
   */
  tienePermisoContable(): boolean {
    const rol = this.auth.perfil()?.rol;
    return rol === 'Administrador' || rol === 'Caja';
  }

  /**
   * Carga todos los comprobantes del período solicitado (paginando automáticamente
   * sobre PostgREST para superar el límite de 1,000 filas sin necesidad de migraciones),
   * reconstruye el estado de abonos acumulados de cada deuda y obtiene el resumen oficial
   * de la Central de Reportes para conciliación.
   */
  async cargarReportePeriodo(
    desde: string,
    hasta: string,
    periodoEtiqueta: string,
  ): Promise<ResultadoReporteContable> {
    if (!this.tienePermisoContable()) {
      throw new Error(
        'Acceso restringido: Solo los roles Administrador y Caja están autorizados para consultar y exportar el Reporte Contable con DNI.',
      );
    }

    const desdeIso = `${desde}T00:00:00-05:00`;
    const hastaIso = `${hasta}T23:59:59.999-05:00`;

    // 1. Consultas principales paginadas + catálogos de titularidad y resumen oficial
    const [
      pagosRaw,
      internosRaw,
      abonosRaw,
      titularidadesVigentes,
      conceptosActivos,
      resumenOficial,
    ] = await Promise.all([
      this.fetchAllPages<PagoRaw>((from, to) =>
        this.db
          .from('pagos')
          .select(`
            id, codigo_transaccion, socio_id, inquilino_id, puesto_id,
            fecha_pago, monto_total, metodo_pago, comprobante, observacion,
            created_by, deleted_at, motivo_anulacion,
            socios(id, dni, nombres, apellidos),
            inquilinos(id, dni, nombres, apellidos),
            puestos(id, codigo_puesto),
            detalle_pagos(
              id, monto_id, monto_aplicado, fecha_aplicacion, deleted_at,
              montos_por_cobrar(
                id, concepto_id, puesto_id, socio_id, periodo_anio, periodo_mes, monto, estado,
                conceptos(id, nombre, grupo),
                puestos(id, codigo_puesto)
              )
            )
          `)
          .gte('fecha_pago', desdeIso)
          .lte('fecha_pago', hastaIso)
          .order('fecha_pago', { ascending: false })
          .order('id', { ascending: false })
          .range(from, to),
      ),
      this.fetchAllPages<IngresoInternoRaw>((from, to) =>
        this.db
          .from('ingresos_internos')
          .select(`
            id, concepto_id, monto, metodo_pago, observacion,
            fecha_ingreso, created_by, deleted_at, motivo_anulacion,
            conceptos(id, nombre, grupo)
          `)
          .gte('fecha_ingreso', desdeIso)
          .lte('fecha_ingreso', hastaIso)
          .order('fecha_ingreso', { ascending: false })
          .order('id', { ascending: false })
          .range(from, to),
      ),
      this.fetchAllPages<RecaudacionAbonoRaw>((from, to) =>
        this.db
          .from('recaudacion_abonos')
          .select(`
            id, socio_id, monto, fecha, created_by, deleted_at, motivo_anulacion,
            socios(id, dni, nombres, apellidos)
          `)
          .gte('fecha', desdeIso)
          .lte('fecha', hastaIso)
          .order('fecha', { ascending: false })
          .order('id', { ascending: false })
          .range(from, to),
      ),
      this.fetchAllPages<TitularidadVigenteRaw>((from, to) =>
        this.db
          .from('historial_titularidad')
          .select(`
            id, puesto_id, socio_id, fecha_inicio, fecha_fin,
            puestos(id, codigo_puesto),
            socios(id, dni, nombres, apellidos)
          `)
          .is('fecha_fin', null)
          .order('id', { ascending: true })
          .range(from, to),
      ),
      this.cargarNombresConceptos(),
      this.cargarResumenCentralSeguro(desde, hasta),
    ]);

    // 2. Mapas de titularidad vigente por puesto_id y por socio_id
    const titularPorPuesto = new Map<
      number,
      { socioId: number; nombre: string; doc: ClasificacionDocumento; codigoPuesto: string }
    >();
    const puestosActualesPorSocio = new Map<number, string[]>();

    for (const t of titularidadesVigentes) {
      const s = unwrapRel(t.socios);
      const p = unwrapRel(t.puestos);
      const codigo = p?.codigo_puesto?.trim() || `#${t.puesto_id}`;
      if (s) {
        const nombreSocio = formatearNombrePersona(s.apellidos, s.nombres);
        const docSocio = clasificarDocumentoPersona(s.dni, true);
        titularPorPuesto.set(t.puesto_id, {
          socioId: s.id,
          nombre: nombreSocio,
          doc: docSocio,
          codigoPuesto: codigo,
        });
      }
      const lista = puestosActualesPorSocio.get(t.socio_id) ?? [];
      if (!lista.includes(codigo)) {
        lista.push(codigo);
      }
      puestosActualesPorSocio.set(t.socio_id, lista);
    }

    // 3. Resolver cajeros (created_by)
    const userIds = new Set<string>();
    pagosRaw.forEach(p => { if (p.created_by) userIds.add(p.created_by); });
    internosRaw.forEach(i => { if (i.created_by) userIds.add(i.created_by); });
    abonosRaw.forEach(a => { if (a.created_by) userIds.add(a.created_by); });
    const mapaCajeros = await this.resolverNombresCajeros(Array.from(userIds));

    // 4. Reconstruir historial acumulado de abonos para cada monto_id involucrado (Ajuste 2.3)
    const montoIds = new Set<number>();
    for (const p of pagosRaw) {
      for (const dp of p.detalle_pagos ?? []) {
        if (dp.monto_id) montoIds.add(dp.monto_id);
      }
    }
    const mapaHistorialDeuda = await this.cargarHistorialAbonosPorMonto(Array.from(montoIds));

    // 5. Construir universo unificado de comprobantes
    const comprobantes: ComprobanteContableItem[] = [];

    // 5.1. Procesar recibos formales (public.pagos)
    for (const p of pagosRaw) {
      const esAnulado = p.deleted_at !== null;
      const { fechaLima, horaLima } = extraerFechaHoraLima(p.fecha_pago);
      const socio = unwrapRel(p.socios);
      const inquilino = unwrapRel(p.inquilinos);
      const puestoCabecera = unwrapRel(p.puestos);
      const codigoPuestoCabecera = puestoCabecera?.codigo_puesto?.trim() || '—';

      let origen: OrigenContable = 'OTROS';
      let tipoPersona: 'SOCIO' | 'INQUILINO' | 'OTRO' = 'OTRO';
      let personaId: number | null = null;
      let personaKey: string | null = null;
      let personaNombre = '—';
      let documento: ClasificacionDocumento = clasificarDocumentoPersona(null, false);

      if (p.socio_id !== null && socio) {
        origen = 'SOCIOS';
        tipoPersona = 'SOCIO';
        personaId = socio.id;
        personaKey = `socio:${socio.id}`;
        personaNombre = formatearNombrePersona(socio.apellidos, socio.nombres);
        documento = clasificarDocumentoPersona(socio.dni, true);
      } else if (p.inquilino_id !== null && inquilino) {
        origen = 'INQUILINOS';
        tipoPersona = 'INQUILINO';
        personaId = inquilino.id;
        personaKey = `inquilino:${inquilino.id}`;
        personaNombre = formatearNombrePersona(inquilino.apellidos, inquilino.nombres);
        documento = clasificarDocumentoPersona(inquilino.dni, true);
      }

      // Distinguir persona registrada vs titular del puesto (Ajuste 2.2)
      const infoTitular = p.puesto_id !== null ? (titularPorPuesto.get(p.puesto_id) ?? null) : null;
      const titularPuestoNombre = infoTitular ? infoTitular.nombre : null;
      const titularPuestoDocumento = infoTitular ? infoTitular.doc.numeroMostrar : null;
      const esPersonaDistintaAlTitular = Boolean(
        infoTitular && (tipoPersona === 'INQUILINO' || (tipoPersona === 'SOCIO' && personaId !== infoTitular.socioId)),
      );

      // Si el recibo está vigente, usar líneas vigentes; si está anulado, incluir todas sus líneas para trazabilidad
      const rawLineas = p.detalle_pagos ?? [];
      const lineasAplicables = esAnulado
        ? rawLineas
        : rawLineas.filter(d => d.deleted_at === null);

      const lineasOrdenadas = [...lineasAplicables].sort((a, b) => a.id - b.id);

      const montoCaja = round2(Number(p.monto_total ?? 0));
      const sumaAplicado = round2(
        lineasOrdenadas.reduce((acc, d) => acc + Number(d.monto_aplicado ?? 0), 0),
      );
      const saldoUtilizado = round2(Math.max(0, sumaAplicado - montoCaja));
      const excedenteGenerado = round2(Math.max(0, montoCaja - sumaAplicado));

      // Determinar Canal Contable
      let canal: CanalContable = 'EFECTIVO';
      let canalEtiqueta = 'Efectivo';
      let metodoPagoBase: 'Efectivo' | 'Transferencia' | 'Saldo a favor' = p.metodo_pago;

      if (montoCaja === 0 && saldoUtilizado > 0) {
        canal = 'SALDO_FAVOR';
        canalEtiqueta = 'Saldo a favor';
        metodoPagoBase = 'Saldo a favor';
      } else if (montoCaja > 0 && saldoUtilizado > 0) {
        canal = 'MIXTO';
        canalEtiqueta =
          p.metodo_pago === 'Efectivo'
            ? 'Mixto (Efectivo + Saldo a favor)'
            : 'Mixto (Banco/QR + Saldo a favor)';
      } else if (p.metodo_pago === 'Transferencia') {
        canal = 'BANCO';
        canalEtiqueta = 'Banco / Transferencia / QR';
      } else {
        canal = 'EFECTIVO';
        canalEtiqueta = 'Efectivo';
      }

      const dineroNuevoEfectivo = p.metodo_pago === 'Efectivo' ? montoCaja : 0;
      const dineroNuevoBanco = p.metodo_pago === 'Transferencia' ? montoCaja : 0;

      // Construir líneas de conceptos con estado de obligación acumulado (Ajuste 2.3)
      const puestosDistintos = new Set<string>();
      if (codigoPuestoCabecera && codigoPuestoCabecera !== '—') {
        puestosDistintos.add(codigoPuestoCabecera);
      }

      const lineas: LineaConceptoContable[] = [];
      const totalLineas = Math.max(1, lineasOrdenadas.length);

      if (lineasOrdenadas.length === 0) {
        // Caso borde: recibo con monto_total > 0 pero sin filas en detalle_pagos (abono directo / excedente)
        lineas.push({
          id: `PAG-${p.id}-L1`,
          numeroLinea: 1,
          totalLineasComprobante: 1,
          esPrimeraLinea: true,
          concepto: 'Abono directo / Excedente a saldo a favor',
          periodo: fechaLima.slice(0, 7),
          puestoLinea: codigoPuestoCabecera,
          esPuestoReferencial: false,
          importeAplicado: montoCaja,
          cargoOriginalDeuda: null,
          abonadoPrevioDeuda: null,
          acumuladoTrasAbono: null,
          saldoRestanteTrasAbono: null,
          tipoAbonoDeuda: 'Directo',
          estadoActualObligacion: 'Directo',
          etiquetaEstadoDeuda: 'Abono directo sin cargo previo',
        });
      } else {
        lineasOrdenadas.forEach((dp, idx) => {
          const mc = unwrapRel(dp.montos_por_cobrar);
          const conc = unwrapRel(mc?.conceptos);
          const puestoDeuda = unwrapRel(mc?.puestos);
          const codigoPuestoLinea =
            puestoDeuda?.codigo_puesto?.trim() || codigoPuestoCabecera || '—';

          if (codigoPuestoLinea && codigoPuestoLinea !== '—') {
            puestosDistintos.add(codigoPuestoLinea);
          }

          const nombreConcepto = conc?.nombre?.trim() || 'Sin concepto';
          const periodo = mc
            ? `${mc.periodo_anio}-${String(mc.periodo_mes).padStart(2, '0')}`
            : '—';
          const importeAplicado = round2(Number(dp.monto_aplicado ?? 0));
          const cargoOriginal = mc ? round2(Number(mc.monto ?? 0)) : null;
          const estadoBdActual = (mc?.estado as EstadoObligacionActual) || 'Directo';

          // Reconstrucción de abonos acumulados sobre este monto_id (Ajuste 2.3)
          let abonadoPrevio: number | null = null;
          let acumuladoTras: number | null = null;
          let saldoRestanteTras: number | null = null;
          let tipoAbono: TipoAbonoDeuda = 'Total';
          let etiquetaEstado = 'Total';

          if (cargoOriginal !== null && dp.monto_id) {
            const historial = mapaHistorialDeuda.get(dp.monto_id) ?? [];
            let sumaPrevia = 0;
            let encontrado = false;
            for (const h of historial) {
              if (h.id === dp.id) {
                encontrado = true;
                break;
              }
              sumaPrevia = round2(sumaPrevia + h.montoAplicado);
            }
            if (!encontrado && !esAnulado) {
              // Fallback seguro si no apareció en el historial
              sumaPrevia = 0;
            }
            abonadoPrevio = sumaPrevia;
            acumuladoTras = round2(sumaPrevia + importeAplicado);
            saldoRestanteTras = round2(Math.max(0, cargoOriginal - acumuladoTras));

            if (abonadoPrevio === 0 && importeAplicado >= cargoOriginal) {
              tipoAbono = 'Total';
              etiquetaEstado = `Pago Total (Obligación: ${estadoBdActual})`;
            } else if (abonadoPrevio > 0 && acumuladoTras >= cargoOriginal) {
              tipoAbono = 'Liquidación (Completa saldo)';
              etiquetaEstado = `Liquidación de saldo (Previo: S/ ${abonadoPrevio.toFixed(2)} | Obligación: ${estadoBdActual})`;
            } else {
              tipoAbono = 'Parcial (A cuenta)';
              etiquetaEstado = `Abono Parcial (Restó S/ ${saldoRestanteTras.toFixed(2)} de S/ ${cargoOriginal.toFixed(2)} | Hoy: ${estadoBdActual})`;
            }
          }

          lineas.push({
            id: `DP-${dp.id}`,
            numeroLinea: idx + 1,
            totalLineasComprobante: totalLineas,
            esPrimeraLinea: idx === 0,
            concepto: nombreConcepto,
            periodo,
            puestoLinea: codigoPuestoLinea,
            esPuestoReferencial: false,
            importeAplicado,
            cargoOriginalDeuda: cargoOriginal,
            abonadoPrevioDeuda: abonadoPrevio,
            acumuladoTrasAbono: acumuladoTras,
            saldoRestanteTrasAbono: saldoRestanteTras,
            tipoAbonoDeuda: tipoAbono,
            estadoActualObligacion: estadoBdActual,
            etiquetaEstadoDeuda: etiquetaEstado,
          });
        });
      }

      const puestoMostrar =
        puestosDistintos.size > 0 ? Array.from(puestosDistintos).join(', ') : '—';

      comprobantes.push({
        uid: `PAG-${p.id}`,
        fuenteTabla: 'pagos',
        registroId: p.id,
        numeroComprobante: p.codigo_transaccion,
        referenciaExterna: p.comprobante?.trim() || p.observacion?.trim() || null,
        fechaIso: p.fecha_pago,
        fechaLima,
        horaLima,
        estado: esAnulado ? 'ANULADO' : 'VIGENTE',
        motivoAnulacion: p.motivo_anulacion ?? null,
        origen,
        tipoPersona,
        personaId,
        personaKey,
        personaRegistradaNombre: personaNombre,
        documento,
        titularPuestoNombre,
        titularPuestoDocumento,
        esPersonaDistintaAlTitular,
        puestoMostrar,
        esPuestoActualReferencial: false,
        cajero: p.created_by ? (mapaCajeros.get(p.created_by) ?? 'Operador Caja') : 'Sistema',
        metodoPagoBase,
        canal,
        canalEtiqueta,
        dineroNuevoCajaBanco: montoCaja,
        dineroNuevoEfectivo,
        dineroNuevoBanco,
        saldoAFavorUtilizado: saldoUtilizado,
        excedenteGenerado,
        totalAplicadoConceptos: sumaAplicado,
        totalAplicadoDeudasInternos: sumaAplicado,
        lineas,
      });
    }

    // 5.2. Procesar Ingresos Internos / Caja Rápida (public.ingresos_internos)
    for (const i of internosRaw) {
      const esAnulado = i.deleted_at !== null;
      const { fechaLima, horaLima } = extraerFechaHoraLima(i.fecha_ingreso);
      const conc = unwrapRel(i.conceptos);
      const nombreConcepto = conc?.nombre?.trim() || 'Otros Ingresos';
      const monto = round2(Number(i.monto ?? 0));
      const codigoSintetico = `INT-${String(i.id).padStart(6, '0')}`;
      const esEfectivo = i.metodo_pago === 'Efectivo';

      comprobantes.push({
        uid: `INT-${i.id}`,
        fuenteTabla: 'ingresos_internos',
        registroId: i.id,
        numeroComprobante: codigoSintetico,
        referenciaExterna: i.observacion?.trim() || null,
        fechaIso: i.fecha_ingreso,
        fechaLima,
        horaLima,
        estado: esAnulado ? 'ANULADO' : 'VIGENTE',
        motivoAnulacion: i.motivo_anulacion ?? null,
        origen: 'OTROS',
        tipoPersona: 'OTRO',
        personaId: null,
        personaKey: null,
        personaRegistradaNombre: i.observacion?.trim()
          ? `Caja Rápida (${i.observacion.trim()})`
          : `Caja Rápida — ${nombreConcepto}`,
        documento: clasificarDocumentoPersona(null, false),
        titularPuestoNombre: null,
        titularPuestoDocumento: null,
        esPersonaDistintaAlTitular: false,
        puestoMostrar: 'NO APLICA',
        esPuestoActualReferencial: false,
        cajero: i.created_by ? (mapaCajeros.get(i.created_by) ?? 'Operador Caja') : 'Sistema',
        metodoPagoBase: i.metodo_pago,
        canal: esEfectivo ? 'EFECTIVO' : 'BANCO',
        canalEtiqueta: esEfectivo ? 'Efectivo' : 'Banco / Transferencia / QR',
        dineroNuevoCajaBanco: monto,
        dineroNuevoEfectivo: esEfectivo ? monto : 0,
        dineroNuevoBanco: esEfectivo ? 0 : monto,
        saldoAFavorUtilizado: 0,
        excedenteGenerado: 0,
        totalAplicadoConceptos: monto,
        totalAplicadoDeudasInternos: monto,
        lineas: [
          {
            id: `INTL-${i.id}`,
            numeroLinea: 1,
            totalLineasComprobante: 1,
            esPrimeraLinea: true,
            concepto: nombreConcepto,
            periodo: fechaLima.slice(0, 7),
            puestoLinea: 'NO APLICA',
            esPuestoReferencial: false,
            importeAplicado: monto,
            cargoOriginalDeuda: null,
            abonadoPrevioDeuda: null,
            acumuladoTrasAbono: null,
            saldoRestanteTrasAbono: null,
            tipoAbonoDeuda: 'Directo',
            estadoActualObligacion: 'Directo',
            etiquetaEstadoDeuda: 'Cobro directo (Caja Rápida)',
          },
        ],
      });
    }

    // 5.3. Procesar Recaudación por Tarjeta (public.recaudacion_abonos) — Decisión 1.A y Ajuste 2.4
    for (const r of abonosRaw) {
      const esAnulado = r.deleted_at !== null;
      const { fechaLima, horaLima } = extraerFechaHoraLima(r.fecha);
      const socio = unwrapRel(r.socios);
      const monto = round2(Number(r.monto ?? 0));
      const codigoRec = `REC-${String(r.id).padStart(6, '0')}`;

      const nombreSocio = socio
        ? formatearNombrePersona(socio.apellidos, socio.nombres)
        : `Socio #${r.socio_id}`;
      const docSocio = clasificarDocumentoPersona(socio?.dni, true);

      // Ajuste 2.4: Mostrar explícitamente como «Puesto(s) actual(es)» sin atribuir titularidad histórica no registrada
      const listaPuestosActuales = puestosActualesPorSocio.get(r.socio_id) ?? [];
      const etiquetaPuestosActuales =
        listaPuestosActuales.length > 0
          ? `Puesto(s) actual(es): ${listaPuestosActuales.join(', ')}`
          : 'Puesto(s) actual(es): Sin titularidad activa';

      comprobantes.push({
        uid: `REC-${r.id}`,
        fuenteTabla: 'recaudacion_abonos',
        registroId: r.id,
        numeroComprobante: codigoRec,
        referenciaExterna: 'Abono semanal de tarjeta prepago',
        fechaIso: r.fecha,
        fechaLima,
        horaLima,
        estado: esAnulado ? 'ANULADO' : 'VIGENTE',
        motivoAnulacion: r.motivo_anulacion ?? null,
        origen: 'SOCIOS',
        tipoPersona: 'SOCIO',
        personaId: r.socio_id,
        personaKey: `socio:${r.socio_id}`,
        personaRegistradaNombre: nombreSocio,
        documento: docSocio,
        titularPuestoNombre: nombreSocio,
        titularPuestoDocumento: docSocio.numeroMostrar,
        esPersonaDistintaAlTitular: false,
        puestoMostrar: etiquetaPuestosActuales,
        esPuestoActualReferencial: true,
        cajero: r.created_by ? (mapaCajeros.get(r.created_by) ?? 'Operador Caja') : 'Sistema',
        metodoPagoBase: 'Efectivo',
        canal: 'EFECTIVO',
        canalEtiqueta: 'Efectivo',
        dineroNuevoCajaBanco: monto,
        dineroNuevoEfectivo: monto,
        dineroNuevoBanco: 0,
        saldoAFavorUtilizado: 0,
        excedenteGenerado: 0,
        totalAplicadoConceptos: monto,
        totalAplicadoDeudasInternos: 0,
        lineas: [
          {
            id: `RECL-${r.id}`,
            numeroLinea: 1,
            totalLineasComprobante: 1,
            esPrimeraLinea: true,
            concepto: 'Recaudación Tarjeta (Abono)',
            periodo: fechaLima.slice(0, 7),
            puestoLinea: etiquetaPuestosActuales,
            esPuestoReferencial: true,
            importeAplicado: monto,
            cargoOriginalDeuda: null,
            abonadoPrevioDeuda: null,
            acumuladoTrasAbono: null,
            saldoRestanteTrasAbono: null,
            tipoAbonoDeuda: 'Directo',
            estadoActualObligacion: 'Directo',
            etiquetaEstadoDeuda: 'Abono a saldo a favor (Tarjeta)',
          },
        ],
      });
    }

    // Ordenar cronológicamente descendente (fechaLima DESC, horaLima DESC, numeroComprobante DESC)
    comprobantes.sort((a, b) => {
      if (a.fechaLima !== b.fechaLima) return b.fechaLima.localeCompare(a.fechaLima);
      if (a.horaLima !== b.horaLima) return b.horaLima.localeCompare(a.horaLima);
      return b.numeroComprobante.localeCompare(a.numeroComprobante);
    });

    // Construir lista de conceptos únicos presentes + activos
    const setConceptos = new Set<string>();
    for (const c of comprobantes) {
      for (const l of c.lineas) {
        setConceptos.add(l.concepto);
      }
    }
    for (const nombreConc of conceptosActivos) {
      setConceptos.add(nombreConc);
    }
    setConceptos.add('Recaudación Tarjeta (Abono)');

    const conceptosDisponibles = Array.from(setConceptos).sort((a, b) => a.localeCompare(b, 'es'));

    const pad = (n: number) => String(n).padStart(2, '0');
    const ahora = new Date();
    const generadoEn = `${ahora.getFullYear()}-${pad(ahora.getMonth() + 1)}-${pad(ahora.getDate())} ${pad(ahora.getHours())}:${pad(ahora.getMinutes())}`;
    const perfil = this.auth.perfil();

    return {
      periodoDesde: desde,
      periodoHasta: hasta,
      periodoEtiqueta,
      generadoEn,
      usuarioEmisor: perfil?.nombres?.trim() || perfil?.email || 'Usuario Autenticado',
      rolEmisor: perfil?.rol || 'Caja',
      universoComprobantes: comprobantes,
      conceptosDisponibles,
      resumenCentralOficial: resumenOficial,
    };
  }

  // ==========================================================================
  // MÉTODOS PUROS DE FILTRADO, AGRUPACIÓN, KPIS Y CONCILIACIÓN
  // ==========================================================================

  /**
   * Filtra el universo de comprobantes aplicando todos los criterios del panel de filtros.
   * Afecta de forma idéntica tanto a la vista previa en pantalla como a la exportación Excel.
   */
  filtrarComprobantes(
    universo: ComprobanteContableItem[],
    filtro: FiltroReporteContable,
  ): ComprobanteContableItem[] {
    const q = filtro.busqueda.trim().toLowerCase();
    const concFiltro = filtro.concepto.trim();

    const resultado: ComprobanteContableItem[] = [];

    for (const item of universo) {
      // 1. Filtro de Estado (Vigentes / Anulados / Todos)
      if (filtro.estado === 'VIGENTES' && item.estado !== 'VIGENTE') continue;
      if (filtro.estado === 'ANULADOS' && item.estado !== 'ANULADO') continue;

      // 2. Filtro de Origen (Todos / Socios / Inquilinos / Otros)
      if (filtro.origen !== 'TODOS' && item.origen !== filtro.origen) continue;

      // 3. Filtro de Canal (Efectivo / Banco / Saldo a favor / Mixto)
      if (filtro.canal !== 'TODOS' && item.canal !== filtro.canal) continue;

      // 4. Filtro de Documento (Todos / Registrados / Sin registrar / Por validar) — Decisión 1.B
      if (filtro.documento === 'REGISTRADOS' && item.documento.estado !== 'REGISTRADO') continue;
      if (filtro.documento === 'SIN_REGISTRAR' && item.documento.estado !== 'SIN REGISTRAR') continue;
      if (filtro.documento === 'POR_VALIDAR' && item.documento.estado !== 'POR VALIDAR') continue;

      // 5. Filtro de Concepto Contable
      let lineasFiltradas = item.lineas;
      if (concFiltro) {
        lineasFiltradas = item.lineas.filter(l => l.concepto === concFiltro);
        if (lineasFiltradas.length === 0) continue;
      }

      // 6. Búsqueda por texto (Nombre, DNI, Número de comprobante, Puesto/Almacén)
      if (q) {
        const matchComprobante = item.numeroComprobante.toLowerCase().includes(q);
        const matchNombre = item.personaRegistradaNombre.toLowerCase().includes(q);
        const matchTitular = (item.titularPuestoNombre ?? '').toLowerCase().includes(q);
        const matchDocMostrar = item.documento.numeroMostrar.toLowerCase().includes(q);
        const matchDocOriginal = (item.documento.valorOriginalBd ?? '').toLowerCase().includes(q);
        const matchPuesto = item.puestoMostrar.toLowerCase().includes(q);
        const matchRef = (item.referenciaExterna ?? '').toLowerCase().includes(q);

        if (
          !matchComprobante &&
          !matchNombre &&
          !matchTitular &&
          !matchDocMostrar &&
          !matchDocOriginal &&
          !matchPuesto &&
          !matchRef
        ) {
          continue;
        }
      }

      // Si hay filtro de concepto activo y el recibo era multiconcepto, reindexar líneas
      // asegurando que esPrimeraLinea sea true en la primera línea visible (Ajuste 2.1).
      if (concFiltro && lineasFiltradas.length !== item.lineas.length) {
        const totalVisibles = lineasFiltradas.length;
        const reindexadas = lineasFiltradas.map((l, idx) => ({
          ...l,
          numeroLinea: idx + 1,
          totalLineasComprobante: totalVisibles,
          esPrimeraLinea: idx === 0,
        }));
        const sumaFiltrada = round2(
          reindexadas.reduce((acc, l) => acc + l.importeAplicado, 0),
        );
        resultado.push({
          ...item,
          totalAplicadoConceptos: sumaFiltrada,
          totalAplicadoDeudasInternos:
            item.fuenteTabla === 'recaudacion_abonos' ? 0 : sumaFiltrada,
          lineas: reindexadas,
        });
      } else {
        resultado.push(item);
      }
    }

    return resultado;
  }

  /**
   * Calcula los 5 Indicadores de Control (Sección C) diferenciando estrictamente
   * comprobantes únicos vs líneas de conceptos y dinero nuevo vs saldo a favor.
   */
  calcularKpis(
    comprobantesFiltrados: ComprobanteContableItem[],
    estadoFiltro: FiltroReporteContable['estado'],
  ): KpisReporteContable {
    const vigentes = comprobantesFiltrados.filter(c => c.estado === 'VIGENTE');
    const anulados = comprobantesFiltrados.filter(c => c.estado === 'ANULADO');

    // Si se consulta solo ANULADOS, mostrar los montos de esos anulados para inspección;
    // en VIGENTES o TODOS, las bases financieras suman exclusivamente comprobantes VIGENTES.
    const baseCalculoFinanciero = estadoFiltro === 'ANULADOS' ? anulados : vigentes;

    let dineroNuevoTotal = 0;
    let dineroNuevoEfectivo = 0;
    let dineroNuevoBanco = 0;
    let recaudacionTarjetaEfectivo = 0;
    let saldoAFavorUtilizado = 0;
    let excedenteGenerado = 0;
    let totalAplicadoConceptos = 0;
    let totalAplicadoDeudasInternos = 0;
    let totalLineasConceptos = 0;

    for (const c of comprobantesFiltrados) {
      totalLineasConceptos += c.lineas.length;
    }

    for (const c of baseCalculoFinanciero) {
      dineroNuevoTotal = round2(dineroNuevoTotal + c.dineroNuevoCajaBanco);
      dineroNuevoEfectivo = round2(dineroNuevoEfectivo + c.dineroNuevoEfectivo);
      dineroNuevoBanco = round2(dineroNuevoBanco + c.dineroNuevoBanco);
      if (c.fuenteTabla === 'recaudacion_abonos') {
        recaudacionTarjetaEfectivo = round2(recaudacionTarjetaEfectivo + c.dineroNuevoEfectivo);
      }
      saldoAFavorUtilizado = round2(saldoAFavorUtilizado + c.saldoAFavorUtilizado);
      excedenteGenerado = round2(excedenteGenerado + c.excedenteGenerado);
      totalAplicadoConceptos = round2(totalAplicadoConceptos + c.totalAplicadoConceptos);
      totalAplicadoDeudasInternos = round2(
        totalAplicadoDeudasInternos + c.totalAplicadoDeudasInternos,
      );
    }

    // Personas únicas con documento pendiente (SIN REGISTRAR o POR VALIDAR)
    const keysSinRegistrar = new Set<string>();
    const keysPorValidar = new Set<string>();

    for (const c of comprobantesFiltrados) {
      if (!c.personaKey) continue;
      if (c.documento.estado === 'SIN REGISTRAR') {
        keysSinRegistrar.add(c.personaKey);
      } else if (c.documento.estado === 'POR VALIDAR') {
        keysPorValidar.add(c.personaKey);
      }
    }

    return {
      comprobantesUnicos: comprobantesFiltrados.length,
      comprobantesVigentes: vigentes.length,
      comprobantesAnulados: anulados.length,
      totalLineasConceptos,
      dineroNuevoTotal,
      dineroNuevoEfectivo,
      dineroNuevoBanco,
      recaudacionTarjetaEfectivo,
      saldoAFavorUtilizado,
      excedenteGenerado,
      totalAplicadoConceptos,
      totalAplicadoDeudasInternos,
      personasSinDocumentoTotal: keysSinRegistrar.size + keysPorValidar.size,
      personasSinRegistrarCount: keysSinRegistrar.size,
      personasPorValidarCount: keysPorValidar.size,
    };
  }

  /**
   * Agrupa comprobantes por día (Sección D) calculando subtotales diarios separados
   * para dinero nuevo, saldo a favor utilizado y total aplicado a conceptos.
   */
  agruparPorDia(
    comprobantes: ComprobanteContableItem[],
    estadoFiltro: FiltroReporteContable['estado'],
  ): GrupoDiarioComprobantes[] {
    const mapa = new Map<string, ComprobanteContableItem[]>();
    for (const c of comprobantes) {
      const lista = mapa.get(c.fechaLima) ?? [];
      lista.push(c);
      mapa.set(c.fechaLima, lista);
    }

    const grupos: GrupoDiarioComprobantes[] = [];
    for (const [fechaLima, items] of mapa.entries()) {
      const vigentes = items.filter(x => x.estado === 'VIGENTE');
      const anulados = items.filter(x => x.estado === 'ANULADO');
      const baseSubtotal = estadoFiltro === 'ANULADOS' ? anulados : vigentes;

      let subtotalDineroNuevo = 0;
      let subtotalEfectivo = 0;
      let subtotalBanco = 0;
      let subtotalSaldoAFavorUtilizado = 0;
      let subtotalExcedenteGenerado = 0;
      let subtotalAplicadoConceptos = 0;

      for (const c of baseSubtotal) {
        subtotalDineroNuevo = round2(subtotalDineroNuevo + c.dineroNuevoCajaBanco);
        subtotalEfectivo = round2(subtotalEfectivo + c.dineroNuevoEfectivo);
        subtotalBanco = round2(subtotalBanco + c.dineroNuevoBanco);
        subtotalSaldoAFavorUtilizado = round2(
          subtotalSaldoAFavorUtilizado + c.saldoAFavorUtilizado,
        );
        subtotalExcedenteGenerado = round2(subtotalExcedenteGenerado + c.excedenteGenerado);
        subtotalAplicadoConceptos = round2(subtotalAplicadoConceptos + c.totalAplicadoConceptos);
      }

      grupos.push({
        fechaLima,
        fechaFormateada: this.formatearFechaLargaLima(fechaLima),
        cantidadComprobantes: items.length,
        cantidadVigentes: vigentes.length,
        cantidadAnulados: anulados.length,
        subtotalDineroNuevo,
        subtotalEfectivo,
        subtotalBanco,
        subtotalSaldoAFavorUtilizado,
        subtotalExcedenteGenerado,
        subtotalAplicadoConceptos,
        comprobantes: items,
      });
    }

    return grupos.sort((a, b) => b.fechaLima.localeCompare(a.fechaLima));
  }

  /**
   * Construye la Matriz por Conceptos (Sección E — inspirada en hojas de arqueo de septiembre).
   * Sus columnas dinámicas dependen exclusivamente de los conceptos realmente registrados
   * en los comprobantes filtrados.
   */
  construirMatrizPorConceptos(comprobantes: ComprobanteContableItem[]): {
    columnasConceptos: string[];
    filas: FilaMatrizConcepto[];
    totalesPorConcepto: Record<string, number>;
  } {
    const conceptosSet = new Set<string>();
    for (const c of comprobantes) {
      for (const l of c.lineas) {
        conceptosSet.add(l.concepto);
      }
    }

    // Orden preferencial contable (Luz, Agua, Gastos adm., Previsión, Alquiler, Recaudación Tarjeta, resto)
    const ordenPrioridad = [
      'Luz',
      'Agua',
      'Gastos administrativos',
      'Previsión social',
      'Alquiler',
      'Alquiler de almacén',
      'Recaudación Tarjeta (Abono)',
      'Deposito',
      'Deuda anterior',
      'Multa',
      'SS.HH 1er PISO',
      'SS.HH 2do PISO',
      'Parqueo',
      'Espacio',
      'TICKET',
      'Otros',
    ];

    const columnasConceptos = Array.from(conceptosSet).sort((a, b) => {
      const ia = ordenPrioridad.indexOf(a);
      const ib = ordenPrioridad.indexOf(b);
      if (ia !== -1 && ib !== -1) return ia - ib;
      if (ia !== -1) return -1;
      if (ib !== -1) return 1;
      return a.localeCompare(b, 'es');
    });

    const totalesPorConcepto: Record<string, number> = {};
    for (const col of columnasConceptos) {
      totalesPorConcepto[col] = 0;
    }

    const filas: FilaMatrizConcepto[] = comprobantes.map(c => {
      const montosPorConcepto: Record<string, number> = {};
      const periodosSet = new Set<string>();

      for (const l of c.lineas) {
        montosPorConcepto[l.concepto] = round2(
          (montosPorConcepto[l.concepto] ?? 0) + l.importeAplicado,
        );
        if (l.periodo && l.periodo !== '—') {
          periodosSet.add(l.periodo);
        }
        if (c.estado === 'VIGENTE') {
          totalesPorConcepto[l.concepto] = round2(
            (totalesPorConcepto[l.concepto] ?? 0) + l.importeAplicado,
          );
        }
      }

      return {
        uid: c.uid,
        fechaLima: c.fechaLima,
        horaLima: c.horaLima,
        numeroComprobante: c.numeroComprobante,
        estado: c.estado,
        origen: c.origen,
        personaRegistradaNombre: c.personaRegistradaNombre,
        tipoDocumento: c.documento.tipoDocumento,
        numeroDocumento: c.documento.numeroMostrar,
        estadoDocumento: c.documento.estado,
        titularPuestoNombre: c.titularPuestoNombre ?? '—',
        puestoMostrar: c.puestoMostrar,
        periodosResumen: Array.from(periodosSet).join(', ') || '—',
        canalEtiqueta: c.canalEtiqueta,
        cajero: c.cajero,
        montosPorConcepto,
        totalAplicadoConceptos: c.totalAplicadoConceptos,
        saldoAFavorUtilizado: c.saldoAFavorUtilizado,
        excedenteGenerado: c.excedenteGenerado,
        dineroNuevoCajaBanco: c.dineroNuevoCajaBanco,
        dineroNuevoEfectivo: c.dineroNuevoEfectivo,
        dineroNuevoBanco: c.dineroNuevoBanco,
      };
    });

    return { columnasConceptos, filas, totalesPorConcepto };
  }

  /**
   * Extrae la lista depurada de personas únicas que requieren completar (`SIN REGISTRAR`)
   * o validar (`POR VALIDAR`) su documento de identidad (Hoja 08_DOCUMENTOS_PENDIENTES).
   */
  extraerDocumentosPendientes(
    comprobantes: ComprobanteContableItem[],
  ): PersonaDocumentoPendiente[] {
    const mapa = new Map<
      string,
      {
        personaKey: string;
        tipoPersona: 'SOCIO' | 'INQUILINO';
        personaId: number;
        nombreCompleto: string;
        estadoDocumento: 'SIN REGISTRAR' | 'POR VALIDAR';
        valorOriginalBd: string;
        motivoObservacion: string;
        puestosSet: Set<string>;
        cantidadComprobantesPeriodo: number;
        totalOperacionesPeriodo: number;
      }
    >();

    for (const c of comprobantes) {
      if (!c.personaKey || !c.personaId || c.tipoPersona === 'OTRO') continue;
      if (c.documento.estado !== 'SIN REGISTRAR' && c.documento.estado !== 'POR VALIDAR') {
        continue;
      }

      const existente = mapa.get(c.personaKey);
      if (existente) {
        existente.cantidadComprobantesPeriodo += 1;
        if (c.estado === 'VIGENTE') {
          existente.totalOperacionesPeriodo = round2(
            existente.totalOperacionesPeriodo + c.totalAplicadoConceptos,
          );
        }
        if (c.puestoMostrar && c.puestoMostrar !== '—') {
          existente.puestosSet.add(c.puestoMostrar);
        }
      } else {
        const puestosSet = new Set<string>();
        if (c.puestoMostrar && c.puestoMostrar !== '—') {
          puestosSet.add(c.puestoMostrar);
        }
        mapa.set(c.personaKey, {
          personaKey: c.personaKey,
          tipoPersona: c.tipoPersona,
          personaId: c.personaId,
          nombreCompleto: c.personaRegistradaNombre,
          estadoDocumento: c.documento.estado,
          valorOriginalBd: c.documento.valorOriginalBd || '(vacío)',
          motivoObservacion: c.documento.observacionValidacion,
          puestosSet,
          cantidadComprobantesPeriodo: 1,
          totalOperacionesPeriodo: c.estado === 'VIGENTE' ? c.totalAplicadoConceptos : 0,
        });
      }
    }

    return Array.from(mapa.values())
      .map(item => ({
        personaKey: item.personaKey,
        tipoPersona: item.tipoPersona,
        personaId: item.personaId,
        nombreCompleto: item.nombreCompleto,
        estadoDocumento: item.estadoDocumento,
        valorOriginalBd: item.valorOriginalBd,
        motivoObservacion: item.motivoObservacion,
        puestosRelacionados: Array.from(item.puestosSet).join(' | ') || '—',
        cantidadComprobantesPeriodo: item.cantidadComprobantesPeriodo,
        totalOperacionesPeriodo: item.totalOperacionesPeriodo,
      }))
      .sort((a, b) => a.nombreCompleto.localeCompare(b.nombreCompleto, 'es'));
  }

  /**
   * Construye el cuadro de conciliación matemática al centavo (Sección 5, Ajuste 2.5 y Hoja 07_CONCILIACION).
   */
  calcularConciliacion(
    comprobantes: ComprobanteContableItem[],
    resumenCentralOficial: ResultadoReporteContable['resumenCentralOficial'],
    haySubfiltroActivo: boolean,
  ): ConciliacionReporteContable {
    const vigentes = comprobantes.filter(c => c.estado === 'VIGENTE');

    let pagosEfectivoSocios = 0;
    let pagosEfectivoInquilinos = 0;
    let recaudacionTarjetaSocios = 0;
    let ingresosInternosEfectivo = 0;

    let pagosBancoSocios = 0;
    let pagosBancoInquilinos = 0;
    let ingresosInternosBanco = 0;

    let saldoAFavorUtilizado = 0;
    let excedenteGenerado = 0;
    let totalImputadoDeudasPagos = 0;
    let totalIngresosInternos = 0;

    for (const c of vigentes) {
      if (c.fuenteTabla === 'pagos') {
        if (c.origen === 'SOCIOS') {
          pagosEfectivoSocios = round2(pagosEfectivoSocios + c.dineroNuevoEfectivo);
          pagosBancoSocios = round2(pagosBancoSocios + c.dineroNuevoBanco);
        } else {
          pagosEfectivoInquilinos = round2(pagosEfectivoInquilinos + c.dineroNuevoEfectivo);
          pagosBancoInquilinos = round2(pagosBancoInquilinos + c.dineroNuevoBanco);
        }
        saldoAFavorUtilizado = round2(saldoAFavorUtilizado + c.saldoAFavorUtilizado);
        excedenteGenerado = round2(excedenteGenerado + c.excedenteGenerado);
        totalImputadoDeudasPagos = round2(totalImputadoDeudasPagos + c.totalAplicadoConceptos);
      } else if (c.fuenteTabla === 'recaudacion_abonos') {
        recaudacionTarjetaSocios = round2(recaudacionTarjetaSocios + c.dineroNuevoEfectivo);
      } else if (c.fuenteTabla === 'ingresos_internos') {
        ingresosInternosEfectivo = round2(ingresosInternosEfectivo + c.dineroNuevoEfectivo);
        ingresosInternosBanco = round2(ingresosInternosBanco + c.dineroNuevoBanco);
        totalIngresosInternos = round2(totalIngresosInternos + c.totalAplicadoConceptos);
      }
    }

    const totalDineroNuevoEfectivo = round2(
      pagosEfectivoSocios +
        pagosEfectivoInquilinos +
        recaudacionTarjetaSocios +
        ingresosInternosEfectivo,
    );

    const totalDineroNuevoBanco = round2(
      pagosBancoSocios + pagosBancoInquilinos + ingresosInternosBanco,
    );

    const totalDineroNuevoCajaBanco = round2(totalDineroNuevoEfectivo + totalDineroNuevoBanco);

    // Hojas clasificadas (02 a 06) — representan exactamente el dinero nuevo por canal y origen
    const hoja02SociosOficina = round2(pagosEfectivoSocios + recaudacionTarjetaSocios);
    const hoja03SociosBanco = pagosBancoSocios;
    const hoja04InquilinosOficina = pagosEfectivoInquilinos;
    const hoja05InquilinosBanco = pagosBancoInquilinos;
    const hoja06OtrosIngresos = round2(ingresosInternosEfectivo + ingresosInternosBanco);

    const sumaHojasClasificadas = round2(
      hoja02SociosOficina +
        hoja03SociosBanco +
        hoja04InquilinosOficina +
        hoja05InquilinosBanco +
        hoja06OtrosIngresos,
    );

    const diferenciaHojasVsDineroNuevo = round2(
      sumaHojasClasificadas - totalDineroNuevoCajaBanco,
    );

    const totalAplicadoDeudasYOtros = round2(totalImputadoDeudasPagos + totalIngresosInternos);
    const totalAplicadoConRecaudacionTarjeta = round2(
      totalAplicadoDeudasYOtros + recaudacionTarjetaSocios,
    );

    // Cruce contra Central de Reportes
    let centralEfectivo: number | null = null;
    let centralTransferencia: number | null = null;
    let centralTotalIngresos: number | null = null;
    let centralTotalConceptos: number | null = null;
    let diferenciaEfectivoVsCentral: number | null = null;
    let diferenciaBancoVsCentral: number | null = null;
    let diferenciaTotalVsCentral: number | null = null;
    let diferenciaConceptosVsCentral: number | null = null;

    const notasConciliacion: string[] = [];

    if (resumenCentralOficial) {
      centralEfectivo = round2(resumenCentralOficial.efectivo);
      centralTransferencia = round2(resumenCentralOficial.transferencia);
      centralTotalIngresos = round2(centralEfectivo + centralTransferencia);
      centralTotalConceptos = round2(resumenCentralOficial.totalConceptos);

      diferenciaEfectivoVsCentral = round2(totalDineroNuevoEfectivo - centralEfectivo);
      diferenciaBancoVsCentral = round2(totalDineroNuevoBanco - centralTransferencia);
      diferenciaTotalVsCentral = round2(totalDineroNuevoCajaBanco - centralTotalIngresos);
      diferenciaConceptosVsCentral = round2(
        totalAplicadoConRecaudacionTarjeta - centralTotalConceptos,
      );
    }

    // Explicación técnica de la relación entre Dinero Nuevo y Conceptos Aplicados
    const pagosDineroNuevo = round2(
      pagosEfectivoSocios + pagosEfectivoInquilinos + pagosBancoSocios + pagosBancoInquilinos,
    );
    const checkIdentidadPagos = round2(
      pagosDineroNuevo + saldoAFavorUtilizado - excedenteGenerado - totalImputadoDeudasPagos,
    );

    notasConciliacion.push(
      `Identidad de Recibos (pagos): Dinero Nuevo en Recibos (S/ ${pagosDineroNuevo.toFixed(2)}) + Saldo a Favor Utilizado (S/ ${saldoAFavorUtilizado.toFixed(2)}) − Excedente Generado (S/ ${excedenteGenerado.toFixed(2)}) = Total Imputado a Deudas (S/ ${totalImputadoDeudasPagos.toFixed(2)}) [Diferencia interna: S/ ${checkIdentidadPagos.toFixed(2)}].`,
    );

    notasConciliacion.push(
      `Diferencia conceptual entre Total Dinero Nuevo (S/ ${totalDineroNuevoCajaBanco.toFixed(2)}) y Total Conceptos con Tarjeta (S/ ${totalAplicadoConRecaudacionTarjeta.toFixed(2)}): se explica exactamente por el Saldo a Favor Utilizado (+S/ ${saldoAFavorUtilizado.toFixed(2)}) menos los Excedentes Generados (−S/ ${excedenteGenerado.toFixed(2)}), que suman S/ ${round2(saldoAFavorUtilizado - excedenteGenerado).toFixed(2)}.`,
    );

    if (haySubfiltroActivo) {
      notasConciliacion.push(
        'Nota de filtro activo: Los importes del Reporte Contable reflejan los filtros seleccionados actualmente en pantalla (origen, canal, concepto, documento o búsqueda), mientras que la columna Central de Reportes muestra el total global del período sin subfiltros.',
      );
    } else if (diferenciaTotalVsCentral === 0 && diferenciaConceptosVsCentral === 0) {
      notasConciliacion.push(
        'Conciliación exacta verificada al 100 % (S/ 0.00 de diferencia) frente a la Central de Reportes oficial del ERP.',
      );
    }

    return {
      pagosEfectivoSocios,
      pagosEfectivoInquilinos,
      recaudacionTarjetaSocios,
      ingresosInternosEfectivo,
      totalDineroNuevoEfectivo,
      pagosBancoSocios,
      pagosBancoInquilinos,
      ingresosInternosBanco,
      totalDineroNuevoBanco,
      totalDineroNuevoCajaBanco,
      hoja02SociosOficina,
      hoja03SociosBanco,
      hoja04InquilinosOficina,
      hoja05InquilinosBanco,
      hoja06OtrosIngresos,
      sumaHojasClasificadas,
      diferenciaHojasVsDineroNuevo,
      saldoAFavorUtilizado,
      excedenteGenerado,
      totalImputadoDeudasPagos,
      totalIngresosInternos,
      totalAplicadoDeudasYOtros,
      totalAplicadoConRecaudacionTarjeta,
      centralEfectivo,
      centralTransferencia,
      centralTotalIngresos,
      centralTotalConceptos,
      diferenciaEfectivoVsCentral,
      diferenciaBancoVsCentral,
      diferenciaTotalVsCentral,
      diferenciaConceptosVsCentral,
      notasConciliacion,
    };
  }

  // ==========================================================================
  // HELPERS PRIVADOS DE ACCESO A DATOS (SOLO LECTURA)
  // ==========================================================================

  private async fetchAllPages<T>(
    queryBuilder: (
      from: number,
      to: number,
    ) => PromiseLike<{ data: T[] | null; error: { message: string } | null }>,
  ): Promise<T[]> {
    const pageSize = 1000;
    const acumulado: T[] = [];
    let offset = 0;

    while (true) {
      const { data, error } = await queryBuilder(offset, offset + pageSize - 1);
      if (error) {
        throw new Error(`Error al consultar datos del reporte: ${error.message}`);
      }
      const lote = data ?? [];
      acumulado.push(...lote);
      if (lote.length < pageSize) {
        break;
      }
      offset += pageSize;
    }

    return acumulado;
  }

  private async cargarHistorialAbonosPorMonto(
    montoIds: number[],
  ): Promise<Map<number, { id: number; montoAplicado: number; fechaMs: number }[]>> {
    const resultado = new Map<number, { id: number; montoAplicado: number; fechaMs: number }[]>();
    if (montoIds.length === 0) return resultado;

    const chunkSize = 400;
    for (let i = 0; i < montoIds.length; i += chunkSize) {
      const chunk = montoIds.slice(i, i + chunkSize);
      const { data, error } = await this.db
        .from('detalle_pagos')
        .select('id, pago_id, monto_id, monto_aplicado, fecha_aplicacion, deleted_at, pagos(fecha_pago, deleted_at)')
        .in('monto_id', chunk)
        .is('deleted_at', null);

      if (error || !data) continue;

      for (const row of data as DetalleHistoricoRaw[]) {
        const pagoRel = unwrapRel(row.pagos);
        if (pagoRel?.deleted_at) continue;
        const fechaStr = pagoRel?.fecha_pago || row.fecha_aplicacion || '';
        const fechaMs = fechaStr ? new Date(fechaStr).getTime() : 0;
        const lista = resultado.get(row.monto_id) ?? [];
        lista.push({
          id: row.id,
          montoAplicado: round2(Number(row.monto_aplicado ?? 0)),
          fechaMs,
        });
        resultado.set(row.monto_id, lista);
      }
    }

    for (const [montoId, lista] of resultado.entries()) {
      lista.sort((a, b) => (a.fechaMs !== b.fechaMs ? a.fechaMs - b.fechaMs : a.id - b.id));
      resultado.set(montoId, lista);
    }

    return resultado;
  }

  private async resolverNombresCajeros(ids: string[]): Promise<Map<string, string>> {
    const mapa = new Map<string, string>();
    const miPerfil = this.auth.perfil();
    if (miPerfil?.id) {
      mapa.set(miPerfil.id, miPerfil.nombres?.trim() || miPerfil.email || 'Operador Caja');
    }
    if (ids.length === 0) return mapa;

    try {
      const { data } = await this.db
        .from('perfiles')
        .select('id, nombres, email')
        .in('id', ids);

      for (const p of (data ?? []) as { id: string; nombres: string | null; email: string }[]) {
        mapa.set(p.id, p.nombres?.trim() || p.email || 'Operador Caja');
      }
    } catch {
      // Fallback resiliente cuando RLS limita lectura de otros perfiles
    }

    return mapa;
  }

  private async cargarNombresConceptos(): Promise<string[]> {
    try {
      const { data } = await this.db
        .from('conceptos')
        .select('nombre')
        .is('deleted_at', null)
        .order('nombre');
      return ((data ?? []) as { nombre: string }[])
        .map(c => c.nombre?.trim())
        .filter((n): n is string => Boolean(n));
    } catch {
      return [];
    }
  }

  private async cargarResumenCentralSeguro(
    desde: string,
    hasta: string,
  ): Promise<ResultadoReporteContable['resumenCentralOficial']> {
    try {
      const { data, error } = await this.db.rpc('rpc_reporte_resumen', {
        p_desde: desde,
        p_hasta: hasta,
        p_tipo_pagador: 'todos',
      });
      if (error || !data) return null;

      const raw = data as {
        caja?: {
          efectivo?: number;
          transferencia?: number;
          ingresos_internos?: number;
          recaudacion_tarjeta?: number;
          count_recibos?: number;
          count_internos?: number;
          count_recaudacion?: number;
          count_anulados?: number;
        };
        por_concepto?: { monto?: number }[];
      };

      const totalConceptos = round2(
        (raw.por_concepto ?? []).reduce((acc, item) => acc + Number(item.monto ?? 0), 0),
      );

      return {
        efectivo: round2(Number(raw.caja?.efectivo ?? 0)),
        transferencia: round2(Number(raw.caja?.transferencia ?? 0)),
        ingresosInternos: round2(Number(raw.caja?.ingresos_internos ?? 0)),
        recaudacionTarjeta: round2(Number(raw.caja?.recaudacion_tarjeta ?? 0)),
        totalConceptos,
        countRecibos: Number(raw.caja?.count_recibos ?? 0),
        countInternos: Number(raw.caja?.count_internos ?? 0),
        countRecaudacion: Number(raw.caja?.count_recaudacion ?? 0),
        countAnulados: Number(raw.caja?.count_anulados ?? 0),
      };
    } catch {
      return null;
    }
  }

  private formatearFechaLargaLima(fechaYmd: string): string {
    const partes = fechaYmd.split('-').map(Number);
    if (partes.length !== 3) return fechaYmd;
    const [y, m, d] = partes;
    const dt = new Date(Date.UTC(y, m - 1, d, 12, 0, 0));
    return new Intl.DateTimeFormat('es-PE', {
      timeZone: 'America/Lima',
      weekday: 'long',
      day: '2-digit',
      month: 'long',
      year: 'numeric',
    }).format(dt);
  }
}
