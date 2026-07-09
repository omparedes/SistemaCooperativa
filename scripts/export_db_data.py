import subprocess
import json
import os

def run_query(sql, outfile):
    print(f"Running query and saving to {outfile}...")
    cmd = ['npx', 'supabase', 'db', 'query', '--linked', '--output-format', 'json', sql]
    try:
        result = subprocess.run(' '.join(cmd), capture_output=True, text=True, check=True, shell=True)
        # Parse output to list
        # Supabase cli json output might have a "rows" field or just be an array
        try:
            data = json.loads(result.stdout)
            if isinstance(data, dict) and 'rows' in data:
                data = data['rows']
        except json.JSONDecodeError:
            print("Failed to decode JSON. Raw stdout:", result.stdout)
            return
            
        with open(outfile, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"Saved {len(data)} rows to {outfile}")
    except subprocess.CalledProcessError as e:
        print(f"Error running query: {e.stderr}")

if __name__ == "__main__":
    os.makedirs('data_exports', exist_ok=True)
    
    run_query("""
    SELECT 
        m.id, m.puesto_id, p.codigo_puesto, 
        m.socio_id, s.nombres, s.apellidos,
        m.concepto_id, c.nombre as concepto_nombre,
        m.periodo_anio, m.periodo_mes,
        m.monto, m.estado
    FROM montos_por_cobrar m
    LEFT JOIN puestos p ON m.puesto_id = p.id
    LEFT JOIN socios s ON (m.socio_id = s.id OR (m.socio_id IS NULL AND p.titular_id = s.id))
    LEFT JOIN conceptos c ON m.concepto_id = c.id
    WHERE m.estado IN ('Pendiente', 'Pagado Parcial')
    AND m.deleted_at IS NULL
    """, 'data_exports/db_pendientes.json')

    run_query("""
    SELECT id, nombres, apellidos, documento_identidad FROM socios WHERE deleted_at IS NULL
    """, 'data_exports/db_socios.json')
    
    run_query("""
    SELECT id, codigo_puesto, titular_id FROM puestos WHERE deleted_at IS NULL
    """, 'data_exports/db_puestos.json')
