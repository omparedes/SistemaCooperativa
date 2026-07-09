import pandas as pd
import json
import math

def normalize_name(name):
    if not isinstance(name, str):
        return ""
    return " ".join(name.upper().replace(',', ' ').split())

def match_name(excel_name, socio_dict):
    excel_parts = excel_name.split()
    best_match = None
    best_score = 0
    for sid, s in socio_dict.items():
        db_name = s['name']
        db_parts = db_name.split()
        
        matches = sum(1 for p in excel_parts if p in db_parts)
        score = matches / len(excel_parts) if excel_parts else 0
        
        if db_name == excel_name:
            return sid
            
        if score > best_score and score >= 0.6: 
            best_score = score
            best_match = sid
    return best_match

# 1. Load DB state
with open('data_exports/db_pendientes.json', 'r', encoding='utf-8') as f:
    pendientes = json.load(f)

with open('data_exports/db_socios.json', 'r', encoding='utf-8') as f:
    socios = json.load(f)
    
try:
    with open('data_exports/titularidad.json', 'r', encoding='utf-8-sig') as f:
        titularidad_raw = json.load(f)
        if isinstance(titularidad_raw, dict) and 'rows' in titularidad_raw:
            titularidad_raw = titularidad_raw['rows']
except FileNotFoundError:
    titularidad_raw = []

titularidad_map = {}
for t in titularidad_raw:
    titularidad_map[t['socio_id']] = t['puesto_id']

socio_dict = {}
for s in socios:
    full_name = normalize_name(f"{s['apellidos']} {s['nombres']}")
    socio_dict[s['id']] = {
        'name': full_name,
        'apellidos': s['apellidos'],
        'nombres': s['nombres']
    }

# Calculate current debt per socio (AFTER 00090)
db_debt = {}
for p in pendientes:
    sid = p.get('socio_id')
    if sid:
        db_debt[sid] = db_debt.get(sid, 0) + float(p['monto'])

# 2. Load Excel Target Debt
df_deuda = pd.read_excel('migracion_coop/julio/SOCIOS - DEUDA ACTUAL Y CONCEPTOS JULIO.xlsx')
excel_debt_by_name = {}
for index, row in df_deuda.iterrows():
    name = normalize_name(row['Socio'])
    if not name:
        continue
    amount = float(row['Deuda actual G']) if pd.notnull(row['Deuda actual G']) else 0
    excel_debt_by_name[name] = amount

# 3. Find Discrepancies and Generate SQL
sql_lines = []
sql_lines.append("BEGIN;")
sql_lines.append("")
sql_lines.append("-- =============================================================================")
sql_lines.append("-- Migración 00091 — Regularización de Saldos Históricos vs Excel de Julio")
sql_lines.append("-- =============================================================================")
sql_lines.append("")
sql_lines.append("DO $$")
sql_lines.append("DECLARE")
sql_lines.append("    v_user_uuid uuid;")
sql_lines.append("BEGIN")
sql_lines.append("    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;")
sql_lines.append("    IF v_user_uuid IS NULL THEN v_user_uuid := '00000000-0000-0000-0000-000000000000'; END IF;")
sql_lines.append("    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);")
sql_lines.append("")

discrepancies = []
for name, excel_amount in excel_debt_by_name.items():
    sid = match_name(name, socio_dict)
    if sid:
        db_amount = db_debt.get(sid, 0)
        diff = round(excel_amount - db_amount, 2)
        if diff > 0:
            # Excel owes MORE than DB. This is a historical gap. We insert a new debt.
            puesto_id = titularidad_map.get(sid, 'NULL')
            if puesto_id == 'NULL':
                # Try to find a puesto_id in pendientes
                for p in pendientes:
                    if p.get('socio_id') == sid and p.get('puesto_id'):
                        puesto_id = p['puesto_id']
                        break
            
            sql_lines.append(f"    -- SOCIO: {name} (ID: {sid}) | Hueco histórico: S/{diff}")
            sql_lines.append(f"    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)")
            sql_lines.append(f"    VALUES ({puesto_id}, {sid}, 9, 2026, 6, {diff}, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);")
            sql_lines.append("")

        elif diff < 0:
            # DB owes MORE than Excel. We need to cancel some debts.
            # (Though 00090 should have fixed most of this, if any remain we force them out)
            diff_abs = abs(diff)
            sql_lines.append(f"    -- SOCIO: {name} (ID: {sid}) | DB excede Excel por: S/{diff_abs}. Anulando {diff_abs} en deudas pendientes.")
            # We don't write complex PL/pgSQL for partial cancellation here, we just add an adjustment record with negative?
            # Montos_por_cobrar checks monto >= 0. We cannot insert negative.
            # We can just UPDATE montos_por_cobrar SET estado = 'Cancelado' 
            # Or just warn the user.
            sql_lines.append(f"    -- TODO: Manejar manualmente el saldo a favor de S/{diff_abs} para {name}")
            sql_lines.append("")

sql_lines.append("END $$;")
sql_lines.append("COMMIT;")

with open('supabase/migrations/00091_regularizacion_deudas_historicas.sql', 'w', encoding='utf-8') as f:
    f.write("\n".join(sql_lines))

print("Migración 00091 generada en supabase/migrations/00091_regularizacion_deudas_historicas.sql")
