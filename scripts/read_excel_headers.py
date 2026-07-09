import pandas as pd
import json
import os

files = [
    "migracion_coop/junio/CONSOLIDADO INGRESOS SSHH Y PARQUEO JUNIO 2026.xlsx",
    "migracion_coop/junio/CONSOLIDADO MOVIMIENTOS BBVA JUNIO 2026.xlsx",
    "migracion_coop/junio/CONSOLIDADO EGRESOS JUNIO 2026.xlsx"
]

output = {}

for f in files:
    try:
        df = pd.read_excel(f)
        output[os.path.basename(f)] = {
            "columns": df.columns.tolist(),
            "first_row": json.loads(df.head(1).to_json(orient='records'))[0] if not df.empty else None
        }
    except Exception as e:
        output[os.path.basename(f)] = {"error": str(e)}

print(json.dumps(output, indent=2))
