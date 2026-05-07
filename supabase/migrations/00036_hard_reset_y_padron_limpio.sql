-- =============================================================================
-- Migración 00036 — HARD RESET + Padrón Limpio (generado 2026-05-07)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Fuente: migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx
-- =============================================================================
-- RESUMEN:
--   Socios:                185
--   Puestos únicos:        288
--   Inquilinos 1er piso:   64  (-E + COOP)
--   Inquilinos 2do piso:   6  (-SP)
--   Inquilinos espacios:   7  (-EP)
--   Inquilinos depós. D1:  7
--   Inquilinos depós. D2:  11
--   Inquilinos depós. D3:  8
--   Total inquilinos:      103
-- =============================================================================
-- ⚠️  PREREQUISITO:
--   Debe existir un socio con DNI='00000000' que represente a la Cooperativa.
--   Se usa como socio_titular_id en puestos SP, EP y Depósitos.
--   Si no existe, los arriendos SP/EP/D emitirán WARNING y se omitirán.
-- ⚠️  VERIFICAR MANUALMENTE:
--   [ ] Socios con DNI duplicado (sufijo -DUP): verificar identidad
--       • 08386039
-- =============================================================================

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 0: HARD RESET — Truncar todas las tablas del padrón y financieras
-- ─────────────────────────────────────────────────────────────────────────────
-- ⚠️  DESTRUCTIVO E IRREVERSIBLE. Solo ejecutar en entorno NO-producción.
TRUNCATE
  public.detalle_pagos,
  public.pagos,
  public.recaudacion_abonos,
  public.montos_por_cobrar,
  public.historial_arriendos,
  public.historial_titularidad,
  public.inquilinos,
  public.socios,
  public.puestos
CASCADE;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 0b: Reiniciar secuencias de ID para partir desde 1
-- ─────────────────────────────────────────────────────────────────────────────
ALTER SEQUENCE IF EXISTS public.detalle_pagos_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.pagos_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.recaudacion_abonos_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.montos_por_cobrar_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.historial_arriendos_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.historial_titularidad_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.inquilinos_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.socios_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.puestos_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.seq_codigo_transaccion RESTART WITH 1;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 1: Insertar 288 puestos (socios + E + SP + EP + D1/D2/D3)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.puestos (codigo_puesto, giro_id, estado, tiene_medidor_luz, tiene_medidor_agua)
VALUES
  ('1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('1-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('1-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('1-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('1-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('1-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
  ('1-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- 2do Piso
  ('2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('2-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('2-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('2-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('2-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('2-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
  ('2-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- 2do Piso
  ('3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('3-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('3-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('3-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('3-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('3-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
  ('3-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- 2do Piso
  ('4', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('4-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('4-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('4-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('4-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('4-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
  ('4-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- 2do Piso
  ('5', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('5-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('5-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('5-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('5-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('5-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
  ('5-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- 2do Piso
  ('6', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('6-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('6-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('6-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('6-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('6-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
  ('6-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- 2do Piso
  ('7-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('7-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('7-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('7-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('7-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
  ('8', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('8-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('8-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('8-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('9', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('9-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('9-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('10', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('10-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('10-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('11-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
  ('11-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('12', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('12-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('13', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('13-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('14', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('14-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('15', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('15-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('16', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('16-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('17', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('17-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('18', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('18-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('19', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('19-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('20', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('20-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('21', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('21-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('22', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('22-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('23', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('23-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('24', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('24-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('25', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('25-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('26', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('26-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('27', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('27-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('28', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('28-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('29', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('29-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('30', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('30-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('31', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('31-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('32', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('32-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('33', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('33-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('34', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('34-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('35', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('36', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('37', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('37-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('38', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('38-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('39', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('39-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('40', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('40-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('41', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('41-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('42', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('42-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('43', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('43-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('44', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('44-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('45', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('45-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('46', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('46-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('47', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('47-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('48', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('48-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('49', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('49-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('50', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('50-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('51', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('51-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('52', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('52-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('53', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('53-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('54', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('54-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('55', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('55-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('56', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('56-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('57', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('57-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('58', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('58-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('59', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('59-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('60', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('60-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('61', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('61-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('62', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('62-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
  ('63', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('64', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('65', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('66', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('67', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('68', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('69', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('70', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('71', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('72', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('73', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('74', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('75', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('76', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('78', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('79', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('80', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('81', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('82', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('83', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('84', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('85', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('86', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('87', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('88', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('89', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('90', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('91', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('93', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('94', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('95', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('96', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('97', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('98', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('99', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('100', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('101', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('102', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('103', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('104', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('105', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('106', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('107', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('108', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('109', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('110', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('111', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('112', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('113', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('114', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('115', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('116', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('117', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('118', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('119', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('120', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('121', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('122', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('123', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('124', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('125', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('126', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('127', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('128', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('129', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('130', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('131', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('132', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('133', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('134', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('135', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('136', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('137', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('138', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('139', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('140', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('141', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('142', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('143', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('144', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('145', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('146', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('147', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('148', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('149', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('150', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('151', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('152', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('153', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('154', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('155', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('156', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('157', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('158', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('159', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('160', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('161', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('162', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('163', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('164', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('165', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('166', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('167', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('168', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('169', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('170', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('171', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('172', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('174', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('175', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('176', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('177', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('178', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('179', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('180', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('181', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('182', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('183', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('184', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('185', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('186', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('187', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('188', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('189', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('190', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('191', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('192', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('194', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
  ('195', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false)
ON CONFLICT (codigo_puesto) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 2: Insertar 185 socios
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.socios
  (dni, nombres, apellidos, estado, habilitado, fecha_ingreso,
   usa_recaudacion_tarjeta)
VALUES
  ('08910771', '', 'AGUIRRE QUISPE WILFREDO GILMER', 'Activo', true, '2020-01-01', false),
  ('41500340', '', 'ALARCON ANAMPA BETSY JANET', 'Activo', true, '2020-01-01', false),
  ('10648704', '', 'ALARCON ANAMPA NANCY GUISELA', 'Activo', true, '2020-01-01', false),
  ('07036952', '', 'ALHUAY PALOMINO DE ALHUAY JUANA', 'Activo', true, '2020-01-01', false),
  ('08351184', '', 'ALVAREZ CAMPOS ROLANDO', 'Activo', true, '2020-01-01', false),
  ('27388264', '', 'ALVAREZ CAMPOS VICTOR ADRIANO', 'Activo', true, '2020-01-01', false),
  ('45483108', '', 'ALVAREZ MARIN MARIANELA', 'Activo', true, '2020-01-01', false),
  ('08408918', '', 'ANAMPA CORAHUA CLEMENCIA MIGDONIA', 'Activo', true, '2020-01-01', false),
  ('08389869', '', 'ANCCO LEON VALENTINA', 'Activo', true, '2020-01-01', false),
  ('08925026', '', 'ATANASIO ORTEGA MAXIMILIANA', 'Activo', true, '2020-01-01', false),
  ('40605904', '', 'AYALA HUASHUAYO NORMA GLADYS', 'Activo', true, '2020-01-01', false),
  ('08376344', '', 'AYALA TABOADA ELISEO', 'Activo', true, '2020-01-01', false),
  ('09411772', '', 'BASTIDAS MEDINA DINA', 'Activo', true, '2020-01-01', false),
  ('09128242', '', 'BASTIDAS MEDINA HERMENEGILDO', 'Activo', true, '2020-01-01', false),
  ('08367778', '', 'BERNAOLA CARHUAZ DE PRADO FLORENCIA', 'Activo', true, '2020-01-01', false),
  ('08407044', '', 'BRAVO HEREDIA ANA MARITZA', 'Activo', true, '2020-01-01', false),
  ('42735431', '', 'BURGA CARRASCO ELIDA', 'Activo', true, '2020-01-01', false),
  ('08385382', '', 'CABALLERO CALZADO GLADYS VICTORIA', 'Activo', true, '2020-01-01', false),
  ('10746685', '', 'CABERO MENDOZA GLORIA LUCINDA', 'Activo', true, '2020-01-01', false),
  ('08408319', '', 'CAHUANA VDA DE DAVILA VICENTINA', 'Activo', true, '2020-01-01', false),
  ('42591926', '', 'CAJALEON CARRASCO LUIS ENRIQUE', 'Activo', true, '2020-01-01', false),
  ('42194583', '', 'CALDERON TORRES BERTHA ESTELA', 'Activo', true, '2020-01-01', false),
  ('08377848', '', 'CALDERON VERA SEGUNDO ALCIDES', 'Activo', true, '2020-01-01', false),
  ('44426461', '', 'CALLE ALVAREZ MARCO ANTONIO', 'Activo', true, '2020-01-01', false),
  ('08352573', '', 'CALLE CALLE FIDEL', 'Activo', true, '2020-01-01', false),
  ('08365775', '', 'CAMPUZANO CABELLO VICENTA DONATILA', 'Activo', true, '2020-01-01', false),
  ('08352205', '', 'CARDENA VILLAFUERTE ALEJANDRINA', 'Activo', true, '2020-01-01', false),
  ('10483507', '', 'CARPIO VASQUEZ TEOFILA', 'Activo', true, '2020-01-01', false),
  ('08408186', '', 'CARRASCO SALVATIERRA FELICITA', 'Activo', true, '2020-01-01', false),
  ('08378575', '', 'CARTAGENA MAMANI BENJAMIN D', 'Activo', true, '2020-01-01', false),
  ('10644600', '', 'CARTAGENA PALOMINO ALVARO BENJAMIN', 'Activo', true, '2020-01-01', false),
  ('09264887', '', 'CASTRO ALEJANDRO HORTENCIA LUCILA', 'Activo', true, '2020-01-01', false),
  ('08410781', '', 'CASTRO GUTIERREZ AQUILA LUCRECIA', 'Activo', true, '2020-01-01', false),
  ('47825713', '', 'CCOYLLO BUSTILLOS DEYSI KAREN', 'Activo', true, '2020-01-01', false),
  ('10129111', '', 'CCOYLLO CHINCHAY DANIEL MASIA', 'Activo', true, '2020-01-01', false),
  ('10549481', '', 'CCOYLLO CHINCHAY JUDITH NATY', 'Activo', true, '2020-01-01', false),
  ('75274713', '', 'CCOYLLO MAYHUASCA ALEXIS', 'Activo', true, '2020-01-01', false),
  ('08964390', '', 'CCOYLLO POLANCO DANIEL', 'Activo', true, '2020-01-01', false),
  ('08237117', '', 'CCOYLLO POLANCO GERMAN', 'Activo', true, '2020-01-01', false),
  ('09124337', '', 'CERDA YUPANQUI CARMEN ROSA', 'Activo', true, '2020-01-01', false),
  ('08980503', '', 'CHALLCO CRUZ DE PALOMINO NICOLAZA', 'Activo', true, '2020-01-01', false),
  ('08954535', '', 'CHIRINOS CABRACANCHA MARIA LOURDES', 'Activo', true, '2020-01-01', false),
  ('08998291', '', 'CHOQUEHUAMANI FELIX CEFERINO', 'Activo', true, '2020-01-01', false),
  ('08365528', '', 'CHUCHULLO HACHA JOSE PEDRO', 'Activo', true, '2020-01-01', false),
  ('09133532', '', 'CLEMENTE ALLER CIRILA', 'Activo', true, '2020-01-01', false),
  ('10084032', '', 'CORDOVA PEREZ MARCO ANTONIO', 'Activo', true, '2020-01-01', false),
  ('10525929', '', 'CORNEJO DONATO DE CORDOVA ESTELA PILAR', 'Activo', true, '2020-01-01', false),
  ('09126040', '', 'CRUZ JARAMILLO LUIS', 'Activo', true, '2020-01-01', false),
  ('08412232', '', 'CUCHO DE LA CRUZ SAUL PEDRO', 'Activo', true, '2020-01-01', false),
  ('08376979', '', 'CUEVAS MAYO ENRIQUE', 'Activo', true, '2020-01-01', false),
  ('41204316', '', 'CULE CARRASCO HAYDEE MONICA', 'Activo', true, '2020-01-01', false),
  ('10487155', '', 'CUSI LAURA SONIA', 'Activo', true, '2020-01-01', false),
  ('41110013', '', 'CUYA SANCHEZ ALBERTO', 'Activo', true, '2020-01-01', false),
  ('10022005', '', 'DAVILA CAHUANA DE PAZ MARISOL', 'Activo', true, '2020-01-01', false),
  ('08409231', '', 'DE LA CRUZ ESTEBAN JOSE LUIS', 'Activo', true, '2020-01-01', false),
  ('09723857', '', 'ESPEJO URBANO ROSA FLORENCIA', 'Activo', true, '2020-01-01', false),
  ('10654208', '', 'ESTELA SUAREZ ELVIA', 'Activo', true, '2020-01-01', false),
  ('09868359', '', 'ESTRADA CHACON OSCAR ALFREDO', 'Activo', true, '2020-01-01', false),
  ('08352447', '', 'FALCON CHIARA HECTOR MARCIAL', 'Activo', true, '2020-01-01', false),
  ('08363681', '', 'FLORES FLORES IRENE BERTILIA', 'Activo', true, '2020-01-01', false),
  ('08362728', '', 'FLORES FLORES UMBELINA DORA', 'Activo', true, '2020-01-01', false),
  ('10347533', '', 'FLORES YATO FRANCISCA DOLORES', 'Activo', true, '2020-01-01', false),
  ('08408138', '', 'GAVILAN MOSQUERA NORMA LUZ', 'Activo', true, '2020-01-01', false),
  ('08395960', '', 'GELDRES REVILLA MIGUEL ANGEL', 'Activo', true, '2020-01-01', false),
  ('10541347', '', 'GUTIERREZ CASTILLO JORGE JAIME', 'Activo', true, '2020-01-01', false),
  ('20101992', '', 'GUTIERREZ CASTILLO TERESA JESUS', 'Activo', true, '2020-01-01', false),
  ('70065666', '', 'GUTIERREZ CASTRO JORGE RICARDO', 'Activo', true, '2020-01-01', false),
  ('41842805', '', 'GUTIERREZ FLORES ROGER REYNAN', 'Activo', true, '2020-01-01', false),
  ('46805327', '', 'HALIRE YUCRA JOSUE JAASIEL', 'Activo', true, '2020-01-01', false),
  ('08406481', '', 'HEREDIA MUNOZ DE BRAVO MARIA', 'Activo', true, '2020-01-01', false),
  ('08398541', '', 'HUAMAN YNCA VISITACION', 'Activo', true, '2020-01-01', false),
  ('07009232', '', 'HUAMANI ROMERO DOMITILA CLEOFE', 'Activo', true, '2020-01-01', false),
  ('08376324', '', 'HUASHUAYO GOMEZ EUDOSIA', 'Activo', true, '2020-01-01', false),
  ('08378045', '', 'HUAYHUALLA DE LOPEZ DONATILA', 'Activo', true, '2020-01-01', false),
  ('40535559', '', 'ISIDRO MARIN CARLOS DANIEL', 'Activo', true, '2020-01-01', false),
  ('09784085', '', 'JARA ALVARES CRISTALINA', 'Activo', true, '2020-01-01', false),
  ('09578792', '', 'JARA ALVAREZ MARIA CENAIDA', 'Activo', true, '2020-01-01', false),
  ('40992336', '', 'JARA ALVAREZ SANTOS PEDRO', 'Activo', true, '2020-01-01', false),
  ('08409075', '', 'JUAREZ CUELLAR LEONOR', 'Activo', true, '2020-01-01', false),
  ('08350259', '', 'LAGOS LUNA DE LEYVA ZAIDA LUISA', 'Activo', true, '2020-01-01', false),
  ('08362967', '', 'LIMAS VARGAS CARMEN ROSA', 'Activo', true, '2020-01-01', false),
  ('09584057', '', 'LOPEZ HUAYHUALLA NELLY NATIVIDAD', 'Activo', true, '2020-01-01', false),
  ('09358600', '', 'LUJAN GONZALES MARINO JUAN', 'Activo', true, '2020-01-01', false),
  ('06273475', '', 'MALLQUI JULCA ALEJANDRINO TEODORO', 'Activo', true, '2020-01-01', false),
  ('46074009', '', 'MALLQUI LOPEZ LIZBETH NATIVIDAD', 'Activo', true, '2020-01-01', false),
  ('08372971', '', 'MARIN HUAMAN DE SALAMANCA MARIA YNES', 'Activo', true, '2020-01-01', false),
  ('08409874', '', 'MARIN LONDONE EDUARDO SANTIAGO', 'Activo', true, '2020-01-01', false),
  ('08378611', '', 'MARIN LONDONE MARIA LUZ', 'Activo', true, '2020-01-01', false),
  ('70543675', '', 'MARIN ROCHA ESTEFANY JULISSA', 'Activo', true, '2020-01-01', false),
  ('08363303', '', 'MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE', 'Activo', true, '2020-01-01', false),
  ('09412367', '', 'MAYHUASCA BASTIDAS MARILU', 'Activo', true, '2020-01-01', false),
  ('08378555', '', 'MAYHUASCA BASTIDAS ULISES', 'Activo', true, '2020-01-01', false),
  ('08933567', '', 'MAYTA COLQUI VIOLETA', 'Activo', true, '2020-01-01', false),
  ('10240212', '', 'MAYTA MATOS HERMELINDA', 'Activo', true, '2020-01-01', false),
  ('46888218', '', 'MEDINA GUTIERREZ HONORATA', 'Activo', true, '2020-01-01', false),
  ('07023212', '', 'MEDINA JOTA DE CACERES VICENTA', 'Activo', true, '2020-01-01', false),
  ('09411020', '', 'MEDINA MEDRANO JUAN CARLOS', 'Activo', true, '2020-01-01', false),
  ('23925250', '', 'MELO BACA MARINA', 'Activo', true, '2020-01-01', false),
  ('08981021', '', 'MESIA CRUZ GLADYS', 'Activo', true, '2020-01-01', false),
  ('08936174', '', 'MORENO CHAVEZ RAFAEL FREDY', 'Activo', true, '2020-01-01', false),
  ('42786348', '', 'NICHO LOPEZ ESTHEPANY CARICIA', 'Activo', true, '2020-01-01', false),
  ('06148853', '', 'NAHUI RUIZ AURELIO', 'Activo', true, '2020-01-01', false),
  ('47920093', '', 'OJEDA CAMPOS EDSON JUNIOR', 'Activo', true, '2020-01-01', false),
  ('08389482', '', 'OQUENDO ARISACA MELESIA ROSARIO', 'Activo', true, '2020-01-01', false),
  ('40389776', '', 'OQUENDO QUISPE JESSICA', 'Activo', true, '2020-01-01', false),
  ('42772112', '', 'OQUENDO QUISPE MIGUEL EUFRACIO', 'Activo', true, '2020-01-01', false),
  ('60992919', '', 'ORDONEZ NICHO AZUL CARILE', 'Activo', true, '2020-01-01', false),
  ('43176165', '', 'ORTIZ NAUPA WELINTONH', 'Activo', true, '2020-01-01', false),
  ('08386039', '', 'PACOMPIA CARDENA GIOVANNI', 'Activo', true, '2020-01-01', false),
  ('08386039-DUP', '', 'PALOMINO HANCCO CECILIA', 'Activo', true, '2020-01-01', false),
  ('10481354', '', 'PALOMINO TENORIO SILVIO EDUARDO', 'Activo', true, '2020-01-01', false),
  ('08353538', '', 'PALOMINO VELASQUEZ EUSEBIO', 'Activo', true, '2020-01-01', false),
  ('08411083', '', 'PAREDES FLORES OSCAR ALFREDO', 'Activo', true, '2020-01-01', false),
  ('44619731', '', 'PAREDES MORALES DIANA VONNETH', 'Activo', true, '2020-01-01', false),
  ('43807858', '', 'PAREDES MORALES OSCAR MARTIN', 'Activo', true, '2020-01-01', false),
  ('08835096', '', 'PEREZ PONCE DE ROMERO SATURNINA MARGARITA', 'Activo', true, '2020-01-01', false),
  ('08981387', '', 'PEREZ QUISPE EPIFANIA RICARDINA', 'Activo', true, '2020-01-01', false),
  ('09407193', '', 'PITTMAN CONCEPCION NELLY MARIA', 'Activo', true, '2020-01-01', false),
  ('08408595', '', 'PLAZA COSQUILLO ROSA ESTELA', 'Activo', true, '2020-01-01', false),
  ('08792796', '', 'PORRAS URCURANGA DE OROYA OLIMPIA', 'Activo', true, '2020-01-01', false),
  ('08382726', '', 'PRADO LLANCARI ZOSIMA', 'Activo', true, '2020-01-01', false),
  ('09126820', '', 'QUINTANA VIDAL GLICERIO', 'Activo', true, '2020-01-01', false),
  ('10651107', '', 'QUISPE CONSA MIGUEL', 'Activo', true, '2020-01-01', false),
  ('10525118', '', 'QUISPE CONSA VIDAL', 'Activo', true, '2020-01-01', false),
  ('09587366', '', 'QUISPE COPAYO ELIO CARLOS', 'Activo', true, '2020-01-01', false),
  ('08377638', '', 'QUISPE AGUILAR DE PALOMINO DOROTEA', 'Activo', true, '2020-01-01', false),
  ('23997014', '', 'QUISPE DURAN ADRIANA', 'Activo', true, '2020-01-01', false),
  ('06218890', '', 'QUISPE ORTEGA ROSA CARMEN', 'Activo', true, '2020-01-01', false),
  ('08350919', '', 'QUISPE URIBE LUCIANO', 'Activo', true, '2020-01-01', false),
  ('08369637', '', 'RAMOS CUEVA PEDRO RAUL', 'Activo', true, '2020-01-01', false),
  ('07413425', '', 'REYES PEREZ DE VALENCIA NANCY VICTORIA', 'Activo', true, '2020-01-01', false),
  ('41051072', '', 'REYES SANCHEZ MILENA GERALDINE', 'Activo', true, '2020-01-01', false),
  ('08852885', '', 'RICSE SAYES TERESA REINA', 'Activo', true, '2020-01-01', false),
  ('08408688', '', 'RIVERA CALLPA JUANA REGIS', 'Activo', true, '2020-01-01', false),
  ('09126077', '', 'RIVERA FERNANDEZ MARINA MAXILIANA', 'Activo', true, '2020-01-01', false),
  ('08353826', '', 'RODRIGUEZ ARQUINEGO IDILIO FELIX', 'Activo', true, '2020-01-01', false),
  ('43806897', '', 'RODRIGUEZ CORDOVA MARCOS', 'Activo', true, '2020-01-01', false),
  ('09257901', '', 'RODRIGUEZ MORENO NORA', 'Activo', true, '2020-01-01', false),
  ('10526901', '', 'ROJAS CORNEJO ERICK JOHN', 'Activo', true, '2020-01-01', false),
  ('08378503', '', 'ROJAS IGNACIO LIONILA JULIA', 'Activo', true, '2020-01-01', false),
  ('09687425', '', 'ROMERO FLORES EDDNA', 'Activo', true, '2020-01-01', false),
  ('09258771', '', 'ROMERO NINAHUAMAN JAVIER JOHNNY', 'Activo', true, '2020-01-01', false),
  ('08897525', '', 'ROMERO YSLA ESTEBAN LIDIO', 'Activo', true, '2020-01-01', false),
  ('10650355', '', 'SAAVEDRA CURIPUMA LUIS HUMBERTO', 'Activo', true, '2020-01-01', false),
  ('10642544', '', 'SALAS MONTALVO JUDITH MAGALI', 'Activo', true, '2020-01-01', false),
  ('10026448', '', 'SALAS MONTALVO RUTH YOVANNA', 'Activo', true, '2020-01-01', false),
  ('08386136', '', 'SALAZAR CONCEPCION VICTORIA', 'Activo', true, '2020-01-01', false),
  ('75695054', '', 'SALVATIERRA OQUENDO ALLISON ADRIANA', 'Activo', true, '2020-01-01', false),
  ('08353253', '', 'SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA', 'Activo', true, '2020-01-01', false),
  ('41018085', '', 'SANCHEZ RODRIGUEZ JUDITH IRIS', 'Activo', true, '2020-01-01', false),
  ('15374505', '', 'SANCHEZ SOTO LUCIA YRENE', 'Activo', true, '2020-01-01', false),
  ('40621354', '', 'SANTILLAN MESIA ZOILA MARIBEL', 'Activo', true, '2020-01-01', false),
  ('10019381', '', 'SEGOVIA VILLAFUERTE DE PONCE JUSTINA', 'Activo', true, '2020-01-01', false),
  ('09121626', '', 'SERMENO GUTIERREZ JAVIER YGNACIO', 'Activo', true, '2020-01-01', false),
  ('08408970', '', 'SORIA TAPIA EDITH CATALINA', 'Activo', true, '2020-01-01', false),
  ('06007412', '', 'SOSA VALDIVIA JUANA ISABEL', 'Activo', true, '2020-01-01', false),
  ('08393305', '', 'SOTO GALLEGO DE VALERO SOFIA', 'Activo', true, '2020-01-01', false),
  ('09126963', '', 'SOTO VARGAS DE FLORES MARIA DEL CARMEN', 'Activo', true, '2020-01-01', false),
  ('44267980', '', 'TAIPE OQUENDO EUGENIO JOEL', 'Activo', true, '2020-01-01', false),
  ('08928757', '', 'TELLO ALVAREZ MARINO', 'Activo', true, '2020-01-01', false),
  ('09694862', '', 'TELLO QUINTANA EDGAR ERASMO', 'Activo', true, '2020-01-01', false),
  ('80652233', '', 'TINEO CABRERA SONIA', 'Activo', true, '2020-01-01', false),
  ('08362537', '', 'TINTAYA CAHUANA PATRICIA HERMENEGILDA', 'Activo', true, '2020-01-01', false),
  ('09005157', '', 'TITO FALCON JESUSA RICARDINA', 'Activo', true, '2020-01-01', false),
  ('10487484', '', 'TORRES ANYOSA MARCELINO', 'Activo', true, '2020-01-01', false),
  ('08362958', '', 'TORRES ASTO FRANCISCO CONTESOR', 'Activo', true, '2020-01-01', false),
  ('10488601', '', 'TORRES ASTO SANTOS NERY F', 'Activo', true, '2020-01-01', false),
  ('08409067', '', 'TORRES ASTO VDA DE CALDERON JUANA FRONILDA', 'Activo', true, '2020-01-01', false),
  ('08364315', '', 'URETA CRUZ EMILIA', 'Activo', true, '2020-01-01', false),
  ('07343203', '', 'VALENCIA TOMAS VICENTE DORIS', 'Activo', true, '2020-01-01', false),
  ('08394062', '', 'VALERO PARIONA MAXIMO ALBINO', 'Activo', true, '2020-01-01', false),
  ('40252062', '', 'VALERO SOTO MAXIMO ELIAS', 'Activo', true, '2020-01-01', false),
  ('42565283', '', 'VALERO SOTO WILLY PERSEO', 'Activo', true, '2020-01-01', false),
  ('10486779', '', 'VALLEJOS HUAMAN MARIA ANA', 'Activo', true, '2020-01-01', false),
  ('09123715', '', 'VALVERDE ROSAS JUAN MARCELINO', 'Activo', true, '2020-01-01', false),
  ('08378938', '', 'VARA CASTRO DELIA ERNESTINA F', 'Activo', true, '2020-01-01', false),
  ('08386699', '', 'VARA DE ROSAS ALICIA VALENTINA', 'Activo', true, '2020-01-01', false),
  ('09573772', '', 'VICENTE CALIXTO JOSE ALBERTO', 'Activo', true, '2020-01-01', false),
  ('09127189', '', 'VILCHEZ GUTARRA LOURDES FANNY', 'Activo', true, '2020-01-01', false),
  ('09120179', '', 'VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA', 'Activo', true, '2020-01-01', false),
  ('09410794', '', 'YAURIMUCHA RIMACHI MARCOS', 'Activo', true, '2020-01-01', false),
  ('09585627', '', 'YRUPAILLA ANAMPA ISIDRO BELISARIO', 'Activo', true, '2020-01-01', false),
  ('09128244', '', 'YRUPAILLA FALCON NILDA ADELINA', 'Activo', true, '2020-01-01', false),
  ('09573359', '', 'ZAPATA RIVERA ROSANA', 'Activo', true, '2020-01-01', false),
  ('08353610', '', 'ZAPATA VELIT VICTORIANO', 'Activo', true, '2020-01-01', false)
ON CONFLICT (dni) DO UPDATE SET
  apellidos               = EXCLUDED.apellidos,
  estado                  = 'Activo',
  habilitado              = true,
  usa_recaudacion_tarjeta = false;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 3: historial_titularidad — 185 socios vinculados a sus puestos
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  rec record;
  v_s bigint; v_p bigint;
BEGIN
  FOR rec IN (
    SELECT * FROM (VALUES
      ('08910771', '134'),
      ('41500340', '63'),
      ('10648704', '59'),
      ('07036952', '181'),
      ('08351184', '73'),
      ('27388264', '155'),
      ('45483108', '80'),
      ('08408918', '60'),
      ('08389869', '48'),
      ('08925026', '179'),
      ('40605904', '12'),
      ('08376344', '10'),
      ('09411772', '74'),
      ('09128242', '104'),
      ('08367778', '166'),
      ('08407044', '64'),
      ('42735431', '15'),
      ('08385382', '108'),
      ('10746685', '37'),
      ('08408319', '159'),
      ('42591926', '76'),
      ('42194583', '58'),
      ('08377848', '184'),
      ('44426461', '149'),
      ('08352573', '56'),
      ('08365775', '101'),
      ('08352205', '13'),
      ('10483507', '183'),
      ('08408186', '75'),
      ('08378575', '165'),
      ('10644600', '89'),
      ('09264887', '79'),
      ('08410781', '18'),
      ('47825713', '17'),
      ('10129111', '62'),
      ('10549481', '55'),
      ('75274713', '110'),
      ('08964390', '117'),
      ('08237117', '49'),
      ('09124337', '103'),
      ('08980503', '194'),
      ('08954535', '78'),
      ('08998291', '93'),
      ('08365528', '67'),
      ('09133532', '27'),
      ('10084032', '94'),
      ('10525929', '128'),
      ('09126040', '167'),
      ('08412232', '177'),
      ('08376979', '71'),
      ('41204316', '171'),
      ('10487155', '154'),
      ('41110013', '16'),
      ('10022005', '57'),
      ('08409231', '125'),
      ('09723857', '35'),
      ('10654208', '95'),
      ('09868359', '162'),
      ('08352447', '14'),
      ('08363681', '152'),
      ('08362728', '163'),
      ('10347533', '24'),
      ('08408138', '107'),
      ('08395960', '109'),
      ('10541347', '191'),
      ('20101992', '84'),
      ('70065666', '170'),
      ('41842805', '39'),
      ('46805327', '100'),
      ('08406481', '150'),
      ('08398541', '140'),
      ('07009232', '1'),
      ('08376324', '9'),
      ('08378045', '113'),
      ('40535559', '96'),
      ('09784085', '161'),
      ('09578792', '50'),
      ('40992336', '87'),
      ('08409075', '47'),
      ('08350259', '25'),
      ('08362967', '2'),
      ('09584057', '169'),
      ('09358600', '178'),
      ('06273475', '192'),
      ('46074009', '130'),
      ('08372971', '31'),
      ('08409874', '176'),
      ('08378611', '81'),
      ('70543675', '126'),
      ('08363303', '135'),
      ('09412367', '186'),
      ('08378555', '188'),
      ('08933567', '158'),
      ('10240212', '88'),
      ('46888218', '174'),
      ('07023212', '5'),
      ('09411020', '143'),
      ('23925250', '122'),
      ('08981021', '106'),
      ('08936174', '83'),
      ('42786348', '144'),
      ('06148853', '61'),
      ('47920093', '133'),
      ('08389482', '119'),
      ('40389776', '172'),
      ('42772112', '146'),
      ('60992919', '182'),
      ('43176165', '185'),
      ('08386039', '29'),
      ('08386039-DUP', '164'),
      ('10481354', '195'),
      ('08353538', '147'),
      ('08411083', '53'),
      ('44619731', '19'),
      ('43807858', '28'),
      ('08835096', '187'),
      ('08981387', '40'),
      ('09407193', '33'),
      ('08408595', '138'),
      ('08792796', '123'),
      ('08382726', '42'),
      ('09126820', '97'),
      ('10651107', '115'),
      ('10525118', '90'),
      ('09587366', '114'),
      ('08377638', '132'),
      ('23997014', '157'),
      ('06218890', '175'),
      ('08350919', '30'),
      ('08369637', '131'),
      ('07413425', '127'),
      ('41051072', '120'),
      ('08852885', '136'),
      ('08408688', '69'),
      ('09126077', '142'),
      ('08353826', '51'),
      ('43806897', '139'),
      ('09257901', '180'),
      ('10526901', '99'),
      ('08378503', '41'),
      ('09687425', '151'),
      ('09258771', '3'),
      ('08897525', '156'),
      ('10650355', '43'),
      ('10642544', '38'),
      ('10026448', '6'),
      ('08386136', '102'),
      ('75695054', '148'),
      ('08353253', '36'),
      ('41018085', '190'),
      ('15374505', '65'),
      ('40621354', '124'),
      ('10019381', '34'),
      ('09121626', '20'),
      ('08408970', '68'),
      ('06007412', '4'),
      ('08393305', '85'),
      ('09126963', '98'),
      ('44267980', '26'),
      ('08928757', '44'),
      ('09694862', '86'),
      ('80652233', '112'),
      ('08362537', '72'),
      ('09005157', '105'),
      ('10487484', '70'),
      ('08362958', '189'),
      ('10488601', '137'),
      ('08409067', '82'),
      ('08364315', '8'),
      ('07343203', '116'),
      ('08394062', '21'),
      ('40252062', '153'),
      ('42565283', '22'),
      ('10486779', '129'),
      ('09123715', '54'),
      ('08378938', '121'),
      ('08386699', '118'),
      ('09573772', '160'),
      ('09127189', '91'),
      ('09120179', '168'),
      ('09410794', '23'),
      ('09585627', '111'),
      ('09128244', '66'),
      ('09573359', '141'),
      ('08353610', '145')
    ) t(dni, puesto_code)
  )
  LOOP
    SELECT id INTO v_s FROM public.socios WHERE dni = rec.dni;
    SELECT id INTO v_p FROM public.puestos WHERE codigo_puesto = rec.puesto_code;
    IF v_s IS NULL THEN
      RAISE WARNING 'Titularidad: socio no encontrado DNI=%', rec.dni;
      CONTINUE;
    END IF;
    IF v_p IS NULL THEN
      RAISE WARNING 'Titularidad: puesto no encontrado código=%', rec.puesto_code;
      CONTINUE;
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM public.historial_titularidad
      WHERE puesto_id = v_p AND socio_id = v_s AND fecha_fin IS NULL
    ) THEN
      INSERT INTO public.historial_titularidad (puesto_id, socio_id, fecha_inicio)
      VALUES (v_p, v_s, '2020-01-01');
    END IF;
  END LOOP;
END; $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 4: Insertar 103 inquilinos
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.inquilinos (dni, nombres, apellidos)
VALUES
  ('10019147', '', 'AIRE MALPARTIDA HECTOR'),
  ('08877133', '', 'ALVAREZ BERRIO FLORENCIA ASUNTA'),
  ('09706677', '', 'ALVAREZ CHIARA EDGAR SALVADOR'),
  ('44071731', '', 'ANCHAYA HUAMAN ABEL'),
  ('00254279', '', 'ARMESTAR GODOS JUANA JACKELYNE'),
  ('31428533', '', 'ARREDONDO GARCIA GLADYS'),
  ('44982231', '', 'AVILA CHAVEZ ROSA MARINA'),
  ('43650510', '', 'AYALA HUASHUAYO MARLENE ESTHER'),
  ('47384400', '', 'AZURZA TRIBINOS DAYSI ELIZABETH'),
  ('08386063', '', 'BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA'),
  ('40466902', '', 'BENITES TRIBINOS ERIKA'),
  ('45136700', '', 'BURGA CARRASCO ELMER'),
  ('42082589', '', 'BUSTAMANTE CHILON GRACIELA'),
  ('60812334', '', 'CAHUANA PUCURIMAY ALEX ENRIQUE'),
  ('44168936', '', 'CARRASCO PICHIHUA MERY RUTH'),
  ('48773769', '', 'CASTILLO ZAPATA ESAEL'),
  ('46405540', '', 'CASTRO RODRIGUEZ JANETT CONSUELO'),
  ('44002664', '', 'CCENCHO CARRASCO DAVID VICENTE'),
  ('46542458', '', 'CERDAN MUNOZ MARIA DOMINGA'),
  ('41762238', '', 'CERVANTES GARCIA CARLOS ARTURO'),
  ('10474827', '', 'CHAMBI APAZA SIMONA'),
  ('48822765', '', 'CHOQUEHUANCA HUAMAN DAVID'),
  ('47205649', '', 'CHOQUEHUANCA HUAMAN DERSE'),
  ('10104498146', '', 'CLAROS TORRES SANTOS JESUS'),
  ('08995920', '', 'CONDORI MAMANI LIDIA AGRIPINA'),
  ('71577898', '', 'CUNIAS SANTOS MARIELA'),
  ('10233461', '', 'DAVILA HILARES YESENIA BEATRIZ'),
  ('09369721', '', 'ENCARNACION PAUCARPOMA GLADYS'),
  ('09407642', '', 'FLORES LAREDO DOMINICIA LUCIANA'),
  ('08905454', '', 'GARCIA MEDINA VDA DE MOLINA CLEMENCIA BEATRIZ'),
  ('41844307', '', 'GOMERO DULANTO MARGARITA JUANA'),
  ('10347772', '', 'GOMEZ MITMA MARIBEL'),
  ('04352513', '', 'HERNANDEZ HERNANDEZ LILIBETH MARIA'),
  ('71009767', '', 'HERRERA PEVES ROMINA DEL CARMEN'),
  ('41365838', '', 'HERRERA CAMPOS ORFELITA'),
  ('46950481', '', 'LA ROSA LOPEZ MARGARITA LILIANA'),
  ('07279524', '', 'LAPAS ZALAZAR ANA MARIA'),
  ('73348594', '', 'LEON RODRIGUEZ ANGIE MARGARITA'),
  ('09575838', '', 'LEONARDO AMARILLO FEDERICO MANUEL'),
  ('10026348', '', 'LEONARDO AMARILLO ROSANA PILAR'),
  ('07266341', '', 'LOPEZ CERRON HAYDEE'),
  ('72446110', '', 'MALLMA CONDORI LISBETH LUCIA'),
  ('10481732', '', 'MAYHUASCA BASTIDAS DORIS'),
  ('06651184', '', 'MIRANDA CACERES FELICITA'),
  ('80055674', '', 'MUJICA PALOMINO SANDRA LIZ'),
  ('08139723', '', 'OBREGON CASTILLO FERNANDO MARTIN'),
  ('44465773', '', 'PALOMINO CUSI ROSA'),
  ('08378642', '', 'PENA VDA DE VILLANUEVA TERESA'),
  ('09720689', '', 'PFUNO RAMOS VICTOR RAUL'),
  ('42841670', '', 'PRADO CATANO MIRIAM MILAGROS'),
  ('09700283', '', 'QUISPE CHAVEZ MARI SOL'),
  ('41747705', '', 'QUISPE MAMANI PATRICIA PAOLA'),
  ('09852414', '', 'REBAZA REBAZA CASILDA CATALINA'),
  ('10625419', '', 'RENTERIA HUANCAS ROSA ARMANDINA'),
  ('09135097', '', 'SALAZAR VASQUEZ MARIA ROSARIO'),
  ('73192679', '', 'SUAREZ REBAZA LUIS ABRAHAM'),
  ('08363214', '', 'YAURIMUCHA RIMACHI URSULA'),
  ('09574907', '', 'YAUYOS MENDIETA MARLENE'),
  ('42479516', '', 'YUPANQUI QUISPE SAYDA'),
  ('20654471', '', 'ZANABRIA LADERA DE COCHACHI LILIA RUFINA'),
  ('03901433', '', 'COLINA CORREA SIRLEY KARINA'), -- COOP
  ('72336226', '', 'PENA VILLANUEVA ASHLEY MARYORI'), -- COOP
  ('45452812', '', 'SALDANA DONAYRE JESSICA PATRICIA'), -- COOP
  ('71390650', '', 'SANCHEZ PRADO DIANA ZENAIDA'), -- COOP
  ('09350799', '', 'ALARCON ESPINOZA MARTHA ESPERANZA'), -- 2do Piso
  ('20097655', '', 'CERRON GALVAN OBDULIA'), -- 2do Piso
  ('08030473', '', 'DURAN CHACON BLANCA NIEVES'), -- 2do Piso
  ('08899417', '', 'ESPARTA CARDENAS JULIO HECTOR'), -- 2do Piso
  ('10106511476', '', 'FERREYRA COSME TANIA MABEL'), -- 2do Piso
  ('08991437', '', 'HUAMANI CONTRERAS MAXIMO FLAVIO'), -- 2do Piso
  ('08914131', '', 'CAYO HUAMANI BACILIO ANTONIO'), -- Espacio
  ('29096837', '', 'CHIPANA DE VARGAS ANATOLIA'), -- Espacio
  ('42799850', '', 'IDALINA MONTENEGRO BAUTISTA'), -- Espacio
  ('46101817', '', 'KARINA LUZ LUCIANO INGA'), -- Espacio
  ('15605235546', '', 'MARILIN DEL CARMEN VERA'), -- Espacio
  ('48462586', '', 'QUISPE NAPUCHE LISBETH KARITO'), -- Espacio
  ('28312595', '', 'TUEROS QUISPE PRUDENCIO'), -- Espacio
  ('DEP-1-D1', '', 'HALIRE YUCRA JOSUE'), -- Depósito D1
  ('DEP-2-D1', '', 'CERDA YUPANQUI CARMEN'), -- Depósito D1
  ('DEP-3-D1', '', 'CARTAGENA ALVARO'), -- Depósito D1
  ('DEP-4-D1', '', 'MESIAS GLADYS'), -- Depósito D1
  ('DEP-5-D1', '', 'MARIN LONDONE MARIA LUZ'), -- Depósito D1
  ('DEP-6-D1', '', 'VILLANUEVA INGA ROSA'), -- Depósito D1
  ('DEP-7-D1', '', 'VILCHEZ GUTARRA LOURDES'), -- Depósito D1
  ('COOP-1-D2', '', 'COOPERATIVA PRIMERO DE MAYO'), -- Depósito D2 (Cooperativa)
  ('DEP-2-D2', '', 'HUASHUAYO GOMEZ EUDOSIA'), -- Depósito D2
  ('DEP-3-D2', '', 'ALVAREZ CAMPOS ROLANDO'), -- Depósito D2
  ('DEP-4-D2', '', 'PALOMINO TENORIO SILVIO EDUARDO'), -- Depósito D2
  ('DEP-5-D2', '', 'VICENTE CALIXTO JOSE ALBERTO'), -- Depósito D2
  ('DEP-6-D2', '', 'AGUIRRE QUISPE WILFREDO GILMER'), -- Depósito D2
  ('DEP-7-D2', '', 'DAVILA CAHUANA MARISOL'), -- Depósito D2
  ('DEP-8-D2', '', 'CABERO MENDOZA GLORIA'), -- Depósito D2
  ('COOP-9-D2', '', 'COOPERATIVA PRIMERO DE MAYO'), -- Depósito D2 (Cooperativa)
  ('DEP-10-D2', '', 'CALLE ALVAREZ MARCO'), -- Depósito D2
  ('DEP-11-D2', '', 'SALDANA DONAYRE JESSICA PATRICIA'), -- Depósito D2
  ('DEP-1-D3', '', 'AYALA TABOADA ELISEO'), -- Depósito D3
  ('DEP-2-D3', '', 'CHUCHULLO HACHA JOSE PEDRO'), -- Depósito D3
  ('DEP-3-D3', '', 'TORRES ANYOSA MARCELINO'), -- Depósito D3
  ('DEP-4-D3', '', 'BUSTAMANTE JOSE'), -- Depósito D3
  ('DEP-5-D3', '', 'ACCO NOA VICTOR'), -- Depósito D3
  ('DEP-6-D3', '', 'ACCO NOA VICTOR'), -- Depósito D3
  ('DEP-7-D3', '', 'LIMAS VARGAS CARMEN'), -- Depósito D3
  ('DEP-8-D3', '', 'CABERO MENDOZA GLORIA') -- Depósito D3
ON CONFLICT (dni) DO UPDATE SET
  apellidos = EXCLUDED.apellidos;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 5: historial_arriendos — 64 inquilinos E+COOP (auto-resolubles)
-- ─────────────────────────────────────────────────────────────────────────────
-- socio_titular_id se resuelve desde historial_titularidad del puesto base.
-- Si el puesto base no tiene titular, se emite WARNING y se omite.
DO $$
DECLARE
  rec record;
  v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  FOR rec IN (
    SELECT * FROM (VALUES
      ('10019147', '31-E', '31'),
      ('08877133', '34-E', '34'),
      ('09706677', '51-E', '51'),
      ('44071731', '2-E', '2'),
      ('00254279', '29-E', '29'),
      ('31428533', '16-E', '16'),
      ('44982231', '40-E', '40'),
      ('43650510', '3-E', '3'),
      ('47384400', '11-E', '11'),
      ('08386063', '4-E', '4'),
      ('40466902', '12-E', '12'),
      ('45136700', '8-E', '8'),
      ('42082589', '52-E', '52'),
      ('60812334', '30-E', '30'),
      ('44168936', '24-E', '24'),
      ('48773769', '1-E', '1'),
      ('46405540', '37-E', '37'),
      ('44002664', '23-E', '23'),
      ('46542458', '25-E', '25'),
      ('41762238', '14-E', '14'),
      ('10474827', '38-E', '38'),
      ('48822765', '46-E', '46'),
      ('47205649', '62-E', '62'),
      ('10104498146', '54-E', '54'),
      ('08995920', '43-E', '43'),
      ('71577898', '49-E', '49'),
      ('10233461', '22-E', '22'),
      ('09369721', '19-E', '19'),
      ('09407642', '44-E', '44'),
      ('08905454', '15-E', '15'),
      ('41844307', '60-E', '60'),
      ('10347772', '48-E', '48'),
      ('04352513', '20-E', '20'),
      ('71009767', '47-E', '47'),
      ('41365838', '50-E', '50'),
      ('46950481', '61-E', '61'),
      ('07279524', '26-E', '26'),
      ('73348594', '33-E', '33'),
      ('09575838', '55-E', '55'),
      ('10026348', '56-E', '56'),
      ('07266341', '13-E', '13'),
      ('72446110', '58-E', '58'),
      ('10481732', '5-E', '5'),
      ('06651184', '27-E', '27'),
      ('80055674', '59-E', '59'),
      ('08139723', '57-E', '57'),
      ('44465773', '28-E', '28'),
      ('08378642', '17-E', '17'),
      ('09720689', '10-E', '10'),
      ('42841670', '18-E', '18'),
      ('09700283', '53-E', '53'),
      ('41747705', '39-E', '39'),
      ('09852414', '6-E', '6'),
      ('10625419', '32-E', '32'),
      ('09135097', '42-E', '42'),
      ('73192679', '45-E', '45'),
      ('08363214', '21-E', '21'),
      ('09574907', '9-E', '9'),
      ('42479516', '41-E', '41'),
      ('20654471', '7-E', '7'),
      ('03901433', '32', '32'),
      ('72336226', '45', '45'),
      ('45452812', '52', '52'),
      ('71390650', '46', '46')
    ) t(inq_dni, puesto_code, base_puesto)
  )
  LOOP
    SELECT id INTO v_inq FROM public.inquilinos WHERE dni = rec.inq_dni;
    SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = rec.puesto_code;
    SELECT ht.socio_id INTO v_soc
      FROM public.historial_titularidad ht
      JOIN public.puestos p ON p.id = ht.puesto_id
      WHERE p.codigo_puesto = rec.base_puesto AND ht.fecha_fin IS NULL
      LIMIT 1;
    IF v_inq IS NULL THEN
      RAISE WARNING 'Arriendo: inquilino no encontrado DNI=%', rec.inq_dni;
      CONTINUE;
    END IF;
    IF v_pue IS NULL THEN
      RAISE WARNING 'Arriendo: puesto no encontrado código=%', rec.puesto_code;
      CONTINUE;
    END IF;
    IF v_soc IS NULL THEN
      RAISE WARNING 'Arriendo: sin titular vigente para puesto base=%  — DNI=% OMITIDO',
                    rec.base_puesto, rec.inq_dni;
      CONTINUE;
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM public.historial_arriendos
      WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
    ) THEN
      INSERT INTO public.historial_arriendos
        (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
      VALUES (v_pue, v_inq, v_soc, '2020-01-01');
      RAISE NOTICE 'Arriendo: DNI=% → puesto=%', rec.inq_dni, rec.puesto_code;
    END IF;
  END LOOP;
END; $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 6: historial_arriendos para -SP y -EP (13 arriendos)
-- ─────────────────────────────────────────────────────────────────────────────
-- socio_titular_id = socio cooperativa con DNI '00000000'.
-- Si ese socio no existe, cada DO-block emitirá WARNING y saltará la fila.

-- 2do Piso: ALARCON ESPINOZA MARTHA ESPERANZA → 1-SP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '09350799';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '1-SP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'ALARCON ESPINOZA MARTHA ESPERANZA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'ALARCON ESPINOZA MARTHA ESPERANZA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'ALARCON ESPINOZA MARTHA ESPERANZA', '1-SP';
  END IF;
END; $$;

-- 2do Piso: CERRON GALVAN OBDULIA → 2-SP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '20097655';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '2-SP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CERRON GALVAN OBDULIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CERRON GALVAN OBDULIA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'CERRON GALVAN OBDULIA', '2-SP';
  END IF;
END; $$;

-- 2do Piso: DURAN CHACON BLANCA NIEVES → 3-SP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08030473';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '3-SP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'DURAN CHACON BLANCA NIEVES: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'DURAN CHACON BLANCA NIEVES: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'DURAN CHACON BLANCA NIEVES', '3-SP';
  END IF;
END; $$;

-- 2do Piso: ESPARTA CARDENAS JULIO HECTOR → 4-SP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08899417';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '4-SP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'ESPARTA CARDENAS JULIO HECTOR: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'ESPARTA CARDENAS JULIO HECTOR: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'ESPARTA CARDENAS JULIO HECTOR', '4-SP';
  END IF;
END; $$;

-- 2do Piso: FERREYRA COSME TANIA MABEL → 5-SP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '10106511476';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '5-SP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'FERREYRA COSME TANIA MABEL: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'FERREYRA COSME TANIA MABEL: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'FERREYRA COSME TANIA MABEL', '5-SP';
  END IF;
END; $$;

-- 2do Piso: HUAMANI CONTRERAS MAXIMO FLAVIO → 6-SP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08991437';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '6-SP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'HUAMANI CONTRERAS MAXIMO FLAVIO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'HUAMANI CONTRERAS MAXIMO FLAVIO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'HUAMANI CONTRERAS MAXIMO FLAVIO', '6-SP';
  END IF;
END; $$;

-- Espacio: CAYO HUAMANI BACILIO ANTONIO → 1-EP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08914131';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '1-EP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CAYO HUAMANI BACILIO ANTONIO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CAYO HUAMANI BACILIO ANTONIO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'CAYO HUAMANI BACILIO ANTONIO', '1-EP';
  END IF;
END; $$;

-- Espacio: CHIPANA DE VARGAS ANATOLIA → 2-EP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '29096837';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '2-EP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CHIPANA DE VARGAS ANATOLIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CHIPANA DE VARGAS ANATOLIA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'CHIPANA DE VARGAS ANATOLIA', '2-EP';
  END IF;
END; $$;

-- Espacio: IDALINA MONTENEGRO BAUTISTA → 3-EP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '42799850';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '3-EP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'IDALINA MONTENEGRO BAUTISTA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'IDALINA MONTENEGRO BAUTISTA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'IDALINA MONTENEGRO BAUTISTA', '3-EP';
  END IF;
END; $$;

-- Espacio: KARINA LUZ LUCIANO INGA → 4-EP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '46101817';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '4-EP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'KARINA LUZ LUCIANO INGA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'KARINA LUZ LUCIANO INGA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'KARINA LUZ LUCIANO INGA', '4-EP';
  END IF;
END; $$;

-- Espacio: MARILIN DEL CARMEN VERA → 5-EP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '15605235546';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '5-EP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'MARILIN DEL CARMEN VERA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'MARILIN DEL CARMEN VERA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'MARILIN DEL CARMEN VERA', '5-EP';
  END IF;
END; $$;

-- Espacio: QUISPE NAPUCHE LISBETH KARITO → 6-EP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '48462586';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '6-EP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'QUISPE NAPUCHE LISBETH KARITO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'QUISPE NAPUCHE LISBETH KARITO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'QUISPE NAPUCHE LISBETH KARITO', '6-EP';
  END IF;
END; $$;

-- Espacio: TUEROS QUISPE PRUDENCIO → 7-EP
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '28312595';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '7-EP';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'TUEROS QUISPE PRUDENCIO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'TUEROS QUISPE PRUDENCIO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo SP/EP: % → %', 'TUEROS QUISPE PRUDENCIO', '7-EP';
  END IF;
END; $$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 7: historial_arriendos para Depósitos D1/D2/D3 (26 arriendos)
-- ─────────────────────────────────────────────────────────────────────────────
-- Los depósitos son propiedad de la Cooperativa.
-- socio_titular_id = socio cooperativa con DNI '00000000'.

-- D1: HALIRE YUCRA JOSUE → 1-D1
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-1-D1';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '1-D1';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'HALIRE YUCRA JOSUE: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'HALIRE YUCRA JOSUE: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'HALIRE YUCRA JOSUE', '1-D1';
  END IF;
END; $$;

-- D1: CERDA YUPANQUI CARMEN → 2-D1
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-2-D1';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '2-D1';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CERDA YUPANQUI CARMEN: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CERDA YUPANQUI CARMEN: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'CERDA YUPANQUI CARMEN', '2-D1';
  END IF;
END; $$;

-- D1: CARTAGENA ALVARO → 3-D1
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-3-D1';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '3-D1';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CARTAGENA ALVARO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CARTAGENA ALVARO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'CARTAGENA ALVARO', '3-D1';
  END IF;
END; $$;

-- D1: MESIAS GLADYS → 4-D1
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-4-D1';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '4-D1';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'MESIAS GLADYS: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'MESIAS GLADYS: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'MESIAS GLADYS', '4-D1';
  END IF;
END; $$;

-- D1: MARIN LONDONE MARIA LUZ → 5-D1
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-5-D1';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '5-D1';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'MARIN LONDONE MARIA LUZ: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'MARIN LONDONE MARIA LUZ: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'MARIN LONDONE MARIA LUZ', '5-D1';
  END IF;
END; $$;

-- D1: VILLANUEVA INGA ROSA → 6-D1
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-6-D1';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '6-D1';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'VILLANUEVA INGA ROSA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'VILLANUEVA INGA ROSA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'VILLANUEVA INGA ROSA', '6-D1';
  END IF;
END; $$;

-- D1: VILCHEZ GUTARRA LOURDES → 7-D1
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-7-D1';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '7-D1';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'VILCHEZ GUTARRA LOURDES: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'VILCHEZ GUTARRA LOURDES: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'VILCHEZ GUTARRA LOURDES', '7-D1';
  END IF;
END; $$;

-- D2: COOPERATIVA PRIMERO DE MAYO → 1-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'COOP-1-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '1-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'COOPERATIVA PRIMERO DE MAYO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'COOPERATIVA PRIMERO DE MAYO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'COOPERATIVA PRIMERO DE MAYO', '1-D2';
  END IF;
END; $$;

-- D2: HUASHUAYO GOMEZ EUDOSIA → 2-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-2-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '2-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'HUASHUAYO GOMEZ EUDOSIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'HUASHUAYO GOMEZ EUDOSIA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'HUASHUAYO GOMEZ EUDOSIA', '2-D2';
  END IF;
END; $$;

-- D2: ALVAREZ CAMPOS ROLANDO → 3-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-3-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '3-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'ALVAREZ CAMPOS ROLANDO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'ALVAREZ CAMPOS ROLANDO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'ALVAREZ CAMPOS ROLANDO', '3-D2';
  END IF;
END; $$;

-- D2: PALOMINO TENORIO SILVIO EDUARDO → 4-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-4-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '4-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'PALOMINO TENORIO SILVIO EDUARDO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'PALOMINO TENORIO SILVIO EDUARDO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'PALOMINO TENORIO SILVIO EDUARDO', '4-D2';
  END IF;
END; $$;

-- D2: VICENTE CALIXTO JOSE ALBERTO → 5-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-5-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '5-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'VICENTE CALIXTO JOSE ALBERTO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'VICENTE CALIXTO JOSE ALBERTO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'VICENTE CALIXTO JOSE ALBERTO', '5-D2';
  END IF;
END; $$;

-- D2: AGUIRRE QUISPE WILFREDO GILMER → 6-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-6-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '6-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'AGUIRRE QUISPE WILFREDO GILMER: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'AGUIRRE QUISPE WILFREDO GILMER: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'AGUIRRE QUISPE WILFREDO GILMER', '6-D2';
  END IF;
END; $$;

-- D2: DAVILA CAHUANA MARISOL → 7-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-7-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '7-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'DAVILA CAHUANA MARISOL: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'DAVILA CAHUANA MARISOL: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'DAVILA CAHUANA MARISOL', '7-D2';
  END IF;
END; $$;

-- D2: CABERO MENDOZA GLORIA → 8-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-8-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '8-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CABERO MENDOZA GLORIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CABERO MENDOZA GLORIA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'CABERO MENDOZA GLORIA', '8-D2';
  END IF;
END; $$;

-- D2: COOPERATIVA PRIMERO DE MAYO → 9-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'COOP-9-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '9-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'COOPERATIVA PRIMERO DE MAYO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'COOPERATIVA PRIMERO DE MAYO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'COOPERATIVA PRIMERO DE MAYO', '9-D2';
  END IF;
END; $$;

-- D2: CALLE ALVAREZ MARCO → 10-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-10-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '10-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CALLE ALVAREZ MARCO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CALLE ALVAREZ MARCO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'CALLE ALVAREZ MARCO', '10-D2';
  END IF;
END; $$;

-- D2: SALDANA DONAYRE JESSICA PATRICIA → 11-D2
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-11-D2';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '11-D2';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'SALDANA DONAYRE JESSICA PATRICIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'SALDANA DONAYRE JESSICA PATRICIA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'SALDANA DONAYRE JESSICA PATRICIA', '11-D2';
  END IF;
END; $$;

-- D3: AYALA TABOADA ELISEO → 1-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-1-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '1-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'AYALA TABOADA ELISEO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'AYALA TABOADA ELISEO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'AYALA TABOADA ELISEO', '1-D3';
  END IF;
END; $$;

-- D3: CHUCHULLO HACHA JOSE PEDRO → 2-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-2-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '2-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CHUCHULLO HACHA JOSE PEDRO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CHUCHULLO HACHA JOSE PEDRO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'CHUCHULLO HACHA JOSE PEDRO', '2-D3';
  END IF;
END; $$;

-- D3: TORRES ANYOSA MARCELINO → 3-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-3-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '3-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'TORRES ANYOSA MARCELINO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'TORRES ANYOSA MARCELINO: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'TORRES ANYOSA MARCELINO', '3-D3';
  END IF;
END; $$;

-- D3: BUSTAMANTE JOSE → 4-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-4-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '4-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'BUSTAMANTE JOSE: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'BUSTAMANTE JOSE: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'BUSTAMANTE JOSE', '4-D3';
  END IF;
END; $$;

-- D3: ACCO NOA VICTOR → 5-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-5-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '5-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'ACCO NOA VICTOR: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'ACCO NOA VICTOR: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'ACCO NOA VICTOR', '5-D3';
  END IF;
END; $$;

-- D3: ACCO NOA VICTOR → 6-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-6-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '6-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'ACCO NOA VICTOR: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'ACCO NOA VICTOR: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'ACCO NOA VICTOR', '6-D3';
  END IF;
END; $$;

-- D3: LIMAS VARGAS CARMEN → 7-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-7-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '7-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'LIMAS VARGAS CARMEN: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'LIMAS VARGAS CARMEN: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'LIMAS VARGAS CARMEN', '7-D3';
  END IF;
END; $$;

-- D3: CABERO MENDOZA GLORIA → 8-D3
DO $$
DECLARE v_inq bigint; v_pue bigint; v_soc bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = 'DEP-8-D3';
  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = '8-D3';
  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CABERO MENDOZA GLORIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF v_soc IS NULL THEN
    RAISE WARNING 'CABERO MENDOZA GLORIA: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, v_soc, '2020-01-01');
    RAISE NOTICE 'Arriendo Depósito: % → %', 'CABERO MENDOZA GLORIA', '8-D3';
  END IF;
END; $$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 8: Estado final y verificación
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_socios bigint; v_inqs bigint; v_puestos bigint;
  v_tit    bigint; v_arr  bigint;
BEGIN
  SELECT count(*) INTO v_socios  FROM public.socios   WHERE deleted_at IS NULL;
  SELECT count(*) INTO v_inqs    FROM public.inquilinos WHERE deleted_at IS NULL;
  SELECT count(*) INTO v_puestos FROM public.puestos   WHERE deleted_at IS NULL;
  SELECT count(*) INTO v_tit     FROM public.historial_titularidad WHERE fecha_fin IS NULL;
  SELECT count(*) INTO v_arr     FROM public.historial_arriendos   WHERE fecha_fin IS NULL;
  RAISE NOTICE '========================================================';
  RAISE NOTICE '✓ Migración 00036 completada';
  RAISE NOTICE '  Socios activos:          %  (esperados: 185)', v_socios;
  RAISE NOTICE '  Inquilinos activos:      %  (esperados: 103)', v_inqs;
  RAISE NOTICE '  Puestos activos:         %  (esperados: 288)', v_puestos;
  RAISE NOTICE '  Titularidades vigentes:  %  (esperados: 185)', v_tit;
  RAISE NOTICE '  Arriendos vigentes:      %  (esperados: 103 si DNI 00000000 existe)', v_arr;
  IF v_socios <> 185 THEN
    RAISE WARNING 'SOCIOS: se esperaban 185, se encontraron %', v_socios;
  END IF;
  IF v_tit <> v_socios THEN
    RAISE WARNING 'HAY % SOCIOS SIN TITULARIDAD VIGENTE', (v_socios - v_tit);
  END IF;
  RAISE NOTICE '========================================================';
END; $$;

COMMIT;