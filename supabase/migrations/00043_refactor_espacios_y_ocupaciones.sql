-- =============================================================================
-- Migración 00043 — Refactor de Espacios: 3 Tipos + Tabla de Ocupaciones
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Cambios:
--   1. tipo_espacio: 'Principal' → 'Regular' | 'Pequeño'  (+ 'Almacen' ya existía)
--   2. Puestos con sufijo -E[n] clasificados como 'Pequeño'.
--   3. Nueva tabla ocupaciones_almacenes (Socio/Inquilino/Tercero en Almacenes).
--   4. Migración de datos: Almacén → sacar de historial_titularidad/arriendos.
--   5. Triggers: bloquean nuevos Almacenes en historial_titularidad/arriendos.
--   6. Vista vw_espacios_con_ocupacion actualizada (incluye ocupaciones_almacenes).
--   7. Nueva vista vw_ocupacion_integral (unificada por tipo de persona).
--   8. generar_cargos_fijos_mes: también carga Almacenes vía ocupaciones_almacenes.
--   9. RPC rpc_asignar_almacen  — asigna Socio/Inquilino/Tercero a un Almacén.
--  10. RPC rpc_liberar_almacen  — cierra una ocupacion_almacen.
--  11. RPC rpc_transferir_puesto — transfiere Regular/Pequeño entre socios.
--  12. RLS para ocupaciones_almacenes.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. EXTENDER CHECK CONSTRAINT tipo_espacio: 'Principal' → 'Regular' | 'Pequeño'
-- =============================================================================
ALTER TABLE public.puestos
  DROP CONSTRAINT IF EXISTS puestos_tipo_espacio_check;

-- -E[n] suffix → 'Pequeño' (pequeños puestos comerciales)
UPDATE public.puestos
  SET tipo_espacio = 'Pequeño'
  WHERE tipo_espacio = 'Principal'
    AND deleted_at IS NULL
    AND codigo_puesto ~ '-E[0-9]*$';

-- Resto de 'Principal' → 'Regular'
UPDATE public.puestos
  SET tipo_espacio = 'Regular'
  WHERE tipo_espacio = 'Principal'
    AND deleted_at IS NULL;

-- Nuevo CHECK y DEFAULT
ALTER TABLE public.puestos
  ADD CONSTRAINT puestos_tipo_espacio_check
    CHECK (tipo_espacio IN ('Regular', 'Pequeño', 'Almacen'));

ALTER TABLE public.puestos
  ALTER COLUMN tipo_espacio SET DEFAULT 'Regular';

COMMENT ON COLUMN public.puestos.tipo_espacio IS
  'Regular = puesto comercial estándar del padrón. '
  'Pequeño = puesto comercial de dimensión reducida (ej. sufijo -E). '
  'Almacen = espacio complementario: depósito (-D), 2do piso (-SP) o espacio (-EP). '
  'Solo Regular/Pequeño tienen historial_titularidad. Almacén usa ocupaciones_almacenes.';

-- Actualizar índice
DROP INDEX IF EXISTS idx_puestos_tipo_espacio;
CREATE INDEX idx_puestos_tipo_espacio
  ON public.puestos (tipo_espacio) WHERE deleted_at IS NULL;

DO $$
DECLARE
  v_regular  int; v_pequeno int; v_almacen int;
BEGIN
  SELECT count(*) INTO v_regular  FROM public.puestos WHERE tipo_espacio = 'Regular'  AND deleted_at IS NULL;
  SELECT count(*) INTO v_pequeno  FROM public.puestos WHERE tipo_espacio = 'Pequeño'  AND deleted_at IS NULL;
  SELECT count(*) INTO v_almacen  FROM public.puestos WHERE tipo_espacio = 'Almacen'  AND deleted_at IS NULL;
  RAISE NOTICE '00043 — Clasificación: Regular=% | Pequeño=% | Almacen=%', v_regular, v_pequeno, v_almacen;
  IF (v_regular + v_pequeno) = 0 THEN
    RAISE EXCEPTION '00043: ningún puesto Regular/Pequeño encontrado. Revisar datos.';
  END IF;
  IF EXISTS (SELECT 1 FROM public.puestos WHERE tipo_espacio = 'Principal' AND deleted_at IS NULL) THEN
    RAISE EXCEPTION '00043: quedan puestos con tipo_espacio="Principal". Migración incompleta.';
  END IF;
END $$;


-- =============================================================================
-- 2. TABLA ocupaciones_almacenes
--    Append-only: fecha_fin=NULL → ocupación activa. Sin soft-delete propio.
-- =============================================================================
CREATE TABLE IF NOT EXISTS public.ocupaciones_almacenes (
  id             bigint      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  puesto_id      bigint      NOT NULL REFERENCES public.puestos(id),
  tipo_ocupante  text        NOT NULL CHECK (tipo_ocupante IN ('Socio', 'Inquilino', 'Tercero')),
  socio_id       bigint               REFERENCES public.socios(id),
  inquilino_id   bigint               REFERENCES public.inquilinos(id),
  fecha_inicio   date        NOT NULL DEFAULT current_date,
  fecha_fin      date,
  motivo_cierre  text,
  created_at     timestamptz NOT NULL DEFAULT now(),
  created_by     uuid                 REFERENCES auth.users(id),
  updated_at     timestamptz,
  CONSTRAINT ck_oa_persona_coherente CHECK (
    (tipo_ocupante = 'Socio'
      AND socio_id     IS NOT NULL
      AND inquilino_id IS NULL)
    OR
    (tipo_ocupante IN ('Inquilino', 'Tercero')
      AND inquilino_id IS NOT NULL
      AND socio_id     IS NULL)
  ),
  CONSTRAINT ck_oa_cierre_coherente CHECK (
    (fecha_fin IS NULL     AND motivo_cierre IS NULL)
    OR
    (fecha_fin IS NOT NULL AND motivo_cierre IS NOT NULL)
  )
);

COMMENT ON TABLE public.ocupaciones_almacenes IS
  'Historial append-only de ocupaciones para espacios tipo Almacén. '
  'Un Socio, Inquilino o Tercero puede ocupar un Almacén por períodos. '
  'fecha_fin = NULL → ocupación vigente. Nunca DELETE sobre esta tabla.';

COMMENT ON COLUMN public.ocupaciones_almacenes.tipo_ocupante IS
  'Socio = socio de la cooperativa. '
  'Inquilino = arrendatario temporal. '
  'Tercero = persona externa sin vínculo con la cooperativa.';

CREATE INDEX IF NOT EXISTS idx_oa_puesto_activo
  ON public.ocupaciones_almacenes (puesto_id) WHERE fecha_fin IS NULL;
CREATE INDEX IF NOT EXISTS idx_oa_socio_activo
  ON public.ocupaciones_almacenes (socio_id) WHERE socio_id IS NOT NULL AND fecha_fin IS NULL;
CREATE INDEX IF NOT EXISTS idx_oa_inquilino_activo
  ON public.ocupaciones_almacenes (inquilino_id) WHERE inquilino_id IS NOT NULL AND fecha_fin IS NULL;
CREATE INDEX IF NOT EXISTS idx_oa_tipo_ocupante
  ON public.ocupaciones_almacenes (tipo_ocupante) WHERE fecha_fin IS NULL;


-- =============================================================================
-- 3. MIGRACIÓN DE DATOS: historial_titularidad (Almacén) → ocupaciones_almacenes
--    Se copian TODOS los registros (activos e históricos).
--    Los activos quedan con fecha_fin=NULL en ocupaciones_almacenes.
--    Luego se cierran en historial_titularidad para desacoplarlos.
-- =============================================================================
INSERT INTO public.ocupaciones_almacenes
  (puesto_id, tipo_ocupante, socio_id, inquilino_id,
   fecha_inicio, fecha_fin, motivo_cierre, created_at, created_by)
SELECT
  ht.puesto_id,
  'Socio',
  ht.socio_id,
  NULL,
  ht.fecha_inicio,
  ht.fecha_fin,
  CASE
    WHEN ht.fecha_fin IS NULL     THEN NULL
    ELSE COALESCE(ht.motivo_cambio, 'Historial previo migrado (00043)')
  END,
  now(),
  NULL::uuid
FROM public.historial_titularidad ht
JOIN public.puestos p ON p.id = ht.puesto_id
WHERE p.tipo_espacio = 'Almacen'
  AND p.deleted_at   IS NULL;

-- Cerrar las titularidades activas de Almacén en historial_titularidad
UPDATE public.historial_titularidad ht
  SET fecha_fin     = current_date,
      motivo_cambio = 'Migrado a ocupaciones_almacenes (00043)'
  FROM public.puestos p
  WHERE p.id           = ht.puesto_id
    AND p.tipo_espacio  = 'Almacen'
    AND p.deleted_at   IS NULL
    AND ht.fecha_fin   IS NULL;

DO $$
DECLARE v_oa_titularidad int;
BEGIN
  SELECT count(*) INTO v_oa_titularidad
  FROM public.ocupaciones_almacenes oa
  JOIN public.puestos p ON p.id = oa.puesto_id
  WHERE p.tipo_espacio = 'Almacen';
  RAISE NOTICE '00043 — ocupaciones_almacenes insertadas desde titularidad: %', v_oa_titularidad;
END $$;


-- =============================================================================
-- 4. MIGRACIÓN DE DATOS: historial_arriendos (Almacén) → ocupaciones_almacenes
--    tipo_ocupante se toma de inquilinos.tipo_inquilino ('Inquilino' | 'Tercero').
-- =============================================================================
INSERT INTO public.ocupaciones_almacenes
  (puesto_id, tipo_ocupante, socio_id, inquilino_id,
   fecha_inicio, fecha_fin, motivo_cierre, created_at, created_by)
SELECT
  ha.puesto_id,
  i.tipo_inquilino,   -- 'Inquilino' o 'Tercero'
  NULL,
  ha.inquilino_id,
  ha.fecha_inicio,
  ha.fecha_fin,
  CASE
    WHEN ha.fecha_fin IS NULL THEN NULL
    ELSE 'Historial de arriendo migrado (00043)'
  END,
  now(),
  NULL::uuid
FROM public.historial_arriendos ha
JOIN public.puestos p    ON p.id  = ha.puesto_id
JOIN public.inquilinos i ON i.id  = ha.inquilino_id
WHERE p.tipo_espacio = 'Almacen'
  AND p.deleted_at   IS NULL;

-- Cerrar los arriendos activos de Almacén en historial_arriendos
UPDATE public.historial_arriendos ha
  SET fecha_fin = current_date
  FROM public.puestos p
  WHERE p.id           = ha.puesto_id
    AND p.tipo_espacio  = 'Almacen'
    AND p.deleted_at   IS NULL
    AND ha.fecha_fin   IS NULL;

DO $$
DECLARE v_oa_arriendos int;
BEGIN
  SELECT count(*) INTO v_oa_arriendos
  FROM public.ocupaciones_almacenes;
  RAISE NOTICE '00043 — ocupaciones_almacenes total tras migración: %', v_oa_arriendos;
END $$;


-- =============================================================================
-- 5. TRIGGERS: Bloquear nuevas entradas de Almacén en historial_*
--    Después de la migración, historial_titularidad/arriendos son solo
--    para espacios Regular y Pequeño.
-- =============================================================================

-- 5a. Bloqueo en historial_titularidad
CREATE OR REPLACE FUNCTION public.tg_bloquear_almacen_en_titularidad()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  v_tipo text;
  v_cod  text;
BEGIN
  SELECT tipo_espacio, codigo_puesto INTO v_tipo, v_cod
  FROM public.puestos WHERE id = NEW.puesto_id;

  IF v_tipo = 'Almacen' THEN
    RAISE EXCEPTION
      'Regla 00043: Los Almacenes no usan historial_titularidad. '
      'Use rpc_asignar_almacen para el puesto "%" (id=%).',
      v_cod, NEW.puesto_id;
  END IF;
  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.tg_bloquear_almacen_en_titularidad IS
  'Bloquea INSERT/UPDATE en historial_titularidad para puestos tipo Almacén. '
  'Desde 00043 los Almacenes van a ocupaciones_almacenes.';

DROP TRIGGER IF EXISTS trg_bloquear_almacen_en_titularidad ON public.historial_titularidad;
CREATE TRIGGER trg_bloquear_almacen_en_titularidad
  BEFORE INSERT OR UPDATE ON public.historial_titularidad
  FOR EACH ROW EXECUTE FUNCTION public.tg_bloquear_almacen_en_titularidad();

-- 5b. Bloqueo en historial_arriendos
CREATE OR REPLACE FUNCTION public.tg_bloquear_almacen_en_arriendos()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  v_tipo text;
  v_cod  text;
BEGIN
  SELECT tipo_espacio, codigo_puesto INTO v_tipo, v_cod
  FROM public.puestos WHERE id = NEW.puesto_id;

  IF v_tipo = 'Almacen' THEN
    RAISE EXCEPTION
      'Regla 00043: Los Almacenes no usan historial_arriendos. '
      'Use rpc_asignar_almacen para el puesto "%" (id=%).',
      v_cod, NEW.puesto_id;
  END IF;
  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.tg_bloquear_almacen_en_arriendos IS
  'Bloquea INSERT en historial_arriendos para puestos tipo Almacén.';

DROP TRIGGER IF EXISTS trg_bloquear_almacen_en_arriendos ON public.historial_arriendos;
CREATE TRIGGER trg_bloquear_almacen_en_arriendos
  BEFORE INSERT ON public.historial_arriendos
  FOR EACH ROW EXECUTE FUNCTION public.tg_bloquear_almacen_en_arriendos();


-- =============================================================================
-- 6. TRIGGER: Validar que ocupaciones_almacenes solo apunte a puestos Almacén
-- =============================================================================
CREATE OR REPLACE FUNCTION public.tg_validar_puesto_en_ocupacion_almacen()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  v_tipo text;
  v_cod  text;
BEGIN
  SELECT tipo_espacio, codigo_puesto INTO v_tipo, v_cod
  FROM public.puestos WHERE id = NEW.puesto_id AND deleted_at IS NULL;

  IF v_tipo IS NULL THEN
    RAISE EXCEPTION 'Puesto id=% no encontrado o dado de baja.', NEW.puesto_id;
  END IF;

  IF v_tipo <> 'Almacen' THEN
    RAISE EXCEPTION
      'ocupaciones_almacenes solo acepta puestos tipo Almacén. '
      'Puesto "%" (id=%) es tipo "%". Use historial_titularidad/arriendos.',
      v_cod, NEW.puesto_id, v_tipo;
  END IF;

  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.tg_validar_puesto_en_ocupacion_almacen IS
  'Garantiza que ocupaciones_almacenes solo contenga puestos tipo Almacén.';

DROP TRIGGER IF EXISTS trg_validar_puesto_en_ocupacion_almacen ON public.ocupaciones_almacenes;
CREATE TRIGGER trg_validar_puesto_en_ocupacion_almacen
  BEFORE INSERT OR UPDATE ON public.ocupaciones_almacenes
  FOR EACH ROW EXECUTE FUNCTION public.tg_validar_puesto_en_ocupacion_almacen();


-- =============================================================================
-- 7. VISTA vw_espacios_con_ocupacion  (reescrita para 00043)
--    Regular/Pequeño: ocupante vía historial_titularidad / historial_arriendos.
--    Almacén: ocupante vía ocupaciones_almacenes.
--    Nuevo campo tipo_ocupante (unifica la semántica en un solo valor).
-- =============================================================================
CREATE OR REPLACE VIEW public.vw_espacios_con_ocupacion
WITH (security_invoker = true) AS
SELECT
  p.id                AS puesto_id,
  p.codigo_puesto,
  p.tipo_espacio,
  p.estado,
  p.giro_id,
  g.nombre            AS giro_nombre,
  p.area_m2,
  p.tiene_medidor_luz,
  p.tiene_medidor_agua,
  p.cobro_luz_activo,
  p.cobro_agua_activo,

  -- Titular socio: historial_titularidad para Regular/Pequeño;
  -- ocupaciones_almacenes tipo=Socio para Almacén.
  COALESCE(
    ht.socio_id,
    CASE WHEN oa.tipo_ocupante = 'Socio' THEN oa.socio_id ELSE NULL END
  )                   AS titular_id,
  COALESCE(s_t.nombres,   s_oa.nombres)   AS titular_nombres,
  COALESCE(s_t.apellidos, s_oa.apellidos) AS titular_apellidos,
  COALESCE(s_t.dni,       s_oa.dni)       AS titular_dni,
  COALESCE(s_t.estado,    s_oa.estado)    AS titular_estado,
  COALESCE(
    ht.fecha_inicio,
    CASE WHEN oa.tipo_ocupante = 'Socio' THEN oa.fecha_inicio ELSE NULL END
  )                   AS titularidad_inicio,

  -- Arrendatario: historial_arriendos para Regular/Pequeño;
  -- ocupaciones_almacenes tipo=Inquilino/Tercero para Almacén.
  COALESCE(
    ha.inquilino_id,
    CASE WHEN oa.tipo_ocupante IN ('Inquilino', 'Tercero') THEN oa.inquilino_id ELSE NULL END
  )                   AS inquilino_id,
  COALESCE(inq_h.nombres,   inq_oa.nombres)   AS inquilino_nombres,
  COALESCE(inq_h.apellidos, inq_oa.apellidos) AS inquilino_apellidos,
  COALESCE(inq_h.tipo_inquilino, inq_oa.tipo_inquilino) AS tipo_inquilino,
  COALESCE(
    ha.fecha_inicio,
    CASE WHEN oa.tipo_ocupante IN ('Inquilino', 'Tercero') THEN oa.fecha_inicio ELSE NULL END
  )                   AS arriendo_inicio,

  -- Tipo de ocupante explícito (nuevo en 00043)
  CASE
    WHEN ht.socio_id IS NOT NULL                                           THEN 'Socio'
    WHEN ha.inquilino_id IS NOT NULL AND inq_h.tipo_inquilino = 'Tercero'  THEN 'Tercero'
    WHEN ha.inquilino_id IS NOT NULL                                       THEN 'Inquilino'
    WHEN oa.tipo_ocupante IS NOT NULL                                      THEN oa.tipo_ocupante
    ELSE NULL
  END                 AS tipo_ocupante,

  -- ID de ocupacion_almacen activa (para rpc_liberar_almacen)
  CASE WHEN p.tipo_espacio = 'Almacen' THEN oa.id ELSE NULL END AS ocupacion_almacen_id

FROM public.puestos p
LEFT JOIN public.giros g
  ON g.id = p.giro_id AND g.deleted_at IS NULL
-- Regular/Pequeño: titular socio
LEFT JOIN public.historial_titularidad ht
  ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
LEFT JOIN public.socios s_t
  ON s_t.id = ht.socio_id AND s_t.deleted_at IS NULL
-- Regular/Pequeño: arrendatario inquilino
LEFT JOIN public.historial_arriendos ha
  ON ha.puesto_id = p.id AND ha.fecha_fin IS NULL
LEFT JOIN public.inquilinos inq_h
  ON inq_h.id = ha.inquilino_id AND inq_h.deleted_at IS NULL
-- Almacén: ocupación vía tabla dedicada
LEFT JOIN public.ocupaciones_almacenes oa
  ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
LEFT JOIN public.socios s_oa
  ON s_oa.id = oa.socio_id AND s_oa.deleted_at IS NULL
LEFT JOIN public.inquilinos inq_oa
  ON inq_oa.id = oa.inquilino_id AND inq_oa.deleted_at IS NULL
WHERE p.deleted_at IS NULL
ORDER BY p.tipo_espacio, p.codigo_puesto;

COMMENT ON VIEW public.vw_espacios_con_ocupacion IS
  'Vista operativa de todos los espacios con su tipo, estado de servicios y '
  'ocupante vigente. Regular/Pequeño usan historial_titularidad/arriendos; '
  'Almacén usa ocupaciones_almacenes (migración 00043). '
  'Nuevo campo tipo_ocupante unifica la semántica.';

GRANT SELECT ON public.vw_espacios_con_ocupacion TO authenticated;


-- =============================================================================
-- 8. VISTA vw_ocupacion_integral
--    Vista UNION plana de todas las ocupaciones activas, cualquier tipo de espacio.
--    Útil para reportes de morosidad y listado global de responsables.
-- =============================================================================
CREATE OR REPLACE VIEW public.vw_ocupacion_integral
WITH (security_invoker = true) AS
-- Regular/Pequeño → socio titular
SELECT
  p.id          AS puesto_id,
  p.codigo_puesto,
  p.tipo_espacio,
  p.estado      AS estado_puesto,
  g.nombre      AS giro_nombre,
  'Socio'       AS tipo_ocupante,
  s.id          AS persona_id,
  s.nombres     AS persona_nombres,
  s.apellidos   AS persona_apellidos,
  s.dni         AS persona_dni,
  ht.fecha_inicio AS ocupacion_desde,
  NULL::date    AS ocupacion_hasta
FROM public.puestos p
LEFT JOIN public.giros g ON g.id = p.giro_id AND g.deleted_at IS NULL
JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
JOIN public.socios s ON s.id = ht.socio_id AND s.deleted_at IS NULL
WHERE p.deleted_at IS NULL

UNION ALL

-- Regular/Pequeño → inquilino arrendatario
SELECT
  p.id, p.codigo_puesto, p.tipo_espacio, p.estado,
  g.nombre,
  i.tipo_inquilino,
  i.id, i.nombres, i.apellidos, i.dni,
  ha.fecha_inicio, NULL::date
FROM public.puestos p
LEFT JOIN public.giros g ON g.id = p.giro_id AND g.deleted_at IS NULL
JOIN public.historial_arriendos ha ON ha.puesto_id = p.id AND ha.fecha_fin IS NULL
JOIN public.inquilinos i ON i.id = ha.inquilino_id AND i.deleted_at IS NULL
WHERE p.deleted_at IS NULL

UNION ALL

-- Almacén → cualquier tipo de ocupante
SELECT
  p.id, p.codigo_puesto, p.tipo_espacio, p.estado,
  g.nombre,
  oa.tipo_ocupante,
  COALESCE(oa.socio_id, oa.inquilino_id),
  COALESCE(s.nombres,  inq.nombres),
  COALESCE(s.apellidos, inq.apellidos),
  COALESCE(s.dni,      inq.dni),
  oa.fecha_inicio, oa.fecha_fin
FROM public.puestos p
LEFT JOIN public.giros g ON g.id = p.giro_id AND g.deleted_at IS NULL
JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
LEFT JOIN public.socios s   ON s.id   = oa.socio_id     AND s.deleted_at   IS NULL
LEFT JOIN public.inquilinos inq ON inq.id = oa.inquilino_id AND inq.deleted_at IS NULL
WHERE p.deleted_at IS NULL AND p.tipo_espacio = 'Almacen';

COMMENT ON VIEW public.vw_ocupacion_integral IS
  'Vista UNION de todas las ocupaciones activas (Regular, Pequeño, Almacén). '
  'Un Regular/Pequeño puede aparecer dos veces: una para el Socio titular y '
  'otra para el Inquilino que lo arrienda.';

GRANT SELECT ON public.vw_ocupacion_integral TO authenticated;


-- =============================================================================
-- 9. ACTUALIZAR generar_cargos_fijos_mes
--    Ahora también genera cargos para Almacenes vía ocupaciones_almacenes.
--    Los Almacenes con ocupación activa reciben los mismos cargos fijos.
-- =============================================================================
CREATE OR REPLACE FUNCTION public.generar_cargos_fijos_mes(
    p_anio                  smallint,
    p_mes                   smallint,
    p_usuario               uuid,
    p_monto_admin           numeric  DEFAULT NULL,
    p_monto_prevision       numeric  DEFAULT NULL,
    p_monto_mantenimiento   numeric  DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_id_admin   bigint;
    v_id_prev    bigint;
    v_id_mant    bigint;
    -- Contadores para Regular/Pequeño (vía historial_titularidad)
    v_cnt_admin  int := 0;
    v_cnt_prev   int := 0;
    v_cnt_mant   int := 0;
    -- Contadores para Almacén (vía ocupaciones_almacenes)
    v_cnt_alm_admin int := 0;
    v_cnt_alm_prev  int := 0;
    v_cnt_alm_mant  int := 0;
    -- Totales informativos
    v_cnt_principales int := 0;
    v_cnt_almacenes   int := 0;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el rol Administrador puede generar cargos masivos.';
    END IF;

    IF p_monto_admin IS NULL THEN
        SELECT valor INTO p_monto_admin FROM public.configuraciones WHERE clave = 'MONTO_GASTOS_ADMIN';
    END IF;
    IF p_monto_prevision IS NULL THEN
        SELECT valor INTO p_monto_prevision FROM public.configuraciones WHERE clave = 'MONTO_PREVISION_SOCIAL';
    END IF;
    IF p_monto_mantenimiento IS NULL THEN
        SELECT valor INTO p_monto_mantenimiento FROM public.configuraciones WHERE clave = 'MONTO_MANTENIMIENTO';
    END IF;

    IF p_anio NOT BETWEEN 2000 AND 2100 THEN RAISE EXCEPTION 'Año inválido: %', p_anio; END IF;
    IF p_mes  NOT BETWEEN 1 AND 12      THEN RAISE EXCEPTION 'Mes inválido: %', p_mes;  END IF;
    IF coalesce(p_monto_admin, 0) <= 0         THEN RAISE EXCEPTION 'MONTO_GASTOS_ADMIN inválido.';       END IF;
    IF coalesce(p_monto_prevision, 0) <= 0     THEN RAISE EXCEPTION 'MONTO_PREVISION_SOCIAL inválido.';   END IF;
    IF coalesce(p_monto_mantenimiento, 0) <= 0 THEN RAISE EXCEPTION 'MONTO_MANTENIMIENTO inválido.';      END IF;

    SELECT id INTO v_id_admin FROM public.conceptos WHERE nombre = 'Gastos administrativos' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_id_prev  FROM public.conceptos WHERE nombre = 'Previsión social'        AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_id_mant  FROM public.conceptos WHERE nombre = 'Mantenimiento'           AND deleted_at IS NULL LIMIT 1;

    IF v_id_admin IS NULL THEN RAISE EXCEPTION 'Concepto "Gastos administrativos" no encontrado.'; END IF;
    IF v_id_prev  IS NULL THEN RAISE EXCEPTION 'Concepto "Previsión social" no encontrado.';       END IF;
    IF v_id_mant  IS NULL THEN RAISE EXCEPTION 'Concepto "Mantenimiento" no encontrado.';          END IF;

    -- Conteo informativo
    SELECT count(*) INTO v_cnt_principales
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL;

    SELECT count(DISTINCT p.id) INTO v_cnt_almacenes
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL;

    -- ── Regular/Pequeño: Gastos administrativos ─────────────────────────────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT p.id, v_id_admin, p_anio, p_mes, p_monto_admin,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_admin = ROW_COUNT;

    -- ── Regular/Pequeño: Previsión social ────────────────────────────────────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT p.id, v_id_prev, p_anio, p_mes, p_monto_prevision,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_prev = ROW_COUNT;

    -- ── Regular/Pequeño: Mantenimiento ──────────────────────────────────────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT p.id, v_id_mant, p_anio, p_mes, p_monto_mantenimiento,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_mant = ROW_COUNT;

    -- ── Almacén: Gastos administrativos ─────────────────────────────────────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT DISTINCT p.id, v_id_admin, p_anio, p_mes, p_monto_admin,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_alm_admin = ROW_COUNT;

    -- ── Almacén: Previsión social ────────────────────────────────────────────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT DISTINCT p.id, v_id_prev, p_anio, p_mes, p_monto_prevision,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_alm_prev = ROW_COUNT;

    -- ── Almacén: Mantenimiento ───────────────────────────────────────────────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT DISTINCT p.id, v_id_mant, p_anio, p_mes, p_monto_mantenimiento,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_alm_mant = ROW_COUNT;

    RETURN jsonb_build_object(
        'periodo',                    jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'puestos_principales',        v_cnt_principales,
        'puestos_almacenes',          v_cnt_almacenes,
        'gastos_administrativos',     v_cnt_admin  + v_cnt_alm_admin,
        'prevision_social',           v_cnt_prev   + v_cnt_alm_prev,
        'mantenimiento',              v_cnt_mant   + v_cnt_alm_mant,
        'total_insertados',           v_cnt_admin  + v_cnt_prev  + v_cnt_mant
                                    + v_cnt_alm_admin + v_cnt_alm_prev + v_cnt_alm_mant
    );
END;
$$;

COMMENT ON FUNCTION public.generar_cargos_fijos_mes IS
    'Genera masivamente los cargos fijos del mes para Regular/Pequeño (vía historial_titularidad) '
    'y para Almacenes con ocupación activa (vía ocupaciones_almacenes). Idempotente. (00043)';

GRANT EXECUTE ON FUNCTION public.generar_cargos_fijos_mes TO authenticated;


-- =============================================================================
-- 10. RPC rpc_asignar_almacen
--     Crea una nueva ocupacion_almacen. Solo Administrador.
--     Falla si ya hay una ocupación activa en ese almacén.
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_asignar_almacen(
    p_puesto_id      bigint,
    p_tipo_ocupante  text,       -- 'Socio' | 'Inquilino' | 'Tercero'
    p_socio_id       bigint  DEFAULT NULL,
    p_inquilino_id   bigint  DEFAULT NULL,
    p_fecha_inicio   date    DEFAULT current_date,
    p_usuario        uuid    DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_tipo text;
    v_cod  text;
    v_id   bigint;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede asignar Almacenes.';
    END IF;
    IF p_usuario IS NULL THEN p_usuario := auth.uid(); END IF;

    IF p_tipo_ocupante NOT IN ('Socio', 'Inquilino', 'Tercero') THEN
        RAISE EXCEPTION 'tipo_ocupante inválido: "%". Usar Socio | Inquilino | Tercero.', p_tipo_ocupante;
    END IF;
    IF p_tipo_ocupante = 'Socio'     AND p_socio_id     IS NULL THEN
        RAISE EXCEPTION 'tipo_ocupante=Socio requiere p_socio_id.';
    END IF;
    IF p_tipo_ocupante IN ('Inquilino', 'Tercero') AND p_inquilino_id IS NULL THEN
        RAISE EXCEPTION 'tipo_ocupante=% requiere p_inquilino_id.', p_tipo_ocupante;
    END IF;

    SELECT tipo_espacio, codigo_puesto INTO v_tipo, v_cod
    FROM public.puestos WHERE id = p_puesto_id AND deleted_at IS NULL;

    IF v_tipo IS NULL THEN
        RAISE EXCEPTION 'Puesto id=% no encontrado o dado de baja.', p_puesto_id;
    END IF;
    IF v_tipo <> 'Almacen' THEN
        RAISE EXCEPTION 'rpc_asignar_almacen solo aplica a puestos tipo Almacén. Puesto "%" es tipo "%".', v_cod, v_tipo;
    END IF;

    IF EXISTS (
        SELECT 1 FROM public.ocupaciones_almacenes
        WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL
    ) THEN
        RAISE EXCEPTION
            'El Almacén "%" ya tiene una ocupación activa. '
            'Ejecute rpc_liberar_almacen primero.', v_cod;
    END IF;

    INSERT INTO public.ocupaciones_almacenes
        (puesto_id, tipo_ocupante, socio_id, inquilino_id, fecha_inicio, created_by)
    VALUES
        (p_puesto_id, p_tipo_ocupante, p_socio_id, p_inquilino_id, p_fecha_inicio, p_usuario)
    RETURNING id INTO v_id;

    RETURN jsonb_build_object(
        'id',             v_id,
        'puesto_id',      p_puesto_id,
        'codigo_puesto',  v_cod,
        'tipo_ocupante',  p_tipo_ocupante,
        'fecha_inicio',   p_fecha_inicio
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_asignar_almacen IS
    'Crea una ocupacion_almacen activa para un espacio tipo Almacén. Solo Administrador. '
    'Falla si ya existe una ocupación activa en ese almacén. (00043)';

GRANT EXECUTE ON FUNCTION public.rpc_asignar_almacen TO authenticated;


-- =============================================================================
-- 11. RPC rpc_liberar_almacen
--     Cierra una ocupacion_almacen (pone fecha_fin + motivo). Solo Administrador.
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_liberar_almacen(
    p_ocupacion_id  bigint,
    p_motivo        text,
    p_fecha_fin     date  DEFAULT current_date,
    p_usuario       uuid  DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_oa    public.ocupaciones_almacenes%ROWTYPE;
    v_cod   text;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede liberar Almacenes.';
    END IF;
    IF p_usuario IS NULL THEN p_usuario := auth.uid(); END IF;
    IF coalesce(trim(p_motivo), '') = '' THEN
        RAISE EXCEPTION 'Se requiere un motivo para liberar el Almacén.';
    END IF;

    SELECT * INTO v_oa
    FROM public.ocupaciones_almacenes
    WHERE id = p_ocupacion_id AND fecha_fin IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Ocupación id=% no encontrada o ya cerrada.', p_ocupacion_id;
    END IF;

    SELECT codigo_puesto INTO v_cod FROM public.puestos WHERE id = v_oa.puesto_id;

    UPDATE public.ocupaciones_almacenes
      SET fecha_fin     = p_fecha_fin,
          motivo_cierre = p_motivo,
          updated_at    = now()
    WHERE id = p_ocupacion_id;

    RETURN jsonb_build_object(
        'ocupacion_id',  p_ocupacion_id,
        'puesto_id',     v_oa.puesto_id,
        'codigo_puesto', v_cod,
        'tipo_ocupante', v_oa.tipo_ocupante,
        'fecha_inicio',  v_oa.fecha_inicio,
        'fecha_fin',     p_fecha_fin,
        'motivo',        p_motivo
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_liberar_almacen IS
    'Cierra una ocupacion_almacen activa. Solo Administrador. '
    'El almacén queda libre para una nueva asignación. (00043)';

GRANT EXECUTE ON FUNCTION public.rpc_liberar_almacen TO authenticated;


-- =============================================================================
-- 12. RPC rpc_transferir_puesto
--     Transfiere la titularidad de un puesto Regular/Pequeño a otro socio.
--     Retorna las deudas pendientes como advertencia (no bloquea la transferencia).
--     Solo Administrador.
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_transferir_puesto(
    p_puesto_id       bigint,
    p_nuevo_socio_id  bigint,
    p_motivo          text,
    p_fecha_efectiva  date  DEFAULT current_date,
    p_usuario         uuid  DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_tipo          text;
    v_cod           text;
    v_ht_id         bigint;
    v_socio_ant_id  bigint;
    v_deudas_cnt    int   := 0;
    v_deudas_total  numeric(14,2) := 0;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede transferir puestos.';
    END IF;
    IF p_usuario IS NULL THEN p_usuario := auth.uid(); END IF;
    IF coalesce(trim(p_motivo), '') = '' THEN
        RAISE EXCEPTION 'Se requiere un motivo para la transferencia.';
    END IF;

    -- Validar puesto
    SELECT tipo_espacio, codigo_puesto INTO v_tipo, v_cod
    FROM public.puestos WHERE id = p_puesto_id AND deleted_at IS NULL;

    IF v_tipo IS NULL THEN
        RAISE EXCEPTION 'Puesto id=% no encontrado o dado de baja.', p_puesto_id;
    END IF;
    IF v_tipo = 'Almacen' THEN
        RAISE EXCEPTION
            'rpc_transferir_puesto no aplica a Almacenes. '
            'Use rpc_liberar_almacen + rpc_asignar_almacen para el puesto "%" (id=%).', v_cod, p_puesto_id;
    END IF;

    -- Validar nuevo socio
    IF NOT EXISTS (SELECT 1 FROM public.socios WHERE id = p_nuevo_socio_id AND deleted_at IS NULL AND estado = 'Activo') THEN
        RAISE EXCEPTION 'Socio id=% no encontrado, dado de baja o inactivo.', p_nuevo_socio_id;
    END IF;

    -- Obtener titularidad actual
    SELECT id, socio_id INTO v_ht_id, v_socio_ant_id
    FROM public.historial_titularidad
    WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL;

    IF v_socio_ant_id = p_nuevo_socio_id THEN
        RAISE EXCEPTION 'El socio id=% ya es el titular del puesto "%".', p_nuevo_socio_id, v_cod;
    END IF;

    -- Contar deudas pendientes (informativo, no bloquea)
    SELECT count(*), coalesce(sum(monto), 0)
      INTO v_deudas_cnt, v_deudas_total
    FROM public.montos_por_cobrar
    WHERE puesto_id = p_puesto_id
      AND estado     = 'Pendiente'
      AND deleted_at IS NULL;

    -- Cerrar titularidad actual
    IF v_ht_id IS NOT NULL THEN
        UPDATE public.historial_titularidad
          SET fecha_fin     = p_fecha_efectiva,
              motivo_cambio = p_motivo
        WHERE id = v_ht_id;
    END IF;

    -- Abrir nueva titularidad
    INSERT INTO public.historial_titularidad
        (puesto_id, socio_id, fecha_inicio, motivo_cambio)
    VALUES
        (p_puesto_id, p_nuevo_socio_id, p_fecha_efectiva, p_motivo);

    RETURN jsonb_build_object(
        'puesto_id',               p_puesto_id,
        'codigo_puesto',           v_cod,
        'socio_anterior_id',       v_socio_ant_id,
        'socio_nuevo_id',          p_nuevo_socio_id,
        'fecha_efectiva',          p_fecha_efectiva,
        'motivo',                  p_motivo,
        'tiene_deudas_pendientes', v_deudas_cnt > 0,
        'deudas_pendientes_count', v_deudas_cnt,
        'deudas_pendientes_total', v_deudas_total
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_transferir_puesto IS
    'Transfiere la titularidad de un puesto Regular/Pequeño a otro socio Activo. '
    'Retorna advertencia con deudas pendientes (no bloquea la operación). Solo Administrador. (00043)';

GRANT EXECUTE ON FUNCTION public.rpc_transferir_puesto TO authenticated;


-- =============================================================================
-- 13. RLS para ocupaciones_almacenes
-- =============================================================================
ALTER TABLE public.ocupaciones_almacenes ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "ocupaciones_almacenes_select_authenticated" ON public.ocupaciones_almacenes;
CREATE POLICY "ocupaciones_almacenes_select_authenticated"
  ON public.ocupaciones_almacenes
  FOR SELECT
  TO authenticated
  USING (true);

-- INSERT/UPDATE/DELETE solo vía RPCs SECURITY DEFINER (sin políticas = denegado directo)


-- =============================================================================
-- 14. VERIFICACIÓN FINAL
-- =============================================================================
DO $$
DECLARE
  v_check_ok         boolean;
  v_tabla_existe     boolean;
  v_trig_titularidad boolean;
  v_trig_arriendos   boolean;
  v_rpc_asignar      boolean;
  v_rpc_liberar      boolean;
  v_rpc_transferir   boolean;
  v_sin_principal    boolean;
BEGIN
  -- No deben quedar puestos con tipo_espacio='Principal'
  SELECT NOT EXISTS (
    SELECT 1 FROM public.puestos WHERE tipo_espacio = 'Principal'
  ) INTO v_sin_principal;

  -- Tabla ocupaciones_almacenes existe
  SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'ocupaciones_almacenes'
  ) INTO v_tabla_existe;

  -- Triggers creados
  SELECT EXISTS (
    SELECT 1 FROM information_schema.triggers
    WHERE trigger_name = 'trg_bloquear_almacen_en_titularidad'
      AND event_object_table = 'historial_titularidad'
  ) INTO v_trig_titularidad;

  SELECT EXISTS (
    SELECT 1 FROM information_schema.triggers
    WHERE trigger_name = 'trg_bloquear_almacen_en_arriendos'
      AND event_object_table = 'historial_arriendos'
  ) INTO v_trig_arriendos;

  -- RPCs creadas
  SELECT EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'rpc_asignar_almacen')   INTO v_rpc_asignar;
  SELECT EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'rpc_liberar_almacen')   INTO v_rpc_liberar;
  SELECT EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'rpc_transferir_puesto') INTO v_rpc_transferir;

  IF NOT (v_sin_principal AND v_tabla_existe AND v_trig_titularidad AND v_trig_arriendos
          AND v_rpc_asignar AND v_rpc_liberar AND v_rpc_transferir) THEN
    RAISE EXCEPTION
      '00043 FALLO: sin_Principal=% tabla=% trig_ht=% trig_ha=% rpc_asignar=% rpc_liberar=% rpc_transferir=%',
      v_sin_principal, v_tabla_existe, v_trig_titularidad, v_trig_arriendos,
      v_rpc_asignar, v_rpc_liberar, v_rpc_transferir;
  END IF;

  RAISE NOTICE '00043 ✓ Migración completada. ocupaciones_almacenes activas: %',
    (SELECT count(*) FROM public.ocupaciones_almacenes WHERE fecha_fin IS NULL);
END $$;

COMMIT;
