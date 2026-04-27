# Reporte de Calidad de Datos — SistemaCooperativa

Generado: 2026-04-26 13:16
Archivos analizados: `Luz setiembre.xlsx` · `AGUA octubre (1).xlsx`


## Luz Setiembre — Análisis por Hoja

### Hoja: 'SETIEMBRE CON MEDIDORES SOCIOS' (lecturas de medidor)
- Precio KWH detectado en encabezado: **0.75**
- Método: diferencia de lecturas (lectura_oct - lectura_ago)
- Filas OK: 114 | Mismatches de puesto: 0 | Errores cálculo: 0

### Hoja: 'socios sin medidores' (amperaje)
- Precios KWH detectados por fila: **[0.78]**
- Filas OK: 0 | Mismatches de puesto: 11 | Errores cálculo: 73
- Columna alumbrado separada: NO detectada (Sub-Total = KWH × precio_kwh)

  **Mismatches:**
  - `13` → `` (Cardeña Villafuerte Alejandrin)
  - `25` → `` (Lagos Luna de Leiva Zaida)
  - `54` → `` (Juan Valverde Rosas (CERRADO))
  - `None` → `` (escalera castillo)
  - `None` → `` (Renovadora 2E)
  - `None` → `` (LUZ DE JUNIO SIN ALUMBRADO)
  - `None` → `` (SOCIOS SIN MEDIDORES)
  - `None` → `` (SOCIOS CON MEDIDORES)
  - `None` → `` (INQUILINOS)
  - `None` → `` (RECIBO DE LUZ DE JUNIO)
  - `None` → `` (Luz que asume la cooperativa)

  **Errores de cálculo (diff > 1%):**
  - puesto=1 amp=2.4 | None | SubTotal esperado=148.26 Excel=142.56
  - puesto=2 amp=1.3 | None | SubTotal esperado=80.31 Excel=77.22
  - puesto=3 amp=1.09 | None | SubTotal esperado=67.34 Excel=64.75
  - puesto=4 amp=1.4 | KWH esperado=110.880 Excel=147.840 diff=25.0% | SubTotal esperado=115.32 Excel=110.88
  - puesto=5 amp=2.5 | None | SubTotal esperado=154.44 Excel=148.50
  - puesto=6 amp=1.2 | None | SubTotal esperado=74.13 Excel=71.28
  - puesto=8 amp=1.6 | None | SubTotal esperado=98.84 Excel=95.04
  - puesto=9 amp=1.7000000000000002 | None | SubTotal esperado=105.02 Excel=100.98
  - puesto=10 amp=0.375 | None | SubTotal esperado=23.17 Excel=22.27
  - puesto=11 amp=2.145 | None | SubTotal esperado=132.51 Excel=127.41
  - puesto=12 amp=0.375 | None | SubTotal esperado=23.17 Excel=22.27
  - puesto=14 amp=0.6 | None | SubTotal esperado=37.07 Excel=35.64
  - puesto=15 amp=0.63 | None | SubTotal esperado=38.92 Excel=37.42
  - puesto=16 amp=0.73 | None | SubTotal esperado=45.10 Excel=43.36
  - puesto=17 amp=1.9 | None | SubTotal esperado=117.37 Excel=112.86

### Hoja: 'Hoja1' (amperaje, versión revisada con precio distinto)
- Precios KWH detectados: **[0.75]**
- Filas OK: 67 | Mismatches: 6 | Errores: 6
- Nota: Esta hoja parece una revisión de 'socios sin medidores'. Evaluaremos si usar esta o la anterior.

  **Errores de cálculo (muestra):**
  - p=4 amp=1.4: KWH esperado=110.880 Excel=147.840 diff=25.0%
  - p=20 amp=3.8: KWH esperado=300.960 Excel=401.280 diff=25.0%
  - p=23 amp=1.07: KWH esperado=84.744 Excel=98.868 diff=14.3%
  - p=26 amp=0.825: KWH esperado=65.340 Excel=87.120 diff=25.0%
  - p=33 amp=1.0: KWH esperado=79.200 Excel=92.400 diff=14.3%
  - p=55 amp=0.65: KWH esperado=51.480 Excel=60.060 diff=14.3%

### Hoja: 'INQUILINOS SETIEMBRE' (lecturas de medidor, inquilinos)
- Precio KWH detectado: **0.77**
- Filas OK: 54 | Mismatches: 3 | Errores: 0

  **Mismatches:**
  - `None` → `` (QUISPE CHAVEZ MARISOL)
  - `None` → `` (HERRERA PEVES ROMINA DEL CARME)
  - `None` → `` (INQUILINOS)


## Agua Octubre — Análisis por Hoja

### Hoja: 'AGUA OCTUBRE CON MEDIDORES'
- Costo por m³ detectado: **[12.7528]** (S/ por m³)
- Filas OK: 80 | Mismatches puesto: 11 | Errores cálculo: 0

  **Mismatches:**
  - `None` (CAMPUZANO CABELLO VICENTA DONA)
  - `None` (CARTAGENA BENJAMIN)
  - `None` (CARTAGENA PALOMINO ALVARO)
  - `None` (JUAREZ LEONOR)
  - `None` (MEDINA MEDRANO JUAN CARLOS)
  - `None` (ARMESTAR GODOS JUANA)
  - `None` (GOMEZ MITMA MARIBEL)
  - `None` (HERRERA PEVES ROMINA DEL CARME)
  - `None` (BAÑO)
  - `None` (NO USA SU MEDIDOR)
  - `None` (PARTE CONSTRUIDO)

### Hoja: 'Agua de octubre' (monto fijo por socio, sin código puesto)
- Montos únicos detectados: [4.0, 6.0, 7.0, 8.0, 9.08, 10.0, 10.28, 10.43, 10.5, 10.61, 10.65, 10.92, 12.0, 12.42, 12.43, 12.73, 13.0, 13.2, 13.52, 15.0]
- Total de registros con nombre: 250
- Nota: Esta hoja NO tiene código de puesto → se cruzará por nombre de socio/inquilino.

### Hoja: 'Hoja1' de Agua (revisión, montos posiblemente actualizados)
- Montos únicos: [6.0, 7.0, 8.0, 9.08, 10.0, 10.28, 10.43, 10.5, 10.61, 10.65, 10.92, 12.0, 12.42, 12.43, 12.73, 13.0, 13.2, 13.52, 15.0, 16.2]
- Total registros: 250

## Análisis de Precios y Alumbrado

**Discrepancias entre Sub-Total Excel y KWH×precio (11 casos):**
  → Esto indica que Sub-Total en esta hoja incluye un componente de alumbrado.

  - amp=2.4 | KWH_calc=190.08 | P=0.78 | Esperado=148.26 | Excel=142.56 | **delta=-5.7**
  - amp=1.3 | KWH_calc=102.96 | P=0.78 | Esperado=80.31 | Excel=77.22 | **delta=-3.09**
  - amp=1.09 | KWH_calc=86.328 | P=0.78 | Esperado=67.34 | Excel=64.74600000000001 | **delta=-2.59**
  - amp=1.4 | KWH_calc=110.88 | P=0.78 | Esperado=86.49 | Excel=110.88 | **delta=24.39**
  - amp=2.5 | KWH_calc=198.0 | P=0.78 | Esperado=154.44 | Excel=148.5 | **delta=-5.94**
  - amp=1.2 | KWH_calc=95.04 | P=0.78 | Esperado=74.13 | Excel=71.28 | **delta=-2.85**
  - amp=1.6 | KWH_calc=126.72 | P=0.78 | Esperado=98.84 | Excel=95.03999999999999 | **delta=-3.8**
  - amp=1.7000000000000002 | KWH_calc=134.64 | P=0.78 | Esperado=105.02 | Excel=100.98000000000003 | **delta=-4.04**
  - amp=0.375 | KWH_calc=29.7 | P=0.78 | Esperado=23.17 | Excel=22.275 | **delta=-0.9**
  - amp=2.145 | KWH_calc=169.884 | P=0.78 | Esperado=132.51 | Excel=127.41299999999997 | **delta=-5.1**

  Delta mín/máx: -5.94 / 24.39 (probable monto_alumbrado fijo)
  Media delta: -0.96 S/

## Casos Extremos — Luz

**Top 5 puestos por amperaje:**
  - Puesto 20: amp=3.8 A → KWH_calc=301.0 (excel=401.3)
  - Puesto 20: amp=3.8 A → KWH_calc=301.0 (excel=401.3)
  - Puesto 75: amp=3.48 A → KWH_calc=275.6 (excel=275.6)
  - Puesto 75: amp=3.48 A → KWH_calc=275.6 (excel=275.6)
  - Puesto 53: amp=2.675 A → KWH_calc=211.9 (excel=211.9)

**Top 5 puestos menor amperaje (> 0):**
  - Puesto 49: amp=0.22 A → KWH_calc=17.4
  - Puesto 49: amp=0.22 A → KWH_calc=17.4
  - Puesto 62: amp=0.25 A → KWH_calc=19.8
  - Puesto 62: amp=0.25 A → KWH_calc=19.8
  - Puesto 46: amp=0.275 A → KWH_calc=21.8

## Veredicto y Recomendaciones para 00007

| Archivo | Total filas | OK (match) | Mismatch | Errores calc | Mismatch % |
|---|---|---|---|---|---|
| Luz (todas las hojas) | 334 | 235 | 20 | 79 | **6.0%** |
| Agua (con código puesto) | 591 | 580 | 11 | — | **1.9%** |

⚠️  **Mismatches entre 5-15% → revisar lista y decidir qué hacer con los huérfanos.**

**Estrategia recomendada por fuente:**
| Hoja | Método | Tabla | Periodo |
|---|---|---|---|
| socios sin medidores (Tipo=SOCIO) | Amperaje → mediciones_luz | mediciones_luz + montos_por_cobrar | 2025-09 |
| socios sin medidores (Tipo=INQUILINO) | Amperaje → mediciones_luz | mediciones_luz + montos_por_cobrar | 2025-09 |
| SETIEMBRE CON MEDIDORES SOCIOS | Medidor → registro_artefactos | registro_artefactos + montos_por_cobrar | 2025-09 |
| INQUILINOS SETIEMBRE | Medidor → registro_artefactos | registro_artefactos + montos_por_cobrar | 2025-09 |
| AGUA OCTUBRE CON MEDIDORES | Medidor agua | montos_por_cobrar (Fijo) | 2025-10 |
| Agua de octubre (sin código puesto) | Monto fijo | montos_por_cobrar (cruzar por nombre) | 2025-10 |