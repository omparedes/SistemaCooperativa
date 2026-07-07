# Contexto del Proyecto: ERP SistemaCooperativa

Este documento es la **fuente de la verdad de negocio** para cualquier IA (Claude Code, etc.) o desarrollador que se una al proyecto. Las reglas técnicas duras viven en [CLAUDE.md](CLAUDE.md); los porqués arquitectónicos en [ARCHITECTURE.md](ARCHITECTURE.md); el estado de salud por módulo en [AUDITORIA_2026.md](AUDITORIA_2026.md). **No asumas el comportamiento del sistema sin leer estas reglas primero.**

## 1. Pila Tecnológica (Tech Stack)
- **Frontend:** Angular 20 (Componentes *Standalone* estrictos, sin `NgModules`). Estado 100 % reactivo con **Signals**. RxJS mínimo.
- **Estilos:** Tailwind CSS v4 (plantilla inspirada en TailAdmin, dark mode en todo).
- **Backend/BD:** Supabase (PostgreSQL). Toda la lógica transaccional y toda lectura agregada se ejecuta en la BD vía RPCs (`SECURITY DEFINER` + chequeo de rol).
- **Salidas:** `pdfmake` (tickets 80mm/A4) y `xlsx`/SheetJS con import dinámico (Excel multi-hoja).

## 2. Reglas de Arquitectura Críticas (¡No Romper!)
- **Soft Deletes estrictos:** nunca `DELETE` duro en entidades principales. Esquema `deleted_at` + `anulado_por` + `motivo_anulacion`.
- **Transacciones ACID:** operaciones financieras y transferencias de espacios van por RPCs de Postgres. Nunca inserciones encadenadas desde el frontend.
- **Seguridad RLS:** todo protegido por políticas basadas en `get_my_rol()` (Administrador / Caja / Asistente-solo-lectura).
- **Deuda unificada:** `fn_deudas_pagador` (migración 00082) es la ÚNICA definición de "cuánto debe una persona". Caja, Cuenta Corriente, Padrón y Portal Público la consumen; ninguna vista reimplementa el cálculo.
- **Reportes server-side:** los totales de rangos amplios se agregan en SQL y viajan como un solo JSON (PostgREST corta a 1000 filas y el Free Tier penaliza egress).
- **Auditoría inmutable con motivo:** `audit_logs` es append-only; las acciones críticas registran una justificación que viaja por la variable transaccional `app.audit_motivo` y se lee como timeline narrativo (`/auditoria`, solo Admin).

## 3. Lógica del Negocio: Módulo Financiero
- **El cobro es al Espacio, no a la Persona:** Luz, Agua y alquiler de almacén se generan contra el espacio físico activo; los cargos de socio (G. Administrativos S/ 60, Previsión Social S/ 5) contra el socio activo, con toggles individuales de suspensión.
- **Caja vs Bancos:** la gaveta física (Efectivo) se separa estrictamente de transferencias (PLIN/BBVA). Fórmula sagrada del arqueo: `Apertura + Efectivo − Gastos − Faltantes + Sobrantes`.
- **Cobro FIFO con saldo a favor:** el wizard de caja distribuye el dinero de más antiguo a más reciente (o manualmente), y los excedentes van a `saldo_a_favor` reutilizable. Recibos inmutables; la corrección es anular + reemitir.
- **Recaudación por tarjeta:** prepago semanal de socios que alimenta `saldo_a_favor` (operación masiva, cuenta como efectivo del día).
- **Dietas y Provisión Social:** beneficios entregados a socios (asambleas, salud, luto) en `beneficios_socios`. ⚠️ Aún **no** están integrados al circuito de caja/arqueo — es el pendiente de negocio n.º 1 (ver TODO.md).

## 4. Lógica del Negocio: Espacios y Ocupación (El Padrón)
El sistema separa radicalmente el "Ladrillo" (El Espacio) del "Papel" (El Contrato).
- **Entidad Física (Espacios):** 3 tipos: `Regular` (puesto principal), `Pequeño` (principal menor) y `Almacén` (complementario; NUNCA principal).
- **Entidad Legal (Personas):** `Socio` (titular: 1 puesto principal + N almacenes), `Inquilino` (arrendatario: 1 principal + N almacenes), `Tercero` (externo: SOLO almacenes).
- **Historial Inmutable:** transferir o liberar cierra el contrato vigente (`fecha_fin`) y crea una fila nueva. Quién ocupó qué y cuándo es sagrado.
- **Consolidación:** la deuda de una persona suma su puesto principal + todos sus almacenes + cargos personales, en todas las pantallas por igual (00082).

## 5. Estado Actual del Desarrollo

### Hito completado (julio 2026) — "Consistencia y Confianza"
- **Unificación de deuda (00082–00084):** `fn_deudas_pagador` como fuente única; Caja por fin ve y cobra los almacenes; paridad total del portal público (incl. `codigo_puesto` por línea de recibo).
- **Regularización histórica (00083):** los 173 conceptos "SIN DEUDA" de los recibos migrados de junio quedaron desglosados; los 61 recibos cuadran al céntimo. Diagnóstico permanente en `scripts/deteccion_recibos_huerfanos.sql`.
- **Central de Reportes v2 (00085):** KPIs + ingresos por concepto con drill-down a línea de recibo, filtro Socios/Inquilinos, egresos por categoría, exportación Excel de 4 hojas. Corrigió el recorte silencioso de totales anuales (límite de 1000 filas de PostgREST).
- **Auditoría narrativa (00086):** timeline tipo ERP (actor + rol, entidad resuelta, deltas "Antes ➔ Ahora", motivo) sobre `audit_logs` inmutable; triggers nuevos en almacenes, gastos y ajustes de caja; motivo opcional en ediciones del padrón vía `rpc_actualizar_con_motivo`.
- **Limpieza:** eliminados los prototipos mock heredados (registro-pago, auditoría localStorage, HTML huérfano de reportes).

### Siguiente hito — "Hardening" (backlog completo en [TODO.md](TODO.md))
1. Bloqueo de concurrencia en `rpc_procesar_pago` (dos cajas simultáneas pueden sobre-pagar una deuda).
2. Integración Dietas/Provisión ↔ circuito de egresos de caja.
3. Triggers de auditoría faltantes (`perfiles`, `configuraciones`, `beneficios_socios`) y regla "último admin".

---
> **Nota para IAs:** al implementar un *feature*, evalúa si rompe alguna de estas reglas. Al cerrar un hito, actualiza la sección 5 de este archivo, el roadmap de CLAUDE.md y marca lo resuelto en TODO.md.
