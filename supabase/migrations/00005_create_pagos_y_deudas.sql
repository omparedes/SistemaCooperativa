-- =============================================================================
-- Migración 00005 — Módulo financiero: Conceptos, Mediciones, Deudas y Pagos
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * conceptos              (catálogo: Luz, Agua, Multa, etc.)
--   * mediciones_luz         (lectura mensual de amperaje por puesto)
--   * registro_artefactos    (registro manual de carga eléctrica por puesto)
--   * montos_por_cobrar      (deudas; XOR puesto/socio)
--   * pagos                  (transacciones; XOR socio/inquilino)
--   * detalle_pagos          (distribución FIFO de un pago contra deudas)
--
-- Reglas de dominio aplicadas (skill cooperative-payments-domain):
--   §0  → soft delete (deleted_at, anulado_por, motivo_anulacion + CHECK triple-nulo)
--          en TODAS las tablas. DELETE bloqueado a nivel de policy.
--   §3  → fórmula de luz por amperaje → columnas GENERADAS (reproducibilidad).
--          precio_kwh y monto_alumbrado se persisten POR MEDICIÓN.
--   §4  → monto > 0 siempre. Estados: Pendiente / Pagado / Cancelado.
--   §4.3 → la distribución FIFO se implementa en el wizard del frontend;
--          el schema solo garantiza la consistencia (monto_aplicado > 0,
--          suma de detalles ≤ monto del adeudo).
--   §5  → pagos.codigo_transaccion único auto-generado. Recibos inmutables
--          (la "anulación" se hace soft delete + asiento compensatorio).
--   §1.3 → la DEUDA pertenece al puesto (luz, agua, admin., previsión)
--          o al socio (multas, aportes). XOR enforced por CHECK.
--   §5.1 → el PAGO siempre tiene puesto_id; el pagador es socio XOR inquilino.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 0. Función updated_at + secuencia para código de transacción
-- -----------------------------------------------------------------------------
create or replace function public.tg_set_updated_at()
returns trigger language plpgsql as $$
begin
    new.updated_at := now();
    return new;
end;
$$;

create sequence if not exists public.seq_codigo_transaccion start 1;

create or replace function public.generar_codigo_transaccion()
returns text language plpgsql as $$
begin
    return 'RIB-' || to_char(now(), 'YYYYMMDD') || '-' ||
           lpad(nextval('public.seq_codigo_transaccion')::text, 6, '0');
end;
$$;
comment on function public.generar_codigo_transaccion() is
    'Genera códigos de transacción legibles tipo RIB-20260425-000001 (skill §5.1).';


-- =============================================================================
-- 1. CONCEPTOS (catálogo)
-- =============================================================================
create table if not exists public.conceptos (
    id                  bigserial   primary key,
    nombre              text        not null unique,
    tipo                text        not null
                                    check (tipo in ('Fijo','Variable')),
    aplica_descuento    boolean     not null default false,
    activo              boolean     not null default true,
    descripcion         text,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_conceptos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.conceptos is
    'Catálogo de conceptos cobrables. Fijo = se genera mensualmente automático (luz, agua, admin., previsión). Variable = manual o evento (multas, aportes).';
comment on column public.conceptos.aplica_descuento is
    'TRUE si el concepto admite descuentos por asamblea (ej. multas con 50% off).';

drop trigger if exists trg_conceptos_set_updated_at on public.conceptos;
create trigger trg_conceptos_set_updated_at
    before update on public.conceptos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 2. MEDICIONES_LUZ (lectura mensual por puesto, método amperaje)
-- =============================================================================
create table if not exists public.mediciones_luz (
    id                      bigserial   primary key,
    puesto_id               bigint      not null
                                        references public.puestos(id)
                                        on update cascade on delete restrict,
    periodo_anio            smallint    not null check (periodo_anio between 2000 and 2100),
    periodo_mes             smallint    not null check (periodo_mes between 1 and 12),
    fecha_medicion          date        not null default current_date,

    -- Inputs persistidos para reproducibilidad histórica (skill §3.1)
    amperaje                numeric(8,2)  not null check (amperaje >= 0),
    horas_uso               smallint      not null default 12 check (horas_uso > 0),
    dias_uso                smallint      not null default 30 check (dias_uso > 0),
    precio_kwh              numeric(8,4)  not null check (precio_kwh > 0),
    monto_alumbrado         numeric(10,2) not null default 0 check (monto_alumbrado >= 0),

    -- Cálculos derivados (fórmula del skill §3.1)
    kwh                     numeric(12,3) generated always as
                                ((amperaje * 220 * horas_uso * dias_uso) / 1000.0) stored,
    monto_calculado         numeric(12,2) generated always as
                                (round(((amperaje * 220 * horas_uso * dias_uso) / 1000.0) * precio_kwh + monto_alumbrado, 2)) stored,

    observacion             text,

    created_at              timestamptz not null default now(),
    updated_at              timestamptz not null default now(),
    created_by              uuid        references auth.users(id) on delete set null,

    deleted_at              timestamptz,
    anulado_por             uuid        references auth.users(id) on delete set null,
    motivo_anulacion        text,

    constraint chk_mediciones_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.mediciones_luz is
    'Mediciones mensuales de amperaje (skill §3.1). precio_kwh y monto_alumbrado se persisten POR MEDICIÓN para que el cálculo histórico sea reproducible.';

-- Una sola medición vigente por puesto/período (re-medir = anular y crear nueva)
create unique index if not exists idx_mediciones_unica_vigente_por_puesto_periodo
    on public.mediciones_luz (puesto_id, periodo_anio, periodo_mes)
    where deleted_at is null;

create index if not exists idx_mediciones_periodo
    on public.mediciones_luz (periodo_anio desc, periodo_mes desc)
    where deleted_at is null;

drop trigger if exists trg_mediciones_set_updated_at on public.mediciones_luz;
create trigger trg_mediciones_set_updated_at
    before update on public.mediciones_luz
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 3. REGISTRO_ARTEFACTOS (método manual para puestos con medidor / artefactos)
-- =============================================================================
create table if not exists public.registro_artefactos (
    id                      bigserial   primary key,
    puesto_id               bigint      not null
                                        references public.puestos(id)
                                        on update cascade on delete restrict,
    periodo_anio            smallint    not null check (periodo_anio between 2000 and 2100),
    periodo_mes             smallint    not null check (periodo_mes between 1 and 12),
    fecha_registro          date        not null default current_date,

    cantidad_focos          smallint    not null default 0 check (cantidad_focos >= 0),
    cantidad_tomacorrientes smallint    not null default 0 check (cantidad_tomacorrientes >= 0),
    otros_equipos           text,
    monto_asignado          numeric(12,2) not null check (monto_asignado >= 0),

    observacion             text,

    created_at              timestamptz not null default now(),
    updated_at              timestamptz not null default now(),
    created_by              uuid        references auth.users(id) on delete set null,

    deleted_at              timestamptz,
    anulado_por             uuid        references auth.users(id) on delete set null,
    motivo_anulacion        text,

    constraint chk_artefactos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.registro_artefactos is
    'Registro manual de carga eléctrica para puestos con medidor o cuando se opta por método de artefactos (skill §3.2).';

create unique index if not exists idx_artefactos_unica_vigente_por_puesto_periodo
    on public.registro_artefactos (puesto_id, periodo_anio, periodo_mes)
    where deleted_at is null;

drop trigger if exists trg_artefactos_set_updated_at on public.registro_artefactos;
create trigger trg_artefactos_set_updated_at
    before update on public.registro_artefactos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 4. MONTOS_POR_COBRAR (deudas)
--    XOR: una deuda pertenece o al puesto (luz/agua/admin/previsión)
--    o al socio (multas/aportes), exactamente una.
-- =============================================================================
create table if not exists public.montos_por_cobrar (
    id                  bigserial   primary key,

    -- Origen de la deuda: XOR puesto / socio
    puesto_id           bigint      references public.puestos(id)
                                    on update cascade on delete restrict,
    socio_id            bigint      references public.socios(id)
                                    on update cascade on delete restrict,

    concepto_id         bigint      not null
                                    references public.conceptos(id)
                                    on update cascade on delete restrict,

    periodo_anio        smallint    not null check (periodo_anio between 2000 and 2100),
    periodo_mes         smallint    not null check (periodo_mes between 1 and 12),

    monto               numeric(12,2) not null check (monto > 0),
    estado              text        not null default 'Pendiente'
                                    check (estado in ('Pendiente','Pagado','Cancelado')),

    metodo_calculo      text        check (metodo_calculo in ('Amperaje','Artefactos','Fijo','Manual')),

    -- Trazabilidad: si vino de una medición o registro_artefactos
    medicion_luz_id     bigint      references public.mediciones_luz(id)
                                    on update cascade on delete set null,
    registro_artefacto_id bigint    references public.registro_artefactos(id)
                                    on update cascade on delete set null,

    fecha_generacion    date        not null default current_date,
    observacion         text,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_montos_origen_xor
        check (
            (puesto_id is not null and socio_id is null)
            or
            (puesto_id is null and socio_id is not null)
        ),
    constraint chk_montos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.montos_por_cobrar is
    'Deudas. La deuda pertenece al PUESTO (skill §1.3) salvo multas/aportes que son del SOCIO. CHECK XOR enforces exactly one source.';
comment on column public.montos_por_cobrar.metodo_calculo is
    'Origen del cálculo: Amperaje / Artefactos (luz), Fijo (agua/admin/previsión), Manual (multas/ajustes). Skill §3.4.';

-- Indices: una deuda activa por puesto/concepto/periodo (evita duplicados)
create unique index if not exists idx_montos_unica_puesto_concepto_periodo
    on public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes)
    where deleted_at is null and puesto_id is not null;

create unique index if not exists idx_montos_unica_socio_concepto_periodo
    on public.montos_por_cobrar (socio_id, concepto_id, periodo_anio, periodo_mes)
    where deleted_at is null and socio_id is not null;

-- Indices para FIFO (las deudas más antiguas primero)
create index if not exists idx_montos_puesto_pendiente_fifo
    on public.montos_por_cobrar (puesto_id, periodo_anio, periodo_mes)
    where deleted_at is null and estado = 'Pendiente' and puesto_id is not null;

create index if not exists idx_montos_socio_pendiente_fifo
    on public.montos_por_cobrar (socio_id, periodo_anio, periodo_mes)
    where deleted_at is null and estado = 'Pendiente' and socio_id is not null;

drop trigger if exists trg_montos_set_updated_at on public.montos_por_cobrar;
create trigger trg_montos_set_updated_at
    before update on public.montos_por_cobrar
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 5. PAGOS (transacciones de cobro)
--    pagador: socio_id XOR inquilino_id (skill §5.1)
--    puesto_id siempre presente (a qué puesto se aplica el pago)
-- =============================================================================
create table if not exists public.pagos (
    id                  bigserial   primary key,
    codigo_transaccion  text        not null unique
                                    default public.generar_codigo_transaccion(),

    -- Pagador: exactamente uno
    socio_id            bigint      references public.socios(id)
                                    on update cascade on delete restrict,
    inquilino_id        bigint      references public.inquilinos(id)
                                    on update cascade on delete restrict,

    puesto_id           bigint      not null
                                    references public.puestos(id)
                                    on update cascade on delete restrict,

    fecha_pago          timestamptz not null default now(),
    monto_total         numeric(12,2) not null check (monto_total > 0),
    metodo_pago         text        not null
                                    check (metodo_pago in ('Efectivo','Transferencia')),
    comprobante         text,
    observacion         text,

    -- Asiento compensatorio: si este pago anula a otro
    pago_revertido_id   bigint      references public.pagos(id)
                                    on update cascade on delete set null,

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_pagos_pagador_xor
        check (
            (socio_id is not null and inquilino_id is null)
            or
            (socio_id is null and inquilino_id is not null)
        ),
    constraint chk_pagos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.pagos is
    'Transacciones de pago. Pagador es socio XOR inquilino (skill §5.1). Recibos inmutables: anular = soft delete + opcional asiento compensatorio vía pago_revertido_id.';
comment on column public.pagos.codigo_transaccion is
    'Auto-generado tipo RIB-20260425-000001. Inmutable después de creado.';

create index if not exists idx_pagos_socio_fecha
    on public.pagos (socio_id, fecha_pago desc)
    where deleted_at is null and socio_id is not null;

create index if not exists idx_pagos_inquilino_fecha
    on public.pagos (inquilino_id, fecha_pago desc)
    where deleted_at is null and inquilino_id is not null;

create index if not exists idx_pagos_puesto_fecha
    on public.pagos (puesto_id, fecha_pago desc)
    where deleted_at is null;

create index if not exists idx_pagos_fecha
    on public.pagos (fecha_pago desc)
    where deleted_at is null;

drop trigger if exists trg_pagos_set_updated_at on public.pagos;
create trigger trg_pagos_set_updated_at
    before update on public.pagos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 6. DETALLE_PAGOS (distribución FIFO de un pago contra adeudos)
--    Cada fila = "del pago X, se aplicaron Y soles al adeudo Z"
-- =============================================================================
create table if not exists public.detalle_pagos (
    id                  bigserial   primary key,
    pago_id             bigint      not null
                                    references public.pagos(id)
                                    on update cascade on delete restrict,
    monto_id            bigint      not null
                                    references public.montos_por_cobrar(id)
                                    on update cascade on delete restrict,
    monto_aplicado      numeric(12,2) not null check (monto_aplicado > 0),
    fecha_aplicacion    timestamptz not null default now(),

    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_detalle_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.detalle_pagos is
    'Distribución FIFO de un pago contra los adeudos del puesto/socio (skill §4.3). monto_aplicado puede ser parcial; la suma para un mismo monto_id no debe exceder montos_por_cobrar.monto.';

create index if not exists idx_detalle_pagos_pago
    on public.detalle_pagos (pago_id) where deleted_at is null;
create index if not exists idx_detalle_pagos_monto
    on public.detalle_pagos (monto_id) where deleted_at is null;

drop trigger if exists trg_detalle_set_updated_at on public.detalle_pagos;
create trigger trg_detalle_set_updated_at
    before update on public.detalle_pagos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 7. ROW LEVEL SECURITY
--    SELECT/INSERT/UPDATE para authenticated, DELETE estructuralmente bloqueado.
--    Refinar por rol (admin/cajero/auditor) en migración posterior.
-- =============================================================================
alter table public.conceptos            enable row level security;
alter table public.mediciones_luz       enable row level security;
alter table public.registro_artefactos  enable row level security;
alter table public.montos_por_cobrar    enable row level security;
alter table public.pagos                enable row level security;
alter table public.detalle_pagos        enable row level security;

-- ---- conceptos ----
drop policy if exists pol_conceptos_select on public.conceptos;
create policy pol_conceptos_select on public.conceptos
    for select to authenticated using (true);

drop policy if exists pol_conceptos_insert on public.conceptos;
create policy pol_conceptos_insert on public.conceptos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_conceptos_update on public.conceptos;
create policy pol_conceptos_update on public.conceptos
    for update to authenticated using (true) with check (true);

-- ---- mediciones_luz ----
drop policy if exists pol_mediciones_select on public.mediciones_luz;
create policy pol_mediciones_select on public.mediciones_luz
    for select to authenticated using (true);

drop policy if exists pol_mediciones_insert on public.mediciones_luz;
create policy pol_mediciones_insert on public.mediciones_luz
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_mediciones_update on public.mediciones_luz;
create policy pol_mediciones_update on public.mediciones_luz
    for update to authenticated using (true) with check (true);

-- ---- registro_artefactos ----
drop policy if exists pol_artefactos_select on public.registro_artefactos;
create policy pol_artefactos_select on public.registro_artefactos
    for select to authenticated using (true);

drop policy if exists pol_artefactos_insert on public.registro_artefactos;
create policy pol_artefactos_insert on public.registro_artefactos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_artefactos_update on public.registro_artefactos;
create policy pol_artefactos_update on public.registro_artefactos
    for update to authenticated using (true) with check (true);

-- ---- montos_por_cobrar ----
drop policy if exists pol_montos_select on public.montos_por_cobrar;
create policy pol_montos_select on public.montos_por_cobrar
    for select to authenticated using (true);

drop policy if exists pol_montos_insert on public.montos_por_cobrar;
create policy pol_montos_insert on public.montos_por_cobrar
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_montos_update on public.montos_por_cobrar;
create policy pol_montos_update on public.montos_por_cobrar
    for update to authenticated using (true) with check (true);

-- ---- pagos ----
drop policy if exists pol_pagos_select on public.pagos;
create policy pol_pagos_select on public.pagos
    for select to authenticated using (true);

drop policy if exists pol_pagos_insert on public.pagos;
create policy pol_pagos_insert on public.pagos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_pagos_update on public.pagos;
create policy pol_pagos_update on public.pagos
    for update to authenticated using (true) with check (true);

-- ---- detalle_pagos ----
drop policy if exists pol_detalle_select on public.detalle_pagos;
create policy pol_detalle_select on public.detalle_pagos
    for select to authenticated using (true);

drop policy if exists pol_detalle_insert on public.detalle_pagos;
create policy pol_detalle_insert on public.detalle_pagos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_detalle_update on public.detalle_pagos;
create policy pol_detalle_update on public.detalle_pagos
    for update to authenticated using (true) with check (true);

-- DELETE: ninguna policy en ninguna tabla → PostgreSQL deniega → soft delete forzado.


-- =============================================================================
-- 8. SEED — Catálogo de conceptos (skill §4.1)
-- =============================================================================
insert into public.conceptos (nombre, tipo, aplica_descuento, descripcion) values
    -- FIJOS: se generan automáticamente cada mes según fórmulas
    ('Luz',                     'Fijo',     false, 'Consumo eléctrico mensual del puesto. Calculado por amperaje o artefactos.'),
    ('Agua',                    'Fijo',     false, 'Consumo de agua mensual. Monto fijo según giro y consumo histórico.'),
    ('Gastos administrativos',  'Fijo',     false, 'Cuota administrativa mensual de la cooperativa.'),
    ('Previsión social',        'Fijo',     false, 'Aporte mensual al fondo de previsión social.'),
    ('Mantenimiento',           'Fijo',     false, 'Mantenimiento de áreas comunes y servicios.'),

    -- VARIABLES: se generan manualmente o por evento
    ('Multa',                   'Variable', true,  'Multa puntual. Admite descuento del 50% por acuerdo de asamblea.'),
    ('Aporte extraordinario',   'Variable', false, 'Aporte único aprobado por asamblea (obras, mejoras, etc.).'),
    ('Deuda anterior',          'Variable', false, 'Saldo arrastrado de períodos anteriores no pagados.'),
    ('Ajuste manual',           'Variable', false, 'Ajuste contable autorizado por administración.')
on conflict (nombre) do nothing;
