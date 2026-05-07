-- =============================================================================
-- Migración 00035 — UPSERT Padrón Final (generado 2026-05-07)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Fuente: migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx
-- =============================================================================
-- RESUMEN:
--   Socios Excel:          185
--     • Match en BD:       168  (se actualiza DNI/datos si hay placeholder)
--     • Nuevos (INSERT):   17
--     • BD sin match:      17  (ver PASO 12 — revisar si marcar Inactivo)
--   Inquilinos Excel:      77
--     • -E (pequeños):     60
--     • COOP:              4
--     • -SP (2do piso):    6
--     • -EP (espacios):    7
--   Depósitos:             24
--     • Renter=Socio:      16  (→ solo puesto, arriendo manual)
--     • Renter=Inq BD:     0
--     • Renter Nuevo:      8
--   Puestos nuevos:        60
-- =============================================================================
-- ⚠️  REQUIERE REVISIÓN MANUAL:
--   [ ] Socios en BD sin match (PASO 12): decidir si marcar Inactivo
--   [ ] Arriendos -SP y -EP (PASO 10): asignar socio_titular_id manualmente
--   [ ] Arriendos depósitos (PASO 11): asignar socio_titular_id manualmente
--   [ ] Advertencias del script:
--       • DNIs duplicados en hoja SOCIOS (el 2º se marcará con sufijo -DUP): 08386039
--       • DNI duplicado 08386039 (PALOMINO HANCCO CECILIA) → usando 08386039-DUP
-- =============================================================================

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 1: Estado inicial (diagnóstico)
-- ─────────────────────────────────────────────────────────────────────────────
DO $$ BEGIN
  RAISE NOTICE '=================================================';
  RAISE NOTICE 'Migración 00035 — UPSERT Padrón Final';
  RAISE NOTICE 'Fecha ejecución: %', now();
  RAISE NOTICE 'Socios:              %', (SELECT count(*) FROM public.socios WHERE deleted_at IS NULL);
  RAISE NOTICE 'Inquilinos:          %', (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL);
  RAISE NOTICE 'Puestos:             %', (SELECT count(*) FROM public.puestos WHERE deleted_at IS NULL);
  RAISE NOTICE 'Titularidades vigentes: %', (SELECT count(*) FROM public.historial_titularidad WHERE fecha_fin IS NULL);
  RAISE NOTICE 'Arriendos vigentes:     %', (SELECT count(*) FROM public.historial_arriendos WHERE fecha_fin IS NULL);
END; $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 2: Insertar 60 puestos nuevos (SP, EP, Dx + cualquier faltante)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.puestos (codigo_puesto, giro_id, estado, tiene_medidor_luz, tiene_medidor_agua)
VALUES
    ('1-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('1-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('1-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
    ('1-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Segundo Piso
    ('10-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('11-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('2-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('2-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('2-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('2-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
    ('2-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Segundo Piso
    ('3-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('3-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('3-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('3-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('3-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
    ('3-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Segundo Piso
    ('37-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('38-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('39-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('4-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('4-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('4-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('4-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
    ('4-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Segundo Piso
    ('40-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('41-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('42-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('43-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('44-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('45-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('46-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('48-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('5-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('5-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('5-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('5-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
    ('5-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Segundo Piso
    ('50-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('51-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('52', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), 
    ('52-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('53-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('54-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('55-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('56-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('59-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('6-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('6-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('6-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('6-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
    ('6-SP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Segundo Piso
    ('61-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('62-E', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Puesto pequeño
    ('7-D1', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('7-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('7-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('7-EP', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Espacio
    ('8-D2', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false), -- Depósito
    ('8-D3', (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1), 'Activo', false, false) -- Depósito
ON CONFLICT (codigo_puesto) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 3: Actualizar socios existentes (DNI real + normalizar apellidos)
-- ─────────────────────────────────────────────────────────────────────────────
-- Match (por nombre, score=1.00): AGUIRRE QUISPE WILFREDO GILMER
UPDATE public.socios SET
  dni       = '08910771',
  estado    = 'Activo'
WHERE id = 114
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08910771');

-- Match (por nombre, score=0.90): ALARCON ANAMPA BETSY JANET
UPDATE public.socios SET
  dni       = '41500340',
  apellidos = 'ALARCON ANAMPA BETSY JANET',
  estado    = 'Activo'
WHERE id = 57
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41500340');

-- Match (por nombre, score=0.94): ALARCON ANAMPA NANCY GUISELA
UPDATE public.socios SET
  dni       = '10648704',
  apellidos = 'ALARCON ANAMPA NANCY GUISELA',
  estado    = 'Activo'
WHERE id = 53
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10648704');

-- Match (por nombre, score=1.00): ALHUAY PALOMINO DE ALHUAY JUANA
UPDATE public.socios SET
  dni       = '07036952',
  estado    = 'Activo'
WHERE id = 129
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '07036952');

-- Match (por nombre, score=1.00): ALVAREZ CAMPOS ROLANDO
UPDATE public.socios SET
  dni       = '08351184',
  estado    = 'Activo'
WHERE id = 67
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08351184');

-- ⚠️  Match por nombre con confianza MEDIA para: ALVAREZ CAMPOS VICTOR ADRIANO
--     BD actual: "ALVAREZ CAMPOS VICTOR" (id=163, DNI=SOC-163) (por nombre, score=0.83)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.83): ALVAREZ CAMPOS VICTOR ADRIANO
UPDATE public.socios SET
  dni       = '27388264',
  apellidos = 'ALVAREZ CAMPOS VICTOR ADRIANO',
  estado    = 'Activo'
WHERE id = 163
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '27388264');

-- Match (por nombre, score=1.00): ALVAREZ MARIN MARIANELA
UPDATE public.socios SET
  dni       = '45483108',
  estado    = 'Activo'
WHERE id = 120
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '45483108');

-- Match (por nombre, score=1.00): ANAMPA CORAHUA CLEMENCIA MIGDONIA
UPDATE public.socios SET
  dni       = '08408918',
  estado    = 'Activo'
WHERE id = 54
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08408918');

-- Match (por nombre, score=1.00): ANCCO LEON VALENTINA
UPDATE public.socios SET
  dni       = '08389869',
  estado    = 'Activo'
WHERE id = 43
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08389869');

-- Match (por nombre, score=1.00): ATANASIO ORTEGA MAXIMILIANA
UPDATE public.socios SET
  dni       = '08925026',
  estado    = 'Activo'
WHERE id = 146
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08925026');

-- Match (por nombre, score=1.00): AYALA HUASHUAYO NORMA GLADYS
UPDATE public.socios SET
  dni       = '40605904',
  estado    = 'Activo'
WHERE id = 10
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '40605904');

-- ⚠️  Match por nombre con confianza MEDIA para: AYALA TABOADA ELISEO
--     BD actual: "Ayala Toboada Eliseo" (id=9, DNI=SOC-009) (por nombre, score=0.89)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.89): AYALA TABOADA ELISEO
UPDATE public.socios SET
  dni       = '08376344',
  apellidos = 'AYALA TABOADA ELISEO',
  estado    = 'Activo'
WHERE id = 9
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08376344');

-- Match (por nombre, score=1.00): BASTIDAS MEDINA DINA
UPDATE public.socios SET
  dni       = '09411772',
  estado    = 'Activo'
WHERE id = 68
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09411772');

-- Match (por nombre, score=0.94): BASTIDAS MEDINA HERMENEGILDO
UPDATE public.socios SET
  dni       = '09128242',
  apellidos = 'BASTIDAS MEDINA HERMENEGILDO',
  estado    = 'Activo'
WHERE id = 152
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09128242');

-- ⚠️  Match por nombre con confianza MEDIA para: BERNAOLA CARHUAZ DE PRADO FLORENCIA
--     BD actual: "BERNAOLA DE PRADO FLORENCIA" (id=173, DNI=SOC-173) (por nombre, score=0.87)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.87): BERNAOLA CARHUAZ DE PRADO FLORENCIA
UPDATE public.socios SET
  dni       = '08367778',
  apellidos = 'BERNAOLA CARHUAZ DE PRADO FLORENCIA',
  estado    = 'Activo'
WHERE id = 173
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08367778');

-- Match (por nombre, score=1.00): BRAVO HEREDIA ANA MARITZA
UPDATE public.socios SET
  dni       = '08407044',
  estado    = 'Activo'
WHERE id = 58
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08407044');

-- Match (por nombre, score=1.00): BURGA CARRASCO ELIDA
UPDATE public.socios SET
  dni       = '42735431',
  estado    = 'Activo'
WHERE id = 13
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42735431');

-- Match (por nombre, score=1.00): CABALLERO CALZADO GLADYS VICTORIA
UPDATE public.socios SET
  dni       = '08385382',
  estado    = 'Activo'
WHERE id = 116
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08385382');

-- ⚠️  Match por nombre con confianza MEDIA para: CABERO MENDOZA GLORIA LUCINDA
--     BD actual: "Cabero Mendoza Gloria" (id=34, DNI=SOC-034) (por nombre, score=0.87)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.87): CABERO MENDOZA GLORIA LUCINDA
UPDATE public.socios SET
  dni       = '10746685',
  apellidos = 'CABERO MENDOZA GLORIA LUCINDA',
  estado    = 'Activo'
WHERE id = 34
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10746685');

-- Match (por nombre, score=1.00): CAHUANA VDA DE DAVILA VICENTINA
UPDATE public.socios SET
  dni       = '08408319',
  estado    = 'Activo'
WHERE id = 132
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08408319');

-- Match (por nombre, score=1.00): CAJALEON CARRASCO LUIS ENRIQUE
UPDATE public.socios SET
  dni       = '42591926',
  estado    = 'Activo'
WHERE id = 70
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42591926');

-- ⚠️  Match por nombre con confianza MEDIA para: CALDERON TORRES BERTHA ESTELA
--     BD actual: "Estela Calderon Torres" (id=52, DNI=SOC-052) (por nombre, score=0.83)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.83): CALDERON TORRES BERTHA ESTELA
UPDATE public.socios SET
  dni       = '42194583',
  apellidos = 'CALDERON TORRES BERTHA ESTELA',
  estado    = 'Activo'
WHERE id = 52
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42194583');

-- Match (por nombre, score=1.00): CALDERON VERA SEGUNDO ALCIDES
UPDATE public.socios SET
  dni       = '08377848',
  estado    = 'Activo'
WHERE id = 109
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08377848');

-- ⚠️  Match por nombre con confianza MEDIA para: CALLE ALVAREZ MARCO ANTONIO
--     BD actual: "CALLE ALVAREZ MARCO" (id=149, DNI=SOC-149) (por nombre, score=0.82)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.82): CALLE ALVAREZ MARCO ANTONIO
UPDATE public.socios SET
  dni       = '44426461',
  apellidos = 'CALLE ALVAREZ MARCO ANTONIO',
  estado    = 'Activo'
WHERE id = 149
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '44426461');

-- Match (por nombre, score=1.00): CALLE CALLE FIDEL
UPDATE public.socios SET
  dni       = '08352573',
  estado    = 'Activo'
WHERE id = 50
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08352573');

-- Match (por nombre, score=1.00): CAMPUZANO CABELLO VICENTA DONATILA
UPDATE public.socios SET
  dni       = '08365775',
  estado    = 'Activo'
WHERE id = 179
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08365775');

-- Match (por nombre, score=1.00): CARDENA VILLAFUERTE ALEJANDRINA
UPDATE public.socios SET
  dni       = '08352205',
  estado    = 'Activo'
WHERE id = 11
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08352205');

-- Match (por nombre, score=1.00): CARPIO VASQUEZ TEOFILA
UPDATE public.socios SET
  dni       = '10483507',
  estado    = 'Activo'
WHERE id = 110
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10483507');

-- Match (por nombre, score=1.00): CARRASCO SALVATIERRA FELICITA
UPDATE public.socios SET
  dni       = '08408186',
  apellidos = 'CARRASCO SALVATIERRA FELICITA',
  estado    = 'Activo'
WHERE id = 69
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08408186');

-- Match (por nombre, score=0.95): CARTAGENA MAMANI BENJAMIN D
UPDATE public.socios SET
  dni       = '08378575',
  apellidos = 'CARTAGENA MAMANI BENJAMIN D',
  estado    = 'Activo'
WHERE id = 78
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08378575');

-- Match (por nombre, score=1.00): CARTAGENA PALOMINO ALVARO BENJAMIN
UPDATE public.socios SET
  dni       = '10644600',
  estado    = 'Activo'
WHERE id = 138
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10644600');

-- Match (por nombre, score=1.00): CASTRO ALEJANDRO HORTENCIA LUCILA
UPDATE public.socios SET
  dni       = '09264887',
  estado    = 'Activo'
WHERE id = 119
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09264887');

-- Match (por nombre, score=1.00): CASTRO GUTIERREZ AQUILA LUCRECIA
UPDATE public.socios SET
  dni       = '08410781',
  estado    = 'Activo'
WHERE id = 16
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08410781');

-- Match (por nombre, score=1.00): CCOYLLO BUSTILLOS DEYSI KAREN
UPDATE public.socios SET
  dni       = '47825713',
  estado    = 'Activo'
WHERE id = 15
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '47825713');

-- Match (por nombre, score=1.00): CCOYLLO CHINCHAY DANIEL MASIA
UPDATE public.socios SET
  dni       = '10129111',
  estado    = 'Activo'
WHERE id = 56
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10129111');

-- ⚠️  Match por nombre con confianza MEDIA para: CCOYLLO CHINCHAY JUDITH NATY
--     BD actual: "Ccoyllo Chinchay Judith" (id=49, DNI=SOC-049) (por nombre, score=0.89)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.89): CCOYLLO CHINCHAY JUDITH NATY
UPDATE public.socios SET
  dni       = '10549481',
  apellidos = 'CCOYLLO CHINCHAY JUDITH NATY',
  estado    = 'Activo'
WHERE id = 49
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10549481');

-- Match (por nombre, score=1.00): CCOYLLO MAYHUASCA ALEXIS
UPDATE public.socios SET
  dni       = '75274713',
  estado    = 'Activo'
WHERE id = 99
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '75274713');

-- Match (por nombre, score=1.00): CCOYLLO POLANCO DANIEL
UPDATE public.socios SET
  dni       = '08964390',
  estado    = 'Activo'
WHERE id = 98
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08964390');

-- Match (por nombre, score=1.00): CCOYLLO POLANCO GERMAN
UPDATE public.socios SET
  dni       = '08237117',
  estado    = 'Activo'
WHERE id = 44
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08237117');

-- Match (por nombre, score=1.00): CERDA YUPANQUI CARMEN ROSA
UPDATE public.socios SET
  dni       = '09124337',
  estado    = 'Activo'
WHERE id = 159
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09124337');

-- Match (por nombre, score=0.91): CHALLCO CRUZ DE PALOMINO NICOLAZA
UPDATE public.socios SET
  dni       = '08980503',
  apellidos = 'CHALLCO CRUZ DE PALOMINO NICOLAZA',
  estado    = 'Activo'
WHERE id = 85
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08980503');

-- ⚠️  Match por nombre con confianza MEDIA para: CHIRINOS CABRACANCHA MARIA LOURDES
--     BD actual: "Chirinos Cabracancha María" (id=71, DNI=SOC-071) (por nombre, score=0.86)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.86): CHIRINOS CABRACANCHA MARIA LOURDES
UPDATE public.socios SET
  dni       = '08954535',
  apellidos = 'CHIRINOS CABRACANCHA MARIA LOURDES',
  estado    = 'Activo'
WHERE id = 71
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08954535');

-- Match (por nombre, score=1.00): CHOQUEHUAMANI FELIX CEFERINO
UPDATE public.socios SET
  dni       = '08998291',
  estado    = 'Activo'
WHERE id = 102
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08998291');

-- Match (por nombre, score=1.00): CLEMENTE ALLER CIRILA
UPDATE public.socios SET
  dni       = '09133532',
  estado    = 'Activo'
WHERE id = 25
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09133532');

-- Match (por nombre, score=1.00): CORDOVA PEREZ MARCO ANTONIO
UPDATE public.socios SET
  dni       = '10084032',
  estado    = 'Activo'
WHERE id = 117
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10084032');

-- Match (por nombre, score=1.00): CORNEJO DONATO DE CORDOVA ESTELA PILAR
UPDATE public.socios SET
  dni       = '10525929',
  estado    = 'Activo'
WHERE id = 169
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10525929');

-- Match (por nombre, score=1.00): CRUZ JARAMILLO LUIS
UPDATE public.socios SET
  dni       = '09126040',
  estado    = 'Activo'
WHERE id = 108
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09126040');

-- ⚠️  Match por nombre con confianza MEDIA para: CUCHO DE LA CRUZ SAUL PEDRO
--     BD actual: "CUCHO DE LA CRUZ SAUL" (id=165, DNI=SOC-165) (por nombre, score=0.87)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.87): CUCHO DE LA CRUZ SAUL PEDRO
UPDATE public.socios SET
  dni       = '08412232',
  apellidos = 'CUCHO DE LA CRUZ SAUL PEDRO',
  estado    = 'Activo'
WHERE id = 165
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08412232');

-- Match (por nombre, score=1.00): CUEVAS MAYO ENRIQUE
UPDATE public.socios SET
  dni       = '08376979',
  estado    = 'Activo'
WHERE id = 65
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08376979');

-- Match (por nombre, score=1.00): CULE CARRASCO HAYDEE MONICA
UPDATE public.socios SET
  dni       = '41204316',
  estado    = 'Activo'
WHERE id = 87
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41204316');

-- Match (por nombre, score=1.00): CUSI LAURA SONIA
UPDATE public.socios SET
  dni       = '10487155',
  estado    = 'Activo'
WHERE id = 167
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10487155');

-- Match (por nombre, score=1.00): CUYA SANCHEZ ALBERTO
UPDATE public.socios SET
  dni       = '41110013',
  estado    = 'Activo'
WHERE id = 14
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41110013');

-- ⚠️  Match por nombre con confianza MEDIA para: DAVILA CAHUANA DE PAZ MARISOL
--     BD actual: "Davila Cahuana Marisol" (id=51, DNI=SOC-051) (por nombre, score=0.85)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.85): DAVILA CAHUANA DE PAZ MARISOL
UPDATE public.socios SET
  dni       = '10022005',
  apellidos = 'DAVILA CAHUANA DE PAZ MARISOL',
  estado    = 'Activo'
WHERE id = 51
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10022005');

-- Match (por nombre, score=0.94): DE LA CRUZ ESTEBAN JOSE LUIS
UPDATE public.socios SET
  dni       = '08409231',
  apellidos = 'DE LA CRUZ ESTEBAN JOSE LUIS',
  estado    = 'Activo'
WHERE id = 170
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08409231');

-- Match (por nombre, score=1.00): ESPEJO URBANO ROSA FLORENCIA
UPDATE public.socios SET
  dni       = '09723857',
  estado    = 'Activo'
WHERE id = 32
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09723857');

-- Match (por nombre, score=1.00): ESTELA SUAREZ ELVIA
UPDATE public.socios SET
  dni       = '10654208',
  estado    = 'Activo'
WHERE id = 122
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10654208');

-- Match (por nombre, score=1.00): FALCON CHIARA HECTOR MARCIAL
UPDATE public.socios SET
  dni       = '08352447',
  estado    = 'Activo'
WHERE id = 12
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08352447');

-- Match (por nombre, score=1.00): FLORES FLORES IRENE BERTILIA
UPDATE public.socios SET
  dni       = '08363681',
  estado    = 'Activo'
WHERE id = 182
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08363681');

-- Match (por nombre, score=1.00): FLORES FLORES UMBELINA DORA
UPDATE public.socios SET
  dni       = '08362728',
  estado    = 'Activo'
WHERE id = 92
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08362728');

-- Match (por nombre, score=1.00): FLORES YATO FRANCISCA DOLORES
UPDATE public.socios SET
  dni       = '10347533',
  estado    = 'Activo'
WHERE id = 22
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10347533');

-- Match (por nombre, score=0.93): GAVILAN MOSQUERA NORMA LUZ
UPDATE public.socios SET
  dni       = '08408138',
  apellidos = 'GAVILAN MOSQUERA NORMA LUZ',
  estado    = 'Activo'
WHERE id = 136
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08408138');

-- Match (por nombre, score=0.90): GELDRES REVILLA MIGUEL ANGEL
UPDATE public.socios SET
  dni       = '08395960',
  apellidos = 'GELDRES REVILLA MIGUEL ANGEL',
  estado    = 'Activo'
WHERE id = 103
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08395960');

-- ⚠️  Match por nombre con confianza MEDIA para: GUTIERREZ CASTILLO JORGE JAIME
--     BD actual: "GUTIERREZ CASTILLO  JORGE" (id=101, DNI=SOC-101) (por nombre, score=0.90)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.90): GUTIERREZ CASTILLO JORGE JAIME
UPDATE public.socios SET
  dni       = '10541347',
  apellidos = 'GUTIERREZ CASTILLO JORGE JAIME',
  estado    = 'Activo'
WHERE id = 101
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10541347');

-- Match (por nombre, score=1.00): GUTIERREZ CASTILLO TERESA JESUS
UPDATE public.socios SET
  dni       = '20101992',
  estado    = 'Activo'
WHERE id = 174
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '20101992');

-- ⚠️  Match por nombre con confianza MEDIA para: GUTIERREZ CASTRO JORGE RICARDO
--     BD actual: "GUTIERREZ CASTRO JORGE" (id=128, DNI=SOC-128) (por nombre, score=0.86)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.86): GUTIERREZ CASTRO JORGE RICARDO
UPDATE public.socios SET
  dni       = '70065666',
  apellidos = 'GUTIERREZ CASTRO JORGE RICARDO',
  estado    = 'Activo'
WHERE id = 128
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '70065666');

-- Match (por nombre, score=0.92): GUTIERREZ FLORES ROGER REYNAN
UPDATE public.socios SET
  dni       = '41842805',
  apellidos = 'GUTIERREZ FLORES ROGER REYNAN',
  estado    = 'Activo'
WHERE id = 36
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41842805');

-- ⚠️  Match por nombre con confianza MEDIA para: HALIRE YUCRA JOSUE JAASIEL
--     BD actual: "HALIRE YUCRA JOSUE" (id=178, DNI=SOC-178) (por nombre, score=0.85)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.85): HALIRE YUCRA JOSUE JAASIEL
UPDATE public.socios SET
  dni       = '46805327',
  apellidos = 'HALIRE YUCRA JOSUE JAASIEL',
  estado    = 'Activo'
WHERE id = 178
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '46805327');

-- Match (por nombre, score=1.00): HEREDIA MUNOZ DE BRAVO MARIA
UPDATE public.socios SET
  dni       = '08406481',
  estado    = 'Activo'
WHERE id = 162
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08406481');

-- Match (por nombre, score=1.00): HUAMAN YNCA VISITACION
UPDATE public.socios SET
  dni       = '08398541',
  estado    = 'Activo'
WHERE id = 75
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08398541');

-- Match (por nombre, score=1.00): HUASHUAYO GOMEZ EUDOSIA
UPDATE public.socios SET
  dni       = '08376324',
  estado    = 'Activo'
WHERE id = 8
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08376324');

-- Match (por nombre, score=1.00): HUAYHUALLA DE LOPEZ DONATILA
UPDATE public.socios SET
  dni       = '08378045',
  estado    = 'Activo'
WHERE id = 72
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08378045');

-- Match (por nombre, score=1.00): ISIDRO MARIN CARLOS DANIEL
UPDATE public.socios SET
  dni       = '40535559',
  estado    = 'Activo'
WHERE id = 139
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '40535559');

-- Match (por nombre, score=1.00): JARA ALVARES CRISTALINA
UPDATE public.socios SET
  dni       = '09784085',
  estado    = 'Activo'
WHERE id = 107
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09784085');

-- Match (por nombre, score=1.00): JARA ALVAREZ MARIA CENAIDA
UPDATE public.socios SET
  dni       = '09578792',
  estado    = 'Activo'
WHERE id = 45
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09578792');

-- ⚠️  Match por nombre con confianza MEDIA para: JARA ALVAREZ SANTOS PEDRO
--     BD actual: "JARA ALVAREZ SANTOS" (id=157, DNI=SOC-157) (por nombre, score=0.85)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.85): JARA ALVAREZ SANTOS PEDRO
UPDATE public.socios SET
  dni       = '40992336',
  apellidos = 'JARA ALVAREZ SANTOS PEDRO',
  estado    = 'Activo'
WHERE id = 157
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '40992336');

-- Match (por nombre, score=1.00): JUAREZ CUELLAR LEONOR
UPDATE public.socios SET
  dni       = '08409075',
  estado    = 'Activo'
WHERE id = 42
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08409075');

-- ⚠️  Match por nombre con confianza MEDIA para: LAGOS LUNA DE LEYVA ZAIDA LUISA
--     BD actual: "Lagos Luna de Leiva Zaida" (id=23, DNI=SOC-023) (por nombre, score=0.85)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.85): LAGOS LUNA DE LEYVA ZAIDA LUISA
UPDATE public.socios SET
  dni       = '08350259',
  apellidos = 'LAGOS LUNA DE LEYVA ZAIDA LUISA',
  estado    = 'Activo'
WHERE id = 23
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08350259');

-- Match (por nombre, score=1.00): LIMAS VARGAS CARMEN ROSA
UPDATE public.socios SET
  dni       = '08362967',
  estado    = 'Activo'
WHERE id = 2
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08362967');

-- Match (por nombre, score=1.00): LOPEZ HUAYHUALLA NELLY NATIVIDAD
UPDATE public.socios SET
  dni       = '09584057',
  estado    = 'Activo'
WHERE id = 131
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09584057');

-- Match (por nombre, score=1.00): LUJAN GONZALES MARINO JUAN
UPDATE public.socios SET
  dni       = '09358600',
  estado    = 'Activo'
WHERE id = 164
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09358600');

-- Match (por nombre, score=1.00): MALLQUI JULCA ALEJANDRINO TEODORO
UPDATE public.socios SET
  dni       = '06273475',
  estado    = 'Activo'
WHERE id = 100
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '06273475');

-- Match (por nombre, score=0.92): MARIN HUAMAN DE SALAMANCA MARIA YNES
UPDATE public.socios SET
  dni       = '08372971',
  apellidos = 'MARIN HUAMAN DE SALAMANCA MARIA YNES',
  estado    = 'Activo'
WHERE id = 29
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08372971');

-- Match (por nombre, score=1.00): MARIN LONDONE EDUARDO SANTIAGO
UPDATE public.socios SET
  dni       = '08409874',
  estado    = 'Activo'
WHERE id = 185
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08409874');

-- Match (por nombre, score=1.00): MARIN LONDONE MARIA LUZ
UPDATE public.socios SET
  dni       = '08378611',
  estado    = 'Activo'
WHERE id = 137
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08378611');

-- ⚠️  Match por nombre con confianza MEDIA para: MARIN ROCHA ESTEFANY JULISSA
--     BD actual: "MARIN ROCHA ESTEFANY" (id=180, DNI=SOC-180) (por nombre, score=0.83)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.83): MARIN ROCHA ESTEFANY JULISSA
UPDATE public.socios SET
  dni       = '70543675',
  apellidos = 'MARIN ROCHA ESTEFANY JULISSA',
  estado    = 'Activo'
WHERE id = 180
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '70543675');

-- Match (por nombre, score=1.00): MAYHUASCA BASTIDAS MARILU
UPDATE public.socios SET
  dni       = '09412367',
  estado    = 'Activo'
WHERE id = 93
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09412367');

-- Match (por nombre, score=1.00): MAYHUASCA BASTIDAS ULISES
UPDATE public.socios SET
  dni       = '08378555',
  estado    = 'Activo'
WHERE id = 77
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08378555');

-- Match (por nombre, score=1.00): MAYTA COLQUI VIOLETA
UPDATE public.socios SET
  dni       = '08933567',
  estado    = 'Activo'
WHERE id = 127
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08933567');

-- Match (por nombre, score=0.95): MAYTA MATOS HERMELINDA
UPDATE public.socios SET
  dni       = '10240212',
  apellidos = 'MAYTA MATOS HERMELINDA',
  estado    = 'Activo'
WHERE id = 154
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10240212');

-- ⚠️  Match por nombre con confianza MEDIA para: MEDINA GUTIERREZ HONORATA
--     BD actual: "MEDINA GUITIERRES HONORATA" (id=166, DNI=SOC-166) (por nombre, score=0.86)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.86): MEDINA GUTIERREZ HONORATA
UPDATE public.socios SET
  dni       = '46888218',
  apellidos = 'MEDINA GUTIERREZ HONORATA',
  estado    = 'Activo'
WHERE id = 166
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '46888218');

-- Match (por nombre, score=1.00): MEDINA MEDRANO JUAN CARLOS
UPDATE public.socios SET
  dni       = '09411020',
  estado    = 'Activo'
WHERE id = 96
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09411020');

-- Match (por nombre, score=1.00): MELO BACA MARINA
UPDATE public.socios SET
  dni       = '23925250',
  estado    = 'Activo'
WHERE id = 141
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '23925250');

-- Match (por nombre, score=1.00): MESIA CRUZ GLADYS
UPDATE public.socios SET
  dni       = '08981021',
  estado    = 'Activo'
WHERE id = 123
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08981021');

-- Match (por nombre, score=1.00): MORENO CHAVEZ RAFAEL FREDY
UPDATE public.socios SET
  dni       = '08936174',
  estado    = 'Activo'
WHERE id = 156
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08936174');

-- Match (por nombre, score=1.00): NICHO LOPEZ ESTHEPANY CARICIA
UPDATE public.socios SET
  dni       = '42786348',
  estado    = 'Activo'
WHERE id = 106
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42786348');

-- Match (por nombre, score=1.00): NAHUI RUIZ AURELIO
UPDATE public.socios SET
  dni       = '06148853',
  estado    = 'Activo'
WHERE id = 55
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '06148853');

-- ⚠️  Match por nombre con confianza MEDIA para: OJEDA CAMPOS EDSON JUNIOR
--     BD actual: "OJEDA CAMPOS EDSON" (id=134, DNI=SOC-134) (por nombre, score=0.82)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.82): OJEDA CAMPOS EDSON JUNIOR
UPDATE public.socios SET
  dni       = '47920093',
  apellidos = 'OJEDA CAMPOS EDSON JUNIOR',
  estado    = 'Activo'
WHERE id = 134
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '47920093');

-- Match (por nombre, score=1.00): OQUENDO ARISACA MELESIA ROSARIO
UPDATE public.socios SET
  dni       = '08389482',
  estado    = 'Activo'
WHERE id = 115
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08389482');

-- Match (por nombre, score=1.00): OQUENDO QUISPE JESSICA
UPDATE public.socios SET
  dni       = '40389776',
  estado    = 'Activo'
WHERE id = 147
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '40389776');

-- Match (por nombre, score=1.00): ORDONEZ NICHO AZUL CARILE
UPDATE public.socios SET
  dni       = '60992919',
  estado    = 'Activo'
WHERE id = 130
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '60992919');

-- Match (por nombre, score=1.00): ORTIZ NAUPA WELINTONH
UPDATE public.socios SET
  dni       = '43176165',
  estado    = 'Activo'
WHERE id = 94
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '43176165');

-- Match (por nombre, score=1.00): PACOMPIA CARDENA GIOVANNI
UPDATE public.socios SET
  dni       = '08386039',
  estado    = 'Activo'
WHERE id = 27
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08386039');

-- Match (por nombre, score=1.00): PALOMINO HANCCO CECILIA
UPDATE public.socios SET
  dni       = '08386039-DUP',
  estado    = 'Activo'
WHERE id = 80
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08386039-DUP');

-- Match (por nombre, score=1.00): PALOMINO TENORIO SILVIO EDUARDO
UPDATE public.socios SET
  dni       = '10481354',
  estado    = 'Activo'
WHERE id = 86
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10481354');

-- Match (por nombre, score=1.00): PALOMINO VELASQUEZ EUSEBIO
UPDATE public.socios SET
  dni       = '08353538',
  estado    = 'Activo'
WHERE id = 126
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08353538');

-- ⚠️  Match por nombre con confianza MEDIA para: PAREDES FLORES OSCAR ALFREDO
--     BD actual: "Paredes Flores Oscar" (id=47, DNI=SOC-047) (por nombre, score=0.83)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.83): PAREDES FLORES OSCAR ALFREDO
UPDATE public.socios SET
  dni       = '08411083',
  apellidos = 'PAREDES FLORES OSCAR ALFREDO',
  estado    = 'Activo'
WHERE id = 47
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08411083');

-- Match (por nombre, score=1.00): PAREDES MORALES OSCAR MARTIN
UPDATE public.socios SET
  dni       = '43807858',
  estado    = 'Activo'
WHERE id = 26
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '43807858');

-- ⚠️  Match por nombre con confianza MEDIA para: PEREZ PONCE DE ROMERO SATURNINA MARGARITA
--     BD actual: "PEREZ PONCE SATURNINA MARGARITA" (id=79, DNI=SOC-079) (por nombre, score=0.89)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.89): PEREZ PONCE DE ROMERO SATURNINA MARGARITA
UPDATE public.socios SET
  dni       = '08835096',
  apellidos = 'PEREZ PONCE DE ROMERO SATURNINA MARGARITA',
  estado    = 'Activo'
WHERE id = 79
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08835096');

-- Match (por nombre, score=1.00): PITTMAN CONCEPCION NELLY MARIA
UPDATE public.socios SET
  dni       = '09407193',
  estado    = 'Activo'
WHERE id = 30
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09407193');

-- Match (por nombre, score=1.00): PLAZA COSQUILLO ROSA ESTELA
UPDATE public.socios SET
  dni       = '08408595',
  estado    = 'Activo'
WHERE id = 82
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08408595');

-- ⚠️  Match por nombre con confianza MEDIA para: PORRAS URCURANGA DE OROYA OLIMPIA
--     BD actual: "PORRAS DE OROYA OLIMPIA" (id=151, DNI=SOC-151) (por nombre, score=0.85)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.85): PORRAS URCURANGA DE OROYA OLIMPIA
UPDATE public.socios SET
  dni       = '08792796',
  apellidos = 'PORRAS URCURANGA DE OROYA OLIMPIA',
  estado    = 'Activo'
WHERE id = 151
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08792796');

-- Match (por nombre, score=0.90): PRADO LLANCARI ZOSIMA
UPDATE public.socios SET
  dni       = '08382726',
  apellidos = 'PRADO LLANCARI ZOSIMA',
  estado    = 'Activo'
WHERE id = 39
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08382726');

-- Match (por nombre, score=1.00): QUINTANA VIDAL GLICERIO
UPDATE public.socios SET
  dni       = '09126820',
  estado    = 'Activo'
WHERE id = 153
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09126820');

-- Match (por nombre, score=1.00): QUISPE CONSA MIGUEL
UPDATE public.socios SET
  dni       = '10651107',
  estado    = 'Activo'
WHERE id = 83
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10651107');

-- Match (por nombre, score=1.00): QUISPE CONSA VIDAL
UPDATE public.socios SET
  dni       = '10525118',
  estado    = 'Activo'
WHERE id = 121
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10525118');

-- Match (por nombre, score=1.00): QUISPE COPAYO ELIO CARLOS
UPDATE public.socios SET
  dni       = '09587366',
  estado    = 'Activo'
WHERE id = 73
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09587366');

-- ⚠️  Match por nombre con confianza MEDIA para: QUISPE AGUILAR DE PALOMINO DOROTEA
--     BD actual: "QUISPE DE PALOMINO DOROTEA" (id=125, DNI=SOC-125) (por nombre, score=0.87)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.87): QUISPE AGUILAR DE PALOMINO DOROTEA
UPDATE public.socios SET
  dni       = '08377638',
  apellidos = 'QUISPE AGUILAR DE PALOMINO DOROTEA',
  estado    = 'Activo'
WHERE id = 125
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08377638');

-- Match (por nombre, score=1.00): QUISPE DURAN ADRIANA
UPDATE public.socios SET
  dni       = '23997014',
  estado    = 'Activo'
WHERE id = 144
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '23997014');

-- Match (por nombre, score=1.00): QUISPE ORTEGA ROSA CARMEN
UPDATE public.socios SET
  dni       = '06218890',
  estado    = 'Activo'
WHERE id = 184
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '06218890');

-- Match (por nombre, score=1.00): QUISPE URIBE LUCIANO
UPDATE public.socios SET
  dni       = '08350919',
  estado    = 'Activo'
WHERE id = 28
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08350919');

-- ⚠️  Match por nombre con confianza MEDIA para: RAMOS CUEVA PEDRO RAUL
--     BD actual: "RAMOS CUEVA PEDRO" (id=142, DNI=SOC-142) (por nombre, score=0.89)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.89): RAMOS CUEVA PEDRO RAUL
UPDATE public.socios SET
  dni       = '08369637',
  apellidos = 'RAMOS CUEVA PEDRO RAUL',
  estado    = 'Activo'
WHERE id = 142
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08369637');

-- ⚠️  Match por nombre con confianza MEDIA para: REYES PEREZ DE VALENCIA NANCY VICTORIA
--     BD actual: "REYES PEREZ DE VALENCIA NANCY" (id=181, DNI=SOC-181) (por nombre, score=0.88)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.88): REYES PEREZ DE VALENCIA NANCY VICTORIA
UPDATE public.socios SET
  dni       = '07413425',
  apellidos = 'REYES PEREZ DE VALENCIA NANCY VICTORIA',
  estado    = 'Activo'
WHERE id = 181
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '07413425');

-- Match (por nombre, score=1.00): REYES SANCHEZ MILENA GERALDINE
UPDATE public.socios SET
  dni       = '41051072',
  estado    = 'Activo'
WHERE id = 135
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41051072');

-- Match (por nombre, score=0.90): RICSE SAYES TERESA REINA
UPDATE public.socios SET
  dni       = '08852885',
  apellidos = 'RICSE SAYES TERESA REINA',
  estado    = 'Activo'
WHERE id = 97
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08852885');

-- Match (por nombre, score=1.00): RIVERA CALLPA JUANA REGIS
UPDATE public.socios SET
  dni       = '08408688',
  estado    = 'Activo'
WHERE id = 63
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08408688');

-- Match (por nombre, score=1.00): RIVERA FERNANDEZ MARINA MAXILIANA
UPDATE public.socios SET
  dni       = '09126077',
  estado    = 'Activo'
WHERE id = 91
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09126077');

-- Match (por nombre, score=1.00): RODRIGUEZ ARQUINEGO IDILIO FELIX
UPDATE public.socios SET
  dni       = '08353826',
  estado    = 'Activo'
WHERE id = 46
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08353826');

-- Match (por nombre, score=1.00): RODRIGUEZ CORDOVA MARCOS
UPDATE public.socios SET
  dni       = '43806897',
  estado    = 'Activo'
WHERE id = 74
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '43806897');

-- Match (por nombre, score=1.00): RODRIGUEZ MORENO NORA
UPDATE public.socios SET
  dni       = '09257901',
  estado    = 'Activo'
WHERE id = 145
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09257901');

-- Match (por nombre, score=0.90): ROJAS CORNEJO ERICK JOHN
UPDATE public.socios SET
  dni       = '10526901',
  apellidos = 'ROJAS CORNEJO ERICK JOHN',
  estado    = 'Activo'
WHERE id = 172
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10526901');

-- Match (por nombre, score=1.00): ROMERO FLORES EDDNA
UPDATE public.socios SET
  dni       = '09687425',
  estado    = 'Activo'
WHERE id = 168
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09687425');

-- ⚠️  Match por nombre con confianza MEDIA para: ROMERO NINAHUAMAN JAVIER JOHNNY
--     BD actual: "Romero Ninahuaman Javier" (id=3, DNI=SOC-003) (por nombre, score=0.88)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.88): ROMERO NINAHUAMAN JAVIER JOHNNY
UPDATE public.socios SET
  dni       = '09258771',
  apellidos = 'ROMERO NINAHUAMAN JAVIER JOHNNY',
  estado    = 'Activo'
WHERE id = 3
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09258771');

-- Match (por nombre, score=1.00): ROMERO YSLA ESTEBAN LIDIO
UPDATE public.socios SET
  dni       = '08897525',
  estado    = 'Activo'
WHERE id = 148
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08897525');

-- Match (por nombre, score=1.00): SAAVEDRA CURIPUMA LUIS HUMBERTO
UPDATE public.socios SET
  dni       = '10650355',
  estado    = 'Activo'
WHERE id = 40
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10650355');

-- Match (por nombre, score=0.96): SALAS MONTALVO JUDITH MAGALI
UPDATE public.socios SET
  dni       = '10642544',
  apellidos = 'SALAS MONTALVO JUDITH MAGALI',
  estado    = 'Activo'
WHERE id = 35
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10642544');

-- Match (por nombre, score=1.00): SALAZAR CONCEPCION VICTORIA
UPDATE public.socios SET
  dni       = '08386136',
  estado    = 'Activo'
WHERE id = 171
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08386136');

-- Match (por nombre, score=0.94): SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA
UPDATE public.socios SET
  dni       = '08353253',
  apellidos = 'SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA',
  estado    = 'Activo'
WHERE id = 33
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08353253');

-- Match (por nombre, score=0.91): SANCHEZ RODRIGUEZ JUDITH IRIS
UPDATE public.socios SET
  dni       = '41018085',
  apellidos = 'SANCHEZ RODRIGUEZ JUDITH IRIS',
  estado    = 'Activo'
WHERE id = 175
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41018085');

-- ⚠️  Match por nombre con confianza MEDIA para: SANCHEZ SOTO LUCIA YRENE
--     BD actual: "Sanchez Soto Lucia" (id=59, DNI=SOC-059) (por nombre, score=0.85)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.85): SANCHEZ SOTO LUCIA YRENE
UPDATE public.socios SET
  dni       = '15374505',
  apellidos = 'SANCHEZ SOTO LUCIA YRENE',
  estado    = 'Activo'
WHERE id = 59
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '15374505');

-- ⚠️  Match por nombre con confianza MEDIA para: SANTILLAN MESIA ZOILA MARIBEL
--     BD actual: "SANTILLAN MESIA ZOILA" (id=160, DNI=SOC-160) (por nombre, score=0.85)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.85): SANTILLAN MESIA ZOILA MARIBEL
UPDATE public.socios SET
  dni       = '40621354',
  apellidos = 'SANTILLAN MESIA ZOILA MARIBEL',
  estado    = 'Activo'
WHERE id = 160
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '40621354');

-- ⚠️  Match por nombre con confianza MEDIA para: SEGOVIA VILLAFUERTE DE PONCE JUSTINA
--     BD actual: "Segovia Villafuerte de Ponce" (id=31, DNI=SOC-031) (por nombre, score=0.88)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.88): SEGOVIA VILLAFUERTE DE PONCE JUSTINA
UPDATE public.socios SET
  dni       = '10019381',
  apellidos = 'SEGOVIA VILLAFUERTE DE PONCE JUSTINA',
  estado    = 'Activo'
WHERE id = 31
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10019381');

-- Match (por nombre, score=1.00): SORIA TAPIA EDITH CATALINA
UPDATE public.socios SET
  dni       = '08408970',
  estado    = 'Activo'
WHERE id = 62
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08408970');

-- Match (por nombre, score=1.00): SOSA VALDIVIA JUANA ISABEL
UPDATE public.socios SET
  dni       = '06007412',
  estado    = 'Activo'
WHERE id = 4
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '06007412');

-- Match (por nombre, score=0.90): SOTO GALLEGO DE VALERO SOFIA
UPDATE public.socios SET
  dni       = '08393305',
  apellidos = 'SOTO GALLEGO DE VALERO SOFIA',
  estado    = 'Activo'
WHERE id = 176
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08393305');

-- Match (por nombre, score=1.00): SOTO VARGAS DE FLORES MARIA DEL CARMEN
UPDATE public.socios SET
  dni       = '09126963',
  estado    = 'Activo'
WHERE id = 158
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09126963');

-- Match (por nombre, score=0.91): TAIPE OQUENDO EUGENIO JOEL
UPDATE public.socios SET
  dni       = '44267980',
  apellidos = 'TAIPE OQUENDO EUGENIO JOEL',
  estado    = 'Activo'
WHERE id = 24
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '44267980');

-- Match (por nombre, score=1.00): TELLO ALVAREZ MARINO
UPDATE public.socios SET
  dni       = '08928757',
  estado    = 'Activo'
WHERE id = 41
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08928757');

-- ⚠️  Match por nombre con confianza MEDIA para: TELLO QUINTANA EDGAR ERASMO
--     BD actual: "TELLO QUINTANA EDGAR" (id=177, DNI=SOC-177) (por nombre, score=0.86)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.86): TELLO QUINTANA EDGAR ERASMO
UPDATE public.socios SET
  dni       = '09694862',
  apellidos = 'TELLO QUINTANA EDGAR ERASMO',
  estado    = 'Activo'
WHERE id = 177
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09694862');

-- Match (por nombre, score=1.00): TINEO CABRERA SONIA
UPDATE public.socios SET
  dni       = '80652233',
  estado    = 'Activo'
WHERE id = 84
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '80652233');

-- Match (por nombre, score=1.00): TITO FALCON JESUSA RICARDINA
UPDATE public.socios SET
  dni       = '09005157',
  estado    = 'Activo'
WHERE id = 140
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09005157');

-- Match (por nombre, score=0.95): TORRES ANYOSA MARCELINO
UPDATE public.socios SET
  dni       = '10487484',
  apellidos = 'TORRES ANYOSA MARCELINO',
  estado    = 'Activo'
WHERE id = 64
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10487484');

-- ⚠️  Match por nombre con confianza MEDIA para: TORRES ASTO FRANCISCO CONTESOR
--     BD actual: "TORRES ASTO FRANCISCO" (id=76, DNI=SOC-076) (por nombre, score=0.88)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.88): TORRES ASTO FRANCISCO CONTESOR
UPDATE public.socios SET
  dni       = '08362958',
  apellidos = 'TORRES ASTO FRANCISCO CONTESOR',
  estado    = 'Activo'
WHERE id = 76
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08362958');

-- ⚠️  Match por nombre con confianza MEDIA para: TORRES ASTO SANTOS NERY F
--     BD actual: "TORRES ASTO NERY (F)" (id=90, DNI=SOC-090) (por nombre, score=0.86)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.86): TORRES ASTO SANTOS NERY F
UPDATE public.socios SET
  dni       = '10488601',
  apellidos = 'TORRES ASTO SANTOS NERY F',
  estado    = 'Activo'
WHERE id = 90
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10488601');

-- Match (por nombre, score=0.94): TORRES ASTO VDA DE CALDERON JUANA FRONILDA
UPDATE public.socios SET
  dni       = '08409067',
  apellidos = 'TORRES ASTO VDA DE CALDERON JUANA FRONILDA',
  estado    = 'Activo'
WHERE id = 155
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08409067');

-- Match (por nombre, score=0.91): URETA CRUZ EMILIA
UPDATE public.socios SET
  dni       = '08364315',
  apellidos = 'URETA CRUZ EMILIA',
  estado    = 'Activo'
WHERE id = 7
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08364315');

-- ⚠️  Match por nombre con confianza MEDIA para: VALENCIA TOMAS VICENTE DORIS
--     BD actual: "VALENCIA TOMAS VICENTE" (id=89, DNI=SOC-089) (por nombre, score=0.87)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.87): VALENCIA TOMAS VICENTE DORIS
UPDATE public.socios SET
  dni       = '07343203',
  apellidos = 'VALENCIA TOMAS VICENTE DORIS',
  estado    = 'Activo'
WHERE id = 89
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '07343203');

-- ⚠️  Match por nombre con confianza MEDIA para: VALERO PARIONA MAXIMO ALBINO
--     BD actual: "Valero Pariona Maximo" (id=19, DNI=SOC-019) (por nombre, score=0.89)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.89): VALERO PARIONA MAXIMO ALBINO
UPDATE public.socios SET
  dni       = '08394062',
  apellidos = 'VALERO PARIONA MAXIMO ALBINO',
  estado    = 'Activo'
WHERE id = 19
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08394062');

-- Match (por nombre, score=1.00): VALERO SOTO MAXIMO ELIAS
UPDATE public.socios SET
  dni       = '40252062',
  estado    = 'Activo'
WHERE id = 183
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '40252062');

-- ⚠️  Match por nombre con confianza MEDIA para: VALERO SOTO WILLY PERSEO
--     BD actual: "Valero Soto Willy Perseo Albino" (id=20, DNI=SOC-020) (por nombre, score=0.89)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.89): VALERO SOTO WILLY PERSEO
UPDATE public.socios SET
  dni       = '42565283',
  apellidos = 'VALERO SOTO WILLY PERSEO',
  estado    = 'Activo'
WHERE id = 20
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42565283');

-- Match (por nombre, score=0.93): VALLEJOS HUAMAN MARIA ANA
UPDATE public.socios SET
  dni       = '10486779',
  apellidos = 'VALLEJOS HUAMAN MARIA ANA',
  estado    = 'Activo'
WHERE id = 161
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10486779');

-- ⚠️  Match por nombre con confianza MEDIA para: VARA CASTRO DELIA ERNESTINA F
--     BD actual: "VARA CASTRO ERNESTINA" (id=124, DNI=SOC-124) (por nombre, score=0.86)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.86): VARA CASTRO DELIA ERNESTINA F
UPDATE public.socios SET
  dni       = '08378938',
  apellidos = 'VARA CASTRO DELIA ERNESTINA F',
  estado    = 'Activo'
WHERE id = 124
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08378938');

-- Match (por nombre, score=1.00): VARA DE ROSAS ALICIA VALENTINA
UPDATE public.socios SET
  dni       = '08386699',
  estado    = 'Activo'
WHERE id = 104
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08386699');

-- Match (por nombre, score=1.00): VICENTE CALIXTO JOSE ALBERTO
UPDATE public.socios SET
  dni       = '09573772',
  estado    = 'Activo'
WHERE id = 112
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09573772');

-- Match (por nombre, score=1.00): VILCHEZ GUTARRA LOURDES FANNY
UPDATE public.socios SET
  dni       = '09127189',
  estado    = 'Activo'
WHERE id = 118
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09127189');

-- ⚠️  Match por nombre con confianza MEDIA para: VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA
--     BD actual: "VILLANUEVA INGA DE VASQUEZ ROSA" (id=111, DNI=SOC-111) (por nombre, score=0.87)
--     Verificar antes de aplicar.
-- Match (por nombre, score=0.87): VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA
UPDATE public.socios SET
  dni       = '09120179',
  apellidos = 'VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA',
  estado    = 'Activo'
WHERE id = 111
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09120179');

-- Match (por nombre, score=1.00): YAURIMUCHA RIMACHI MARCOS
UPDATE public.socios SET
  dni       = '09410794',
  estado    = 'Activo'
WHERE id = 21
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09410794');

-- Match (por nombre, score=1.00): ZAPATA RIVERA ROSANA
UPDATE public.socios SET
  dni       = '09573359',
  estado    = 'Activo'
WHERE id = 81
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09573359');

-- Match (por nombre, score=1.00): ZAPATA VELIT VICTORIANO
UPDATE public.socios SET
  dni       = '08353610',
  estado    = 'Activo'
WHERE id = 113
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08353610');


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 4: Insertar 17 socios nuevos
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.socios (dni, nombres, apellidos, estado, habilitado, fecha_ingreso)
VALUES
    ('08365528', '', 'CHUCHULLO HACHA JOSE PEDRO', 'Activo', true, '2020-01-01'),
    ('09868359', '', 'ESTRADA CHACON OSCAR ALFREDO', 'Activo', true, '2020-01-01'),
    ('07009232', '', 'HUAMANI ROMERO DOMITILA CLEOFE', 'Activo', true, '2020-01-01'),
    ('46074009', '', 'MALLQUI LOPEZ LIZBETH NATIVIDAD', 'Activo', true, '2020-01-01'),
    ('08363303', '', 'MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE', 'Activo', true, '2020-01-01'),
    ('07023212', '', 'MEDINA JOTA DE CACERES VICENTA', 'Activo', true, '2020-01-01'),
    ('42772112', '', 'OQUENDO QUISPE MIGUEL EUFRACIO', 'Activo', true, '2020-01-01'),
    ('44619731', '', 'PAREDES MORALES DIANA VONNETH', 'Activo', true, '2020-01-01'),
    ('08981387', '', 'PEREZ QUISPE EPIFANIA RICARDINA', 'Activo', true, '2020-01-01'),
    ('08378503', '', 'ROJAS IGNACIO LIONILA JULIA', 'Activo', true, '2020-01-01'),
    ('10026448', '', 'SALAS MONTALVO RUTH YOVANNA', 'Activo', true, '2020-01-01'),
    ('75695054', '', 'SALVATIERRA OQUENDO ALLISON ADRIANA', 'Activo', true, '2020-01-01'),
    ('09121626', '', 'SERMENO GUTIERREZ JAVIER YGNACIO', 'Activo', true, '2020-01-01'),
    ('08362537', '', 'TINTAYA CAHUANA PATRICIA HERMENEGILDA', 'Activo', true, '2020-01-01'),
    ('09123715', '', 'VALVERDE ROSAS JUAN MARCELINO', 'Activo', true, '2020-01-01'),
    ('09585627', '', 'YRUPAILLA ANAMPA ISIDRO BELISARIO', 'Activo', true, '2020-01-01'),
    ('09128244', '', 'YRUPAILLA FALCON NILDA ADELINA', 'Activo', true, '2020-01-01')
ON CONFLICT (dni) DO UPDATE SET
  apellidos = EXCLUDED.apellidos,
  estado    = 'Activo'
WHERE public.socios.apellidos LIKE 'SOCIO %' OR public.socios.apellidos = '';

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 5: Actualizar inquilinos existentes (DNI real si hay placeholder)
-- ─────────────────────────────────────────────────────────────────────────────
-- Match (nombre, score=1.00): AIRE MALPARTIDA HECTOR
UPDATE public.inquilinos SET
  dni       = '10019147'
WHERE id = 27
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10019147');

-- Match (nombre, score=0.86): ALVAREZ BERRIO FLORENCIA ASUNTA
UPDATE public.inquilinos SET
  dni       = '08877133',
  apellidos = 'ALVAREZ BERRIO FLORENCIA ASUNTA'
WHERE id = 49
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08877133');

-- Match (nombre, score=0.85): ALVAREZ CHIARA EDGAR SALVADOR
UPDATE public.inquilinos SET
  dni       = '09706677',
  apellidos = 'ALVAREZ CHIARA EDGAR SALVADOR'
WHERE id = 48
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09706677');

-- Match (nombre, score=1.00): ANCHAYA HUAMAN ABEL
UPDATE public.inquilinos SET
  dni       = '44071731'
WHERE id = 62
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '44071731');

-- Match (nombre, score=0.91): ARMESTAR GODOS JUANA JACKELYNE
UPDATE public.inquilinos SET
  dni       = '00254279',
  apellidos = 'ARMESTAR GODOS JUANA JACKELYNE'
WHERE id = 30
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '00254279');

-- Match (nombre, score=1.00): ARREDONDO GARCIA GLADYS
UPDATE public.inquilinos SET
  dni       = '31428533'
WHERE id = 23
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '31428533');

-- Match (nombre, score=0.83): AVILA CHAVEZ ROSA MARINA
UPDATE public.inquilinos SET
  dni       = '44982231',
  apellidos = 'AVILA CHAVEZ ROSA MARINA'
WHERE id = 35
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '44982231');

-- Match (nombre, score=0.88): AYALA HUASHUAYO MARLENE ESTHER
UPDATE public.inquilinos SET
  dni       = '43650510',
  apellidos = 'AYALA HUASHUAYO MARLENE ESTHER'
WHERE id = 57
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '43650510');

-- Match (nombre, score=1.00): AZURZA TRIBINOS DAYSI ELIZABETH
UPDATE public.inquilinos SET
  dni       = '47384400'
WHERE id = 13
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '47384400');

-- Match (nombre, score=1.00): BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA
UPDATE public.inquilinos SET
  dni       = '08386063'
WHERE id = 1
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08386063');

-- Match (nombre, score=1.00): BURGA CARRASCO ELMER
UPDATE public.inquilinos SET
  dni       = '45136700'
WHERE id = 7
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '45136700');

-- Match (nombre, score=1.00): BUSTAMANTE CHILON GRACIELA
UPDATE public.inquilinos SET
  dni       = '42082589'
WHERE id = 47
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42082589');

-- Match (nombre, score=1.00): CARRASCO PICHIHUA MERY RUTH
UPDATE public.inquilinos SET
  dni       = '44168936'
WHERE id = 12
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '44168936');

-- Match (nombre, score=0.92): CASTILLO ZAPATA ESAEL
UPDATE public.inquilinos SET
  dni       = '48773769',
  apellidos = 'CASTILLO ZAPATA ESAEL'
WHERE id = 61
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '48773769');

-- Match (nombre, score=0.98): CASTRO RODRIGUEZ JANETT CONSUELO
UPDATE public.inquilinos SET
  dni       = '46405540',
  apellidos = 'CASTRO RODRIGUEZ JANETT CONSUELO'
WHERE id = 33
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '46405540');

-- Match (nombre, score=0.96): CCENCHO CARRASCO DAVID VICENTE
UPDATE public.inquilinos SET
  dni       = '44002664',
  apellidos = 'CCENCHO CARRASCO DAVID VICENTE'
WHERE id = 14
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '44002664');

-- Match (nombre, score=1.00): CERVANTES GARCIA CARLOS ARTURO
UPDATE public.inquilinos SET
  dni       = '41762238'
WHERE id = 19
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41762238');

-- Match (nombre, score=1.00): CHAMBI APAZA SIMONA
UPDATE public.inquilinos SET
  dni       = '10474827'
WHERE id = 55
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10474827');

-- Match (nombre, score=1.00): CHOQUEHUANCA HUAMAN DAVID
UPDATE public.inquilinos SET
  dni       = '48822765'
WHERE id = 52
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '48822765');

-- Match (nombre, score=0.95): CHOQUEHUANCA HUAMAN DERSE
UPDATE public.inquilinos SET
  dni       = '47205649',
  apellidos = 'CHOQUEHUANCA HUAMAN DERSE'
WHERE id = 5
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '47205649');

-- Match (nombre, score=0.92): CUNIAS SANTOS MARIELA
UPDATE public.inquilinos SET
  dni       = '71577898',
  apellidos = 'CUNIAS SANTOS MARIELA'
WHERE id = 50
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '71577898');

-- Match (nombre, score=0.84): DAVILA HILARES YESENIA BEATRIZ
UPDATE public.inquilinos SET
  dni       = '10233461',
  apellidos = 'DAVILA HILARES YESENIA BEATRIZ'
WHERE id = 16
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10233461');

-- Match (nombre, score=0.92): ENCARNACION PAUCARPOMA GLADYS
UPDATE public.inquilinos SET
  dni       = '09369721',
  apellidos = 'ENCARNACION PAUCARPOMA GLADYS'
WHERE id = 22
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09369721');

-- Match (nombre, score=1.00): FLORES LAREDO DOMINICIA LUCIANA
UPDATE public.inquilinos SET
  dni       = '09407642'
WHERE id = 39
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09407642');

-- Match (nombre, score=0.90): GARCIA MEDINA VDA DE MOLINA CLEMENCIA BEATRIZ
UPDATE public.inquilinos SET
  dni       = '08905454',
  apellidos = 'GARCIA MEDINA VDA DE MOLINA CLEMENCIA BEATRIZ'
WHERE id = 21
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08905454');

-- Match (nombre, score=0.89): GOMERO DULANTO MARGARITA JUANA
UPDATE public.inquilinos SET
  dni       = '41844307',
  apellidos = 'GOMERO DULANTO MARGARITA JUANA'
WHERE id = 32
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41844307');

-- Match (nombre, score=1.00): GOMEZ MITMA MARIBEL
UPDATE public.inquilinos SET
  dni       = '10347772'
WHERE id = 54
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10347772');

-- Match (nombre, score=0.85): HERNANDEZ HERNANDEZ LILIBETH MARIA
UPDATE public.inquilinos SET
  dni       = '04352513',
  apellidos = 'HERNANDEZ HERNANDEZ LILIBETH MARIA'
WHERE id = 20
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '04352513');

-- Match (nombre, score=1.00): HERRERA PEVES ROMINA DEL CARMEN
UPDATE public.inquilinos SET
  dni       = '71009767'
WHERE id = 53
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '71009767');

-- Match (nombre, score=1.00): HERRERA CAMPOS ORFELITA
UPDATE public.inquilinos SET
  dni       = '41365838'
WHERE id = 51
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41365838');

-- Match (nombre, score=0.89): LA ROSA LOPEZ MARGARITA LILIANA
UPDATE public.inquilinos SET
  dni       = '46950481',
  apellidos = 'LA ROSA LOPEZ MARGARITA LILIANA'
WHERE id = 31
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '46950481');

-- Match (nombre, score=0.92): LAPAS ZALAZAR ANA MARIA
UPDATE public.inquilinos SET
  dni       = '07279524',
  apellidos = 'LAPAS ZALAZAR ANA MARIA'
WHERE id = 9
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '07279524');

-- Match (nombre, score=1.00): LEON RODRIGUEZ ANGIE MARGARITA
UPDATE public.inquilinos SET
  dni       = '73348594'
WHERE id = 44
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '73348594');

-- Match (nombre, score=0.90): LEONARDO AMARILLO FEDERICO MANUEL
UPDATE public.inquilinos SET
  dni       = '09575838',
  apellidos = 'LEONARDO AMARILLO FEDERICO MANUEL'
WHERE id = 43
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09575838');

-- Match (nombre, score=1.00): LEONARDO AMARILLO ROSANA PILAR
UPDATE public.inquilinos SET
  dni       = '10026348'
WHERE id = 42
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10026348');

-- Match (nombre, score=1.00): LOPEZ CERRON HAYDEE
UPDATE public.inquilinos SET
  dni       = '07266341'
WHERE id = 17
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '07266341');

-- Match (nombre, score=0.92): MALLMA CONDORI LISBETH LUCIA
UPDATE public.inquilinos SET
  dni       = '72446110',
  apellidos = 'MALLMA CONDORI LISBETH LUCIA'
WHERE id = 40
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '72446110');

-- Match (nombre, score=1.00): MAYHUASCA BASTIDAS DORIS
UPDATE public.inquilinos SET
  dni       = '10481732'
WHERE id = 2
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10481732');

-- Match (nombre, score=0.98): MIRANDA CACERES FELICITA
UPDATE public.inquilinos SET
  dni       = '06651184',
  apellidos = 'MIRANDA CACERES FELICITA'
WHERE id = 6
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '06651184');

-- Match (nombre, score=0.93): MUJICA PALOMINO SANDRA LIZ
UPDATE public.inquilinos SET
  dni       = '80055674',
  apellidos = 'MUJICA PALOMINO SANDRA LIZ'
WHERE id = 34
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '80055674');

-- Match (nombre, score=1.00): OBREGON CASTILLO FERNANDO MARTIN
UPDATE public.inquilinos SET
  dni       = '08139723'
WHERE id = 41
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08139723');

-- Match (nombre, score=1.00): PALOMINO CUSI ROSA
UPDATE public.inquilinos SET
  dni       = '44465773'
WHERE id = 26
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '44465773');

-- Match (nombre, score=0.92): PENA VDA DE VILLANUEVA TERESA
UPDATE public.inquilinos SET
  dni       = '08378642',
  apellidos = 'PENA VDA DE VILLANUEVA TERESA'
WHERE id = 25
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08378642');

-- Match (nombre, score=0.92): PFUNO RAMOS VICTOR RAUL
UPDATE public.inquilinos SET
  dni       = '09720689',
  apellidos = 'PFUNO RAMOS VICTOR RAUL'
WHERE id = 11
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09720689');

-- Match (nombre, score=1.00): PRADO CATANO MIRIAM MILAGROS
UPDATE public.inquilinos SET
  dni       = '42841670'
WHERE id = 24
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42841670');

-- Match (nombre, score=0.95): QUISPE CHAVEZ MARI SOL
UPDATE public.inquilinos SET
  dni       = '09700283',
  apellidos = 'QUISPE CHAVEZ MARI SOL'
WHERE id = 46
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09700283');

-- Match (nombre, score=1.00): QUISPE MAMANI PATRICIA PAOLA
UPDATE public.inquilinos SET
  dni       = '41747705'
WHERE id = 56
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '41747705');

-- Match (nombre, score=0.82): REBAZA REBAZA CASILDA CATALINA
UPDATE public.inquilinos SET
  dni       = '09852414',
  apellidos = 'REBAZA REBAZA CASILDA CATALINA'
WHERE id = 3
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09852414');

-- Match (nombre, score=0.98): RENTERIA HUANCAS ROSA ARMANDINA
UPDATE public.inquilinos SET
  dni       = '10625419',
  apellidos = 'RENTERIA HUANCAS ROSA ARMANDINA'
WHERE id = 28
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '10625419');

-- Match (nombre, score=0.88): SALAZAR VASQUEZ MARIA ROSARIO
UPDATE public.inquilinos SET
  dni       = '09135097',
  apellidos = 'SALAZAR VASQUEZ MARIA ROSARIO'
WHERE id = 37
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09135097');

-- Match (nombre, score=1.00): YAURIMUCHA RIMACHI URSULA
UPDATE public.inquilinos SET
  dni       = '08363214'
WHERE id = 18
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08363214');

-- Match (nombre, score=1.00): YAUYOS MENDIETA MARLENE
UPDATE public.inquilinos SET
  dni       = '09574907'
WHERE id = 8
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09574907');

-- Match (nombre, score=0.84): YUPANQUI QUISPE SAYDA
UPDATE public.inquilinos SET
  dni       = '42479516',
  apellidos = 'YUPANQUI QUISPE SAYDA'
WHERE id = 36
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '42479516');

-- Match (nombre, score=0.89): ALARCON ESPINOZA MARTHA ESPERANZA
UPDATE public.inquilinos SET
  dni       = '09350799',
  apellidos = 'ALARCON ESPINOZA MARTHA ESPERANZA'
WHERE id = 63
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '09350799');

-- Match (nombre, score=0.95): ESPARTA CARDENAS JULIO HECTOR
UPDATE public.inquilinos SET
  dni       = '08899417',
  apellidos = 'ESPARTA CARDENAS JULIO HECTOR'
WHERE id = 65
  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != '08899417');


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 6: Insertar 30 inquilinos nuevos
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.inquilinos (dni, nombres, apellidos)
VALUES
    ('40466902', '', 'BENITES TRIBINOS ERIKA'), 
    ('60812334', '', 'CAHUANA PUCURIMAY ALEX ENRIQUE'), 
    ('46542458', '', 'CERDAN MUNOZ MARIA DOMINGA'), 
    ('10104498146', '', 'CLAROS TORRES SANTOS JESUS'), 
    ('08995920', '', 'CONDORI MAMANI LIDIA AGRIPINA'), 
    ('73192679', '', 'SUAREZ REBAZA LUIS ABRAHAM'), 
    ('20654471', '', 'ZANABRIA LADERA DE COCHACHI LILIA RUFINA'), 
    ('03901433', '', 'COLINA CORREA SIRLEY KARINA'), 
    ('72336226', '', 'PENA VILLANUEVA ASHLEY MARYORI'), 
    ('45452812', '', 'SALDANA DONAYRE JESSICA PATRICIA'), 
    ('71390650', '', 'SANCHEZ PRADO DIANA ZENAIDA'), 
    ('20097655', '', 'CERRON GALVAN OBDULIA'), -- 2do Piso
    ('08030473', '', 'DURAN CHACON BLANCA NIEVES'), -- 2do Piso
    ('10106511476', '', 'FERREYRA COSME TANIA MABEL'), -- 2do Piso
    ('08991437', '', 'HUAMANI CONTRERAS MAXIMO FLAVIO'), -- 2do Piso
    ('08914131', '', 'CAYO HUAMANI BACILIO ANTONIO'), -- Espacio
    ('29096837', '', 'CHIPANA DE VARGAS ANATOLIA'), -- Espacio
    ('42799850', '', 'IDALINA MONTENEGRO BAUTISTA'), -- Espacio
    ('46101817', '', 'KARINA LUZ LUCIANO INGA'), -- Espacio
    ('15605235546', '', 'MARILIN DEL CARMEN VERA'), -- Espacio
    ('48462586', '', 'QUISPE NAPUCHE LISBETH KARITO'), -- Espacio
    ('28312595', '', 'TUEROS QUISPE PRUDENCIO'), -- Espacio
    ('DEP-3-D1', '', 'CARTAGENA ALVARO'), -- Depósito D1
    ('DEP-4-D1', '', 'MESIAS GLADYS'), -- Depósito D1
    ('DEP-6-D1', '', 'VILLANUEVA INGA ROSA'), -- Depósito D1
    ('DEP-11-D2', '', 'SALDANA DONAYRE JESSICA PATRICIA'), -- Depósito D2
    ('DEP-2-D3', '', 'CHUCHULLO HACHA JOSE PEDRO'), -- Depósito D3
    ('DEP-4-D3', '', 'BUSTAMANTE JOSE'), -- Depósito D3
    ('DEP-5-D3', '', 'ACCO NOA VICTOR'), -- Depósito D3
    ('DEP-6-D3', '', 'ACCO NOA VICTOR') -- Depósito D3
ON CONFLICT (dni) DO UPDATE SET
  apellidos = EXCLUDED.apellidos
WHERE public.inquilinos.apellidos LIKE 'INQUILINO %' OR public.inquilinos.apellidos = '';

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 7: historial_titularidad — 185 socios vinculados a sus puestos
-- ─────────────────────────────────────────────────────────────────────────────
-- Lógica por socio (resuelve ID por DNI en tiempo de ejecución SQL):
--   • Cierra titularidades vigentes equivocadas (diferente socio para el mismo puesto)
--   • Inserta si no existe la combinación socio+puesto vigente
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
      RAISE WARNING 'historial_titularidad: socio no encontrado DNI=%', rec.dni;
      CONTINUE;
    END IF;
    IF v_p IS NULL THEN
      RAISE WARNING 'historial_titularidad: puesto no encontrado código=%', rec.puesto_code;
      CONTINUE;
    END IF;
    -- Cerrar cualquier titularidad vigente en este puesto que sea de otro socio
    UPDATE public.historial_titularidad
      SET fecha_fin = CURRENT_DATE
    WHERE puesto_id = v_p AND fecha_fin IS NULL AND socio_id != v_s;
    -- Insertar sólo si no existe ya la titularidad vigente
    IF NOT EXISTS (
      SELECT 1 FROM public.historial_titularidad
      WHERE puesto_id = v_p AND socio_id = v_s AND fecha_fin IS NULL
    ) THEN
      INSERT INTO public.historial_titularidad (puesto_id, socio_id, fecha_inicio)
      VALUES (v_p, v_s, '2020-01-01');
      RAISE NOTICE 'Titularidad creada: DNI=% → puesto=%', rec.dni, rec.puesto_code;
    END IF;
  END LOOP;
END; $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 8: historial_arriendos — 64 inquilinos (-E y COOP)
-- ─────────────────────────────────────────────────────────────────────────────
-- socio_titular_id se resuelve desde historial_titularidad del puesto BASE.
-- Si el base_puesto no tiene titular vigente, se emite RAISE WARNING y se omite.
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
    SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = rec.puesto_code;
    SELECT ht.socio_id INTO v_soc
      FROM public.historial_titularidad ht
      JOIN public.puestos p ON p.id = ht.puesto_id
      WHERE p.codigo_puesto = rec.base_puesto AND ht.fecha_fin IS NULL
      LIMIT 1;
    IF v_inq IS NULL THEN
      RAISE WARNING 'historial_arriendos: inquilino no encontrado DNI=%', rec.inq_dni;
      CONTINUE;
    END IF;
    IF v_pue IS NULL THEN
      RAISE WARNING 'historial_arriendos: puesto no encontrado código=%', rec.puesto_code;
      CONTINUE;
    END IF;
    IF v_soc IS NULL THEN
      RAISE WARNING 'historial_arriendos: sin titular vigente para puesto base=%; OMITIDO — asignar manualmente.', rec.base_puesto;
      CONTINUE;
    END IF;
    -- Cerrar arriendo vigente para OTRO inquilino en el mismo puesto
    UPDATE public.historial_arriendos
      SET fecha_fin = CURRENT_DATE
    WHERE puesto_id = v_pue AND fecha_fin IS NULL AND inquilino_id != v_inq;
    -- Insertar si no existe
    IF NOT EXISTS (
      SELECT 1 FROM public.historial_arriendos
      WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
    ) THEN
      INSERT INTO public.historial_arriendos
        (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
      VALUES (v_pue, v_inq, v_soc, '2020-01-01');
      RAISE NOTICE 'Arriendo creado: DNI=% → puesto=%', rec.inq_dni, rec.puesto_code;
    END IF;
  END LOOP;
END; $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 9: Depósitos — arriendos para renters que ya existen en BD como inquilinos
-- ─────────────────────────────────────────────────────────────────────────────
-- Para estos registros el puesto ya fue insertado en PASO 2.
-- El socio_titular_id NO APLICA (depósito de la Cooperativa) — campo NOT NULL:
-- se usa el primer socio activo como placeholder; CORREGIR MANUALMENTE.
-- No hay depósitos con renter ya registrado como inquilino en BD.

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 10 (MANUAL): historial_arriendos para -SP y -EP
-- ─────────────────────────────────────────────────────────────────────────────
-- Los puestos -SP (2do Piso) y -EP (Espacios) son propiedad de la Cooperativa.
-- NO tienen socio_titular_id individual → historial_arriendos requiere asignación manual.
-- Los inquilinos ya fueron insertados en PASO 6.
--
-- PARA CADA UNO: descomenta el bloque, reemplaza <SOCIO_ID_COOPERATIVA> con el id
-- del socio que represente a la Cooperativa, y ejecuta.

/*
-- 2do Piso: ALARCON ESPINOZA MARTHA ESPERANZA → puesto 1-SP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '09350799';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '1-SP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'ALARCON ESPINOZA MARTHA ESPERANZA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- 2do Piso: CERRON GALVAN OBDULIA → puesto 2-SP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '20097655';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '2-SP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CERRON GALVAN OBDULIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- 2do Piso: DURAN CHACON BLANCA NIEVES → puesto 3-SP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08030473';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '3-SP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'DURAN CHACON BLANCA NIEVES: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- 2do Piso: ESPARTA CARDENAS JULIO HECTOR → puesto 4-SP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08899417';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '4-SP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'ESPARTA CARDENAS JULIO HECTOR: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- 2do Piso: FERREYRA COSME TANIA MABEL → puesto 5-SP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '10106511476';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '5-SP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'FERREYRA COSME TANIA MABEL: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- 2do Piso: HUAMANI CONTRERAS MAXIMO FLAVIO → puesto 6-SP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08991437';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '6-SP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'HUAMANI CONTRERAS MAXIMO FLAVIO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- Espacio: CAYO HUAMANI BACILIO ANTONIO → puesto 1-EP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '08914131';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '1-EP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CAYO HUAMANI BACILIO ANTONIO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- Espacio: CHIPANA DE VARGAS ANATOLIA → puesto 2-EP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '29096837';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '2-EP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'CHIPANA DE VARGAS ANATOLIA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- Espacio: IDALINA MONTENEGRO BAUTISTA → puesto 3-EP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '42799850';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '3-EP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'IDALINA MONTENEGRO BAUTISTA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- Espacio: KARINA LUZ LUCIANO INGA → puesto 4-EP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '46101817';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '4-EP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'KARINA LUZ LUCIANO INGA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- Espacio: MARILIN DEL CARMEN VERA → puesto 5-EP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '15605235546';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '5-EP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'MARILIN DEL CARMEN VERA: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- Espacio: QUISPE NAPUCHE LISBETH KARITO → puesto 6-EP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '48462586';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '6-EP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'QUISPE NAPUCHE LISBETH KARITO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/

/*
-- Espacio: TUEROS QUISPE PRUDENCIO → puesto 7-EP
DO $$
DECLARE v_inq bigint; v_pue bigint;
BEGIN
  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = '28312595';
  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = '7-EP';
  IF v_inq IS NULL OR v_pue IS NULL THEN
    RAISE WARNING 'TUEROS QUISPE PRUDENCIO: inquilino o puesto no encontrado'; RETURN;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.historial_arriendos
    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL
  ) THEN
    INSERT INTO public.historial_arriendos
      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, '2020-01-01');
  END IF;
END; $$;
*/


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 11 (MANUAL): historial_arriendos depósitos nuevos + depósitos de socios
-- ─────────────────────────────────────────────────────────────────────────────
-- Los depósitos son propiedad de la Cooperativa: socio_titular_id sin asignar.
-- Inquilinos nuevos ya insertados en PASO 6 con DNI=DEP-<puesto>.

-- Depósitos donde el renter ES un SOCIO (no puede ser inquilino_id directamente):
-- • 1-D1: HALIRE YUCRA JOSUE → SOCIO id=178 (HALIRE YUCRA JOSUE)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 2-D1: CERDA YUPANQUI CARMEN → SOCIO id=159 (CERDA YUPANQUI CARMEN ROSA)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 5-D1: MARIN LONDONE MARIA LUZ → SOCIO id=137 (MARIN LONDOÑE MARIA LUZ)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 7-D1: VILCHEZ GUTARRA LOURDES → SOCIO id=118 (VILCHEZ GUTARRA LOURDES FANNY)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 2-D2: HUASHUAYO GOMEZ EUDOSIA → SOCIO id=8 (Huashuayo Gomez Eudosia)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 3-D2: ALVAREZ CAMPOS ROLANDO → SOCIO id=67 (Alvarez Campos Rolando)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 4-D2: PALOMINO TENORIO SILVIO EDUARDO → SOCIO id=86 (PALOMINO TENORIO SILVIO EDUARDO)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 5-D2: VICENTE CALIXTO JOSE ALBERTO → SOCIO id=112 (VICENTE CALIXTO JOSE ALBERTO)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 6-D2: AGUIRRE QUISPE WILFREDO GILMER → SOCIO id=114 (AGUIRRE QUISPE WILFREDO GILMER)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 7-D2: DAVILA CAHUANA MARISOL → SOCIO id=51 (Davila Cahuana Marisol)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 8-D2: CABERO MENDOZA GLORIA → SOCIO id=34 (Cabero Mendoza Gloria)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 10-D2: CALLE ALVAREZ MARCO → SOCIO id=149 (CALLE ALVAREZ MARCO)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 1-D3: AYALA TABOADA ELISEO → SOCIO id=9 (Ayala Toboada Eliseo)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 3-D3: TORRES ANYOSA MARCELINO → SOCIO id=64 (Torres Anyorsa Marcelino)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 7-D3: LIMAS VARGAS CARMEN → SOCIO id=2 (Limas Vargas Carmen Rosa)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?
-- • 8-D3: CABERO MENDOZA GLORIA → SOCIO id=34 (Cabero Mendoza Gloria)
--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?

-- Depósitos nuevos (insertar arriendo manualmente cuando se decida socio_titular_id):
-- • 3-D1: CARTAGENA ALVARO (DNI temporal = 'DEP-3-D1')
-- • 4-D1: MESIAS GLADYS (DNI temporal = 'DEP-4-D1')
-- • 6-D1: VILLANUEVA INGA ROSA (DNI temporal = 'DEP-6-D1')
-- • 11-D2: SALDANA DONAYRE JESSICA PATRICIA (DNI temporal = 'DEP-11-D2')
-- • 2-D3: CHUCHULLO HACHA JOSE PEDRO (DNI temporal = 'DEP-2-D3')
-- • 4-D3: BUSTAMANTE JOSE (DNI temporal = 'DEP-4-D3')
-- • 5-D3: ACCO NOA VICTOR (DNI temporal = 'DEP-5-D3')
-- • 6-D3: ACCO NOA VICTOR (DNI temporal = 'DEP-6-D3')

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 12 (MANUAL): Socios en BD no presentes en el Excel definitivo
-- ─────────────────────────────────────────────────────────────────────────────
-- Los siguientes 17 socios están en BD pero NO aparecen en el padrón Excel.
-- Verificar con el administrador si deben marcarse como Inactivos.
-- Para marcar: descomenta el UPDATE correspondiente.

-- id=1 DNI=SOC-001 → "Huamani Romero Donatila"
-- id=5 DNI=SOC-005 → "Medina Jota Vicenta"
-- id=6 DNI=SOC-006 → "Salas Montalvo Ruth"
-- id=17 DNI=SOC-017 → "Paredes Morales Diana"
-- id=18 DNI=SOC-018 → "Javier Sermeño Gutierrez"
-- id=37 DNI=SOC-037 → "Perez Quispe Epifania"
-- id=38 DNI=SOC-038 → "Rojas Ignacio Leonila"
-- id=48 DNI=SOC-048 → "Juan Valverde Rosas (CERRADO)"
-- id=60 DNI=SOC-060 → "Yruipalla Falcon Hilda"
-- id=61 DNI=SOC-061 → "Chuchuyo Hacha José"
-- id=66 DNI=SOC-066 → "Tintaya Cahuana Patricia"
-- id=88 DNI=SOC-088 → "YRUPAILLA ANAMPA ISIDRO"
-- id=95 DNI=SOC-095 → "ESTRADA OSCAR"
-- id=105 DNI=SOC-105 → "MAYHUASCA BASTIDAS CLUDDY"
-- id=133 DNI=SOC-133 → "OQUENDO QUISPE MIGUEL"
-- id=143 DNI=SOC-143 → "SALVATIERRA AYALA ALLISON"
-- id=150 DNI=SOC-150 → "MALLQUI LOPEZ LIZBETH"

/*
UPDATE public.socios SET estado = 'Inactivo', habilitado = false
WHERE id IN (
  1, 5, 6, 17, 18, 37, 38, 48, 60, 61, 66, 88, 95, 105, 133, 143, 150
);
*/

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 13: Estado final y verificación
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_socios    bigint; v_inqs bigint; v_puestos bigint;
  v_titulares bigint; v_arriendos bigint;
BEGIN
  SELECT count(*) INTO v_socios    FROM public.socios WHERE deleted_at IS NULL;
  SELECT count(*) INTO v_inqs      FROM public.inquilinos WHERE deleted_at IS NULL;
  SELECT count(*) INTO v_puestos   FROM public.puestos WHERE deleted_at IS NULL;
  SELECT count(*) INTO v_titulares FROM public.historial_titularidad WHERE fecha_fin IS NULL;
  SELECT count(*) INTO v_arriendos FROM public.historial_arriendos WHERE fecha_fin IS NULL;
  RAISE NOTICE '=================================================';
  RAISE NOTICE '✓ Migración 00035 completada';
  RAISE NOTICE '  Socios activos:         %', v_socios;
  RAISE NOTICE '  Inquilinos activos:     %', v_inqs;
  RAISE NOTICE '  Puestos activos:        %', v_puestos;
  RAISE NOTICE '  Titularidades vigentes: %', v_titulares;
  RAISE NOTICE '  Arriendos vigentes:     %', v_arriendos;
  -- Verificación: cada socio debe tener como mínimo una titularidad vigente
  IF v_titulares < v_socios THEN
    RAISE WARNING 'Hay % socios sin titularidad vigente — revisar PASO 7', (v_socios - v_titulares);
  END IF;
  RAISE NOTICE '=================================================';
END; $$;

COMMIT;