import pandas as pd
import json
import math

def normalize_name(name):
    if not isinstance(name, str):
        return ""
    # Remove extra spaces and normalize
    return " ".join(name.upper().replace(',', ' ').split())

# 1. Load DB data
with open('data_exports/db_pendientes.json', 'r', encoding='utf-8') as f:
    pendientes = json.load(f)

with open('data_exports/db_socios.json', 'r', encoding='utf-8') as f:
    socios = json.load(f)

# Build a mapping of socio_id -> Socio Name
socio_dict = {}
for s in socios:
    # Full name format used in DB usually is Apellidos Nombres
    full_name = normalize_name(f"{s['apellidos']} {s['nombres']}")
    socio_dict[s['id']] = {
        'name': full_name,
        'original_apellidos': s['apellidos'],
        'original_nombres': s['nombres'],
        'dni': s['dni']
    }

# Sum current debt per socio
db_debt = {}
for p in pendientes:
    # If socio_id is directly on the debt
    sid = p.get('socio_id')
    if sid:
        db_debt[sid] = db_debt.get(sid, 0) + float(p['monto'])
    else:
        # What if it's tied to a puesto?
        pass # In this system, montos_por_cobrar usually has socio_id

# 2. Load Excel Target Debt
df = pd.read_excel('migracion_coop/julio/SOCIOS - CONSOLIDADO PAGOS JUNIO 2026 ACTUALIZADO.xlsx')
print("Pagos columns:", df.columns.tolist())

# We will need to map Excel names to socio_id
# Let's just print the column names for now to inspect the structure
