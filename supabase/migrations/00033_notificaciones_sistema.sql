-- =============================================================================
-- Migración 00033 — Sistema de Notificaciones Persistentes
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * notificaciones              — tabla append-only de eventos del sistema
--   * fn_notif_pago_anulado()     — trigger AFTER UPDATE ON pagos
--   * fn_notif_cargo_anulado()    — trigger AFTER UPDATE ON montos_por_cobrar
--   * fn_notif_stock_bajo()       — trigger AFTER INSERT ON inventario_movimientos
--
-- Las notificaciones NUNCA se eliminan físicamente (soft-delete vía leido=true).
-- Los triggers son SECURITY DEFINER → se ejecutan como el owner (postgres)
-- y bypasan RLS al insertar, sin necesitar grant INSERT para authenticated.
-- =============================================================================


-- =============================================================================
-- 1. TABLA notificaciones
-- =============================================================================
create table if not exists public.notificaciones (
    id          uuid            primary key default gen_random_uuid(),
    titulo      text            not null,
    mensaje     text            not null,
    tipo        text            not null
                                check (tipo in ('auditoria', 'inventario', 'morosidad', 'caja')),
    leido       boolean         not null default false,
    created_at  timestamptz     not null default now()
);

comment on table public.notificaciones is
    'Eventos del sistema para el panel de notificaciones del Header. '
    'Append-only: marcar como leído (leido=true) es el único cambio permitido.';

comment on column public.notificaciones.tipo is
    'auditoria=anulaciones críticas · inventario=stock bajo · '
    'morosidad=acumulación de deudas · caja=recordatorio de cierre diario';

create index if not exists idx_notificaciones_no_leidas
    on public.notificaciones (created_at desc)
    where leido = false;


-- =============================================================================
-- 2. RLS en notificaciones
-- =============================================================================
alter table public.notificaciones enable row level security;

-- Cualquier usuario autenticado puede ver notificaciones
drop policy if exists pol_notif_select on public.notificaciones;
create policy pol_notif_select on public.notificaciones
    for select to authenticated using (true);

-- Solo Administrador puede marcar como leídas
drop policy if exists pol_notif_update on public.notificaciones;
create policy pol_notif_update on public.notificaciones
    for update to authenticated
    using  (public.get_my_rol() in ('Administrador', 'Caja'))
    with check (public.get_my_rol() in ('Administrador', 'Caja'));

-- INSERT solo vía triggers SECURITY DEFINER (postgres bypasa RLS)
-- No se crea policy FOR INSERT → el frontend no puede insertar directamente.


-- =============================================================================
-- 3. TRIGGER: notificación al anular un PAGO
--    Disparo: AFTER UPDATE ON pagos, solo cuando deleted_at pasa de NULL a NOT NULL
-- =============================================================================
create or replace function public.fn_notif_pago_anulado()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
    if old.deleted_at is null and new.deleted_at is not null then
        insert into public.notificaciones (titulo, mensaje, tipo)
        values (
            'Pago Anulado',
            'Se anuló el pago #' || new.id::text
                || ' por S/ ' || to_char(new.monto_total, 'FM999,999,990.00')
                || '. Motivo: ' || coalesce(new.motivo_anulacion, 'Sin especificar'),
            'auditoria'
        );
    end if;
    return null;
end;
$$;

comment on function public.fn_notif_pago_anulado() is
    'Inserta una notificación de tipo auditoria cuando se anula un pago (soft-delete).';

drop trigger if exists tg_notif_pago_anulado on public.pagos;
create trigger tg_notif_pago_anulado
    after update on public.pagos
    for each row execute function public.fn_notif_pago_anulado();


-- =============================================================================
-- 4. TRIGGER: notificación al anular un CARGO (monto_por_cobrar)
--    Disparo: AFTER UPDATE ON montos_por_cobrar, solo soft-delete
-- =============================================================================
create or replace function public.fn_notif_cargo_anulado()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
    v_concepto text;
begin
    if old.deleted_at is null and new.deleted_at is not null then
        select nombre into v_concepto
        from   public.conceptos
        where  id = new.concepto_id;

        insert into public.notificaciones (titulo, mensaje, tipo)
        values (
            'Cargo Anulado',
            'Se anuló el cargo de ' || coalesce(v_concepto, 'Concepto #' || new.concepto_id::text)
                || ' por S/ ' || to_char(new.monto, 'FM999,999,990.00')
                || '. Motivo: ' || coalesce(new.motivo_anulacion, 'Sin especificar'),
            'auditoria'
        );
    end if;
    return null;
end;
$$;

comment on function public.fn_notif_cargo_anulado() is
    'Inserta una notificación de tipo auditoria cuando se anula un cargo (monto_por_cobrar soft-delete).';

drop trigger if exists tg_notif_cargo_anulado on public.montos_por_cobrar;
create trigger tg_notif_cargo_anulado
    after update on public.montos_por_cobrar
    for each row execute function public.fn_notif_cargo_anulado();


-- =============================================================================
-- 5. TRIGGER: notificación de STOCK BAJO en inventario
--    Disparo: AFTER INSERT ON inventario_movimientos (tras actualizar stock_actual
--    via tg_actualizar_stock BEFORE INSERT).
--    Solo para Salidas que dejen stock_actual ≤ max(2, stock_minimo).
--    Suprime duplicados: no emite si ya existe una notificación del mismo
--    producto en las últimas 24 horas.
-- =============================================================================
create or replace function public.fn_notif_stock_bajo()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
    v_prod record;
begin
    -- Solo reaccionar a salidas
    if new.tipo_movimiento != 'Salida' then
        return null;
    end if;

    -- Leer el stock actual (ya actualizado por tg_actualizar_stock BEFORE INSERT)
    select nombre, stock_actual, stock_minimo
    into   v_prod
    from   public.inventario_productos
    where  id = new.producto_id;

    -- Umbral crítico: 2 unidades físicas O por debajo del mínimo configurado
    if v_prod.stock_actual > 2 and v_prod.stock_actual > v_prod.stock_minimo then
        return null;
    end if;

    -- Deduplicación: evitar spam si ya se notificó en las últimas 24 horas
    if exists (
        select 1
        from   public.notificaciones
        where  tipo       = 'inventario'
          and  created_at >= now() - interval '24 hours'
          and  mensaje     like '%' || v_prod.nombre || '%'
    ) then
        return null;
    end if;

    insert into public.notificaciones (titulo, mensaje, tipo)
    values (
        'Stock Crítico',
        'El stock de "' || v_prod.nombre || '" está en '
            || v_prod.stock_actual::text || ' unidad(es)'
            || ' (mínimo configurado: ' || v_prod.stock_minimo::text || ').',
        'inventario'
    );

    return null;
end;
$$;

comment on function public.fn_notif_stock_bajo() is
    'Emite una notificación de tipo inventario cuando una Salida deja el stock_actual '
    'en ≤ 2 unidades o ≤ stock_minimo. Suprime duplicados dentro de 24 horas.';

drop trigger if exists tg_notif_stock_bajo on public.inventario_movimientos;
create trigger tg_notif_stock_bajo
    after insert on public.inventario_movimientos
    for each row execute function public.fn_notif_stock_bajo();


-- =============================================================================
-- 6. GRANTS
-- =============================================================================
-- authenticated puede leer y marcar como leído (UPDATE leido)
grant select, update (leido) on public.notificaciones to authenticated;
