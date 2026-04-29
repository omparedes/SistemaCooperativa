-- =============================================================================
-- Migración 00020 — Actualización módulo Gastos (Egresos Excel)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- 1. Agrega columna `responsable` a gastos (nombre de quien recibe el dinero).
-- 2. Garantiza UNIQUE en categorias_gasto.nombre (requiere ON CONFLICT).
-- 3. Inserta las categorías del Excel de Egresos.
-- =============================================================================

-- 1. Nueva columna (idempotente)
alter table public.gastos
    add column if not exists responsable text;

comment on column public.gastos.responsable is
    'Nombre de la persona que recibe o gestiona el egreso (ej: RAMIREZ HERMELINDA).';

-- 2. Garantiza unicidad en nombre para que ON CONFLICT funcione
create unique index if not exists idx_categorias_gasto_nombre_unique
    on public.categorias_gasto (nombre);

-- 3. Categorías del Excel de Egresos
insert into public.categorias_gasto (nombre) values
    ('Remuneraciones'),
    ('Dietas Directivas'),
    ('Infraestructura y Obras'),
    ('Movilidad'),
    ('Limpieza y Mantenimiento')
on conflict (nombre) do nothing;
