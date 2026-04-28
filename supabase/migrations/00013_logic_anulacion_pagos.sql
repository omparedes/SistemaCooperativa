-- =============================================================================
-- Migración 00013 — Lógica de Anulación de Pagos
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * anular_pago(p_pago_id bigint, p_motivo text, p_usuario_id uuid) → jsonb
--     · Valida que el pago exista y no esté ya anulado.
--     · Soft-delete en pagos (deleted_at + anulado_por + motivo_anulacion).
--     · Soft-delete en cada detalle_pago del mismo pago.
--     · Recalcula estado de montos_por_cobrar afectados:
--         'Pagado'    si otros pagos vigentes aún cubren el monto completo.
--         'Pendiente' en cualquier otro caso (parcial o sin cobertura).
--     · Registra en auditoria si la tabla existe (usa EXECUTE dinámico para
--       no fallar en migraciones previas a la creación de esa tabla).
-- =============================================================================

create or replace function public.anular_pago(
  p_pago_id    bigint,
  p_motivo     text,
  p_usuario_id uuid
)
returns jsonb
language plpgsql
as $$
declare
  v_pago            record;
  v_detalle         record;
  v_ya_pagado       numeric(12,2);
  v_nuevo_estado    text;
  v_tabla_auditoria boolean := false;
begin

  -- ── 1. Validaciones ──────────────────────────────────────────────────────────
  if p_motivo is null or trim(p_motivo) = '' then
    raise exception 'El motivo de anulación no puede estar vacío.';
  end if;

  select * into v_pago from public.pagos where id = p_pago_id;
  if not found then
    raise exception 'Pago % no encontrado.', p_pago_id;
  end if;
  if v_pago.deleted_at is not null then
    raise exception 'El pago % ya está anulado.', p_pago_id;
  end if;

  -- ── 2. Soft-delete del pago ──────────────────────────────────────────────────
  update public.pagos
  set
    deleted_at       = now(),
    anulado_por      = p_usuario_id,
    motivo_anulacion = p_motivo
  where id = p_pago_id;

  -- ── 3. Soft-delete de detalles y restauración de estados de montos ───────────
  for v_detalle in
    select id, monto_id
    from   public.detalle_pagos
    where  pago_id    = p_pago_id
      and  deleted_at is null
  loop
    -- Anular el detalle
    update public.detalle_pagos
    set
      deleted_at       = now(),
      anulado_por      = p_usuario_id,
      motivo_anulacion = p_motivo
    where id = v_detalle.id;

    -- Suma de lo que queda pagado para este monto (excluyendo el detalle recién anulado)
    select coalesce(sum(dp.monto_aplicado), 0)
    into   v_ya_pagado
    from   public.detalle_pagos dp
    where  dp.monto_id  = v_detalle.monto_id
      and  dp.deleted_at is null;

    -- Nuevo estado: 'Pagado' solo si otro pago vigente cubre el total
    select case
             when v_ya_pagado >= m.monto then 'Pagado'
             else 'Pendiente'
           end
    into   v_nuevo_estado
    from   public.montos_por_cobrar m
    where  m.id = v_detalle.monto_id;

    -- Actualizar (nunca tocar montos Cancelado por admin ni ya eliminados)
    update public.montos_por_cobrar
    set    estado = v_nuevo_estado
    where  id         = v_detalle.monto_id
      and  estado    != 'Cancelado'
      and  deleted_at is null;
  end loop;

  -- ── 4. Auditoría (graceful — tabla puede no existir aún) ────────────────────
  select exists (
    select 1
    from   information_schema.tables
    where  table_schema = 'public'
      and  table_name   = 'auditoria'
  ) into v_tabla_auditoria;

  if v_tabla_auditoria then
    begin
      execute
        'insert into public.auditoria
           (tabla_afectada, registro_id, accion, valor_anterior, valor_nuevo, usuario_id)
         values ($1, $2, $3, $4, $5, $6)'
      using
        'pagos',
        p_pago_id::text,
        'Anular',
        '{"deleted_at":null,"motivo_anulacion":null}'::jsonb,
        jsonb_build_object(
          'deleted_at',       now(),
          'motivo_anulacion', p_motivo,
          'anulado_por',      p_usuario_id::text
        ),
        p_usuario_id;
    exception when others then
      raise warning 'anular_pago: no se pudo insertar en auditoría: %', sqlerrm;
    end;
  end if;

  -- ── 5. Retorno ───────────────────────────────────────────────────────────────
  return jsonb_build_object(
    'ok',      true,
    'pago_id', p_pago_id,
    'mensaje', 'Pago anulado correctamente.'
  );

end;
$$;

comment on function public.anular_pago(bigint, text, uuid) is
  'Anula un pago aplicando soft-delete en pagos y detalle_pagos, restaura el estado '
  'de los montos_por_cobrar afectados a Pendiente/Pagado según cobertura restante, '
  'y registra la acción en la tabla auditoria si existe. '
  'Levanta excepción si el pago no existe o ya fue anulado previamente.';

-- Cualquier usuario autenticado puede invocar la función;
-- el control de rol Administrador se aplica en el frontend y en futuras RLS.
grant execute on function public.anular_pago(bigint, text, uuid) to authenticated;
