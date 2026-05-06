-- =============================================================================
-- Seed: Inyección de Deudas Iniciales — Go-Live Mayo 2026  (v4 — padrón real)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-05-05 a partir de listapersonascoop.xlsx
-- =============================================================================
-- INSTRUCCIONES:
--   1. Rellena los montos reales del CSV en las dos secciones marcadas con ▼▼▼.
--   2. Ejecuta en Supabase Studio → SQL Editor (es un único DO block).
--   3. La búsqueda es por ILIKE en apellidos — si hay ambigüedad, ajusta el nombre.
--
-- MAPEO:
--   ga_ps    → Gastos administrativos  → puesto del socio (via historial_titularidad)
--   luz_agua → Deuda anterior          → puesto del socio
--   deposito → Aporte extraordinario   → puesto del socio
--   multas   → Multa                   → socio directamente (deuda personal)
-- =============================================================================

DO $$
DECLARE
    c_ga   bigint;
    c_luz  bigint;
    c_dep  bigint;
    c_mul  bigint;
    v_fp   integer;   -- filas de puesto insertadas
    v_fm   integer;   -- filas de multa insertadas
BEGIN
    -- Resolución de IDs de conceptos
    SELECT id INTO c_ga  FROM public.conceptos WHERE nombre = 'Gastos administrativos';
    SELECT id INTO c_luz FROM public.conceptos WHERE nombre = 'Deuda anterior';
    SELECT id INTO c_dep FROM public.conceptos WHERE nombre = 'Aporte extraordinario';
    SELECT id INTO c_mul FROM public.conceptos WHERE nombre = 'Multa';
    IF c_ga IS NULL THEN RAISE EXCEPTION 'Concepto "Gastos administrativos" no encontrado'; END IF;
    IF c_luz IS NULL THEN RAISE EXCEPTION 'Concepto "Deuda anterior" no encontrado'; END IF;
    IF c_dep IS NULL THEN RAISE EXCEPTION 'Concepto "Aporte extraordinario" no encontrado'; END IF;
    IF c_mul IS NULL THEN RAISE EXCEPTION 'Concepto "Multa" no encontrado'; END IF;

    -- =====================================================================
    -- BLOQUE A — Deudas de PUESTO (GA/PS, Luz/Agua, Depósito)
    -- Busca el puesto_id vía JOIN LATERAL sobre apellidos del socio.
    -- =====================================================================
    INSERT INTO public.montos_por_cobrar
        (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, observacion)
    SELECT
        ht.puesto_id,
        NULL,
        t.concepto_id,
        2026, 5,
        t.monto,
        'Pendiente', 'Manual', CURRENT_DATE, 'Deuda Go-Live May-2026'
    FROM (VALUES
-- ▼▼▼ DATOS PUESTO (nombre_socio, ga_ps, luz_agua, deposito) ▼▼▼
-- Rellena los 0.00 con los montos reales. Deja 0.00 si no tiene deuda en ese rubro.
-- El nombre es el APELLIDO Y NOMBRE del Excel — búsqueda por ILIKE '%nombre%'.
        ('Huamani Romero Donatila', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Limas Vargas Carmen Rosa', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Romero Ninahuaman Javier', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Sosa Valdivia Juana Isabel', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Medina Jota Vicenta', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Salas Montalvo Ruth', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Uretra Cruz Emilia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Huashuayo Gomez Eudosia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ayala Toboada Eliseo', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ayala Huashuayo Norma Gladys', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Cardeña Villafuerte Alejandrina', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Falcon Chiara Hector  Marcial', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Burga Carrasco Elida', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Cuya Sanchez Alberto', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ccoyllo Bustillos Deysi Karen', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Castro Gutierrez Aquila Lucrecia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Paredes Morales Diana', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Javier Sermeño Gutierrez', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Valero Pariona Maximo', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Valero Soto Willy Perseo Albino', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Yaurimucha Rimachi Marcos', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Flores Yato Francisca Dolores', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Lagos Luna de Leiva Zaida', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Taype Oquendo Eugenio Joel', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Clemente Aller Cirila', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Paredes Morales Oscar Martín', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Pacompia Cardeña Giovanni', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Quispe Uribe Luciano', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Marin Huaman de Salamanca Maria', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Pittman Concepción Nelly Maria', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Segovia Villafuerte de Ponce', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Espejo Urbano Rosa Florencia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Sanchez Astos de Torres Yolanda Sofia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Cabero Mendoza Gloria', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Salas Montalvo Magali Judith', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Gutierrez Flores Roger Reyman', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Perez Quispe Epifania', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Rojas Ignacio Leonila', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Prado Llancari Zozima', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Saavedra Curipuma Luis Humberto', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Tello Alvarez Marino', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Juarez Cuellar Leonor', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ancco Leon Valentina', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ccoyllo Polanco German', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Jara Alvarez Maria Cenaida', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Rodriguez Arquiñego Idilio Félix', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Paredes Flores Oscar', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Juan Valverde Rosas (CERRADO)', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ccoyllo Chinchay Judith', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Calle Calle Fidel', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Davila Cahuana Marisol', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Estela Calderon Torres', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Alarcon Anampa Nancy Gisela', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Anampa Corahua Clemencia Migdonia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ñahui Ruiz Aurelio', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Ccoyllo Chinchay Daniel Masia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Alarcon Anampa Betsy', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Bravo Heredia Ana Maritza', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Sanchez Soto Lucia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Yruipalla Falcon Hilda', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Chuchuyo Hacha José', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Soria Tapia Edith Catalina', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Rivera Callpa Juana Regis', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Torres Anyorsa Marcelino', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Cuevas Mayo Enrique', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Tintaya Cahuana Patricia', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Alvarez Campos Rolando', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Bastidas Medina Dina', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Carrasco Salvatierra Felicitas', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Cajaleon Carrasco Luis Enrique', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('Chirinos Cabracancha María', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('HUAYHUALLA DE LOPEZ DONATILA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('QUISPE COPAYO  ELIO CARLOS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('RODRIGUEZ CORDOVA MARCOS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('HUAMAN YNCA VISITACION', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('TORRES ASTO FRANCISCO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MAYHUASCA BASTIDAS ULISES', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CARTAGENA MAMANI BENJAMIN', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('PEREZ PONCE SATURNINA MARGARITA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('PALOMINO HANCCO CECILIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ZAPATA RIVERA ROSANA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('PLAZA COSQUILLO ROSA ESTELA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('QUISPE CONSA MIGUEL', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('TINEO CABRERA SONIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CHALLCO DE PALOMINO NICOLAZA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('PALOMINO TENORIO SILVIO EDUARDO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CULE CARRASCO HAYDEE MONICA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('YRUPAILLA ANAMPA ISIDRO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VALENCIA TOMAS VICENTE', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('TORRES ASTO NERY (F)', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('RIVERA FERNANDEZ MARINA MAXILIANA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('FLORES FLORES UMBELINA DORA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MAYHUASCA BASTIDAS MARILU', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ORTIZ ÑAUPA WELINTONH', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ESTRADA OSCAR', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MEDINA MEDRANO JUAN CARLOS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('RICSE SAYES TERESA REYNA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CCOYLLO POLANCO DANIEL', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CCOYLLO MAYHUASCA ALEXIS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MALLQUI JULCA ALEJANDRINO TEODORO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('GUTIERREZ CASTILLO  JORGE', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CHOQUEHUAMANI FELIX CEFERINO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('GELDRES REVILLA MIGUEL', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VARA DE ROSAS ALICIA VALENTINA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MAYHUASCA BASTIDAS CLUDDY', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('NICHO LOPEZ ESTHEPANY CARICIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('JARA ALVARES CRISTALINA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CRUZ JARAMILLO LUIS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CALDERON VERA SEGUNDO ALCIDES', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CARPIO VASQUEZ TEOFILA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VILLANUEVA INGA DE VASQUEZ ROSA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VICENTE CALIXTO JOSE ALBERTO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ZAPATA  VELIT VICTORIANO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('AGUIRRE QUISPE WILFREDO GILMER', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('OQUENDO ARISACA MELESIA ROSARIO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CABALLERO CALZADO GLADYS VICTORIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CORDOVA PEREZ MARCO ANTONIO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VILCHEZ GUTARRA LOURDES FANNY', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CASTRO ALEJANDRO HORTENCIA LUCILA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ALVAREZ MARIN MARIANELA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('QUISPE CONSA VIDAL', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ESTELA SUAREZ ELVIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MESIA CRUZ GLADYS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VARA CASTRO ERNESTINA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('QUISPE DE PALOMINO DOROTEA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('PALOMINO VELASQUEZ EUSEBIO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MAYTA COLQUI VIOLETA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('GUTIERREZ CASTRO JORGE', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ALHUAY PALOMINO DE ALHUAY JUANA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ORDOÑEZ NICHO AZUL CARILE', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('LOPEZ HUAYHUALLA NELLY NATIVIDAD', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CAHUANA VDA DE DAVILA VICENTINA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('OQUENDO QUISPE MIGUEL', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('OJEDA CAMPOS EDSON', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('REYES SANCHEZ MILENA GERALDINE', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('GAVILAN MOSQUERA NORMA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MARIN LONDOÑE MARIA LUZ', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CARTAGENA PALOMINO ALVARO BENJAMIN', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ISIDRO MARIN CARLOS DANIEL', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('TITO FALCON JESUSA RICARDINA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MELO BACA MARINA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('RAMOS CUEVA PEDRO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('SALVATIERRA AYALA ALLISON', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('QUISPE DURAN ADRIANA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('RODRIGUEZ MORENO NORA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ATANASIO ORTEGA MAXIMILIANA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('OQUENDO QUISPE JESSICA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ROMERO YSLA ESTEBAN LIDIO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CALLE ALVAREZ MARCO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MALLQUI LOPEZ LIZBETH', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('PORRAS DE OROYA OLIMPIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('BASTIDAS MEDINA HERMEREGILDO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('QUINTANA VIDAL GLICERIO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('HERMELINDA MAYTA MATOS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('TORRES ASTO VDA DE CALDERON JUANA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MORENO CHAVEZ RAFAEL FREDY', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('JARA ALVAREZ SANTOS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('SOTO VARGAS DE FLORES MARIA DEL CARMEN', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CERDA YUPANQUI CARMEN ROSA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('SANTILLAN MESIA ZOILA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VALLEJOS HUAMAN MARIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('HEREDIA MUÑOZ DE BRAVO MARIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ALVAREZ CAMPOS VICTOR', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('LUJAN GONZALES MARINO JUAN', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CUCHO DE LA CRUZ SAUL', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MEDINA GUITIERRES HONORATA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CUSI LAURA SONIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ROMERO FLORES EDDNA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CORNEJO DONATO DE CORDOVA ESTELA PILAR', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('DE LA CRUZ ESTEBAN JOSE', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('SALAZAR CONCEPCION VICTORIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('ROJAS CORNEJO ERICK', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('BERNAOLA DE PRADO FLORENCIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('GUTIERREZ CASTILLO  TERESA JESUS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('SANCHEZ RODRIGUEZ JUDITH', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('SOTO GALLEGO DE VALERO', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('TELLO QUINTANA EDGAR', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('HALIRE YUCRA JOSUE', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('CAMPUZANO CABELLO VICENTA DONATILA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MARIN ROCHA ESTEFANY', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('REYES PEREZ DE VALENCIA NANCY', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('FLORES FLORES IRENE BERTILIA', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('VALERO SOTO  MAXIMO ELIAS', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('QUISPE ORTEGA ROSA CARMEN', 0.00::numeric, 0.00::numeric, 0.00::numeric),
        ('MARIN LONDOÑE EDUARDO SANTIAGO', 0.00::numeric, 0.00::numeric, 0.00::numeric)
-- ▲▲▲ FIN DATOS BLOQUE A ▲▲▲
    ) AS d(nombre, ga_ps, luz_agua, deposito)
    -- JOIN LATERAL: busca el puesto del socio cuyo apellidos coincida con el nombre
    JOIN LATERAL (
        SELECT ht2.puesto_id
        FROM public.historial_titularidad ht2
        JOIN public.socios s ON s.id = ht2.socio_id
        WHERE s.apellidos ILIKE '%' || d.nombre || '%'
          AND ht2.fecha_fin IS NULL
        LIMIT 1
    ) AS ht ON true
    -- CROSS JOIN expande 3 conceptos por fila (ga_ps, luz_agua, deposito)
    CROSS JOIN LATERAL (VALUES
        (c_ga,  d.ga_ps),
        (c_luz, d.luz_agua),
        (c_dep, d.deposito)
    ) AS t(concepto_id, monto)
    WHERE t.monto > 0
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;

    GET DIAGNOSTICS v_fp = ROW_COUNT;

    -- =====================================================================
    -- BLOQUE B — Deudas personales del SOCIO (Multas / Otros)
    -- Busca directamente el socio_id por apellidos.
    -- =====================================================================
    INSERT INTO public.montos_por_cobrar
        (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, observacion)
    SELECT
        NULL,
        s.id,
        c_mul,
        2026, 5,
        d.multas,
        'Pendiente', 'Manual', CURRENT_DATE, 'Deuda Go-Live May-2026 — Multa'
    FROM (VALUES
-- ▼▼▼ DATOS MULTAS (nombre_socio, multas) ▼▼▼
        ('Huamani Romero Donatila', 0.00::numeric),
        ('Limas Vargas Carmen Rosa', 0.00::numeric),
        ('Romero Ninahuaman Javier', 0.00::numeric),
        ('Sosa Valdivia Juana Isabel', 0.00::numeric),
        ('Medina Jota Vicenta', 0.00::numeric),
        ('Salas Montalvo Ruth', 0.00::numeric),
        ('Uretra Cruz Emilia', 0.00::numeric),
        ('Huashuayo Gomez Eudosia', 0.00::numeric),
        ('Ayala Toboada Eliseo', 0.00::numeric),
        ('Ayala Huashuayo Norma Gladys', 0.00::numeric),
        ('Cardeña Villafuerte Alejandrina', 0.00::numeric),
        ('Falcon Chiara Hector  Marcial', 0.00::numeric),
        ('Burga Carrasco Elida', 0.00::numeric),
        ('Cuya Sanchez Alberto', 0.00::numeric),
        ('Ccoyllo Bustillos Deysi Karen', 0.00::numeric),
        ('Castro Gutierrez Aquila Lucrecia', 0.00::numeric),
        ('Paredes Morales Diana', 0.00::numeric),
        ('Javier Sermeño Gutierrez', 0.00::numeric),
        ('Valero Pariona Maximo', 0.00::numeric),
        ('Valero Soto Willy Perseo Albino', 0.00::numeric),
        ('Yaurimucha Rimachi Marcos', 0.00::numeric),
        ('Flores Yato Francisca Dolores', 0.00::numeric),
        ('Lagos Luna de Leiva Zaida', 0.00::numeric),
        ('Taype Oquendo Eugenio Joel', 0.00::numeric),
        ('Clemente Aller Cirila', 0.00::numeric),
        ('Paredes Morales Oscar Martín', 0.00::numeric),
        ('Pacompia Cardeña Giovanni', 0.00::numeric),
        ('Quispe Uribe Luciano', 0.00::numeric),
        ('Marin Huaman de Salamanca Maria', 0.00::numeric),
        ('Pittman Concepción Nelly Maria', 0.00::numeric),
        ('Segovia Villafuerte de Ponce', 0.00::numeric),
        ('Espejo Urbano Rosa Florencia', 0.00::numeric),
        ('Sanchez Astos de Torres Yolanda Sofia', 0.00::numeric),
        ('Cabero Mendoza Gloria', 0.00::numeric),
        ('Salas Montalvo Magali Judith', 0.00::numeric),
        ('Gutierrez Flores Roger Reyman', 0.00::numeric),
        ('Perez Quispe Epifania', 0.00::numeric),
        ('Rojas Ignacio Leonila', 0.00::numeric),
        ('Prado Llancari Zozima', 0.00::numeric),
        ('Saavedra Curipuma Luis Humberto', 0.00::numeric),
        ('Tello Alvarez Marino', 0.00::numeric),
        ('Juarez Cuellar Leonor', 0.00::numeric),
        ('Ancco Leon Valentina', 0.00::numeric),
        ('Ccoyllo Polanco German', 0.00::numeric),
        ('Jara Alvarez Maria Cenaida', 0.00::numeric),
        ('Rodriguez Arquiñego Idilio Félix', 0.00::numeric),
        ('Paredes Flores Oscar', 0.00::numeric),
        ('Juan Valverde Rosas (CERRADO)', 0.00::numeric),
        ('Ccoyllo Chinchay Judith', 0.00::numeric),
        ('Calle Calle Fidel', 0.00::numeric),
        ('Davila Cahuana Marisol', 0.00::numeric),
        ('Estela Calderon Torres', 0.00::numeric),
        ('Alarcon Anampa Nancy Gisela', 0.00::numeric),
        ('Anampa Corahua Clemencia Migdonia', 0.00::numeric),
        ('Ñahui Ruiz Aurelio', 0.00::numeric),
        ('Ccoyllo Chinchay Daniel Masia', 0.00::numeric),
        ('Alarcon Anampa Betsy', 0.00::numeric),
        ('Bravo Heredia Ana Maritza', 0.00::numeric),
        ('Sanchez Soto Lucia', 0.00::numeric),
        ('Yruipalla Falcon Hilda', 0.00::numeric),
        ('Chuchuyo Hacha José', 0.00::numeric),
        ('Soria Tapia Edith Catalina', 0.00::numeric),
        ('Rivera Callpa Juana Regis', 0.00::numeric),
        ('Torres Anyorsa Marcelino', 0.00::numeric),
        ('Cuevas Mayo Enrique', 0.00::numeric),
        ('Tintaya Cahuana Patricia', 0.00::numeric),
        ('Alvarez Campos Rolando', 0.00::numeric),
        ('Bastidas Medina Dina', 0.00::numeric),
        ('Carrasco Salvatierra Felicitas', 0.00::numeric),
        ('Cajaleon Carrasco Luis Enrique', 0.00::numeric),
        ('Chirinos Cabracancha María', 0.00::numeric),
        ('HUAYHUALLA DE LOPEZ DONATILA', 0.00::numeric),
        ('QUISPE COPAYO  ELIO CARLOS', 0.00::numeric),
        ('RODRIGUEZ CORDOVA MARCOS', 0.00::numeric),
        ('HUAMAN YNCA VISITACION', 0.00::numeric),
        ('TORRES ASTO FRANCISCO', 0.00::numeric),
        ('MAYHUASCA BASTIDAS ULISES', 0.00::numeric),
        ('CARTAGENA MAMANI BENJAMIN', 0.00::numeric),
        ('PEREZ PONCE SATURNINA MARGARITA', 0.00::numeric),
        ('PALOMINO HANCCO CECILIA', 0.00::numeric),
        ('ZAPATA RIVERA ROSANA', 0.00::numeric),
        ('PLAZA COSQUILLO ROSA ESTELA', 0.00::numeric),
        ('QUISPE CONSA MIGUEL', 0.00::numeric),
        ('TINEO CABRERA SONIA', 0.00::numeric),
        ('CHALLCO DE PALOMINO NICOLAZA', 0.00::numeric),
        ('PALOMINO TENORIO SILVIO EDUARDO', 0.00::numeric),
        ('CULE CARRASCO HAYDEE MONICA', 0.00::numeric),
        ('YRUPAILLA ANAMPA ISIDRO', 0.00::numeric),
        ('VALENCIA TOMAS VICENTE', 0.00::numeric),
        ('TORRES ASTO NERY (F)', 0.00::numeric),
        ('RIVERA FERNANDEZ MARINA MAXILIANA', 0.00::numeric),
        ('FLORES FLORES UMBELINA DORA', 0.00::numeric),
        ('MAYHUASCA BASTIDAS MARILU', 0.00::numeric),
        ('ORTIZ ÑAUPA WELINTONH', 0.00::numeric),
        ('ESTRADA OSCAR', 0.00::numeric),
        ('MEDINA MEDRANO JUAN CARLOS', 0.00::numeric),
        ('RICSE SAYES TERESA REYNA', 0.00::numeric),
        ('CCOYLLO POLANCO DANIEL', 0.00::numeric),
        ('CCOYLLO MAYHUASCA ALEXIS', 0.00::numeric),
        ('MALLQUI JULCA ALEJANDRINO TEODORO', 0.00::numeric),
        ('GUTIERREZ CASTILLO  JORGE', 0.00::numeric),
        ('CHOQUEHUAMANI FELIX CEFERINO', 0.00::numeric),
        ('GELDRES REVILLA MIGUEL', 0.00::numeric),
        ('VARA DE ROSAS ALICIA VALENTINA', 0.00::numeric),
        ('MAYHUASCA BASTIDAS CLUDDY', 0.00::numeric),
        ('NICHO LOPEZ ESTHEPANY CARICIA', 0.00::numeric),
        ('JARA ALVARES CRISTALINA', 0.00::numeric),
        ('CRUZ JARAMILLO LUIS', 0.00::numeric),
        ('CALDERON VERA SEGUNDO ALCIDES', 0.00::numeric),
        ('CARPIO VASQUEZ TEOFILA', 0.00::numeric),
        ('VILLANUEVA INGA DE VASQUEZ ROSA', 0.00::numeric),
        ('VICENTE CALIXTO JOSE ALBERTO', 0.00::numeric),
        ('ZAPATA  VELIT VICTORIANO', 0.00::numeric),
        ('AGUIRRE QUISPE WILFREDO GILMER', 0.00::numeric),
        ('OQUENDO ARISACA MELESIA ROSARIO', 0.00::numeric),
        ('CABALLERO CALZADO GLADYS VICTORIA', 0.00::numeric),
        ('CORDOVA PEREZ MARCO ANTONIO', 0.00::numeric),
        ('VILCHEZ GUTARRA LOURDES FANNY', 0.00::numeric),
        ('CASTRO ALEJANDRO HORTENCIA LUCILA', 0.00::numeric),
        ('ALVAREZ MARIN MARIANELA', 0.00::numeric),
        ('QUISPE CONSA VIDAL', 0.00::numeric),
        ('ESTELA SUAREZ ELVIA', 0.00::numeric),
        ('MESIA CRUZ GLADYS', 0.00::numeric),
        ('VARA CASTRO ERNESTINA', 0.00::numeric),
        ('QUISPE DE PALOMINO DOROTEA', 0.00::numeric),
        ('PALOMINO VELASQUEZ EUSEBIO', 0.00::numeric),
        ('MAYTA COLQUI VIOLETA', 0.00::numeric),
        ('GUTIERREZ CASTRO JORGE', 0.00::numeric),
        ('ALHUAY PALOMINO DE ALHUAY JUANA', 0.00::numeric),
        ('ORDOÑEZ NICHO AZUL CARILE', 0.00::numeric),
        ('LOPEZ HUAYHUALLA NELLY NATIVIDAD', 0.00::numeric),
        ('CAHUANA VDA DE DAVILA VICENTINA', 0.00::numeric),
        ('OQUENDO QUISPE MIGUEL', 0.00::numeric),
        ('OJEDA CAMPOS EDSON', 0.00::numeric),
        ('REYES SANCHEZ MILENA GERALDINE', 0.00::numeric),
        ('GAVILAN MOSQUERA NORMA', 0.00::numeric),
        ('MARIN LONDOÑE MARIA LUZ', 0.00::numeric),
        ('CARTAGENA PALOMINO ALVARO BENJAMIN', 0.00::numeric),
        ('ISIDRO MARIN CARLOS DANIEL', 0.00::numeric),
        ('TITO FALCON JESUSA RICARDINA', 0.00::numeric),
        ('MELO BACA MARINA', 0.00::numeric),
        ('RAMOS CUEVA PEDRO', 0.00::numeric),
        ('SALVATIERRA AYALA ALLISON', 0.00::numeric),
        ('QUISPE DURAN ADRIANA', 0.00::numeric),
        ('RODRIGUEZ MORENO NORA', 0.00::numeric),
        ('ATANASIO ORTEGA MAXIMILIANA', 0.00::numeric),
        ('OQUENDO QUISPE JESSICA', 0.00::numeric),
        ('ROMERO YSLA ESTEBAN LIDIO', 0.00::numeric),
        ('CALLE ALVAREZ MARCO', 0.00::numeric),
        ('MALLQUI LOPEZ LIZBETH', 0.00::numeric),
        ('PORRAS DE OROYA OLIMPIA', 0.00::numeric),
        ('BASTIDAS MEDINA HERMEREGILDO', 0.00::numeric),
        ('QUINTANA VIDAL GLICERIO', 0.00::numeric),
        ('HERMELINDA MAYTA MATOS', 0.00::numeric),
        ('TORRES ASTO VDA DE CALDERON JUANA', 0.00::numeric),
        ('MORENO CHAVEZ RAFAEL FREDY', 0.00::numeric),
        ('JARA ALVAREZ SANTOS', 0.00::numeric),
        ('SOTO VARGAS DE FLORES MARIA DEL CARMEN', 0.00::numeric),
        ('CERDA YUPANQUI CARMEN ROSA', 0.00::numeric),
        ('SANTILLAN MESIA ZOILA', 0.00::numeric),
        ('VALLEJOS HUAMAN MARIA', 0.00::numeric),
        ('HEREDIA MUÑOZ DE BRAVO MARIA', 0.00::numeric),
        ('ALVAREZ CAMPOS VICTOR', 0.00::numeric),
        ('LUJAN GONZALES MARINO JUAN', 0.00::numeric),
        ('CUCHO DE LA CRUZ SAUL', 0.00::numeric),
        ('MEDINA GUITIERRES HONORATA', 0.00::numeric),
        ('CUSI LAURA SONIA', 0.00::numeric),
        ('ROMERO FLORES EDDNA', 0.00::numeric),
        ('CORNEJO DONATO DE CORDOVA ESTELA PILAR', 0.00::numeric),
        ('DE LA CRUZ ESTEBAN JOSE', 0.00::numeric),
        ('SALAZAR CONCEPCION VICTORIA', 0.00::numeric),
        ('ROJAS CORNEJO ERICK', 0.00::numeric),
        ('BERNAOLA DE PRADO FLORENCIA', 0.00::numeric),
        ('GUTIERREZ CASTILLO  TERESA JESUS', 0.00::numeric),
        ('SANCHEZ RODRIGUEZ JUDITH', 0.00::numeric),
        ('SOTO GALLEGO DE VALERO', 0.00::numeric),
        ('TELLO QUINTANA EDGAR', 0.00::numeric),
        ('HALIRE YUCRA JOSUE', 0.00::numeric),
        ('CAMPUZANO CABELLO VICENTA DONATILA', 0.00::numeric),
        ('MARIN ROCHA ESTEFANY', 0.00::numeric),
        ('REYES PEREZ DE VALENCIA NANCY', 0.00::numeric),
        ('FLORES FLORES IRENE BERTILIA', 0.00::numeric),
        ('VALERO SOTO  MAXIMO ELIAS', 0.00::numeric),
        ('QUISPE ORTEGA ROSA CARMEN', 0.00::numeric),
        ('MARIN LONDOÑE EDUARDO SANTIAGO', 0.00::numeric)
-- ▲▲▲ FIN DATOS BLOQUE B ▲▲▲
    ) AS d(nombre, multas)
    JOIN LATERAL (
        SELECT id FROM public.socios
        WHERE apellidos ILIKE '%' || d.nombre || '%'
        LIMIT 1
    ) AS s ON true
    WHERE d.multas > 0
    ON CONFLICT (socio_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND socio_id IS NOT NULL
        DO NOTHING;

    GET DIAGNOSTICS v_fm = ROW_COUNT;

    RAISE NOTICE '============================================';
    RAISE NOTICE 'SEED COMPLETADO';
    RAISE NOTICE '  Deudas de puesto insertadas: %', v_fp;
    RAISE NOTICE '  Deudas de multa insertadas:  %', v_fm;
    RAISE NOTICE '  Total:  %', v_fp + v_fm;
    RAISE NOTICE '  Monto total: S/ %',
        (SELECT round(sum(monto),2) FROM public.montos_por_cobrar WHERE periodo_anio=2026 AND periodo_mes=5);
    RAISE NOTICE '============================================';
END;
$$;