import pandas as pd
import json

def normalize_name(name):
    if not isinstance(name, str):
        return ""
    return " ".join(name.upper().replace(',', ' ').split())

# 1. Load DB data
with open('data_exports/db_pendientes.json', 'r', encoding='utf-8') as f:
    pendientes = json.load(f)

with open('data_exports/db_socios.json', 'r', encoding='utf-8') as f:
    socios = json.load(f)

socio_dict = {}
for s in socios:
    full_name = normalize_name(f"{s['apellidos']} {s['nombres']}")
    socio_dict[s['id']] = {
        'name': full_name,
        'apellidos': s['apellidos'],
        'nombres': s['nombres']
    }

# Sum current DB debt per socio
db_debt = {}
for p in pendientes:
    sid = p.get('socio_id')
    if sid:
        db_debt[sid] = db_debt.get(sid, 0) + float(p['monto'])
    else:
        pass

# 2. Load Excel Target Debt
df_deuda = pd.read_excel('migracion_coop/julio/SOCIOS - DEUDA ACTUAL Y CONCEPTOS JULIO.xlsx')
excel_debt_by_name = {}
for index, row in df_deuda.iterrows():
    name = normalize_name(row['Socio'])
    amount = float(row['Deuda actual G']) if pd.notnull(row['Deuda actual G']) else 0
    excel_debt_by_name[name] = amount

def match_name(excel_name, socio_dict):
    excel_parts = excel_name.split()
    best_match = None
    best_score = 0
    for sid, s in socio_dict.items():
        db_name = s['name']
        db_parts = db_name.split()
        
        # Check how many parts of excel_name are in db_name
        matches = sum(1 for p in excel_parts if p in db_parts)
        score = matches / len(excel_parts) if excel_parts else 0
        
        # Exact match preferred
        if db_name == excel_name:
            return sid
            
        if score > best_score and score >= 0.6: # At least 60% of words match
            best_score = score
            best_match = sid
    return best_match

# Compare and find discrepancies
discrepancies = []
for name, excel_amount in excel_debt_by_name.items():
    if not name:
        continue
    sid = match_name(name, socio_dict)
    if sid:
        db_amount = db_debt.get(sid, 0)
        diff = round(db_amount - excel_amount, 2)
        if diff != 0:
            discrepancies.append({
                'name': name,
                'db': round(db_amount, 2),
                'excel': round(excel_amount, 2),
                'diff': diff,
                'sid': sid
            })
    else:
        # Not found in DB at all
        if excel_amount > 0:
            discrepancies.append({
                'name': name,
                'db': 0,
                'excel': round(excel_amount, 2),
                'diff': round(0 - excel_amount, 2),
                'sid': None
            })

discrepancies.sort(key=lambda x: x['diff'], reverse=True)

print(f"Total discrepancies: {len(discrepancies)}")
for d in discrepancies[:20]:
    print(f"{d['name']} (SID={d['sid']}): DB={d['db']} | Excel={d['excel']} | Diferencia={d['diff']}")
