-- =============================================================================
-- Migración 00042 — Tipo de Espacio, Servicios Flexibles y Soporte a Terceros
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Cambios:
--   1. puestos: + tipo_espacio ('Principal' | 'Almacen')
--              + cobro_luz_activo  BOOLEAN DEFAULT true
--              + cobro_agua_activo BOOLEAN DEFAULT true
--   2. Clasificación automática de puestos existentes por sufijo de código.
--   3. inquilinos: + tipo_inquilino ('Inquilino' | 'Tercero')
--   4. Trigger historial_arriendos: Tercero → solo puede ocupar Almacén.
--   5. Trigger mediciones_luz: bloquea inserción si cobro_luz_activo = false.
--   6. RPC toggle_servicio_puesto (Administrador).
--   7. guardar_mediciones_luz_bulk: omite silenciosamente cobro_luz_activo=false.
--   8. Vista vw_espacios_con_ocupacion (reemplaza la lectura plana de puestos).
--   9. Índices nuevos en puestos por tipo_espacio y flags de cobro.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. NUEVAS COLUMNAS EN puestos
-- =============================================================================
alter table public.puestos
  add column if not exists tipo_espacio      text    not null default 'Principal'
    check (tipo_espacio in ('Principal', 'Almacen')),
  add column if not exists cobro_luz_activo  boolean not null default true,
  add column if not exists cobro_agua_activo boolean not null default true;

comment on column public.puestos.tipo_espacio is
  'Principal = espacio comercial del padrón (puesto base del socio en el directorio). '
  'Almacen = espacio complementario: depósito (-D1/D2/D3), 2do piso (-SP) o espacio (-EP).';
comment on column public.puestos.cobro_luz_activo is
  'false → las RPCs de facturación de Luz omiten este espacio (sin generar monto_por_cobrar).';
comment on column public.puestos.cobro_agua_activo is
  'false → las RPCs de facturación de Agua omiten este espacio (sin generar monto_por_cobrar).';


-- =============================================================================
-- 2. CLASIFICACIÓN AUTOMÁTICA DE PUESTOS EXISTENTES
--    Regla: sufijos -D<n> (depósito), -SP (segundo piso), -EP (espacio) → Almacen.
--    Todo lo demás (números solos, -E) → permanece Principal.
-- =============================================================================
update public.puestos
  set tipo_espacio = 'Almacen'
  where deleted_at is null
    and (
      codigo_puesto ~ '-D[0-9]+$'   -- ej. 1-D1, 6-D3
      or codigo_puesto ~ '-SP$'     -- ej. 3-SP
      or codigo_puesto ~ '-EP$'     -- ej. 5-EP
    );

do $$
declare
  v_principal int;
  v_almacen   int;
begin
  select count(*) into v_principal from public.puestos where tipo_espacio = 'Principal' and deleted_at is null;
  select count(*) into v_almacen   from public.puestos where tipo_espacio = 'Almacen'   and deleted_at is null;
  raise notice '00042 — Puestos clasificados → Principal: %  |  Almacen: %', v_principal, v_almacen;
  if v_principal = 0 then
    raise exception 'ERROR 00042: ningún puesto clasificado como Principal. Revisar regex.';
  end if;
end $$;

create index if not exists idx_puestos_tipo_espacio
  on public.puestos (tipo_espacio) where deleted_at is null;

create index if not exists idx_puestos_cobro_luz_inactivo
  on public.puestos (id) where deleted_at is null and cobro_luz_activo = false;

create index if not exists idx_puestos_cobro_agua_inactivo
  on public.puestos (id) where deleted_at is null and cobro_agua_activo = false;


-- =============================================================================
-- 3. NUEVA COLUMNA tipo_inquilino EN inquilinos
-- =============================================================================
alter table public.inquilinos
  add column if not exists tipo_inquilino text not null default 'Inquilino'
    check (tipo_inquilino in ('Inquilino', 'Tercero'));

comment on column public.inquilinos.tipo_inquilino is
  'Inquilino = posesionario temporal de un puesto comercial Principal. '
  'Tercero = arrendatario externo de un Almacén (no es socio ni inquilino comercial). '
  'Restricción: un Tercero nunca puede asignarse a un puesto tipo Principal (ver trigger).';

create index if not exists idx_inquilinos_tipo_inquilino
  on public.inquilinos (tipo_inquilino) where deleted_at is null;


-- =============================================================================
-- 4. TRIGGER: Tercero solo puede arrendar puestos tipo 'Almacen'
-- =============================================================================
create or replace function public.tg_validar_tercero_en_almacen()
returns trigger
language plpgsql
as $$
declare
  v_tipo_espacio   text;
  v_tipo_inquilino text;
  v_codigo_puesto  text;
begin
  select tipo_inquilino into v_tipo_inquilino
  from public.inquilinos where id = new.inquilino_id;

  if v_tipo_inquilino = 'Tercero' then
    select tipo_espacio, codigo_puesto
      into v_tipo_espacio, v_codigo_puesto
    from public.puestos where id = new.puesto_id;

    if coalesce(v_tipo_espacio, 'Principal') <> 'Almacen' then
      raise exception
        'Regla de negocio (00042): un Tercero solo puede arrendar espacios tipo Almacén. '
        'Puesto "%" (id=%) es tipo "%".',
        v_codigo_puesto, new.puesto_id, v_tipo_espacio;
    end if;
  end if;

  return new;
end;
$$;

comment on function public.tg_validar_tercero_en_almacen is
  'Impide que un Tercero (tipo_inquilino=Tercero) ocupe un puesto de tipo Principal.';

drop trigger if exists trg_validar_tercero_en_almacen on public.historial_arriendos;
create trigger trg_validar_tercero_en_almacen
  before insert or update on public.historial_arriendos
  for each row execute function public.tg_validar_tercero_en_almacen();


-- =============================================================================
-- 5. TRIGGER: Bloquear medición de Luz si cobro_luz_activo = false
-- =============================================================================
create or replace function public.tg_bloquear_medicion_luz_inactiva()
returns trigger
language plpgsql
as $$
declare
  v_activo boolean;
  v_codigo text;
begin
  select cobro_luz_activo, codigo_puesto
    into v_activo, v_codigo
  from public.puestos where id = new.puesto_id;

  if not coalesce(v_activo, true) then
    raise exception
      'No se puede registrar medición de luz para el puesto "%" (id=%) porque '
      'cobro_luz_activo=false. Active el servicio antes de registrar mediciones.',
      v_codigo, new.puesto_id;
  end if;

  return new;
end;
$$;

comment on function public.tg_bloquear_medicion_luz_inactiva is
  'Impide insertar mediciones_luz cuando cobro_luz_activo=false en el puesto.';

drop trigger if exists trg_bloquear_medicion_luz_inactiva on public.mediciones_luz;
create trigger trg_bloquear_medicion_luz_inactiva
  before insert on public.mediciones_luz
  for each row execute function public.tg_bloquear_medicion_luz_inactiva();


-- =============================================================================
-- 6. RPC: toggle_servicio_puesto
--    Activa / desactiva cobro_luz_activo o cobro_agua_activo. Solo Administrador.
--    Retorna estado anterior y nuevo para trazabilidad en el frontend.
-- =============================================================================
create or replace function public.toggle_servicio_puesto(
  p_puesto_id bigint,
  p_servicio  text,     -- 'luz' | 'agua'
  p_activo    boolean,
  p_usuario   uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_codigo text;
  v_prev   boolean;
begin
  if public.get_my_rol() <> 'Administrador' then
    raise exception 'Acceso denegado: solo el Administrador puede cambiar estados de servicio.';
  end if;

  if p_servicio not in ('luz', 'agua') then
    raise exception 'Servicio inválido: "%" — usar "luz" o "agua".', p_servicio;
  end if;

  select codigo_puesto into v_codigo
  from public.puestos where id = p_puesto_id and deleted_at is null;

  if v_codigo is null then
    raise exception 'Puesto id=% no encontrado o dado de baja.', p_puesto_id;
  end if;

  if p_servicio = 'luz' then
    select cobro_luz_activo  into v_prev from public.puestos where id = p_puesto_id;
    update public.puestos set cobro_luz_activo  = p_activo where id = p_puesto_id;
  else
    select cobro_agua_activo into v_prev from public.puestos where id = p_puesto_id;
    update public.puestos set cobro_agua_activo = p_activo where id = p_puesto_id;
  end if;

  return jsonb_build_object(
    'puesto_id',     p_puesto_id,
    'codigo_puesto', v_codigo,
    'servicio',      p_servicio,
    'activo_prev',   v_prev,
    'activo_nuevo',  p_activo
  );
end;
$$;

comment on function public.toggle_servicio_puesto is
  'Activa/desactiva cobro de Luz o Agua para un puesto. Solo Administrador. '
  'El estado previo y nuevo se devuelven para que el frontend pueda trazarlo.';

grant execute on function public.toggle_servicio_puesto to authenticated;


-- =============================================================================
-- 7. ACTUALIZAR guardar_mediciones_luz_bulk
--    Agrega omisión silenciosa de puestos con cobro_luz_activo=false.
--    El trigger del paso 5 bloquea inserts directos; la función los salta
--    en batch sin abortar la transacción completa.
-- =============================================================================
create or replace function public.guardar_mediciones_luz_bulk(
    p_lecturas   jsonb,
    p_anio       smallint,
    p_mes        smallint,
    p_precio_kwh numeric default null,
    p_usuario    uuid    default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_lectura           jsonb;
    v_puesto_id         bigint;
    v_amperaje          numeric(8,2);
    v_horas_uso         smallint;
    v_dias_uso          smallint;
    v_med_id            bigint;
    v_monto_calc        numeric(12,2);
    v_id_luz            bigint;
    v_insertadas        int := 0;
    v_ignoradas         int := 0;
    v_omitidas_inactivo int := 0;
    v_montos_gen        int := 0;
    v_cobro_activo      boolean;
begin
    -- Resolver usuario desde el contexto de sesión si no se pasó explícitamente
    if p_usuario is null then
        p_usuario := auth.uid();
    end if;

    if public.get_my_rol() <> 'Administrador' then
        raise exception 'Acceso denegado: solo el Administrador puede guardar mediciones masivas.';
    end if;

    if p_precio_kwh is null then
        select valor into p_precio_kwh
        from public.configuraciones where clave = 'PRECIO_KWH_SOCIO';
    end if;

    if coalesce(p_precio_kwh, 0) <= 0 then
        raise exception 'El precio S/kWh debe ser mayor a cero.';
    end if;

    select id into v_id_luz from public.conceptos
    where nombre = 'Luz' and deleted_at is null limit 1;

    if v_id_luz is null then
        raise exception 'Concepto "Luz" no encontrado en el catálogo.';
    end if;

    for v_lectura in select value from jsonb_array_elements(p_lecturas) loop

        v_puesto_id := (v_lectura->>'puesto_id')::bigint;
        v_amperaje  := coalesce((v_lectura->>'amperaje')::numeric(8,2), 0);
        v_horas_uso := coalesce((v_lectura->>'horas_uso')::smallint, 12);
        v_dias_uso  := coalesce((v_lectura->>'dias_uso')::smallint,  30);

        if v_amperaje < 0 then
            raise exception 'Amperaje negativo para puesto_id %', v_puesto_id;
        end if;

        -- Omitir silenciosamente puestos con cobro de Luz desactivado (00042)
        select cobro_luz_activo into v_cobro_activo
        from public.puestos where id = v_puesto_id and deleted_at is null;

        if not coalesce(v_cobro_activo, true) then
            v_omitidas_inactivo := v_omitidas_inactivo + 1;
            continue;
        end if;

        insert into public.mediciones_luz
            (puesto_id, periodo_anio, periodo_mes, fecha_medicion,
             amperaje, horas_uso, dias_uso, precio_kwh, monto_alumbrado, created_by)
        values
            (v_puesto_id, p_anio, p_mes, current_date,
             v_amperaje, v_horas_uso, v_dias_uso, p_precio_kwh, 0, p_usuario)
        on conflict (puesto_id, periodo_anio, periodo_mes)
            where deleted_at is null
            do nothing
        returning id, monto_calculado into v_med_id, v_monto_calc;

        if v_med_id is not null then
            v_insertadas := v_insertadas + 1;

            if v_monto_calc > 0 then
                insert into public.montos_por_cobrar
                    (puesto_id, concepto_id, periodo_anio, periodo_mes,
                     monto, estado, metodo_calculo, medicion_luz_id, fecha_generacion, created_by)
                values
                    (v_puesto_id, v_id_luz, p_anio, p_mes,
                     v_monto_calc, 'Pendiente', 'Amperaje', v_med_id, current_date, p_usuario)
                on conflict (puesto_id, concepto_id, periodo_anio, periodo_mes)
                    where deleted_at is null and puesto_id is not null
                    do nothing;

                if found then
                    v_montos_gen := v_montos_gen + 1;
                end if;
            end if;
        else
            v_ignoradas := v_ignoradas + 1;
        end if;

    end loop;

    return jsonb_build_object(
        'periodo',                   jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'mediciones_nuevas',         v_insertadas,
        'mediciones_ya_existian',    v_ignoradas,
        'omitidas_cobro_inactivo',   v_omitidas_inactivo,
        'montos_luz_generados',      v_montos_gen
    );
end;
$$;

comment on function public.guardar_mediciones_luz_bulk is
    'Inserta mediciones_luz en batch (método Amperaje §3.1) y genera montos_por_cobrar de Luz. '
    'Idempotente: ignora puestos con medición ya registrada en el período. '
    '(00042) Omite silenciosamente puestos con cobro_luz_activo=false sin abortar el batch.';

grant execute on function public.guardar_mediciones_luz_bulk to authenticated;


-- =============================================================================
-- 8. VISTA: vw_espacios_con_ocupacion
--    Lectura operativa de todos los espacios con su tipo, estado de servicios
--    y ocupante vigente. Usada por la pantalla "Gestión de Espacios".
-- =============================================================================
create or replace view public.vw_espacios_con_ocupacion
with (security_invoker = true) as
select
  p.id                  as puesto_id,
  p.codigo_puesto,
  p.tipo_espacio,
  p.estado,
  p.giro_id,
  g.nombre              as giro_nombre,
  p.area_m2,
  p.tiene_medidor_luz,
  p.tiene_medidor_agua,
  p.cobro_luz_activo,
  p.cobro_agua_activo,
  -- Titular vigente (socio propietario del derecho)
  ht.socio_id           as titular_id,
  s.nombres             as titular_nombres,
  s.apellidos           as titular_apellidos,
  s.dni                 as titular_dni,
  s.estado              as titular_estado,
  ht.fecha_inicio       as titularidad_inicio,
  -- Inquilino o Tercero vigente (arrendatario físico, opcional)
  ha.inquilino_id,
  inq.nombres           as inquilino_nombres,
  inq.apellidos         as inquilino_apellidos,
  inq.tipo_inquilino,
  ha.fecha_inicio       as arriendo_inicio
from public.puestos p
left join public.giros g
  on g.id = p.giro_id and g.deleted_at is null
left join public.historial_titularidad ht
  on ht.puesto_id = p.id and ht.fecha_fin is null
left join public.socios s
  on s.id = ht.socio_id and s.deleted_at is null
left join public.historial_arriendos ha
  on ha.puesto_id = p.id and ha.fecha_fin is null
left join public.inquilinos inq
  on inq.id = ha.inquilino_id and inq.deleted_at is null
where p.deleted_at is null
order by p.tipo_espacio, p.codigo_puesto;

comment on view public.vw_espacios_con_ocupacion is
  'Vista operativa de todos los espacios (Principal y Almacén) con estado de servicios '
  'y ocupante vigente (titular socio + inquilino/tercero). '
  'Requiere tipo_espacio, cobro_*_activo (migración 00042).';

grant select on public.vw_espacios_con_ocupacion to authenticated;


-- =============================================================================
-- 9. VERIFICACIÓN FINAL
-- =============================================================================
do $$
declare
  v_col_tipo   boolean;
  v_col_luz    boolean;
  v_col_agua   boolean;
  v_col_tipinq boolean;
begin
  select exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'puestos'
      and column_name = 'tipo_espacio'
  ) into v_col_tipo;

  select exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'puestos'
      and column_name = 'cobro_luz_activo'
  ) into v_col_luz;

  select exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'puestos'
      and column_name = 'cobro_agua_activo'
  ) into v_col_agua;

  select exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'inquilinos'
      and column_name = 'tipo_inquilino'
  ) into v_col_tipinq;

  if not (v_col_tipo and v_col_luz and v_col_agua and v_col_tipinq) then
    raise exception '00042 FALLO: columnas faltantes. tipo_espacio=% cobro_luz=% cobro_agua=% tipo_inquilino=%',
      v_col_tipo, v_col_luz, v_col_agua, v_col_tipinq;
  end if;

  raise notice '00042 ✓ Migración completada correctamente.';
end $$;

COMMIT;
