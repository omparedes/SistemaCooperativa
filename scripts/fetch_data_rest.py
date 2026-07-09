import os
import requests
import json
from dotenv import load_dotenv

load_dotenv()
SUPABASE_URL = os.getenv("SUPABASE_URL", "")
SUPABASE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY", "")

HEADERS = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json"
}

def fetch_table(table_name, select_query):
    print(f"Fetching {table_name}...")
    url = f"{SUPABASE_URL}/rest/v1/{table_name}?select={select_query}"
    
    response = requests.get(url, headers=HEADERS)
    if response.status_code != 200:
        print(f"Error fetching {table_name}: {response.text}")
        return []
    
    data = response.json()
    print(f"Fetched {len(data)} records from {table_name}")
    return data

if __name__ == "__main__":
    os.makedirs('data_exports', exist_ok=True)
    
    # 1. Montos por cobrar (Pendientes)
    montos = fetch_table('montos_por_cobrar', 'id,puesto_id,socio_id,concepto_id,periodo_anio,periodo_mes,monto,estado,puestos(codigo_puesto),socios(nombres,apellidos),conceptos(nombre)&estado=in.(Pendiente,Pagado Parcial)')
    with open('data_exports/db_pendientes.json', 'w', encoding='utf-8') as f:
        json.dump(montos, f, ensure_ascii=False, indent=2)
        
    # 2. Socios
    socios = fetch_table('socios', 'id,nombres,apellidos,dni&deleted_at=is.null')
    with open('data_exports/db_socios.json', 'w', encoding='utf-8') as f:
        json.dump(socios, f, ensure_ascii=False, indent=2)
        
    # 3. Puestos
    puestos = fetch_table('puestos', 'id,codigo_puesto&deleted_at=is.null')
    with open('data_exports/db_puestos.json', 'w', encoding='utf-8') as f:
        json.dump(puestos, f, ensure_ascii=False, indent=2)
        
    print("Done exporting DB state using REST API.")
