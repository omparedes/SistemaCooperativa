-- =============================================================================
-- Migración 00006 — Vistas financieras (capa de lectura optimizada)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Tres vistas reusables para reportes y consumo desde el frontend Angular:
--
--   1. vw_deuda_total_por_puesto  → desglose JSONB por concepto + total general
--   2. vw_socios_morosos          → socios con ≥ 1 deuda vencida
--   3. vw_recaudacion_mensual     → ingresos agrupados por año/mes/concepto
--
-- Patrón aplicado:
--   • WITH (security_invoker = true)  → la vista corre con la RLS del usuario
--                                       que la consulta (no del owner). Las
--                                       policies SELECT existentes aplican.
--   • "Saldo pendiente" se calcula en vivo: monto - SUM(detalle_aplicado)
--     porque la columna `estado` puede quedar desactualizada momentáneamente.
--   • Filtros consistentes: deleted_at IS NULL en TODAS las tablas.
--   • GRANT SELECT a authenticated al final.
-- =============================================================================


-- =============================================================================
-- 1. vw_deuda_total_por_puesto
--    Una fila por puesto activo. Desglose por concepto en JSONB + total.
-- =============================================================================
create or replace view public.vw_deuda_total_por_puesto
with (security_invoker = true) as
with saldos AS (
    -- Saldo restante de cada deuda activa con puesto
    select
        m.id           as monto_id,
        m.puesto_id,
        m.concepto_id,
        m.monto - coalesce(
            sum(d.monto_aplicado) filter (where d.deleted_at is null),
            0
        ) as saldo
    from public.montos_por_cobrar m
    left join public.detalle_pagos d on d.monto_id = m.id
    where m.deleted_at is null
      and m.puesto_id is not null
      and m.estado <> 'Cancelado'
    group by m.id, m.puesto_id, m.concepto_id, m.monto
    having m.monto - coalesce(
        sum(d.monto_aplicado) filter (where d.deleted_at is null),
        0
    ) > 0
),
por_concepto as (
    select
        s.puesto_id,
        c.nombre as concepto,
        sum(s.saldo) as saldo
    from saldos s
    join public.conceptos c on c.id = s.concepto_id
    group by s.puesto_id, c.nombre
)
select
    p.id           as puesto_id,
    p.codigo_puesto,
    p.estado       as estado_puesto,
    coalesce(
        jsonb_object_agg(pc.concepto, pc.saldo)
            filter (where pc.concepto is not null),
        '{}'::jsonb
    )              as desglose_por_concepto,
    coalesce(sum(pc.saldo), 0)::numeric(14,2) as total_general,
    count(pc.concepto)                        as cantidad_conceptos_pendientes
from public.puestos p
left join por_concepto pc on pc.puesto_id = p.id
where p.deleted_at is null
group by p.id, p.codigo_puesto, p.estado
order by p.codigo_puesto;

comment on view public.vw_deuda_total_por_puesto is
    'Una fila por puesto activo con la deuda pendiente desglosada por concepto (JSONB) y el total general. Saldo = monto - SUM(detalle.monto_aplicado).';


-- =============================================================================
-- 2. vw_socios_morosos
--    Socios con ≥ 1 deuda vencida (período anterior al actual).
--    Considera AMBOS orígenes: deudas del puesto que son titulares + deudas
--    personales (multas, aportes).
-- =============================================================================
create or replace view public.vw_socios_morosos
with (security_invoker = true) as
with periodo_actual as (
    select
        extract(year  from current_date)::int as anio,
        extract(month from current_date)::int as mes
),
deudas_vencidas as (
    -- (a) Deudas del PUESTO que el socio ocupa como titular vigente
    select
        ht.socio_id,
        m.id        as monto_id,
        m.periodo_anio,
        m.periodo_mes,
        m.monto - coalesce(
            sum(d.monto_aplicado) filter (where d.deleted_at is null),
            0
        ) as saldo,
        'puesto'    as origen
    from public.montos_por_cobrar m
    join public.historial_titularidad ht
      on ht.puesto_id  = m.puesto_id
     and ht.fecha_fin is null
    left join public.detalle_pagos d on d.monto_id = m.id
    cross join periodo_actual pa
    where m.deleted_at is null
      and m.puesto_id  is not null
      and m.estado    <> 'Cancelado'
      and (m.periodo_anio  < pa.anio
           or (m.periodo_anio = pa.anio and m.periodo_mes < pa.mes))
    group by ht.socio_id, m.id, m.periodo_anio, m.periodo_mes, m.monto
    having m.monto - coalesce(
        sum(d.monto_aplicado) filter (where d.deleted_at is null),
        0
    ) > 0

    union all

    -- (b) Deudas PERSONALES del socio (multas, aportes extraordinarios)
    select
        m.socio_id,
        m.id,
        m.periodo_anio,
        m.periodo_mes,
        m.monto - coalesce(
            sum(d.monto_aplicado) filter (where d.deleted_at is null),
            0
        ) as saldo,
        'personal'  as origen
    from public.montos_por_cobrar m
    left join public.detalle_pagos d on d.monto_id = m.id
    cross join periodo_actual pa
    where m.deleted_at is null
      and m.socio_id   is not null
      and m.estado    <> 'Cancelado'
      and (m.periodo_anio  < pa.anio
           or (m.periodo_anio = pa.anio and m.periodo_mes < pa.mes))
    group by m.socio_id, m.id, m.periodo_anio, m.periodo_mes, m.monto
    having m.monto - coalesce(
        sum(d.monto_aplicado) filter (where d.deleted_at is null),
        0
    ) > 0
)
select
    s.id           as socio_id,
    s.dni,
    s.apellidos,
    s.nombres,
    s.estado       as estado_socio,
    s.habilitado,
    p.id           as puesto_actual_id,
    p.codigo_puesto as puesto_actual_codigo,
    count(distinct dv.monto_id)              as cantidad_deudas_vencidas,
    sum(dv.saldo)::numeric(14,2)              as monto_total_vencido,
    min(dv.periodo_anio * 100 + dv.periodo_mes) as periodo_mas_antiguo_yyyymm,
    count(distinct dv.monto_id) filter (where dv.origen = 'puesto')   as deudas_de_puesto,
    count(distinct dv.monto_id) filter (where dv.origen = 'personal') as deudas_personales
from public.socios s
join deudas_vencidas dv on dv.socio_id = s.id
left join public.historial_titularidad ht
  on ht.socio_id   = s.id
 and ht.fecha_fin is null
left join public.puestos p on p.id = ht.puesto_id
where s.deleted_at is null
group by s.id, s.dni, s.apellidos, s.nombres, s.estado, s.habilitado, p.id, p.codigo_puesto
order by sum(dv.saldo) desc;

comment on view public.vw_socios_morosos is
    'Socios con ≥1 deuda pendiente vencida (períodos anteriores al actual). Cubre tanto deudas del puesto del titular como deudas personales (multas/aportes). periodo_mas_antiguo_yyyymm = AAAA*100+MM (ej. 202503 = marzo 2025).';


-- =============================================================================
-- 3. vw_recaudacion_mensual
--    Total recaudado agrupado por año, mes y concepto.
-- =============================================================================
create or replace view public.vw_recaudacion_mensual
with (security_invoker = true) as
select
    extract(year  from p.fecha_pago)::smallint as anio,
    extract(month from p.fecha_pago)::smallint as mes,
    c.id   as concepto_id,
    c.nombre as concepto,
    c.tipo  as concepto_tipo,
    count(distinct p.id)             as cantidad_pagos,
    sum(d.monto_aplicado)::numeric(14,2) as total_recaudado,
    count(distinct p.id) filter (where p.metodo_pago = 'Efectivo')        as pagos_efectivo,
    count(distinct p.id) filter (where p.metodo_pago = 'Transferencia')   as pagos_transferencia,
    sum(d.monto_aplicado) filter (where p.metodo_pago = 'Efectivo')::numeric(14,2)      as recaudado_efectivo,
    sum(d.monto_aplicado) filter (where p.metodo_pago = 'Transferencia')::numeric(14,2) as recaudado_transferencia
from public.pagos p
join public.detalle_pagos    d on d.pago_id  = p.id and d.deleted_at is null
join public.montos_por_cobrar m on m.id      = d.monto_id
join public.conceptos        c on c.id      = m.concepto_id
where p.deleted_at is null
group by anio, mes, c.id, c.nombre, c.tipo
order by anio desc, mes desc, total_recaudado desc;

comment on view public.vw_recaudacion_mensual is
    'Recaudación agrupada por año, mes y concepto. Excluye pagos anulados (deleted_at IS NULL). Desglosa también por método de pago (Efectivo / Transferencia).';


-- =============================================================================
-- 4. Permisos para PostgREST (consumo desde el cliente vía Supabase JS)
-- =============================================================================
grant select on public.vw_deuda_total_por_puesto to authenticated;
grant select on public.vw_socios_morosos          to authenticated;
grant select on public.vw_recaudacion_mensual    to authenticated;

-- También al rol anon por si se construyen reportes públicos a futuro
-- (PostgREST en Supabase usa anon para usuarios no autenticados).
grant select on public.vw_deuda_total_por_puesto to anon;
grant select on public.vw_socios_morosos          to anon;
grant select on public.vw_recaudacion_mensual    to anon;
