-- =============================================================================
-- Migración 00002 — Personas (Socios + Inquilinos), Giros, Puestos e Historiales
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * giros                    (catálogo de giros comerciales)
--   * socios                   (titulares / dueños — padrón independiente)
--   * inquilinos               (posesionarios temporales — padrón independiente)
--   * puestos                  (unidades físicas del mercado)
--   * historial_titularidad    (relación socio ↔ puesto, append-only)
--   * historial_arriendos      (relación inquilino ↔ puesto, append-only)
--
-- Patrones aplicados (consistentes con 00001):
--   - Soft delete (deleted_at, anulado_por, motivo_anulacion) + CHECK de
--     consistencia (los tres NULL o los tres llenos) en TODAS las tablas base.
--   - Trigger updated_at en cada UPDATE.
--   - RLS habilitado: SELECT/INSERT/UPDATE para authenticated, DELETE bloqueado
--     a nivel de política (no existe ninguna policy FOR DELETE).
--   - Tablas de historial: append-only desde el dominio. Solo SE PUEDE cerrar
--     una fila vigente seteando fecha_fin (UPDATE permitido para eso). NO se
--     permite DELETE. Índices únicos parciales garantizan UNA fila activa por
--     puesto.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 0. Función updated_at (idempotente — ya existe desde 00001, se redefine safe)
-- -----------------------------------------------------------------------------
create or replace function public.tg_set_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at := now();
    return new;
end;
$$;


-- =============================================================================
-- 1. GIROS (catálogo)
-- =============================================================================
create table if not exists public.giros (
    id                  bigserial   primary key,
    nombre              text        not null unique,
    tarifa_agua_base    numeric(12,2) not null default 0 check (tarifa_agua_base >= 0),
    tarifa_luz_base     numeric(12,2) not null default 0 check (tarifa_luz_base  >= 0),
    activo              boolean     not null default true,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_giros_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.giros is
    'Catálogo de giros comerciales (abarrotes, comida, jugos, bazar, etc.) con tarifas base de luz y agua.';

drop trigger if exists trg_giros_set_updated_at on public.giros;
create trigger trg_giros_set_updated_at
    before update on public.giros
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 2. SOCIOS (padrón independiente — titulares / dueños)
-- =============================================================================
create table if not exists public.socios (
    id                  bigserial   primary key,
    dni                 text        not null unique,
    nombres             text        not null,
    apellidos           text        not null,
    direccion           text,
    telefono            text,
    email               text,
    fecha_ingreso       date        not null,

    estado              text        not null default 'Activo'
                                    check (estado in ('Activo', 'Inactivo')),
    habilitado          boolean     not null default true,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_socios_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.socios is
    'Padrón de socios titulares de la cooperativa. DNI único dentro de este padrón. estado=Inactivo no genera nuevos cobros; habilitado=false (Inhábil) no participa en asambleas.';
comment on column public.socios.habilitado is
    'TRUE = Hábil (sin deuda pendiente), FALSE = Inhábil. Se recalcula tras el cierre mensual.';

create index if not exists idx_socios_apellidos on public.socios (apellidos) where deleted_at is null;
create index if not exists idx_socios_estado    on public.socios (estado)    where deleted_at is null;

drop trigger if exists trg_socios_set_updated_at on public.socios;
create trigger trg_socios_set_updated_at
    before update on public.socios
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 3. INQUILINOS (padrón independiente — posesionarios temporales)
--    Solo datos personales. La relación con puesto/socio vive en historial_arriendos.
-- =============================================================================
create table if not exists public.inquilinos (
    id                  bigserial   primary key,
    dni                 text        not null unique,
    nombres             text        not null,
    apellidos           text        not null,
    direccion           text,
    telefono            text,
    email               text,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_inquilinos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.inquilinos is
    'Padrón de inquilinos / posesionarios temporales. DNI único dentro de este padrón (independiente del padrón de socios). NO heredan derechos de socio (no votan, no reciben remanentes), pero pueden pagar deudas del puesto que ocupan.';

create index if not exists idx_inquilinos_apellidos on public.inquilinos (apellidos) where deleted_at is null;

drop trigger if exists trg_inquilinos_set_updated_at on public.inquilinos;
create trigger trg_inquilinos_set_updated_at
    before update on public.inquilinos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 4. PUESTOS (unidades físicas del mercado)
-- =============================================================================
create table if not exists public.puestos (
    id                  bigserial   primary key,
    codigo_puesto       text        not null unique,
    giro_id             bigint      not null
                                    references public.giros(id)
                                    on update cascade
                                    on delete restrict,
    area_m2             numeric(8,2) check (area_m2 is null or area_m2 > 0),
    estado              text        not null default 'Activo'
                                    check (estado in ('Activo', 'Inactivo')),
    tiene_medidor_luz   boolean     not null default false,
    tiene_medidor_agua  boolean     not null default false,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_puestos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.puestos is
    'Unidades físicas del mercado. Las DEUDAS pertenecen al puesto (no al socio), permitiendo conservar el histórico aunque cambie el titular o el inquilino.';
comment on column public.puestos.tiene_medidor_luz is
    'Determina el método de cálculo de luz: true → Medidor/Artefactos, false → Amperaje.';

create index if not exists idx_puestos_giro    on public.puestos (giro_id) where deleted_at is null;
create index if not exists idx_puestos_estado  on public.puestos (estado)  where deleted_at is null;

drop trigger if exists trg_puestos_set_updated_at on public.puestos;
create trigger trg_puestos_set_updated_at
    before update on public.puestos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 5. HISTORIAL_TITULARIDAD (socio ↔ puesto, append-only)
--    Cada fila representa un período en que un socio fue titular de un puesto.
--    fecha_fin IS NULL ⇒ titularidad VIGENTE.
--    Solo puede haber UNA fila vigente por puesto (índice único parcial).
-- =============================================================================
create table if not exists public.historial_titularidad (
    id              bigserial   primary key,
    puesto_id       bigint      not null
                                references public.puestos(id)
                                on update cascade on delete restrict,
    socio_id        bigint      not null
                                references public.socios(id)
                                on update cascade on delete restrict,
    fecha_inicio    date        not null,
    fecha_fin       date,
    motivo_cambio   text,

    created_at      timestamptz not null default now(),
    updated_at      timestamptz not null default now(),
    created_by      uuid        references auth.users(id) on delete set null,

    constraint chk_titularidad_fechas
        check (fecha_fin is null or fecha_fin >= fecha_inicio)
);

comment on table public.historial_titularidad is
    'Append-only. Historial de titularidades socio↔puesto. Para cerrar un período se hace UPDATE de fecha_fin. NUNCA se hace DELETE. La fila con fecha_fin IS NULL es la titularidad vigente.';

create unique index if not exists idx_titularidad_vigente_unica_por_puesto
    on public.historial_titularidad (puesto_id)
    where fecha_fin is null;

create index if not exists idx_titularidad_socio  on public.historial_titularidad (socio_id);
create index if not exists idx_titularidad_puesto on public.historial_titularidad (puesto_id);

drop trigger if exists trg_titularidad_set_updated_at on public.historial_titularidad;
create trigger trg_titularidad_set_updated_at
    before update on public.historial_titularidad
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 6. HISTORIAL_ARRIENDOS (inquilino ↔ puesto, append-only)
--    Cada fila representa un período en que un inquilino ocupó un puesto.
--    Guarda también socio_titular_id (quién era el dueño en ese momento) para
--    contexto histórico, aunque cambie luego.
-- =============================================================================
create table if not exists public.historial_arriendos (
    id                  bigserial   primary key,
    puesto_id           bigint      not null
                                    references public.puestos(id)
                                    on update cascade on delete restrict,
    inquilino_id        bigint      not null
                                    references public.inquilinos(id)
                                    on update cascade on delete restrict,
    socio_titular_id    bigint      not null
                                    references public.socios(id)
                                    on update cascade on delete restrict,
    fecha_inicio        date        not null,
    fecha_fin           date,
    monto_arriendo      numeric(12,2) check (monto_arriendo is null or monto_arriendo >= 0),
    motivo_termino      text,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    constraint chk_arriendos_fechas
        check (fecha_fin is null or fecha_fin >= fecha_inicio)
);

comment on table public.historial_arriendos is
    'Append-only. Historial de arriendos inquilino↔puesto. Para cerrar un arriendo se hace UPDATE de fecha_fin. NUNCA se hace DELETE. La fila con fecha_fin IS NULL es el arriendo vigente.';

create unique index if not exists idx_arriendo_vigente_unico_por_puesto
    on public.historial_arriendos (puesto_id)
    where fecha_fin is null;

create index if not exists idx_arriendos_inquilino on public.historial_arriendos (inquilino_id);
create index if not exists idx_arriendos_puesto    on public.historial_arriendos (puesto_id);
create index if not exists idx_arriendos_socio     on public.historial_arriendos (socio_titular_id);

drop trigger if exists trg_arriendos_set_updated_at on public.historial_arriendos;
create trigger trg_arriendos_set_updated_at
    before update on public.historial_arriendos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 7. ROW LEVEL SECURITY
--    Política base: SELECT/INSERT/UPDATE para authenticated, DELETE bloqueado
--    estructuralmente (no existe ninguna policy FOR DELETE → PostgreSQL niega).
--    Refinar por rol (admin/cajero/auditor) en una migración posterior.
-- =============================================================================
alter table public.giros                  enable row level security;
alter table public.socios                 enable row level security;
alter table public.inquilinos             enable row level security;
alter table public.puestos                enable row level security;
alter table public.historial_titularidad  enable row level security;
alter table public.historial_arriendos    enable row level security;


-- ---- giros ----
drop policy if exists pol_giros_select on public.giros;
create policy pol_giros_select on public.giros
    for select to authenticated using (true);

drop policy if exists pol_giros_insert on public.giros;
create policy pol_giros_insert on public.giros
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_giros_update on public.giros;
create policy pol_giros_update on public.giros
    for update to authenticated using (true) with check (true);


-- ---- socios ----
drop policy if exists pol_socios_select on public.socios;
create policy pol_socios_select on public.socios
    for select to authenticated using (true);

drop policy if exists pol_socios_insert on public.socios;
create policy pol_socios_insert on public.socios
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_socios_update on public.socios;
create policy pol_socios_update on public.socios
    for update to authenticated using (true) with check (true);


-- ---- inquilinos ----
drop policy if exists pol_inquilinos_select on public.inquilinos;
create policy pol_inquilinos_select on public.inquilinos
    for select to authenticated using (true);

drop policy if exists pol_inquilinos_insert on public.inquilinos;
create policy pol_inquilinos_insert on public.inquilinos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_inquilinos_update on public.inquilinos;
create policy pol_inquilinos_update on public.inquilinos
    for update to authenticated using (true) with check (true);


-- ---- puestos ----
drop policy if exists pol_puestos_select on public.puestos;
create policy pol_puestos_select on public.puestos
    for select to authenticated using (true);

drop policy if exists pol_puestos_insert on public.puestos;
create policy pol_puestos_insert on public.puestos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_puestos_update on public.puestos;
create policy pol_puestos_update on public.puestos
    for update to authenticated using (true) with check (true);


-- ---- historial_titularidad ----
drop policy if exists pol_titularidad_select on public.historial_titularidad;
create policy pol_titularidad_select on public.historial_titularidad
    for select to authenticated using (true);

drop policy if exists pol_titularidad_insert on public.historial_titularidad;
create policy pol_titularidad_insert on public.historial_titularidad
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_titularidad_update on public.historial_titularidad;
create policy pol_titularidad_update on public.historial_titularidad
    for update to authenticated using (true) with check (true);


-- ---- historial_arriendos ----
drop policy if exists pol_arriendos_select on public.historial_arriendos;
create policy pol_arriendos_select on public.historial_arriendos
    for select to authenticated using (true);

drop policy if exists pol_arriendos_insert on public.historial_arriendos;
create policy pol_arriendos_insert on public.historial_arriendos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_arriendos_update on public.historial_arriendos;
create policy pol_arriendos_update on public.historial_arriendos
    for update to authenticated using (true) with check (true);


-- =============================================================================
-- DELETE: ninguna política FOR DELETE en NINGUNA tabla.
--         PostgreSQL deniega por defecto si no existe policy → soft delete forzado.
-- =============================================================================
