"""
generar_saldos_iniciales.py
─────────────────────────────────────────────────────────────────────────────
Migración Go-Live — Cooperativa Primero de Mayo (01-01-2026)
Genera los archivos:
  · migracion_coop/saldos_iniciales_matcheados.csv
  · migracion_coop/saldos_iniciales_huerfanos.csv
  · migracion_coop/saldos_iniciales_excluidos.csv
  · supabase/migrations/00038_saldos_iniciales_2025.sql

Ejecutar: python -X utf8 scripts/generar_saldos_iniciales.py
─────────────────────────────────────────────────────────────────────────────
REGLAS DE NEGOCIO APLICADAS:
  1. FUENTE DE DEUDA:  Excel CUENTAS X COBRAR AL 31-12-2025 (SOCIOS + INQUILINOS)
  2. FUENTE DE PADRON: Excel SOCIOS E INQUILINOS TERMINADO (SOCIOS + INQUILINOS)
  3. DEPOSITO: NO se usa como fuente de personas nuevas, SALVO:
       - BUSTAMANTE JOSE  (solo deposito, puesto 4-D3)
       - ACCO NOA VICTOR  (solo deposito, puesto 5-D3)
  4. ALIASES: correcciones de nombres conocidas (ver dict ALIASES abajo)
  5. EXCLUSIONES: personas cuya deuda NO se migra (ver set EXCLUIR abajo)
  6. HARDCODE: personas sin nombre en padron pero con puesto confirmado
─────────────────────────────────────────────────────────────────────────────
"""
import pandas as pd
import unicodedata
import re
import os
import difflib
from datetime import datetime

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EXCEL_PADRON  = os.path.join(BASE_DIR, "migracion_coop", "SOCIOS E INQUILINOS TERMINADO.xlsx")
EXCEL_CUENTAS = os.path.join(BASE_DIR, "migracion_coop", "CUENTAS X COBRAR AL 31-12-2025.xlsx")
OUTPUT_DIR    = os.path.join(BASE_DIR, "migracion_coop")
SQL_DIR       = os.path.join(BASE_DIR, "supabase", "migrations")


# ─── Helpers de normalización ─────────────────────────────────────────────────

def norm(s: str) -> str:
    """Mayúsculas, sin tildes, un solo espacio."""
    s = str(s).upper().strip()
    s = unicodedata.normalize('NFKD', s).encode('ascii', 'ignore').decode()
    return re.sub(r'\s+', ' ', s)

def sql_esc(s: str) -> str:
    return str(s).replace("'", "''")

def clean_excel_name(s: str) -> str:
    """Quita sufijos no informativos: (F), (f), paréntesis finales."""
    s = re.sub(r'\s*\(F\)\s*$', '', s, flags=re.IGNORECASE)
    s = re.sub(r'\s*\([^)]*\)\s*$', '', s)
    return s.strip()

def token_subset_match(short: str, candidate: str) -> bool:
    """True si todos los tokens del nombre corto aparecen en el candidato."""
    tokens_short = set(short.split())
    tokens_cand  = set(candidate.split())
    return len(tokens_short) >= 2 and tokens_short.issubset(tokens_cand)


# =============================================================================
# CONFIGURACIÓN MANUAL
# =============================================================================

# ─── Aliases: nombre en CUENTAS (normalizado) → nombre en PADRON (normalizado)
# Cubre: typos, inversión de palabras, nombres abreviados y traspasos de puesto.
ALIASES: dict[str, str] = {
    # Inversión / typo en nombre propio
    norm('SALAS MONTALVO MAGALI JUDTH'):   norm('SALAS MONTALVO JUDITH MAGALI'),
    norm('TINTTAYA CAHUANA PATRICIA'):     norm('TINTAYA CAHUANA PATRICIA HERMENEGILDA'),
    norm('CAYO HUAMANI BASILIO'):          norm('CAYO HUAMANI BACILIO ANTONIO'),
    norm('FLORES DOMINICA'):              norm('FLORES LAREDO DOMINICIA LUCIANA'),
    norm('PREÑA ASHLEY'):                 norm('PENA VILLANUEVA ASHLEY MARYORI'),
    # Traspasos de puesto: la deuda histórica va al nuevo titular
    norm('MARIN ILIZARDE BACILISA'):      norm('ISIDRO MARIN CARLOS DANIEL'),
    norm('RIOS RAMOS MANUEL ELOY'):       norm('PLAZA COSQUILLO ROSA ESTELA'),
    # MAYHUASCA BASTIDAS GLUDDY es MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE (puesto 135)
    # El fuzzy la asignaba erróneamente a MARILU (puesto 186). Corregido en 00039.
    norm('MAYHUASCA BASTIDAS GLUDDY'):    norm('MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE'),
}

# ─── Depósito puro: personas que SOLO tienen depósito (no están en SOCIOS/INQUILINOS)
DEPOSITO_ESPECIALES: dict[str, dict] = {
    # ACCO NOA VICTOR alquila 2 depositos (5-D3 y 6-D3, S/ 150 c/u).
    # CUENTAS lo lista con una sola linea de S/ 300 total.
    # Decision: consolidar toda la deuda en el primer deposito (5-D3).
    # El puesto 6-D3 inicia sin saldo inicial.
    norm('ACCO VICTOR'):     {'tipo': 'inquilino', 'codigo_puesto': '5-D3', 'nombre_db': 'ACCO NOA VICTOR'},
    norm('ACCO NOA VICTOR'): {'tipo': 'inquilino', 'codigo_puesto': '5-D3', 'nombre_db': 'ACCO NOA VICTOR'},
    norm('BUSTAMANTE JOSE'): {'tipo': 'inquilino', 'codigo_puesto': '4-D3', 'nombre_db': 'BUSTAMANTE JOSE'},
}

# ─── Exclusiones: deuda NO migrada (puesto inicia con S/ 0)
EXCLUIR: set[str] = {
    # Puesto 34-E: cambio de inquilino en enero; nuevo inquilino inicia con 0
    norm('DEISSY YESENIA LUJAN HUERTA'),
}

# ─── Hardcode directo: persona sin nombre en padron, puesto confirmado manualmente
HARDCODE_DIRECTO: dict[str, dict] = {
    # SATALAYA TAPULIMA ocupó puesto 32-E hasta may-2026; deuda del puesto se conserva
    norm('SEGUNDO ELVIS SATALAYA TAPULIMA'): {
        'tipo': 'inquilino',
        'codigo_puesto': '32-E',
        'nombre_db': 'SATALAYA TAPULIMA SEGUNDO ELVIS (traspaso a RENTERIA HUANCAS desde may-2026)',
    },
}


# =============================================================================
# 1. Leer padrón (SOCIOS + INQUILINOS únicamente — NO DEPOSITO)
# =============================================================================

print("── Leyendo padrón ───────────────────────────────────────────────────")

df_soc = pd.read_excel(EXCEL_PADRON, sheet_name='SOCIOS')
df_soc = df_soc.dropna(subset=['Apellidos y nombres']).copy()
df_soc['nombre_norm']   = df_soc['Apellidos y nombres'].apply(norm)
df_soc['codigo_puesto'] = df_soc['Puesto'].apply(lambda x: str(int(x)))
df_soc['tipo']          = 'socio'
df_soc['nombre_db']     = df_soc['Apellidos y nombres'].astype(str).str.strip()
print(f"  Socios en padron Excel: {len(df_soc)}")

df_inq = pd.read_excel(EXCEL_PADRON, sheet_name='INQUIINOS')
df_inq = df_inq.dropna(subset=['Apellidos y nombres']).copy()
df_inq['nombre_norm']   = df_inq['Apellidos y nombres'].apply(norm)
df_inq['codigo_puesto'] = df_inq['Puesto'].astype(str).str.strip()
df_inq['tipo']          = 'inquilino'
df_inq['nombre_db']     = df_inq['Apellidos y nombres'].astype(str).str.strip()
print(f"  Inquilinos en padron Excel: {len(df_inq)}")

# ─── Build padron lookup dict ─────────────────────────────────────────────────
# IMPORTANTE: NO incluimos DEPOSITO (evita sobrescribir entradas de SOCIOS/INQUILINOS)
padron: dict[str, dict] = {}
for _, r in df_soc.iterrows():
    padron[r['nombre_norm']] = {
        'tipo': r['tipo'], 'codigo_puesto': r['codigo_puesto'], 'nombre_db': r['nombre_db'],
    }
for _, r in df_inq.iterrows():
    padron[r['nombre_norm']] = {
        'tipo': r['tipo'], 'codigo_puesto': r['codigo_puesto'], 'nombre_db': r['nombre_db'],
    }

padron_keys = list(padron.keys())
print(f"  Total entradas en lookup (sin deposito): {len(padron)}")


# =============================================================================
# 2. Leer CUENTAS X COBRAR
# =============================================================================

print("\n── Leyendo Cuentas x Cobrar ─────────────────────────────────────────")

def read_cuentas_sheet(xls_path: str, sheet_name: str) -> pd.DataFrame:
    """
    Lee una hoja de CUENTAS X COBRAR. Estructura:
      Fila 0 (física): Título
      Fila 1 (física): Etiquetas (ITEM, NOMBRE, LUZ, …, DEUDA TOTAL)
      Fila 2+         : Datos
    Retorna DataFrame con: ITEM (int), nombre_excel (str), deuda_total (float)
    """
    raw = pd.read_excel(xls_path, sheet_name=sheet_name, header=None)

    # Buscar fila con "ITEM" en las primeras 3 columnas
    header_idx = None
    for i, row in raw.iterrows():
        for ci in range(min(3, len(row))):
            if str(row.iloc[ci]).strip().upper().replace('\n', ' ') == 'ITEM':
                header_idx = i
                break
        if header_idx is not None:
            break
    if header_idx is None:
        raise ValueError(f"No se encontro fila con 'ITEM' en hoja '{sheet_name}'")

    col_names = [
        str(v).strip().replace('\n', ' ') if pd.notna(v) else ''
        for v in raw.iloc[header_idx]
    ]
    data = raw.iloc[header_idx + 1:].copy()
    data.columns = col_names

    # Normalizar nombre de columna ITEM (puede venir en minúsculas)
    rename_map = {c: c.upper().strip() for c in data.columns if str(c).strip().upper() == 'ITEM'}
    data = data.rename(columns=rename_map)

    data = data[pd.to_numeric(data['ITEM'], errors='coerce').notna()].copy()
    data['ITEM'] = pd.to_numeric(data['ITEM']).astype(int)

    nombre_col = data.columns[2]
    deuda_col  = next((c for c in data.columns if 'DEUDA' in str(c).upper() and 'TOTAL' in str(c).upper()), None)
    if deuda_col is None:
        raise ValueError(f"No se encontro columna 'DEUDA TOTAL' en '{sheet_name}'")

    data['nombre_excel'] = data[nombre_col].astype(str).str.strip()
    data['deuda_total']  = pd.to_numeric(data[deuda_col], errors='coerce').fillna(0)

    data = data[~data['nombre_excel'].isin(['nan', 'NaN', '', 'None'])]
    data = data[data['deuda_total'] > 0]

    return data[['ITEM', 'nombre_excel', 'deuda_total']].reset_index(drop=True)


df_ct_socios = read_cuentas_sheet(EXCEL_CUENTAS, 'ANEXO-1 N.5 SOCIOS -Pg-21-25')
df_ct_inq    = read_cuentas_sheet(EXCEL_CUENTAS, 'ANEXO 2- N6 IN-pg 26-27')
print(f"  Socios con deuda en cuentas:     {len(df_ct_socios)}")
print(f"  Inquilinos con deuda en cuentas: {len(df_ct_inq)}")


# =============================================================================
# 3. Matching: nombre Excel ↔ padrón
# =============================================================================

print("\n── Matching nombres ─────────────────────────────────────────────────")

def find_match(nombre_excel: str) -> tuple[dict | None, str | None, str]:
    """
    Matching en cascada. Retorna (match_dict, match_type, nombre_normalizado).
    match_type = 'EXCLUIDA' significa: ignorar esta persona (no es huerfano).
    """
    n_raw   = norm(nombre_excel)
    n_clean = norm(clean_excel_name(nombre_excel))

    # 0. Exclusión explícita
    if n_raw in EXCLUIR or n_clean in EXCLUIR:
        return None, 'EXCLUIDA', n_clean

    # 1. Hardcode directo (persona confirmada manualmente, sin entrada en padron)
    for key_n in (n_raw, n_clean):
        if key_n in HARDCODE_DIRECTO:
            return HARDCODE_DIRECTO[key_n], 'hardcode', key_n

    # 2. Deposito especial (ACCO, BUSTAMANTE — solo deposito)
    for key_n in (n_raw, n_clean):
        if key_n in DEPOSITO_ESPECIALES:
            return DEPOSITO_ESPECIALES[key_n], 'deposito_especial', key_n

    # 3. Alias manual → buscar en padron con el nombre corregido
    for key_n in (n_raw, n_clean):
        if key_n in ALIASES:
            alias_n = ALIASES[key_n]
            if alias_n in padron:
                return padron[alias_n], f'alias', key_n

    # 4. Exact match (raw)
    if n_raw in padron:
        return padron[n_raw], 'exact', n_raw

    # 5. Exact match (limpio, sin sufijos)
    if n_clean in padron:
        return padron[n_clean], 'exact_clean', n_clean

    # 6. Token-subset: todos los tokens del Excel están en el nombre del padron
    for key in padron_keys:
        if token_subset_match(n_clean, key) or token_subset_match(n_raw, key):
            return padron[key], 'token_subset', n_clean

    # 7. Fuzzy (sobre nombre limpio)
    close = difflib.get_close_matches(n_clean, padron_keys, n=1, cutoff=0.80)
    if close:
        return padron[close[0]], 'fuzzy', n_clean

    return None, None, n_clean


matcheados: list[dict] = []
huerfanos:  list[dict] = []
excluidos:  list[dict] = []

def process_sheet(df: pd.DataFrame, hoja: str) -> None:
    for _, row in df.iterrows():
        nombre = str(row['nombre_excel']).strip()
        deuda  = float(row['deuda_total'])
        item   = int(row['ITEM'])
        match, match_type, nombre_norm = find_match(nombre)

        if match_type == 'EXCLUIDA':
            excluidos.append({'hoja': hoja, 'item': item, 'nombre_excel': nombre,
                              'deuda_total': deuda, 'motivo': 'exclusion_explicita'})
        elif match:
            matcheados.append({
                'hoja': hoja, 'item': item,
                'tipo': match['tipo'], 'codigo_puesto': match['codigo_puesto'],
                'nombre_db': match['nombre_db'], 'nombre_excel': nombre,
                'nombre_norm': nombre_norm, 'deuda_total': deuda,
                'match_type': match_type,
            })
        else:
            huerfanos.append({'hoja': hoja, 'item': item, 'nombre_excel': nombre,
                              'nombre_norm': nombre_norm, 'deuda_total': deuda})


process_sheet(df_ct_socios, 'SOCIOS')
process_sheet(df_ct_inq,    'INQUILINOS')

print(f"  Matcheados: {len(matcheados)}")
print(f"  Excluidos:  {len(excluidos)} (deuda = 0 por decision de negocio)")
print(f"  Huerfanos:  {len(huerfanos)}")


# =============================================================================
# 4. Guardar CSVs
# =============================================================================

df_m = pd.DataFrame(matcheados)
df_h = pd.DataFrame(huerfanos)
df_e = pd.DataFrame(excluidos)

df_m.to_csv(os.path.join(OUTPUT_DIR, 'saldos_iniciales_matcheados.csv'), index=False, encoding='utf-8-sig')
df_h.to_csv(os.path.join(OUTPUT_DIR, 'saldos_iniciales_huerfanos.csv'),  index=False, encoding='utf-8-sig')
df_e.to_csv(os.path.join(OUTPUT_DIR, 'saldos_iniciales_excluidos.csv'),  index=False, encoding='utf-8-sig')

suma_matcheados  = float(df_m['deuda_total'].sum()) if len(df_m) else 0.0
suma_excluidos   = float(df_e['deuda_total'].sum()) if len(df_e) else 0.0
suma_total_excel = float(df_ct_socios['deuda_total'].sum()) + float(df_ct_inq['deuda_total'].sum())

print(f"\n  Suma deudas matcheadas:   S/ {suma_matcheados:.2f}")
print(f"  Suma excluidas (no migra): S/ {suma_excluidos:.2f}")
print(f"  Suma total Excel:          S/ {suma_total_excel:.2f}")
print(f"  Balance:                   S/ {suma_matcheados + suma_excluidos:.2f} / {suma_total_excel:.2f}")


# =============================================================================
# 5. Generar SQL 00038
# =============================================================================

print("\n── Generando SQL 00038 ──────────────────────────────────────────────")

def build_sql() -> str:
    lines: list[str] = []
    now_str = datetime.now().strftime('%Y-%m-%d %H:%M')

    lines += [
        "-- =============================================================================",
        "-- Migracion 00038 - Saldos Iniciales al 31-12-2025 (Go-Live 01-01-2026)",
        "-- Cooperativa Primero de Mayo - SistemaCooperativa",
        f"-- Generado: {now_str}",
        f"-- Personas con saldo: {len(df_m)}",
        f"-- Suma total migrada: S/ {suma_matcheados:.2f}",
        f"-- Excluidas (deuda 0): {len(df_e)} persona(s) - S/ {suma_excluidos:.2f}",
        f"-- Huerfanos sin match: {len(df_h)}",
        "-- =============================================================================",
        "",
        "BEGIN;",
        "",
        "-- --- Concepto 'Saldo Inicial 2025' ----------------------------------------",
        "INSERT INTO public.conceptos (nombre, tipo, aplica_descuento, activo, descripcion)",
        "VALUES (",
        "    'Saldo Inicial 2025',",
        "    'Variable',",
        "    false,",
        "    true,",
        "    'Saldo de apertura al 31-12-2025. Una fila consolidada por puesto. '",
        "    || 'El detalle del concepto que se esta pagando se captura en '",
        "    || 'pagos.observacion al momento del cobro.'",
        ")",
        "ON CONFLICT (nombre) DO NOTHING;",
        "",
        "-- --- Saldos iniciales por puesto -------------------------------------------",
        "-- Cada bloque DO es atomico. Puesto no encontrado emite WARNING y continua.",
        "",
    ]

    for block_num, (_, row) in enumerate(df_m.iterrows(), start=1):
        codigo  = sql_esc(str(row['codigo_puesto']))
        nombre  = sql_esc(str(row['nombre_db']))
        tipo    = str(row['tipo']).upper()
        deuda   = float(row['deuda_total'])
        hoja    = str(row['hoja'])
        mtype   = str(row['match_type'])

        lines += [
            f"-- [{block_num}] {tipo}: {nombre} | Puesto {codigo} | S/ {deuda:.2f} ({hoja} / {mtype})",
            f"DO $b{block_num}$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN",
            f"    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '{codigo}' AND deleted_at IS NULL LIMIT 1;",
            "    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;",
            "    IF v_puesto IS NULL THEN",
            f"        RAISE WARNING 'Puesto % no encontrado, omitiendo [{nombre}]', '{codigo}';",
            "    ELSE",
            "        INSERT INTO public.montos_por_cobrar",
            "            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)",
            "        VALUES",
            f"            (v_puesto, v_concepto, 2025, 12, {deuda:.2f}, 'Pendiente', 'Manual', '2025-12-31'::date,",
            f"             'Saldo inicial migrado al 31-12-2025 · {nombre}')",
            "        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)",
            "            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL",
            "        DO NOTHING;",
            "    END IF;",
            f"END $b{block_num}$;",
            "",
        ]

    lines += [
        "-- --- Verificacion post-INSERT ----------------------------------------------",
        "DO $$",
        "DECLARE",
        "    v_count   integer;",
        "    v_suma    numeric;",
        f"    v_exp_cnt integer := {len(df_m)};",
        f"    v_exp_sum numeric  := {suma_matcheados:.2f};",
        "BEGIN",
        "    SELECT count(*), COALESCE(sum(monto), 0)",
        "    INTO v_count, v_suma",
        "    FROM public.montos_por_cobrar",
        "    WHERE concepto_id = (SELECT id FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025')",
        "      AND deleted_at IS NULL;",
        "",
        "    RAISE NOTICE '=================================================';",
        "    RAISE NOTICE '00038 Saldos Iniciales 2025 - Verificacion';",
        "    RAISE NOTICE 'Filas en BD:  %  (esperado: %)',  v_count, v_exp_cnt;",
        "    RAISE NOTICE 'Suma en BD:   S/ %  (esperado: S/ %)', v_suma, v_exp_sum;",
        "    IF v_count <> v_exp_cnt THEN",
        "        RAISE WARNING 'DISCREPANCIA en cantidad de filas';",
        "    END IF;",
        "    RAISE NOTICE '=================================================';",
        "END $$;",
        "",
        "COMMIT;",
    ]

    return '\n'.join(lines)


sql_content = build_sql()
sql_path = os.path.join(SQL_DIR, '00038_saldos_iniciales_2025.sql')
with open(sql_path, 'w', encoding='utf-8') as f:
    f.write(sql_content)

print(f"  -> {sql_path}")


# =============================================================================
# 6. Resumen final
# =============================================================================

print("\n==============================================")
print("RESUMEN FINAL")
print("==============================================")
print(f"  Matcheados:     {len(df_m):>5}  (S/ {suma_matcheados:.2f})")
print(f"  Excluidos:      {len(df_e):>5}  (S/ {suma_excluidos:.2f}) - deuda no heredada")
print(f"  Huerfanos:      {len(df_h):>5}  <- deben ser 0")
print(f"  Total Excel:    S/ {suma_total_excel:.2f}")

if len(df_h) > 0:
    print("\n  HUERFANOS (aun sin match):")
    print(df_h[['hoja', 'item', 'nombre_excel', 'deuda_total']].to_string(index=False))

if len(df_e) > 0:
    print("\n  EXCLUIDOS (deuda = 0):")
    for _, r in df_e.iterrows():
        print(f"    [{r['hoja']}] {r['nombre_excel']} - S/ {r['deuda_total']:.2f}")

# Verificar bugs de deposito (SOCIOS mal asignados a puestos -D)
bugs = df_m[df_m['codigo_puesto'].str.contains('-D', na=False) & (df_m['hoja'] == 'SOCIOS')]
if len(bugs) > 0:
    print("\n  ATENCION - Socios asignados a deposito (revisar):")
    for _, r in bugs.iterrows():
        print(f"    {r['nombre_db']} -> puesto {r['codigo_puesto']}")
else:
    print("\n  OK: No hay socios mal asignados a deposito.")

print("\n  Archivos generados:")
print(f"  -> migracion_coop/saldos_iniciales_matcheados.csv")
print(f"  -> migracion_coop/saldos_iniciales_huerfanos.csv")
print(f"  -> migracion_coop/saldos_iniciales_excluidos.csv")
print(f"  -> supabase/migrations/00038_saldos_iniciales_2025.sql")
print("==============================================")
print("Proximos pasos:")
print("  1. Verificar que huerfanos = 0")
print("  2. Backup: supabase db dump -f backup_pre_golive_FECHA.sql")
print("  3. Aplicar: supabase db push")
print("==============================================")
