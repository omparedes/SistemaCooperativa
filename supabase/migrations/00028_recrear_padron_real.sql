-- =============================================================================
-- Migración 00028 — Padrón Real (generado automáticamente 2026-05-05)
-- Fuente: migracion_coop/listapersonascoop.xlsx
-- Socios: 185 | Inquilinos: 65 | Puestos únicos: 246
-- Puestos compartidos (arriendos no insertados, asignar por UI): 42E, 49E Y 50E, 2DO PISO
-- =============================================================================

BEGIN;

-- PASO 1: Wipe completo del padrón anterior
TRUNCATE TABLE
    public.socios,
    public.inquilinos,
    public.puestos,
    public.historial_titularidad,
    public.historial_arriendos
RESTART IDENTITY CASCADE;

-- PASO 2: 246 puestos únicos (185 numéricos + 61 alfa)
INSERT INTO public.puestos (codigo_puesto, giro_id, estado, tiene_medidor_luz, tiene_medidor_agua)
VALUES
    ('1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('4', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('5', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('6', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('8', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('9', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('10', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('12', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('13', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('14', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('15', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('16', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('17', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('18', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('19', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('20', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('21', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('22', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('23', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('24', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('25', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('26', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('27', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('28', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('29', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('30', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('31', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('33', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('34', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('35', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('36', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('37', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('38', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('39', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('40', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('41', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('42', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('43', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('44', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('47', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('48', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('49', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('50', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('51', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('53', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('54', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('55', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('56', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('57', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('58', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('59', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('60', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('61', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('62', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
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
    ('195', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('1-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('10-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('11', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('11-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('12-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('13-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('14-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('15-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('16-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('17-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('18-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('19-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('2-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('20-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('21-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('22-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('23-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('24-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('25-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('26-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('27-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('28-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('29-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('2DO PISO', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('30-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('31-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('32', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('32-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('33-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('34-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('37E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('4-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('40E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('42E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('43E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('45', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('46', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('46E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('47-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('47E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('48E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('49-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('49E Y 50E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('5-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('51E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('52E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('53E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('54E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('55E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('56E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('57-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('57E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('58-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('58E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('59E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('6-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('60-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('60E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('7-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('8-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false),
    ('9-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false);

-- PASO 3: 185 socios
INSERT INTO public.socios (dni, nombres, apellidos, estado, habilitado, fecha_ingreso)
VALUES
    ('SOC-001', '', 'Huamani Romero Donatila', 'Activo', true, '2020-01-01'),
    ('SOC-002', '', 'Limas Vargas Carmen Rosa', 'Activo', true, '2020-01-01'),
    ('SOC-003', '', 'Romero Ninahuaman Javier', 'Activo', true, '2020-01-01'),
    ('SOC-004', '', 'Sosa Valdivia Juana Isabel', 'Activo', true, '2020-01-01'),
    ('SOC-005', '', 'Medina Jota Vicenta', 'Activo', true, '2020-01-01'),
    ('SOC-006', '', 'Salas Montalvo Ruth', 'Activo', true, '2020-01-01'),
    ('SOC-007', '', 'Uretra Cruz Emilia', 'Activo', true, '2020-01-01'),
    ('SOC-008', '', 'Huashuayo Gomez Eudosia', 'Activo', true, '2020-01-01'),
    ('SOC-009', '', 'Ayala Toboada Eliseo', 'Activo', true, '2020-01-01'),
    ('SOC-010', '', 'Ayala Huashuayo Norma Gladys', 'Activo', true, '2020-01-01'),
    ('SOC-011', '', 'Cardeña Villafuerte Alejandrina', 'Activo', true, '2020-01-01'),
    ('SOC-012', '', 'Falcon Chiara Hector  Marcial', 'Activo', true, '2020-01-01'),
    ('SOC-013', '', 'Burga Carrasco Elida', 'Activo', true, '2020-01-01'),
    ('SOC-014', '', 'Cuya Sanchez Alberto', 'Activo', true, '2020-01-01'),
    ('SOC-015', '', 'Ccoyllo Bustillos Deysi Karen', 'Activo', true, '2020-01-01'),
    ('SOC-016', '', 'Castro Gutierrez Aquila Lucrecia', 'Activo', true, '2020-01-01'),
    ('SOC-017', '', 'Paredes Morales Diana', 'Activo', true, '2020-01-01'),
    ('SOC-018', '', 'Javier Sermeño Gutierrez', 'Activo', true, '2020-01-01'),
    ('SOC-019', '', 'Valero Pariona Maximo', 'Activo', true, '2020-01-01'),
    ('SOC-020', '', 'Valero Soto Willy Perseo Albino', 'Activo', true, '2020-01-01'),
    ('SOC-021', '', 'Yaurimucha Rimachi Marcos', 'Activo', true, '2020-01-01'),
    ('SOC-022', '', 'Flores Yato Francisca Dolores', 'Activo', true, '2020-01-01'),
    ('SOC-023', '', 'Lagos Luna de Leiva Zaida', 'Activo', true, '2020-01-01'),
    ('SOC-024', '', 'Taype Oquendo Eugenio Joel', 'Activo', true, '2020-01-01'),
    ('SOC-025', '', 'Clemente Aller Cirila', 'Activo', true, '2020-01-01'),
    ('SOC-026', '', 'Paredes Morales Oscar Martín', 'Activo', true, '2020-01-01'),
    ('SOC-027', '', 'Pacompia Cardeña Giovanni', 'Activo', true, '2020-01-01'),
    ('SOC-028', '', 'Quispe Uribe Luciano', 'Activo', true, '2020-01-01'),
    ('SOC-029', '', 'Marin Huaman de Salamanca Maria', 'Activo', true, '2020-01-01'),
    ('SOC-030', '', 'Pittman Concepción Nelly Maria', 'Activo', true, '2020-01-01'),
    ('SOC-031', '', 'Segovia Villafuerte de Ponce', 'Activo', true, '2020-01-01'),
    ('SOC-032', '', 'Espejo Urbano Rosa Florencia', 'Activo', true, '2020-01-01'),
    ('SOC-033', '', 'Sanchez Astos de Torres Yolanda Sofia', 'Activo', true, '2020-01-01'),
    ('SOC-034', '', 'Cabero Mendoza Gloria', 'Activo', true, '2020-01-01'),
    ('SOC-035', '', 'Salas Montalvo Magali Judith', 'Activo', true, '2020-01-01'),
    ('SOC-036', '', 'Gutierrez Flores Roger Reyman', 'Activo', true, '2020-01-01'),
    ('SOC-037', '', 'Perez Quispe Epifania', 'Activo', true, '2020-01-01'),
    ('SOC-038', '', 'Rojas Ignacio Leonila', 'Activo', true, '2020-01-01'),
    ('SOC-039', '', 'Prado Llancari Zozima', 'Activo', true, '2020-01-01'),
    ('SOC-040', '', 'Saavedra Curipuma Luis Humberto', 'Activo', true, '2020-01-01'),
    ('SOC-041', '', 'Tello Alvarez Marino', 'Activo', true, '2020-01-01'),
    ('SOC-042', '', 'Juarez Cuellar Leonor', 'Activo', true, '2020-01-01'),
    ('SOC-043', '', 'Ancco Leon Valentina', 'Activo', true, '2020-01-01'),
    ('SOC-044', '', 'Ccoyllo Polanco German', 'Activo', true, '2020-01-01'),
    ('SOC-045', '', 'Jara Alvarez Maria Cenaida', 'Activo', true, '2020-01-01'),
    ('SOC-046', '', 'Rodriguez Arquiñego Idilio Félix', 'Activo', true, '2020-01-01'),
    ('SOC-047', '', 'Paredes Flores Oscar', 'Activo', true, '2020-01-01'),
    ('SOC-048', '', 'Juan Valverde Rosas (CERRADO)', 'Activo', true, '2020-01-01'),
    ('SOC-049', '', 'Ccoyllo Chinchay Judith', 'Activo', true, '2020-01-01'),
    ('SOC-050', '', 'Calle Calle Fidel', 'Activo', true, '2020-01-01'),
    ('SOC-051', '', 'Davila Cahuana Marisol', 'Activo', true, '2020-01-01'),
    ('SOC-052', '', 'Estela Calderon Torres', 'Activo', true, '2020-01-01'),
    ('SOC-053', '', 'Alarcon Anampa Nancy Gisela', 'Activo', true, '2020-01-01'),
    ('SOC-054', '', 'Anampa Corahua Clemencia Migdonia', 'Activo', true, '2020-01-01'),
    ('SOC-055', '', 'Ñahui Ruiz Aurelio', 'Activo', true, '2020-01-01'),
    ('SOC-056', '', 'Ccoyllo Chinchay Daniel Masia', 'Activo', true, '2020-01-01'),
    ('SOC-057', '', 'Alarcon Anampa Betsy', 'Activo', true, '2020-01-01'),
    ('SOC-058', '', 'Bravo Heredia Ana Maritza', 'Activo', true, '2020-01-01'),
    ('SOC-059', '', 'Sanchez Soto Lucia', 'Activo', true, '2020-01-01'),
    ('SOC-060', '', 'Yruipalla Falcon Hilda', 'Activo', true, '2020-01-01'),
    ('SOC-061', '', 'Chuchuyo Hacha José', 'Activo', true, '2020-01-01'),
    ('SOC-062', '', 'Soria Tapia Edith Catalina', 'Activo', true, '2020-01-01'),
    ('SOC-063', '', 'Rivera Callpa Juana Regis', 'Activo', true, '2020-01-01'),
    ('SOC-064', '', 'Torres Anyorsa Marcelino', 'Activo', true, '2020-01-01'),
    ('SOC-065', '', 'Cuevas Mayo Enrique', 'Activo', true, '2020-01-01'),
    ('SOC-066', '', 'Tintaya Cahuana Patricia', 'Activo', true, '2020-01-01'),
    ('SOC-067', '', 'Alvarez Campos Rolando', 'Activo', true, '2020-01-01'),
    ('SOC-068', '', 'Bastidas Medina Dina', 'Activo', true, '2020-01-01'),
    ('SOC-069', '', 'Carrasco Salvatierra Felicitas', 'Activo', true, '2020-01-01'),
    ('SOC-070', '', 'Cajaleon Carrasco Luis Enrique', 'Activo', true, '2020-01-01'),
    ('SOC-071', '', 'Chirinos Cabracancha María', 'Activo', true, '2020-01-01'),
    ('SOC-072', '', 'HUAYHUALLA DE LOPEZ DONATILA', 'Activo', true, '2020-01-01'),
    ('SOC-073', '', 'QUISPE COPAYO  ELIO CARLOS', 'Activo', true, '2020-01-01'),
    ('SOC-074', '', 'RODRIGUEZ CORDOVA MARCOS', 'Activo', true, '2020-01-01'),
    ('SOC-075', '', 'HUAMAN YNCA VISITACION', 'Activo', true, '2020-01-01'),
    ('SOC-076', '', 'TORRES ASTO FRANCISCO', 'Activo', true, '2020-01-01'),
    ('SOC-077', '', 'MAYHUASCA BASTIDAS ULISES', 'Activo', true, '2020-01-01'),
    ('SOC-078', '', 'CARTAGENA MAMANI BENJAMIN', 'Activo', true, '2020-01-01'),
    ('SOC-079', '', 'PEREZ PONCE SATURNINA MARGARITA', 'Activo', true, '2020-01-01'),
    ('SOC-080', '', 'PALOMINO HANCCO CECILIA', 'Activo', true, '2020-01-01'),
    ('SOC-081', '', 'ZAPATA RIVERA ROSANA', 'Activo', true, '2020-01-01'),
    ('SOC-082', '', 'PLAZA COSQUILLO ROSA ESTELA', 'Activo', true, '2020-01-01'),
    ('SOC-083', '', 'QUISPE CONSA MIGUEL', 'Activo', true, '2020-01-01'),
    ('SOC-084', '', 'TINEO CABRERA SONIA', 'Activo', true, '2020-01-01'),
    ('SOC-085', '', 'CHALLCO DE PALOMINO NICOLAZA', 'Activo', true, '2020-01-01'),
    ('SOC-086', '', 'PALOMINO TENORIO SILVIO EDUARDO', 'Activo', true, '2020-01-01'),
    ('SOC-087', '', 'CULE CARRASCO HAYDEE MONICA', 'Activo', true, '2020-01-01'),
    ('SOC-088', '', 'YRUPAILLA ANAMPA ISIDRO', 'Activo', true, '2020-01-01'),
    ('SOC-089', '', 'VALENCIA TOMAS VICENTE', 'Activo', true, '2020-01-01'),
    ('SOC-090', '', 'TORRES ASTO NERY (F)', 'Activo', true, '2020-01-01'),
    ('SOC-091', '', 'RIVERA FERNANDEZ MARINA MAXILIANA', 'Activo', true, '2020-01-01'),
    ('SOC-092', '', 'FLORES FLORES UMBELINA DORA', 'Activo', true, '2020-01-01'),
    ('SOC-093', '', 'MAYHUASCA BASTIDAS MARILU', 'Activo', true, '2020-01-01'),
    ('SOC-094', '', 'ORTIZ ÑAUPA WELINTONH', 'Activo', true, '2020-01-01'),
    ('SOC-095', '', 'ESTRADA OSCAR', 'Activo', true, '2020-01-01'),
    ('SOC-096', '', 'MEDINA MEDRANO JUAN CARLOS', 'Activo', true, '2020-01-01'),
    ('SOC-097', '', 'RICSE SAYES TERESA REYNA', 'Activo', true, '2020-01-01'),
    ('SOC-098', '', 'CCOYLLO POLANCO DANIEL', 'Activo', true, '2020-01-01'),
    ('SOC-099', '', 'CCOYLLO MAYHUASCA ALEXIS', 'Activo', true, '2020-01-01'),
    ('SOC-100', '', 'MALLQUI JULCA ALEJANDRINO TEODORO', 'Activo', true, '2020-01-01'),
    ('SOC-101', '', 'GUTIERREZ CASTILLO  JORGE', 'Activo', true, '2020-01-01'),
    ('SOC-102', '', 'CHOQUEHUAMANI FELIX CEFERINO', 'Activo', true, '2020-01-01'),
    ('SOC-103', '', 'GELDRES REVILLA MIGUEL', 'Activo', true, '2020-01-01'),
    ('SOC-104', '', 'VARA DE ROSAS ALICIA VALENTINA', 'Activo', true, '2020-01-01'),
    ('SOC-105', '', 'MAYHUASCA BASTIDAS CLUDDY', 'Activo', true, '2020-01-01'),
    ('SOC-106', '', 'NICHO LOPEZ ESTHEPANY CARICIA', 'Activo', true, '2020-01-01'),
    ('SOC-107', '', 'JARA ALVARES CRISTALINA', 'Activo', true, '2020-01-01'),
    ('SOC-108', '', 'CRUZ JARAMILLO LUIS', 'Activo', true, '2020-01-01'),
    ('SOC-109', '', 'CALDERON VERA SEGUNDO ALCIDES', 'Activo', true, '2020-01-01'),
    ('SOC-110', '', 'CARPIO VASQUEZ TEOFILA', 'Activo', true, '2020-01-01'),
    ('SOC-111', '', 'VILLANUEVA INGA DE VASQUEZ ROSA', 'Activo', true, '2020-01-01'),
    ('SOC-112', '', 'VICENTE CALIXTO JOSE ALBERTO', 'Activo', true, '2020-01-01'),
    ('SOC-113', '', 'ZAPATA  VELIT VICTORIANO', 'Activo', true, '2020-01-01'),
    ('SOC-114', '', 'AGUIRRE QUISPE WILFREDO GILMER', 'Activo', true, '2020-01-01'),
    ('SOC-115', '', 'OQUENDO ARISACA MELESIA ROSARIO', 'Activo', true, '2020-01-01'),
    ('SOC-116', '', 'CABALLERO CALZADO GLADYS VICTORIA', 'Activo', true, '2020-01-01'),
    ('SOC-117', '', 'CORDOVA PEREZ MARCO ANTONIO', 'Activo', true, '2020-01-01'),
    ('SOC-118', '', 'VILCHEZ GUTARRA LOURDES FANNY', 'Activo', true, '2020-01-01'),
    ('SOC-119', '', 'CASTRO ALEJANDRO HORTENCIA LUCILA', 'Activo', true, '2020-01-01'),
    ('SOC-120', '', 'ALVAREZ MARIN MARIANELA', 'Activo', true, '2020-01-01'),
    ('SOC-121', '', 'QUISPE CONSA VIDAL', 'Activo', true, '2020-01-01'),
    ('SOC-122', '', 'ESTELA SUAREZ ELVIA', 'Activo', true, '2020-01-01'),
    ('SOC-123', '', 'MESIA CRUZ GLADYS', 'Activo', true, '2020-01-01'),
    ('SOC-124', '', 'VARA CASTRO ERNESTINA', 'Activo', true, '2020-01-01'),
    ('SOC-125', '', 'QUISPE DE PALOMINO DOROTEA', 'Activo', true, '2020-01-01'),
    ('SOC-126', '', 'PALOMINO VELASQUEZ EUSEBIO', 'Activo', true, '2020-01-01'),
    ('SOC-127', '', 'MAYTA COLQUI VIOLETA', 'Activo', true, '2020-01-01'),
    ('SOC-128', '', 'GUTIERREZ CASTRO JORGE', 'Activo', true, '2020-01-01'),
    ('SOC-129', '', 'ALHUAY PALOMINO DE ALHUAY JUANA', 'Activo', true, '2020-01-01'),
    ('SOC-130', '', 'ORDOÑEZ NICHO AZUL CARILE', 'Activo', true, '2020-01-01'),
    ('SOC-131', '', 'LOPEZ HUAYHUALLA NELLY NATIVIDAD', 'Activo', true, '2020-01-01'),
    ('SOC-132', '', 'CAHUANA VDA DE DAVILA VICENTINA', 'Activo', true, '2020-01-01'),
    ('SOC-133', '', 'OQUENDO QUISPE MIGUEL', 'Activo', true, '2020-01-01'),
    ('SOC-134', '', 'OJEDA CAMPOS EDSON', 'Activo', true, '2020-01-01'),
    ('SOC-135', '', 'REYES SANCHEZ MILENA GERALDINE', 'Activo', true, '2020-01-01'),
    ('SOC-136', '', 'GAVILAN MOSQUERA NORMA', 'Activo', true, '2020-01-01'),
    ('SOC-137', '', 'MARIN LONDOÑE MARIA LUZ', 'Activo', true, '2020-01-01'),
    ('SOC-138', '', 'CARTAGENA PALOMINO ALVARO BENJAMIN', 'Activo', true, '2020-01-01'),
    ('SOC-139', '', 'ISIDRO MARIN CARLOS DANIEL', 'Activo', true, '2020-01-01'),
    ('SOC-140', '', 'TITO FALCON JESUSA RICARDINA', 'Activo', true, '2020-01-01'),
    ('SOC-141', '', 'MELO BACA MARINA', 'Activo', true, '2020-01-01'),
    ('SOC-142', '', 'RAMOS CUEVA PEDRO', 'Activo', true, '2020-01-01'),
    ('SOC-143', '', 'SALVATIERRA AYALA ALLISON', 'Activo', true, '2020-01-01'),
    ('SOC-144', '', 'QUISPE DURAN ADRIANA', 'Activo', true, '2020-01-01'),
    ('SOC-145', '', 'RODRIGUEZ MORENO NORA', 'Activo', true, '2020-01-01'),
    ('SOC-146', '', 'ATANASIO ORTEGA MAXIMILIANA', 'Activo', true, '2020-01-01'),
    ('SOC-147', '', 'OQUENDO QUISPE JESSICA', 'Activo', true, '2020-01-01'),
    ('SOC-148', '', 'ROMERO YSLA ESTEBAN LIDIO', 'Activo', true, '2020-01-01'),
    ('SOC-149', '', 'CALLE ALVAREZ MARCO', 'Activo', true, '2020-01-01'),
    ('SOC-150', '', 'MALLQUI LOPEZ LIZBETH', 'Activo', true, '2020-01-01'),
    ('SOC-151', '', 'PORRAS DE OROYA OLIMPIA', 'Activo', true, '2020-01-01'),
    ('SOC-152', '', 'BASTIDAS MEDINA HERMEREGILDO', 'Activo', true, '2020-01-01'),
    ('SOC-153', '', 'QUINTANA VIDAL GLICERIO', 'Activo', true, '2020-01-01'),
    ('SOC-154', '', 'HERMELINDA MAYTA MATOS', 'Activo', true, '2020-01-01'),
    ('SOC-155', '', 'TORRES ASTO VDA DE CALDERON JUANA', 'Activo', true, '2020-01-01'),
    ('SOC-156', '', 'MORENO CHAVEZ RAFAEL FREDY', 'Activo', true, '2020-01-01'),
    ('SOC-157', '', 'JARA ALVAREZ SANTOS', 'Activo', true, '2020-01-01'),
    ('SOC-158', '', 'SOTO VARGAS DE FLORES MARIA DEL CARMEN', 'Activo', true, '2020-01-01'),
    ('SOC-159', '', 'CERDA YUPANQUI CARMEN ROSA', 'Activo', true, '2020-01-01'),
    ('SOC-160', '', 'SANTILLAN MESIA ZOILA', 'Activo', true, '2020-01-01'),
    ('SOC-161', '', 'VALLEJOS HUAMAN MARIA', 'Activo', true, '2020-01-01'),
    ('SOC-162', '', 'HEREDIA MUÑOZ DE BRAVO MARIA', 'Activo', true, '2020-01-01'),
    ('SOC-163', '', 'ALVAREZ CAMPOS VICTOR', 'Activo', true, '2020-01-01'),
    ('SOC-164', '', 'LUJAN GONZALES MARINO JUAN', 'Activo', true, '2020-01-01'),
    ('SOC-165', '', 'CUCHO DE LA CRUZ SAUL', 'Activo', true, '2020-01-01'),
    ('SOC-166', '', 'MEDINA GUITIERRES HONORATA', 'Activo', true, '2020-01-01'),
    ('SOC-167', '', 'CUSI LAURA SONIA', 'Activo', true, '2020-01-01'),
    ('SOC-168', '', 'ROMERO FLORES EDDNA', 'Activo', true, '2020-01-01'),
    ('SOC-169', '', 'CORNEJO DONATO DE CORDOVA ESTELA PILAR', 'Activo', true, '2020-01-01'),
    ('SOC-170', '', 'DE LA CRUZ ESTEBAN JOSE', 'Activo', true, '2020-01-01'),
    ('SOC-171', '', 'SALAZAR CONCEPCION VICTORIA', 'Activo', true, '2020-01-01'),
    ('SOC-172', '', 'ROJAS CORNEJO ERICK', 'Activo', true, '2020-01-01'),
    ('SOC-173', '', 'BERNAOLA DE PRADO FLORENCIA', 'Activo', true, '2020-01-01'),
    ('SOC-174', '', 'GUTIERREZ CASTILLO  TERESA JESUS', 'Activo', true, '2020-01-01'),
    ('SOC-175', '', 'SANCHEZ RODRIGUEZ JUDITH', 'Activo', true, '2020-01-01'),
    ('SOC-176', '', 'SOTO GALLEGO DE VALERO', 'Activo', true, '2020-01-01'),
    ('SOC-177', '', 'TELLO QUINTANA EDGAR', 'Activo', true, '2020-01-01'),
    ('SOC-178', '', 'HALIRE YUCRA JOSUE', 'Activo', true, '2020-01-01'),
    ('SOC-179', '', 'CAMPUZANO CABELLO VICENTA DONATILA', 'Activo', true, '2020-01-01'),
    ('SOC-180', '', 'MARIN ROCHA ESTEFANY', 'Activo', true, '2020-01-01'),
    ('SOC-181', '', 'REYES PEREZ DE VALENCIA NANCY', 'Activo', true, '2020-01-01'),
    ('SOC-182', '', 'FLORES FLORES IRENE BERTILIA', 'Activo', true, '2020-01-01'),
    ('SOC-183', '', 'VALERO SOTO  MAXIMO ELIAS', 'Activo', true, '2020-01-01'),
    ('SOC-184', '', 'QUISPE ORTEGA ROSA CARMEN', 'Activo', true, '2020-01-01'),
    ('SOC-185', '', 'MARIN LONDOÑE EDUARDO SANTIAGO', 'Activo', true, '2020-01-01');

-- PASO 4: 185 titularidades
INSERT INTO public.historial_titularidad (puesto_id, socio_id, fecha_inicio)
VALUES
    (1, 1, '2020-01-01'),  -- Huamani Romero Donatila → puesto "1"
    (2, 2, '2020-01-01'),  -- Limas Vargas Carmen Rosa → puesto "2"
    (3, 3, '2020-01-01'),  -- Romero Ninahuaman Javier → puesto "3"
    (4, 4, '2020-01-01'),  -- Sosa Valdivia Juana Isabel → puesto "4"
    (5, 5, '2020-01-01'),  -- Medina Jota Vicenta → puesto "5"
    (6, 6, '2020-01-01'),  -- Salas Montalvo Ruth → puesto "6"
    (7, 7, '2020-01-01'),  -- Uretra Cruz Emilia → puesto "8"
    (8, 8, '2020-01-01'),  -- Huashuayo Gomez Eudosia → puesto "9"
    (9, 9, '2020-01-01'),  -- Ayala Toboada Eliseo → puesto "10"
    (10, 10, '2020-01-01'),  -- Ayala Huashuayo Norma Gladys → puesto "12"
    (11, 11, '2020-01-01'),  -- Cardeña Villafuerte Alejandrina → puesto "13"
    (12, 12, '2020-01-01'),  -- Falcon Chiara Hector  Marcial → puesto "14"
    (13, 13, '2020-01-01'),  -- Burga Carrasco Elida → puesto "15"
    (14, 14, '2020-01-01'),  -- Cuya Sanchez Alberto → puesto "16"
    (15, 15, '2020-01-01'),  -- Ccoyllo Bustillos Deysi Karen → puesto "17"
    (16, 16, '2020-01-01'),  -- Castro Gutierrez Aquila Lucrecia → puesto "18"
    (17, 17, '2020-01-01'),  -- Paredes Morales Diana → puesto "19"
    (18, 18, '2020-01-01'),  -- Javier Sermeño Gutierrez → puesto "20"
    (19, 19, '2020-01-01'),  -- Valero Pariona Maximo → puesto "21"
    (20, 20, '2020-01-01'),  -- Valero Soto Willy Perseo Albino → puesto "22"
    (21, 21, '2020-01-01'),  -- Yaurimucha Rimachi Marcos → puesto "23"
    (22, 22, '2020-01-01'),  -- Flores Yato Francisca Dolores → puesto "24"
    (23, 23, '2020-01-01'),  -- Lagos Luna de Leiva Zaida → puesto "25"
    (24, 24, '2020-01-01'),  -- Taype Oquendo Eugenio Joel → puesto "26"
    (25, 25, '2020-01-01'),  -- Clemente Aller Cirila → puesto "27"
    (26, 26, '2020-01-01'),  -- Paredes Morales Oscar Martín → puesto "28"
    (27, 27, '2020-01-01'),  -- Pacompia Cardeña Giovanni → puesto "29"
    (28, 28, '2020-01-01'),  -- Quispe Uribe Luciano → puesto "30"
    (29, 29, '2020-01-01'),  -- Marin Huaman de Salamanca Maria → puesto "31"
    (30, 30, '2020-01-01'),  -- Pittman Concepción Nelly Maria → puesto "33"
    (31, 31, '2020-01-01'),  -- Segovia Villafuerte de Ponce → puesto "34"
    (32, 32, '2020-01-01'),  -- Espejo Urbano Rosa Florencia → puesto "35"
    (33, 33, '2020-01-01'),  -- Sanchez Astos de Torres Yolanda Sofia → puesto "36"
    (34, 34, '2020-01-01'),  -- Cabero Mendoza Gloria → puesto "37"
    (35, 35, '2020-01-01'),  -- Salas Montalvo Magali Judith → puesto "38"
    (36, 36, '2020-01-01'),  -- Gutierrez Flores Roger Reyman → puesto "39"
    (37, 37, '2020-01-01'),  -- Perez Quispe Epifania → puesto "40"
    (38, 38, '2020-01-01'),  -- Rojas Ignacio Leonila → puesto "41"
    (39, 39, '2020-01-01'),  -- Prado Llancari Zozima → puesto "42"
    (40, 40, '2020-01-01'),  -- Saavedra Curipuma Luis Humberto → puesto "43"
    (41, 41, '2020-01-01'),  -- Tello Alvarez Marino → puesto "44"
    (42, 42, '2020-01-01'),  -- Juarez Cuellar Leonor → puesto "47"
    (43, 43, '2020-01-01'),  -- Ancco Leon Valentina → puesto "48"
    (44, 44, '2020-01-01'),  -- Ccoyllo Polanco German → puesto "49"
    (45, 45, '2020-01-01'),  -- Jara Alvarez Maria Cenaida → puesto "50"
    (46, 46, '2020-01-01'),  -- Rodriguez Arquiñego Idilio Félix → puesto "51"
    (47, 47, '2020-01-01'),  -- Paredes Flores Oscar → puesto "53"
    (48, 48, '2020-01-01'),  -- Juan Valverde Rosas (CERRADO) → puesto "54"
    (49, 49, '2020-01-01'),  -- Ccoyllo Chinchay Judith → puesto "55"
    (50, 50, '2020-01-01'),  -- Calle Calle Fidel → puesto "56"
    (51, 51, '2020-01-01'),  -- Davila Cahuana Marisol → puesto "57"
    (52, 52, '2020-01-01'),  -- Estela Calderon Torres → puesto "58"
    (53, 53, '2020-01-01'),  -- Alarcon Anampa Nancy Gisela → puesto "59"
    (54, 54, '2020-01-01'),  -- Anampa Corahua Clemencia Migdonia → puesto "60"
    (55, 55, '2020-01-01'),  -- Ñahui Ruiz Aurelio → puesto "61"
    (56, 56, '2020-01-01'),  -- Ccoyllo Chinchay Daniel Masia → puesto "62"
    (57, 57, '2020-01-01'),  -- Alarcon Anampa Betsy → puesto "63"
    (58, 58, '2020-01-01'),  -- Bravo Heredia Ana Maritza → puesto "64"
    (59, 59, '2020-01-01'),  -- Sanchez Soto Lucia → puesto "65"
    (60, 60, '2020-01-01'),  -- Yruipalla Falcon Hilda → puesto "66"
    (61, 61, '2020-01-01'),  -- Chuchuyo Hacha José → puesto "67"
    (62, 62, '2020-01-01'),  -- Soria Tapia Edith Catalina → puesto "68"
    (63, 63, '2020-01-01'),  -- Rivera Callpa Juana Regis → puesto "69"
    (64, 64, '2020-01-01'),  -- Torres Anyorsa Marcelino → puesto "70"
    (65, 65, '2020-01-01'),  -- Cuevas Mayo Enrique → puesto "71"
    (66, 66, '2020-01-01'),  -- Tintaya Cahuana Patricia → puesto "72"
    (67, 67, '2020-01-01'),  -- Alvarez Campos Rolando → puesto "73"
    (68, 68, '2020-01-01'),  -- Bastidas Medina Dina → puesto "74"
    (69, 69, '2020-01-01'),  -- Carrasco Salvatierra Felicitas → puesto "75"
    (70, 70, '2020-01-01'),  -- Cajaleon Carrasco Luis Enrique → puesto "76"
    (71, 71, '2020-01-01'),  -- Chirinos Cabracancha María → puesto "78"
    (105, 72, '2020-01-01'),  -- HUAYHUALLA DE LOPEZ DONATILA → puesto "113"
    (106, 73, '2020-01-01'),  -- QUISPE COPAYO  ELIO CARLOS → puesto "114"
    (131, 74, '2020-01-01'),  -- RODRIGUEZ CORDOVA MARCOS → puesto "139"
    (132, 75, '2020-01-01'),  -- HUAMAN YNCA VISITACION → puesto "140"
    (180, 76, '2020-01-01'),  -- TORRES ASTO FRANCISCO → puesto "189"
    (179, 77, '2020-01-01'),  -- MAYHUASCA BASTIDAS ULISES → puesto "188"
    (157, 78, '2020-01-01'),  -- CARTAGENA MAMANI BENJAMIN → puesto "165"
    (178, 79, '2020-01-01'),  -- PEREZ PONCE SATURNINA MARGARITA → puesto "187"
    (156, 80, '2020-01-01'),  -- PALOMINO HANCCO CECILIA → puesto "164"
    (133, 81, '2020-01-01'),  -- ZAPATA RIVERA ROSANA → puesto "141"
    (130, 82, '2020-01-01'),  -- PLAZA COSQUILLO ROSA ESTELA → puesto "138"
    (107, 83, '2020-01-01'),  -- QUISPE CONSA MIGUEL → puesto "115"
    (104, 84, '2020-01-01'),  -- TINEO CABRERA SONIA → puesto "112"
    (184, 85, '2020-01-01'),  -- CHALLCO DE PALOMINO NICOLAZA → puesto "194"
    (185, 86, '2020-01-01'),  -- PALOMINO TENORIO SILVIO EDUARDO → puesto "195"
    (163, 87, '2020-01-01'),  -- CULE CARRASCO HAYDEE MONICA → puesto "171"
    (103, 88, '2020-01-01'),  -- YRUPAILLA ANAMPA ISIDRO → puesto "111"
    (108, 89, '2020-01-01'),  -- VALENCIA TOMAS VICENTE → puesto "116"
    (129, 90, '2020-01-01'),  -- TORRES ASTO NERY (F) → puesto "137"
    (134, 91, '2020-01-01'),  -- RIVERA FERNANDEZ MARINA MAXILIANA → puesto "142"
    (155, 92, '2020-01-01'),  -- FLORES FLORES UMBELINA DORA → puesto "163"
    (177, 93, '2020-01-01'),  -- MAYHUASCA BASTIDAS MARILU → puesto "186"
    (176, 94, '2020-01-01'),  -- ORTIZ ÑAUPA WELINTONH → puesto "185"
    (154, 95, '2020-01-01'),  -- ESTRADA OSCAR → puesto "162"
    (135, 96, '2020-01-01'),  -- MEDINA MEDRANO JUAN CARLOS → puesto "143"
    (128, 97, '2020-01-01'),  -- RICSE SAYES TERESA REYNA → puesto "136"
    (109, 98, '2020-01-01'),  -- CCOYLLO POLANCO DANIEL → puesto "117"
    (102, 99, '2020-01-01'),  -- CCOYLLO MAYHUASCA ALEXIS → puesto "110"
    (183, 100, '2020-01-01'),  -- MALLQUI JULCA ALEJANDRINO TEODORO → puesto "192"
    (182, 101, '2020-01-01'),  -- GUTIERREZ CASTILLO  JORGE → puesto "191"
    (85, 102, '2020-01-01'),  -- CHOQUEHUAMANI FELIX CEFERINO → puesto "93"
    (101, 103, '2020-01-01'),  -- GELDRES REVILLA MIGUEL → puesto "109"
    (110, 104, '2020-01-01'),  -- VARA DE ROSAS ALICIA VALENTINA → puesto "118"
    (127, 105, '2020-01-01'),  -- MAYHUASCA BASTIDAS CLUDDY → puesto "135"
    (136, 106, '2020-01-01'),  -- NICHO LOPEZ ESTHEPANY CARICIA → puesto "144"
    (153, 107, '2020-01-01'),  -- JARA ALVARES CRISTALINA → puesto "161"
    (159, 108, '2020-01-01'),  -- CRUZ JARAMILLO LUIS → puesto "167"
    (175, 109, '2020-01-01'),  -- CALDERON VERA SEGUNDO ALCIDES → puesto "184"
    (174, 110, '2020-01-01'),  -- CARPIO VASQUEZ TEOFILA → puesto "183"
    (160, 111, '2020-01-01'),  -- VILLANUEVA INGA DE VASQUEZ ROSA → puesto "168"
    (152, 112, '2020-01-01'),  -- VICENTE CALIXTO JOSE ALBERTO → puesto "160"
    (137, 113, '2020-01-01'),  -- ZAPATA  VELIT VICTORIANO → puesto "145"
    (126, 114, '2020-01-01'),  -- AGUIRRE QUISPE WILFREDO GILMER → puesto "134"
    (111, 115, '2020-01-01'),  -- OQUENDO ARISACA MELESIA ROSARIO → puesto "119"
    (100, 116, '2020-01-01'),  -- CABALLERO CALZADO GLADYS VICTORIA → puesto "108"
    (86, 117, '2020-01-01'),  -- CORDOVA PEREZ MARCO ANTONIO → puesto "94"
    (84, 118, '2020-01-01'),  -- VILCHEZ GUTARRA LOURDES FANNY → puesto "91"
    (72, 119, '2020-01-01'),  -- CASTRO ALEJANDRO HORTENCIA LUCILA → puesto "79"
    (73, 120, '2020-01-01'),  -- ALVAREZ MARIN MARIANELA → puesto "80"
    (83, 121, '2020-01-01'),  -- QUISPE CONSA VIDAL → puesto "90"
    (87, 122, '2020-01-01'),  -- ESTELA SUAREZ ELVIA → puesto "95"
    (98, 123, '2020-01-01'),  -- MESIA CRUZ GLADYS → puesto "106"
    (113, 124, '2020-01-01'),  -- VARA CASTRO ERNESTINA → puesto "121"
    (124, 125, '2020-01-01'),  -- QUISPE DE PALOMINO DOROTEA → puesto "132"
    (139, 126, '2020-01-01'),  -- PALOMINO VELASQUEZ EUSEBIO → puesto "147"
    (150, 127, '2020-01-01'),  -- MAYTA COLQUI VIOLETA → puesto "158"
    (162, 128, '2020-01-01'),  -- GUTIERREZ CASTRO JORGE → puesto "170"
    (172, 129, '2020-01-01'),  -- ALHUAY PALOMINO DE ALHUAY JUANA → puesto "181"
    (173, 130, '2020-01-01'),  -- ORDOÑEZ NICHO AZUL CARILE → puesto "182"
    (161, 131, '2020-01-01'),  -- LOPEZ HUAYHUALLA NELLY NATIVIDAD → puesto "169"
    (151, 132, '2020-01-01'),  -- CAHUANA VDA DE DAVILA VICENTINA → puesto "159"
    (138, 133, '2020-01-01'),  -- OQUENDO QUISPE MIGUEL → puesto "146"
    (125, 134, '2020-01-01'),  -- OJEDA CAMPOS EDSON → puesto "133"
    (112, 135, '2020-01-01'),  -- REYES SANCHEZ MILENA GERALDINE → puesto "120"
    (99, 136, '2020-01-01'),  -- GAVILAN MOSQUERA NORMA → puesto "107"
    (74, 137, '2020-01-01'),  -- MARIN LONDOÑE MARIA LUZ → puesto "81"
    (82, 138, '2020-01-01'),  -- CARTAGENA PALOMINO ALVARO BENJAMIN → puesto "89"
    (88, 139, '2020-01-01'),  -- ISIDRO MARIN CARLOS DANIEL → puesto "96"
    (97, 140, '2020-01-01'),  -- TITO FALCON JESUSA RICARDINA → puesto "105"
    (114, 141, '2020-01-01'),  -- MELO BACA MARINA → puesto "122"
    (123, 142, '2020-01-01'),  -- RAMOS CUEVA PEDRO → puesto "131"
    (140, 143, '2020-01-01'),  -- SALVATIERRA AYALA ALLISON → puesto "148"
    (149, 144, '2020-01-01'),  -- QUISPE DURAN ADRIANA → puesto "157"
    (171, 145, '2020-01-01'),  -- RODRIGUEZ MORENO NORA → puesto "180"
    (170, 146, '2020-01-01'),  -- ATANASIO ORTEGA MAXIMILIANA → puesto "179"
    (164, 147, '2020-01-01'),  -- OQUENDO QUISPE JESSICA → puesto "172"
    (148, 148, '2020-01-01'),  -- ROMERO YSLA ESTEBAN LIDIO → puesto "156"
    (141, 149, '2020-01-01'),  -- CALLE ALVAREZ MARCO → puesto "149"
    (122, 150, '2020-01-01'),  -- MALLQUI LOPEZ LIZBETH → puesto "130"
    (115, 151, '2020-01-01'),  -- PORRAS DE OROYA OLIMPIA → puesto "123"
    (96, 152, '2020-01-01'),  -- BASTIDAS MEDINA HERMEREGILDO → puesto "104"
    (89, 153, '2020-01-01'),  -- QUINTANA VIDAL GLICERIO → puesto "97"
    (81, 154, '2020-01-01'),  -- HERMELINDA MAYTA MATOS → puesto "88"
    (75, 155, '2020-01-01'),  -- TORRES ASTO VDA DE CALDERON JUANA → puesto "82"
    (76, 156, '2020-01-01'),  -- MORENO CHAVEZ RAFAEL FREDY → puesto "83"
    (80, 157, '2020-01-01'),  -- JARA ALVAREZ SANTOS → puesto "87"
    (90, 158, '2020-01-01'),  -- SOTO VARGAS DE FLORES MARIA DEL CARMEN → puesto "98"
    (95, 159, '2020-01-01'),  -- CERDA YUPANQUI CARMEN ROSA → puesto "103"
    (116, 160, '2020-01-01'),  -- SANTILLAN MESIA ZOILA → puesto "124"
    (121, 161, '2020-01-01'),  -- VALLEJOS HUAMAN MARIA → puesto "129"
    (142, 162, '2020-01-01'),  -- HEREDIA MUÑOZ DE BRAVO MARIA → puesto "150"
    (147, 163, '2020-01-01'),  -- ALVAREZ CAMPOS VICTOR → puesto "155"
    (169, 164, '2020-01-01'),  -- LUJAN GONZALES MARINO JUAN → puesto "178"
    (168, 165, '2020-01-01'),  -- CUCHO DE LA CRUZ SAUL → puesto "177"
    (165, 166, '2020-01-01'),  -- MEDINA GUITIERRES HONORATA → puesto "174"
    (146, 167, '2020-01-01'),  -- CUSI LAURA SONIA → puesto "154"
    (143, 168, '2020-01-01'),  -- ROMERO FLORES EDDNA → puesto "151"
    (120, 169, '2020-01-01'),  -- CORNEJO DONATO DE CORDOVA ESTELA PILAR → puesto "128"
    (117, 170, '2020-01-01'),  -- DE LA CRUZ ESTEBAN JOSE → puesto "125"
    (94, 171, '2020-01-01'),  -- SALAZAR CONCEPCION VICTORIA → puesto "102"
    (91, 172, '2020-01-01'),  -- ROJAS CORNEJO ERICK → puesto "99"
    (158, 173, '2020-01-01'),  -- BERNAOLA DE PRADO FLORENCIA → puesto "166"
    (77, 174, '2020-01-01'),  -- GUTIERREZ CASTILLO  TERESA JESUS → puesto "84"
    (181, 175, '2020-01-01'),  -- SANCHEZ RODRIGUEZ JUDITH → puesto "190"
    (78, 176, '2020-01-01'),  -- SOTO GALLEGO DE VALERO → puesto "85"
    (79, 177, '2020-01-01'),  -- TELLO QUINTANA EDGAR → puesto "86"
    (92, 178, '2020-01-01'),  -- HALIRE YUCRA JOSUE → puesto "100"
    (93, 179, '2020-01-01'),  -- CAMPUZANO CABELLO VICENTA DONATILA → puesto "101"
    (118, 180, '2020-01-01'),  -- MARIN ROCHA ESTEFANY → puesto "126"
    (119, 181, '2020-01-01'),  -- REYES PEREZ DE VALENCIA NANCY → puesto "127"
    (144, 182, '2020-01-01'),  -- FLORES FLORES IRENE BERTILIA → puesto "152"
    (145, 183, '2020-01-01'),  -- VALERO SOTO  MAXIMO ELIAS → puesto "153"
    (166, 184, '2020-01-01'),  -- QUISPE ORTEGA ROSA CARMEN → puesto "175"
    (167, 185, '2020-01-01');  -- MARIN LONDOÑE EDUARDO SANTIAGO → puesto "176"

-- PASO 5: 65 inquilinos
INSERT INTO public.inquilinos (dni, nombres, apellidos)
VALUES
    ('INQ-001', '', 'BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA'),
    ('INQ-002', '', 'MAYHUASCA BASTIDAS DORIS'),
    ('INQ-003', '', 'REBAZA REBAZA CASILDA'),
    ('INQ-004', '', 'ZANABRIA LADERA LILIA'),
    ('INQ-005', '', 'CHOQUEHUANCA HUMAN DERSE'),
    ('INQ-006', '', 'MIRANDA CACERES FELICITAS'),
    ('INQ-007', '', 'BURGA CARRASCO ELMER'),
    ('INQ-008', '', 'YAUYOS MENDIETA MARLENE'),
    ('INQ-009', '', 'LAPAS SALAZAR ANA MARIA'),
    ('INQ-010', '', 'CERDAN  MUÑOZ MARIA'),
    ('INQ-011', '', 'PFUÑO RAMOS VICTOR'),
    ('INQ-012', '', 'CARRASCO PICHIHUA MERY RUTH'),
    ('INQ-013', '', 'AZURZA TRIBIÑOS DAYSI ELIZABETH'),
    ('INQ-014', '', 'DAVID VICENTE CCENCHO CARRASCO'),
    ('INQ-015', '', 'BENITES TRIBIÑOS SILVIA FABIOLA'),
    ('INQ-016', '', 'DAVILA HILARES YESENIA'),
    ('INQ-017', '', 'LOPEZ CERRON HAYDEE'),
    ('INQ-018', '', 'YAURIMUCHA RIMACHI URSULA'),
    ('INQ-019', '', 'CERVANTES GARCIA CARLOS ARTURO'),
    ('INQ-020', '', 'HERNANDEZ HERNANDEZ LILIBETH'),
    ('INQ-021', '', 'GARCIA VDA MEDINA CLEMENCIA BEATRIZ'),
    ('INQ-022', '', 'GLADYS ENCARNACION PAUCARPOMA'),
    ('INQ-023', '', 'ARREDONDO GARCIA GLADYS'),
    ('INQ-024', '', 'PRADO CATAÑO MIRIAM MILAGROS'),
    ('INQ-025', '', 'PEÑA VDA DE VILLANUEVA TEREZA'),
    ('INQ-026', '', 'PALOMINO CUSI ROSA'),
    ('INQ-027', '', 'AIRE MALPARTIDA HECTOR'),
    ('INQ-028', '', 'ROSA ARMANDINA RENTERIA HUANCAS'),
    ('INQ-029', '', 'CAHUANA PUCURUMAY ALEX'),
    ('INQ-030', '', 'ARMESTA GODOS JUANA JACKELINE'),
    ('INQ-031', '', 'LA ROSA LOPEZ MARGARITA'),
    ('INQ-032', '', 'GOMERO DULANTO MARGARITA'),
    ('INQ-033', '', 'CASTRO RODRIGUEZ JANET  CONSUELO'),
    ('INQ-034', '', 'MUJICA PALOMINO SANDRA'),
    ('INQ-035', '', 'AVILA CHAVEZ ROSA'),
    ('INQ-036', '', 'YUPANQUI SAYDA'),
    ('INQ-037', '', 'SALAZAR VASQUEZ MARIA'),
    ('INQ-038', '', 'CONDORI MAMANI LIDIA'),
    ('INQ-039', '', 'FLORES LAREDO DOMINICIA LUCIANA'),
    ('INQ-040', '', 'MALLMA CONDORI LIZBETH LUCIA'),
    ('INQ-041', '', 'OBREGON CASTILLO FERNANDO MARTIN'),
    ('INQ-042', '', 'LEONARDO AMARILLO ROSANA PILAR'),
    ('INQ-043', '', 'LEONARDO AMARILLO FEDERICO'),
    ('INQ-044', '', 'LEON RODRIGUEZ ANGIE MARGARITA'),
    ('INQ-045', '', 'CLAROS SANTOS'),
    ('INQ-046', '', 'QUISPE CHAVEZ MARISOL'),
    ('INQ-047', '', 'BUSTAMANTE CHILON GRACIELA'),
    ('INQ-048', '', 'ALVAREZ CHIARA EDGAR'),
    ('INQ-049', '', 'ALVAREZ BERRIO FLORENCIA'),
    ('INQ-050', '', 'MARIELA  CUNIAS SANTOS'),
    ('INQ-051', '', 'HERRERA CAMPOS ORFELITA'),
    ('INQ-052', '', 'CHOQUEHUANCA HUAMAN DAVID'),
    ('INQ-053', '', 'HERRERA PEVES ROMINA DEL CARMEN'),
    ('INQ-054', '', 'GOMEZ MITMA MARIBEL'),
    ('INQ-055', '', 'CHAMBI APAZA SIMONA'),
    ('INQ-056', '', 'QUISPE MAMANI PATRICIA PAOLA'),
    ('INQ-057', '', 'Ayala Huashuayo Marlen Ester'),
    ('INQ-058', '', 'Peña Ashley'),
    ('INQ-059', '', 'Sanchez Diana'),
    ('INQ-060', '', 'Colina Sirley'),
    ('INQ-061', '', 'CASTILLO ZAPATA ASAEL'),
    ('INQ-062', '', 'ANCHAYA HUAMAN ABEL'),
    ('INQ-063', '', 'ALARCON ESPINOZA MARTHA'),
    ('INQ-064', '', 'DURAND CHACON BLANCA'),
    ('INQ-065', '', 'ESPARTRA CARDENAS JULIO HECTOR');

-- PASO 6: 49 arriendos automáticos
-- Omitidos: 16 (sin titular identificable o puesto compartido)
--   Asignar desde UI → Inquilinos → Asignar puesto
--   INQ-004 "ZANABRIA LADERA LILIA" → puesto "7-E" (sin socio titular)
--   INQ-013 "AZURZA TRIBIÑOS DAYSI ELIZABETH" → puesto "11-E" (sin socio titular)
--   INQ-028 "ROSA ARMANDINA RENTERIA HUANCAS" → puesto "32-E" (sin socio titular)
--   INQ-037 "SALAZAR VASQUEZ MARIA" → puesto "42E" (puesto compartido)
--   INQ-038 "CONDORI MAMANI LIDIA" → puesto "42E" (puesto compartido)
--   INQ-047 "BUSTAMANTE CHILON GRACIELA" → puesto "52E" (sin socio titular)
--   INQ-050 "MARIELA  CUNIAS SANTOS" → puesto "49E Y 50E" (puesto compartido)
--   INQ-051 "HERRERA CAMPOS ORFELITA" → puesto "49E Y 50E" (puesto compartido)
--   INQ-052 "CHOQUEHUANCA HUAMAN DAVID" → puesto "46E" (sin socio titular)
--   INQ-057 "Ayala Huashuayo Marlen Ester" → puesto "11" (sin socio titular)
--   INQ-058 "Peña Ashley" → puesto "45" (sin socio titular)
--   INQ-059 "Sanchez Diana" → puesto "46" (sin socio titular)
--   INQ-060 "Colina Sirley" → puesto "32" (sin socio titular)
--   INQ-063 "ALARCON ESPINOZA MARTHA" → puesto "2DO PISO" (puesto compartido)
--   INQ-064 "DURAND CHACON BLANCA" → puesto "2DO PISO" (puesto compartido)
--   INQ-065 "ESPARTRA CARDENAS JULIO HECTOR" → puesto "2DO PISO" (puesto compartido)
INSERT INTO public.historial_arriendos (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
VALUES
    (217, 1, 4, '2020-01-01'),  -- BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA → puesto "4-E"
    (229, 2, 5, '2020-01-01'),  -- MAYHUASCA BASTIDAS DORIS → puesto "5-E"
    (241, 3, 6, '2020-01-01'),  -- REBAZA REBAZA CASILDA → puesto "6-E"
    (236, 5, 51, '2020-01-01'),  -- CHOQUEHUANCA HUMAN DERSE → puesto "57-E"
    (206, 6, 25, '2020-01-01'),  -- MIRANDA CACERES FELICITAS → puesto "27-E"
    (245, 7, 7, '2020-01-01'),  -- BURGA CARRASCO ELMER → puesto "8-E"
    (246, 8, 8, '2020-01-01'),  -- YAUYOS MENDIETA MARLENE → puesto "9-E"
    (205, 9, 24, '2020-01-01'),  -- LAPAS SALAZAR ANA MARIA → puesto "26-E"
    (204, 10, 23, '2020-01-01'),  -- CERDAN  MUÑOZ MARIA → puesto "25-E"
    (187, 11, 9, '2020-01-01'),  -- PFUÑO RAMOS VICTOR → puesto "10-E"
    (203, 12, 22, '2020-01-01'),  -- CARRASCO PICHIHUA MERY RUTH → puesto "24-E"
    (202, 14, 21, '2020-01-01'),  -- DAVID VICENTE CCENCHO CARRASCO → puesto "23-E"
    (190, 15, 10, '2020-01-01'),  -- BENITES TRIBIÑOS SILVIA FABIOLA → puesto "12-E"
    (201, 16, 20, '2020-01-01'),  -- DAVILA HILARES YESENIA → puesto "22-E"
    (191, 17, 11, '2020-01-01'),  -- LOPEZ CERRON HAYDEE → puesto "13-E"
    (200, 18, 19, '2020-01-01'),  -- YAURIMUCHA RIMACHI URSULA → puesto "21-E"
    (192, 19, 12, '2020-01-01'),  -- CERVANTES GARCIA CARLOS ARTURO → puesto "14-E"
    (199, 20, 18, '2020-01-01'),  -- HERNANDEZ HERNANDEZ LILIBETH → puesto "20-E"
    (193, 21, 13, '2020-01-01'),  -- GARCIA VDA MEDINA CLEMENCIA BEATRIZ → puesto "15-E"
    (197, 22, 17, '2020-01-01'),  -- GLADYS ENCARNACION PAUCARPOMA → puesto "19-E"
    (194, 23, 14, '2020-01-01'),  -- ARREDONDO GARCIA GLADYS → puesto "16-E"
    (196, 24, 16, '2020-01-01'),  -- PRADO CATAÑO MIRIAM MILAGROS → puesto "18-E"
    (195, 25, 15, '2020-01-01'),  -- PEÑA VDA DE VILLANUEVA TEREZA → puesto "17-E"
    (207, 26, 26, '2020-01-01'),  -- PALOMINO CUSI ROSA → puesto "28-E"
    (211, 27, 29, '2020-01-01'),  -- AIRE MALPARTIDA HECTOR → puesto "31-E"
    (210, 29, 28, '2020-01-01'),  -- CAHUANA PUCURUMAY ALEX → puesto "30-E"
    (208, 30, 27, '2020-01-01'),  -- ARMESTA GODOS JUANA JACKELINE → puesto "29-E"
    (224, 31, 42, '2020-01-01'),  -- LA ROSA LOPEZ MARGARITA → puesto "47-E"
    (243, 32, 54, '2020-01-01'),  -- GOMERO DULANTO MARGARITA → puesto "60E"
    (216, 33, 34, '2020-01-01'),  -- CASTRO RODRIGUEZ JANET  CONSUELO → puesto "37E"
    (240, 34, 53, '2020-01-01'),  -- MUJICA PALOMINO SANDRA → puesto "59E"
    (218, 35, 37, '2020-01-01'),  -- AVILA CHAVEZ ROSA → puesto "40E"
    (227, 36, 44, '2020-01-01'),  -- YUPANQUI SAYDA → puesto "49-E"
    (220, 39, 40, '2020-01-01'),  -- FLORES LAREDO DOMINICIA LUCIANA → puesto "43E"
    (239, 40, 52, '2020-01-01'),  -- MALLMA CONDORI LIZBETH LUCIA → puesto "58E"
    (237, 41, 51, '2020-01-01'),  -- OBREGON CASTILLO FERNANDO MARTIN → puesto "57E"
    (235, 42, 50, '2020-01-01'),  -- LEONARDO AMARILLO ROSANA PILAR → puesto "56E"
    (234, 43, 49, '2020-01-01'),  -- LEONARDO AMARILLO FEDERICO → puesto "55E"
    (214, 44, 30, '2020-01-01'),  -- LEON RODRIGUEZ ANGIE MARGARITA → puesto "33-E"
    (233, 45, 48, '2020-01-01'),  -- CLAROS SANTOS → puesto "54E"
    (232, 46, 47, '2020-01-01'),  -- QUISPE CHAVEZ MARISOL → puesto "53E"
    (230, 48, 46, '2020-01-01'),  -- ALVAREZ CHIARA EDGAR → puesto "51E"
    (215, 49, 31, '2020-01-01'),  -- ALVAREZ BERRIO FLORENCIA → puesto "34-E"
    (225, 53, 42, '2020-01-01'),  -- HERRERA PEVES ROMINA DEL CARMEN → puesto "47E"
    (226, 54, 43, '2020-01-01'),  -- GOMEZ MITMA MARIBEL → puesto "48E"
    (242, 55, 54, '2020-01-01'),  -- CHAMBI APAZA SIMONA → puesto "60-E"
    (238, 56, 52, '2020-01-01'),  -- QUISPE MAMANI PATRICIA PAOLA → puesto "58-E"
    (186, 61, 1, '2020-01-01'),  -- CASTILLO ZAPATA ASAEL → puesto "1-E"
    (198, 62, 2, '2020-01-01');  -- ANCHAYA HUAMAN ABEL → puesto "2-E"

-- PASO 7: Verificación
DO $$
BEGIN
    ASSERT (SELECT count(*) FROM public.socios)                = 185,    'ERROR: socios';
    ASSERT (SELECT count(*) FROM public.inquilinos)            = 65, 'ERROR: inquilinos';
    ASSERT (SELECT count(*) FROM public.puestos)               = 246,    'ERROR: puestos';
    ASSERT (SELECT count(*) FROM public.historial_titularidad WHERE fecha_fin IS NULL) = 185, 'ERROR: titularidades';
    ASSERT (SELECT count(*) FROM public.historial_arriendos WHERE fecha_fin IS NULL)   = 49, 'ERROR: arriendos';
    RAISE NOTICE '✓ Padrón real aplicado exitosamente.';
    RAISE NOTICE '  Socios:      185';
    RAISE NOTICE '  Inquilinos:  65 (49 con puesto asignado, 16 pendientes de UI)';
    RAISE NOTICE '  Puestos:     246';
END;
$$;

COMMIT;