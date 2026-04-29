-- =============================================================================
-- Migración 00016 — Audit Trail (trazabilidad de cambios críticos)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * audit_logs              — tabla append-only de eventos
--   * log_audit_action()      — trigger genérico SECURITY DEFINER
--   * triggers en socios, inquilinos, puestos, pagos
--   * RLS: SELECT solo Administrador; INSERT/UPDATE/DELETE bloqueados
--     para clientes directos (solo el trigger puede insertar).
-- =============================================================================


-- =============================================================================
-- 1. Tabla audit_logs (append-only, sin soft-delete)
-- =============================================================================
create table if not exists public.audit_logs (
    id          uuid        primary key default gen_random_uuid(),
    table_name  text        not null,
    record_id   text        not null,
    action      text        not null check (action in ('INSERT', 'UPDATE', 'DELETE')),
    old_data    jsonb,
    new_data    jsonb,
    changed_by  uuid        references auth.users(id) on delete set null,
    created_at  timestamptz not null default now()
);

comment on table public.audit_logs is
    'Registro append-only de cambios críticos (socios, inquilinos, puestos, pagos). '
    'Inmutable: no se permiten UPDATE ni DELETE. Solo el trigger SECURITY DEFINER puede insertar.';

create index if not exists idx_audit_logs_created_at
    on public.audit_logs (created_at desc);

create index if not exists idx_audit_logs_table_action
    on public.audit_logs (table_name, action);


-- =============================================================================
-- 2. Función trigger genérica log_audit_action()
--    SECURITY DEFINER: bypassea RLS para poder insertar en audit_logs
--    desde cualquier rol. auth.uid() funciona porque lee el setting de sesión
--    (request.jwt.claims) que PostgREST establece por petición.
-- =============================================================================
create or replace function public.log_audit_action()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
    insert into public.audit_logs (table_name, record_id, action, old_data, new_data, changed_by)
    values (
        tg_table_name,
        case tg_op
            when 'DELETE' then to_jsonb(old) ->> 'id'
            else               to_jsonb(new) ->> 'id'
        end,
        tg_op,
        case tg_op when 'INSERT' then null else to_jsonb(old) end,
        case tg_op when 'DELETE' then null else to_jsonb(new) end,
        auth.uid()
    );
    return null;
end;
$$;

comment on function public.log_audit_action() is
    'Trigger AFTER INSERT|UPDATE|DELETE genérico. Inserta en audit_logs con SECURITY DEFINER '
    'para bypassear RLS. Captura el usuario vía auth.uid() (sesión PostgREST).';


-- =============================================================================
-- 3. Aplicar trigger a las tablas críticas
-- =============================================================================
drop trigger if exists trg_audit_socios on public.socios;
create trigger trg_audit_socios
    after insert or update or delete on public.socios
    for each row execute function public.log_audit_action();

drop trigger if exists trg_audit_inquilinos on public.inquilinos;
create trigger trg_audit_inquilinos
    after insert or update or delete on public.inquilinos
    for each row execute function public.log_audit_action();

drop trigger if exists trg_audit_puestos on public.puestos;
create trigger trg_audit_puestos
    after insert or update or delete on public.puestos
    for each row execute function public.log_audit_action();

drop trigger if exists trg_audit_pagos on public.pagos;
create trigger trg_audit_pagos
    after insert or update or delete on public.pagos
    for each row execute function public.log_audit_action();


-- =============================================================================
-- 4. RLS en audit_logs
--    INSERT: bloqueado para clientes directos (solo el trigger SECURITY DEFINER
--            puede insertar — SECURITY DEFINER no está sujeto a RLS del invocador).
--    SELECT: solo rol Administrador.
--    UPDATE / DELETE: ninguna policy → PostgreSQL deniega (inmutabilidad forzada).
-- =============================================================================
alter table public.audit_logs enable row level security;

drop policy if exists pol_audit_select on public.audit_logs;
create policy pol_audit_select on public.audit_logs
    for select to authenticated
    using (public.get_my_rol() = 'Administrador');
