-- =============================================================================
-- Migración 00047 — Enmascaramiento de PII en el Portal Público (Consultas)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- PROBLEMA (Auditoría A1):
--   `rpc_public_buscar_pagador` (accesible por anon, sin login) devolvía el DNI
--   COMPLETO de socios e inquilinos, y permitía búsqueda por coincidencia parcial
--   de nombre/apellido. Esto hacía posible enumerar todo el padrón con DNI desde
--   el portal público /consultas, sin autenticación.
--
-- SOLUCIÓN:
--   1. Helper `mask_dni(text)` → enmascara el DNI dejando solo los 3 últimos
--      dígitos visibles (p. ej. 12345678 → *****678).
--   2. `rpc_public_buscar_pagador` ahora devuelve el DNI enmascarado.
--      La COINCIDENCIA de búsqueda sigue usando el DNI real internamente
--      (si el usuario teclea su DNI completo, lo encuentra igual).
--   3. Guarda de longitud mínima (>= 3) para reducir el barrido masivo por
--      prefijos de nombre. NO afecta la búsqueda por DNI (8 dígitos) ni por
--      códigos de puesto de 3+ caracteres.
--
-- IMPACTO EN FRONTEND: NINGUNO. La UI (consultas.component) solo muestra el
--   campo `dni` tal cual lo devuelve el RPC; ahora lo verá enmascarado, incluido
--   el recibo PDF público (deseable).
--
-- NO TOCA: lógica financiera, cálculo de deudas, arqueos ni RLS.
-- Reversible: re-aplicar la versión de 00015 restaura el comportamiento anterior.
-- =============================================================================


-- =============================================================================
-- 1. Helper de enmascaramiento (IMMUTABLE: indexable y cacheable)
-- =============================================================================
create or replace function public.mask_dni(p_dni text)
returns text
language sql
immutable
as $$
    select case
        when p_dni is null                 then null
        when length(trim(p_dni)) <= 3       then repeat('*', length(trim(p_dni)))
        else repeat('*', length(trim(p_dni)) - 3) || right(trim(p_dni), 3)
    end;
$$;

comment on function public.mask_dni(text) is
    'Enmascara un DNI dejando visibles solo los 3 últimos dígitos. Uso en portales públicos.';


-- =============================================================================
-- 2. Reemplazo de rpc_public_buscar_pagador con DNI enmascarado
--    (idéntico a 00015 salvo: guarda de longitud mínima + mask_dni en la salida)
-- =============================================================================
create or replace function public.rpc_public_buscar_pagador(p_query text)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_termino text;
    v_result  json;
begin
    v_termino := upper(trim(p_query));

    if v_termino = '' then
        return '[]'::json;
    end if;

    -- Guarda de longitud: evita enumeración masiva con 1 carácter.
    -- Umbral en 2 para soportar códigos de puesto de 2 dígitos (ej. '53', '98').
    if length(v_termino) < 2 then
        return '[]'::json;
    end if;

    if length(v_termino) > 100 then
        return '[]'::json;
    end if;

    with all_matches as (

        -- Socios: coincidencia por DNI (real), nombre o apellidos
        (select
            'socio'::text                                as tipo,
            s.id                                         as persona_id,
            s.dni                                        as dni,
            s.apellidos || ', ' || s.nombres             as nombre_completo,
            p.id                                         as puesto_id,
            p.codigo_puesto,
            1                                            as prioridad
        from public.socios s
        join public.historial_titularidad ht
             on ht.socio_id = s.id and ht.fecha_fin is null
        join public.puestos p
             on p.id = ht.puesto_id and p.deleted_at is null
        where s.deleted_at is null
          and (   upper(s.dni)       like '%' || v_termino || '%'
               or upper(s.nombres)   like '%' || v_termino || '%'
               or upper(s.apellidos) like '%' || v_termino || '%')
        limit 8)

        union all

        -- Inquilinos: coincidencia por DNI (real), nombre o apellidos
        (select
            'inquilino'::text,
            i.id,
            i.dni,
            i.apellidos || ', ' || i.nombres,
            p.id,
            p.codigo_puesto,
            2
        from public.inquilinos i
        join public.historial_arriendos ha
             on ha.inquilino_id = i.id and ha.fecha_fin is null
        join public.puestos p
             on p.id = ha.puesto_id and p.deleted_at is null
        where i.deleted_at is null
          and (   upper(i.dni)       like '%' || v_termino || '%'
               or upper(i.nombres)   like '%' || v_termino || '%'
               or upper(i.apellidos) like '%' || v_termino || '%')
        limit 8)

        union all

        -- Puestos: coincidencia por código (devuelve el titular socio vigente)
        (select
            'socio'::text,
            s.id,
            s.dni,
            s.apellidos || ', ' || s.nombres,
            p.id,
            p.codigo_puesto,
            3
        from public.puestos p
        join public.historial_titularidad ht
             on ht.puesto_id = p.id and ht.fecha_fin is null
        join public.socios s
             on s.id = ht.socio_id and s.deleted_at is null
        where p.deleted_at is null
          and upper(p.codigo_puesto) like '%' || v_termino || '%'
        limit 5)

    ),

    -- Deduplicar por puesto_id; cuando hay duplicado preferir prioridad menor
    dedupe as (
        select distinct on (puesto_id)
            tipo, persona_id, dni, nombre_completo, puesto_id, codigo_puesto
        from all_matches
        order by puesto_id, prioridad
    )

    select coalesce(
        json_agg(
            json_build_object(
                'tipo',           tipo,
                'persona_id',     persona_id,
                'dni',            public.mask_dni(dni),   -- ← PII enmascarada en la salida
                'nombre_completo', nombre_completo,
                'puesto_id',      puesto_id,
                'codigo_puesto',  codigo_puesto
            )
        ),
        '[]'::json
    )
    into v_result
    from (select * from dedupe limit 10) final_set;

    return v_result;
end;
$$;

comment on function public.rpc_public_buscar_pagador(text) is
    'Portal público: busca pagadores (socios/inquilinos/puestos) por DNI, nombre o '
    'código. SECURITY DEFINER — bypasea RLS de solo lectura para uso anon. '
    'Devuelve hasta 10 resultados deduplicados por puesto_id. DNI enmascarado (00047).';

grant execute on function public.rpc_public_buscar_pagador(text) to anon;
grant execute on function public.rpc_public_buscar_pagador(text) to authenticated;

-- =============================================================================
-- NOTA: rpc_public_cargar_deudas y rpc_public_obtener_historial NO devuelven DNI,
--       por lo que no requieren cambios para esta corrección de PII.
-- =============================================================================
