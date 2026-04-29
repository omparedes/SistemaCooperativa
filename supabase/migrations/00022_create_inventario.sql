-- =============================================================================
-- Migración 00022 — Módulo de Almacén Interno (Inventario)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * inventario_productos   — catálogo de ítems del almacén
--   * inventario_movimientos — registro append-only de entradas y salidas
--   * tg_actualizar_stock    — trigger BEFORE INSERT que mantiene stock_actual
--                              y bloquea salidas que dejarían stock negativo.
--   * RLS en ambas tablas
-- =============================================================================


-- =============================================================================
-- 1. inventario_productos
-- =============================================================================
create table if not exists public.inventario_productos (
    id              bigserial           primary key,
    codigo          text                not null unique,
    nombre          text                not null,
    categoria       text,
    unidad_medida   text                not null default 'Unidad',
    stock_actual    numeric(12,3)       not null default 0 check (stock_actual >= 0),
    stock_minimo    numeric(12,3)       not null default 0 check (stock_minimo >= 0),
    estado          text                not null default 'Activo'
                                        check (estado in ('Activo', 'Inactivo')),
    created_at      timestamptz         not null default now(),
    updated_at      timestamptz         not null default now(),
    created_by      uuid                references auth.users(id) on delete set null
);

comment on table public.inventario_productos is
    'Catálogo de productos del almacén interno. stock_actual se actualiza '
    'automáticamente mediante el trigger tg_actualizar_stock.';
comment on column public.inventario_productos.stock_actual is
    'Mantenido por el trigger: nunca modificar directamente desde el frontend.';

create index if not exists idx_inventario_estado
    on public.inventario_productos (estado)
    where estado = 'Activo';

drop trigger if exists trg_inventario_productos_updated_at on public.inventario_productos;
create trigger trg_inventario_productos_updated_at
    before update on public.inventario_productos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 2. inventario_movimientos
-- =============================================================================
create table if not exists public.inventario_movimientos (
    id                  bigserial       primary key,

    producto_id         bigint          not null
                                        references public.inventario_productos(id)
                                        on update cascade on delete restrict,

    tipo_movimiento     text            not null
                                        check (tipo_movimiento in ('Entrada', 'Salida')),
    cantidad            numeric(12,3)   not null check (cantidad > 0),
    responsable         text,
    observacion         text,
    fecha               date            not null,

    created_at          timestamptz     not null default now(),
    created_by          uuid            references auth.users(id) on delete set null
);

comment on table public.inventario_movimientos is
    'Registro append-only de movimientos del almacén. Cada INSERT dispara '
    'tg_actualizar_stock que ajusta inventario_productos.stock_actual.';

create index if not exists idx_inv_mov_producto_fecha
    on public.inventario_movimientos (producto_id, fecha desc);

create index if not exists idx_inv_mov_fecha
    on public.inventario_movimientos (fecha desc);


-- =============================================================================
-- 3. Trigger BEFORE INSERT: validar y actualizar stock atomicamente
--    SECURITY DEFINER → puede escribir en inventario_productos desde cualquier rol.
--    FOR UPDATE en el SELECT → bloqueo exclusivo de fila para evitar
--    condiciones de carrera entre movimientos concurrentes del mismo producto.
-- =============================================================================
create or replace function public.tg_actualizar_stock()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
    v_stock_actual numeric(12,3);
begin
    -- Bloqueo exclusivo de fila para atomicidad bajo concurrencia
    select stock_actual into v_stock_actual
    from public.inventario_productos
    where id = NEW.producto_id
    for update;

    if not found then
        raise exception 'Producto % no encontrado en el catálogo.', NEW.producto_id;
    end if;

    if NEW.tipo_movimiento = 'Salida' then
        if v_stock_actual < NEW.cantidad then
            raise exception
                'Stock insuficiente para el movimiento de Salida. '
                'Stock actual: %, cantidad solicitada: %.',
                v_stock_actual, NEW.cantidad;
        end if;
        update public.inventario_productos
        set stock_actual = stock_actual - NEW.cantidad
        where id = NEW.producto_id;
    else
        -- Entrada: siempre permitida
        update public.inventario_productos
        set stock_actual = stock_actual + NEW.cantidad
        where id = NEW.producto_id;
    end if;

    return NEW;
end;
$$;

comment on function public.tg_actualizar_stock() is
    'Trigger BEFORE INSERT en inventario_movimientos. '
    'Bloquea filas con FOR UPDATE para atomicidad. '
    'Lanza EXCEPTION si una Salida deja stock_actual < 0.';

drop trigger if exists trg_actualizar_stock on public.inventario_movimientos;
create trigger trg_actualizar_stock
    before insert on public.inventario_movimientos
    for each row execute function public.tg_actualizar_stock();


-- =============================================================================
-- 4. RLS
-- =============================================================================
alter table public.inventario_productos    enable row level security;
alter table public.inventario_movimientos  enable row level security;

-- ── inventario_productos ──────────────────────────────────────────────────────
drop policy if exists pol_inv_prod_select on public.inventario_productos;
create policy pol_inv_prod_select on public.inventario_productos
    for select to authenticated using (true);

drop policy if exists pol_inv_prod_insert on public.inventario_productos;
create policy pol_inv_prod_insert on public.inventario_productos
    for insert to authenticated
    with check (public.get_my_rol() = 'Administrador' and created_by = auth.uid());

drop policy if exists pol_inv_prod_update on public.inventario_productos;
create policy pol_inv_prod_update on public.inventario_productos
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');

-- ── inventario_movimientos ────────────────────────────────────────────────────
drop policy if exists pol_inv_mov_select on public.inventario_movimientos;
create policy pol_inv_mov_select on public.inventario_movimientos
    for select to authenticated using (true);

drop policy if exists pol_inv_mov_insert on public.inventario_movimientos;
create policy pol_inv_mov_insert on public.inventario_movimientos
    for insert to authenticated
    with check (
        public.get_my_rol() in ('Administrador', 'Caja')
        and created_by = auth.uid()
    );

-- DELETE: ninguna policy → PostgreSQL deniega (movimientos son append-only).


-- =============================================================================
-- 5. Seed: productos de ejemplo
-- =============================================================================
insert into public.inventario_productos (codigo, nombre, categoria, unidad_medida, stock_actual, stock_minimo)
values
    ('LMP-001', 'Detergente Industrial 5Kg',  'Limpieza',   'Bolsa',   15,  5),
    ('PAP-001', 'Papel Bond A4 (resma)',       'Papelería',  'Resma',    3, 10),
    ('LMP-002', 'Escobas',                     'Limpieza',   'Unidad',   4,  3),
    ('LMP-003', 'Bolsas de basura x100',       'Limpieza',   'Paquete', 50, 20),
    ('FER-001', 'Foco LED 18W',                'Ferretería', 'Unidad',   6,  5)
on conflict (codigo) do nothing;
