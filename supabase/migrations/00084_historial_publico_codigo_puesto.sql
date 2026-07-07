-- =============================================================================
-- Migración 00084 — rpc_public_obtener_historial: codigo_puesto por línea
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Paridad con el panel administrativo (PagosService.obtenerHistorialPorPagador,
-- actualizado junto a 00082/00083): cada línea del detalle del historial
-- público incluye ahora `codigo_puesto` — el espacio al que pertenece el cargo
-- pagado (null para cargos personales sin puesto). Así la reimpresión de
-- recibos desde el portal de consultas distingue "Deposito · DEPOSITO 6-D2"
-- igual que Caja y Padrón.
--
-- Cambio puramente additivo sobre la definición de 00015: un LEFT JOIN a
-- puestos vía montos_por_cobrar.puesto_id y la clave nueva en el JSON.
-- No devuelve PII (sin cambios respecto al criterio de 00047).
-- =============================================================================

BEGIN;

create or replace function public.rpc_public_obtener_historial(p_id bigint, p_tipo text)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_result json;
begin
    if p_tipo not in ('socio', 'inquilino') then
        raise exception 'Tipo inválido: %. Valores aceptados: socio, inquilino.', p_tipo;
    end if;

    select coalesce(
        json_agg(pago_obj order by fecha_pago desc),
        '[]'::json
    )
    into v_result
    from (
        select
            p.fecha_pago,
            json_build_object(
                'id',               p.id,
                'codigo_transaccion', p.codigo_transaccion,
                'fecha_pago',       p.fecha_pago,
                'monto_total',      p.monto_total,
                'metodo_pago',      p.metodo_pago,
                'comprobante',      p.comprobante,
                'codigo_puesto',    coalesce(pu.codigo_puesto, '—'),
                'anulado',          (p.deleted_at is not null),
                'motivo_anulacion', p.motivo_anulacion,
                'deleted_at',       p.deleted_at,
                'detalle', (
                    select coalesce(
                        json_agg(
                            json_build_object(
                                'monto_aplicado', dp.monto_aplicado,
                                'concepto',       coalesce(c.nombre, 'Concepto eliminado'),
                                'codigo_puesto',  pm.codigo_puesto,
                                'periodo_anio',   coalesce(m.periodo_anio, 0),
                                'periodo_mes',    coalesce(m.periodo_mes,  0),
                                'monto_original', coalesce(m.monto, dp.monto_aplicado)
                            )
                        ),
                        '[]'::json
                    )
                    from public.detalle_pagos dp
                    left join public.montos_por_cobrar m on m.id = dp.monto_id
                    left join public.conceptos c         on c.id = m.concepto_id
                    left join public.puestos pm          on pm.id = m.puesto_id
                    where dp.pago_id = p.id
                      -- Para pagos anulados: mostrar todos los detalles (incluye soft-deleted)
                      -- Para pagos vigentes: solo detalles activos
                      and (p.deleted_at is not null or dp.deleted_at is null)
                )
            ) as pago_obj
        from public.pagos p
        left join public.puestos pu on pu.id = p.puesto_id
        where (
            case
                when p_tipo = 'socio'     then p.socio_id     = p_id
                when p_tipo = 'inquilino' then p.inquilino_id = p_id
            end
        )
        order by p.fecha_pago desc
        limit 200
    ) pagos_con_detalle;

    return v_result;
end;
$$;

comment on function public.rpc_public_obtener_historial(bigint, text) is
    'Portal público: historial de pagos de un socio o inquilino, incluyendo anulados. '
    'SECURITY DEFINER — bypasea RLS de solo lectura para uso anon. '
    'p_tipo acepta: socio | inquilino. Cada línea del detalle incluye codigo_puesto '
    'del espacio al que pertenece el cargo (paridad con el panel admin). (00015 → 00084)';

grant execute on function public.rpc_public_obtener_historial(bigint, text) to anon;
grant execute on function public.rpc_public_obtener_historial(bigint, text) to authenticated;

COMMIT;
