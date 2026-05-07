-- =============================================================================
-- Migración 00034 — Configuración de Recibos e Identidad Visual
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * configuracion_recibos — fila única (id = 1) con los textos e identidad
--                             que el Administrador puede editar desde la UI.
--
-- Patrón: tabla de fila-única (singleton). Nunca se insertan más filas;
-- el frontend solo hace UPDATE donde id = 1.
-- =============================================================================

create table if not exists public.configuracion_recibos (
    id                  integer         primary key check (id = 1),

    nombre_institucion  text            not null
                                        default 'COOPERATIVA DE COMERCIANTES PRIMERO DE MAYO',

    subtitulo           text            not null
                                        default 'Mercado Municipal — Sistema de Recaudación',

    mensaje_pie         text            not null
                                        default 'Gracias por su puntualidad.',

    color_principal     text            not null
                                        default '#166534'
                                        check (color_principal ~ '^#[0-9A-Fa-f]{6}$'),

    formato_impresion   text            not null
                                        default 'A4'
                                        check (formato_impresion in ('A4', 'TICKET_80MM')),

    updated_at          timestamptz     not null default now(),
    updated_by          uuid            references auth.users(id) on delete set null
);

comment on table public.configuracion_recibos is
    'Fila única (id=1) con la identidad visual de los recibos de pago: '
    'textos del encabezado, pie de página, color corporativo y formato de impresión.';

comment on column public.configuracion_recibos.color_principal is
    'Color hexadecimal (#RRGGBB) usado como fondo del banner de título en el recibo PDF.';

comment on column public.configuracion_recibos.formato_impresion is
    'A4 = hoja carta/A4 estándar · TICKET_80MM = rollo de 80mm de impresora térmica.';


-- =============================================================================
-- 2. Trigger updated_at
-- =============================================================================
drop trigger if exists trg_configuracion_recibos_updated_at on public.configuracion_recibos;
create trigger trg_configuracion_recibos_updated_at
    before update on public.configuracion_recibos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 3. Fila por defecto (INSERT solo si no existe)
-- =============================================================================
insert into public.configuracion_recibos (
    id, nombre_institucion, subtitulo, mensaje_pie, color_principal, formato_impresion
) values (
    1,
    'COOPERATIVA DE COMERCIANTES PRIMERO DE MAYO',
    'Mercado Municipal — Sistema de Recaudación',
    'Gracias por su puntualidad.',
    '#166534',
    'A4'
) on conflict (id) do nothing;


-- =============================================================================
-- 4. RLS
-- =============================================================================
alter table public.configuracion_recibos enable row level security;

-- Cualquier usuario autenticado puede leer la configuración
drop policy if exists pol_config_recibos_select on public.configuracion_recibos;
create policy pol_config_recibos_select on public.configuracion_recibos
    for select to authenticated using (true);

-- Solo Administrador puede actualizar
drop policy if exists pol_config_recibos_update on public.configuracion_recibos;
create policy pol_config_recibos_update on public.configuracion_recibos
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');

-- No se permiten INSERT ni DELETE adicionales (singleton guardado por el CHECK id=1)


-- =============================================================================
-- 5. Grants
-- =============================================================================
grant select on public.configuracion_recibos to authenticated;
grant update (nombre_institucion, subtitulo, mensaje_pie, color_principal,
              formato_impresion, updated_at, updated_by)
      on public.configuracion_recibos to authenticated;
