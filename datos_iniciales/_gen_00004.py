import json, re, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
from pathlib import Path
from collections import defaultdict

EXACT = {'TOTAL','INQUILINOS','PARTE CONSTRUIDA','RELACION INQUILINOS 2025',
         'DESCRIPCIÓN','DESCRIPCION','BAÑO','BANO','SSHH','N°',''}
PREFIX = ('TOTAL ','SUBTOTAL','SUMA ','RELACION ')

def es_noise(n):
    if n in EXACT: return True
    if any(n.startswith(p) for p in PREFIX): return True
    if re.fullmatch(r'[\d\s\-]+', n): return True
    return False

base = Path(r"c:/Github/SistemaCooperativa/datos_iniciales")
data = json.loads((base / '_extracted.json').read_text(encoding='utf-8'))

socios     = [r for r in data['socios']     if not es_noise(r[0])]
inquilinos = [r for r in data['inquilinos'] if not es_noise(r[0])]

soc_mapping = [(d, p) for (n, d, p) in socios     if p.strip()]
inq_mapping = [(d, p) for (n, d, p) in inquilinos if p.strip()]

def dedupe_por_puesto(mapping):
    by_puesto = defaultdict(list)
    for display, puesto in mapping:
        by_puesto[puesto].append(display)
    elegidos, descartados = [], []
    for puesto, displays in by_puesto.items():
        displays.sort()
        elegidos.append((displays[0], puesto))
        if len(displays) > 1:
            descartados.extend([(d, puesto) for d in displays[1:]])
    return elegidos, descartados

soc_map_d, soc_descart = dedupe_por_puesto(soc_mapping)
inq_map_d, inq_descart = dedupe_por_puesto(inq_mapping)

puestos_con_socio     = {p for _, p in soc_map_d}
puestos_con_inq       = {p for _, p in inq_map_d}
puestos_inq_sin_socio = sorted(puestos_con_inq - puestos_con_socio)

print("=== Estadisticas ===")
print(f"Socios con puesto en fuente:         {len(soc_mapping)}")
print(f"  -> Titularidades unicas (1/puesto): {len(soc_map_d)}")
print(f"  -> Variantes descartadas:           {len(soc_descart)}")
print(f"Inquilinos con puesto en fuente:     {len(inq_mapping)}")
print(f"  -> Arriendos unicos (1/puesto):    {len(inq_map_d)}")
print(f"  -> Variantes descartadas:           {len(inq_descart)}")
print(f"Puestos con inquilino sin titular:    {len(puestos_inq_sin_socio)}")
print(f"  -> Se asignan a COOPERATIVA institucional")

def esc(s):
    return "'" + str(s).replace("'", "''") + "'"

L = []
A = L.append
A("-- =============================================================================")
A("-- Migracion 00004 - Seed: Historial de Titularidad y Arriendos (estado inicial)")
A("-- Cooperativa Primero de Mayo - SistemaCooperativa")
A("-- -----------------------------------------------------------------------------")
A("-- Vincula los socios e inquilinos del seed 00003 con sus puestos fisicos,")
A("-- segun el mapeo extraido de los Excel (columna N DE PUESTO).")
A("--")
A("-- Estado modelado: ESTADO INICIAL DEL SISTEMA")
A("--   * fecha_inicio = 2025-01-01")
A("--   * fecha_fin    = NULL (vigente)")
A("--")
A("-- Resolucion de claves foraneas (NO se hardcodean IDs):")
A("--   El INSERT...SELECT cruza:")
A("--     - public.puestos.codigo_puesto    <-> codigo del Excel")
A("--     - public.socios.apellidos         <-> nombre del socio (preservado exacto en 00003)")
A("--     - public.inquilinos.apellidos     <-> nombre del inquilino")
A("--     - historial_titularidad.socio_id  <-> se resuelve desde la titularidad VIGENTE")
A("--                                           del puesto al insertar arriendos")
A("--")
A("-- Idempotencia: TODOS los INSERT respetan los indices unicos parciales de 00002:")
A("--   ON CONFLICT (puesto_id) WHERE fecha_fin IS NULL DO NOTHING")
A("--   -> re-ejecutar la migracion es seguro y no inserta duplicados.")
A("--")
A("-- Inserts esperados:")
A("--   * 1 socio institucional COOPERATIVA PRIMERO DE MAYO (DNI 'COOP-00000')")
A(f"--   * {len(soc_map_d):>3} titularidades de socios individuales")
A(f"--   * {len(puestos_inq_sin_socio):>3} titularidades institucionales (puestos arrendados directamente)")
A(f"--   * {len(inq_map_d):>3} arriendos inquilino -> puesto")
A("--")
A(f"-- Calidad de datos (no bloqueante):")
A(f"--   * {len(soc_descart)} variantes de nombre de socio descartadas por colision en mismo puesto")
A(f"--     (typos / nombres duplicados en Excel fuente).")
A(f"--   * {len(inq_descart)} variantes de nombre de inquilino descartadas, idem.")
A(f"--   Las descartadas QUEDAN insertadas en socios/inquilinos (00003) pero sin")
A(f"--   titularidad/arriendo vinculados - revisar manualmente.")
A("-- =============================================================================")
A("")

# Paso 0
A("-- -----------------------------------------------------------------------------")
A("-- 0. Socio institucional: COOPERATIVA PRIMERO DE MAYO")
A("--    Representa la titularidad colectiva sobre los puestos arrendados")
A("--    directamente por la cooperativa a inquilinos (tipicamente puestos -E).")
A("-- -----------------------------------------------------------------------------")
A("insert into public.socios (dni, nombres, apellidos, fecha_ingreso) values")
A("    ('COOP-00000', '', 'COOPERATIVA PRIMERO DE MAYO (titular institucional)', '1970-01-01')")
A("on conflict (dni) do nothing;")
A("")

# Paso 1
A("-- -----------------------------------------------------------------------------")
A(f"-- 1. Titularidad de socios individuales ({len(soc_map_d)} registros)")
A("-- -----------------------------------------------------------------------------")
A("insert into public.historial_titularidad (puesto_id, socio_id, fecha_inicio, motivo_cambio)")
A("select p.id, s.id, '2025-01-01'::date, 'Carga inicial del sistema (seed 00004)'")
A("from (values")
A(",\n".join(f"    ({esc(d)}, {esc(p)})" for d, p in sorted(soc_map_d)))
A(") as m(nombre, codigo_puesto)")
A("join public.puestos p on p.codigo_puesto = m.codigo_puesto")
A("join public.socios   s on s.apellidos    = m.nombre")
A("on conflict (puesto_id) where fecha_fin is null do nothing;")
A("")

# Paso 2
if puestos_inq_sin_socio:
    A("-- -----------------------------------------------------------------------------")
    A(f"-- 2. Titularidad institucional COOPERATIVA ({len(puestos_inq_sin_socio)} puestos)")
    A("--    Para puestos con inquilino vigente pero sin socio individual conocido.")
    A("-- -----------------------------------------------------------------------------")
    A("insert into public.historial_titularidad (puesto_id, socio_id, fecha_inicio, motivo_cambio)")
    A("select p.id,")
    A("       (select id from public.socios where dni = 'COOP-00000'),")
    A("       '2025-01-01'::date,")
    A("       'Titularidad institucional - arrendado directamente por la cooperativa'")
    A("from (values")
    A(",\n".join(f"    ({esc(p)})" for p in puestos_inq_sin_socio))
    A(") as m(codigo_puesto)")
    A("join public.puestos p on p.codigo_puesto = m.codigo_puesto")
    A("on conflict (puesto_id) where fecha_fin is null do nothing;")
    A("")

# Paso 3
A("-- -----------------------------------------------------------------------------")
A(f"-- 3. Arriendos inquilino -> puesto ({len(inq_map_d)} registros)")
A("--    socio_titular_id se resuelve cruzando con la titularidad vigente del")
A("--    puesto (insertada en pasos 1 y 2 - siempre debe existir a estas alturas).")
A("-- -----------------------------------------------------------------------------")
A("insert into public.historial_arriendos (puesto_id, inquilino_id, socio_titular_id, fecha_inicio, motivo_termino)")
A("select p.id, i.id, ht.socio_id, '2025-01-01'::date, 'Carga inicial del sistema (seed 00004)'")
A("from (values")
A(",\n".join(f"    ({esc(d)}, {esc(p)})" for d, p in sorted(inq_map_d)))
A(") as m(nombre, codigo_puesto)")
A("join public.puestos             p  on p.codigo_puesto = m.codigo_puesto")
A("join public.inquilinos          i  on i.apellidos     = m.nombre")
A("join public.historial_titularidad ht on ht.puesto_id  = p.id")
A("                                       and ht.fecha_fin is null")
A("on conflict (puesto_id) where fecha_fin is null do nothing;")
A("")

out_path = Path(r"c:/Github/SistemaCooperativa/supabase/migrations/00004_seed_historial_titularidad_y_arriendos.sql")
out_path.write_text("\n".join(L), encoding='utf-8')
print(f"\n-> {out_path.name}")
print(f"   Tamano: {out_path.stat().st_size:,} bytes")
