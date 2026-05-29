---
name: data-integrity-and-rpcs
description: "Valida reglas contables, consistencia transaccional y uso de RPCs en Supabase para prevenir datos huérfanos e inconsistencias."
metadata:
  author: Antigravity
  version: "1.0.0"
---

# Integridad de Datos y Stored Procedures (RPCs)

Este estándar asegura que las transacciones financieras y la consistencia de la base de datos se mantengan intactas bajo el principio de robustez contable.

## Reglas de Integridad y Transacciones

### 1. Transacciones Atómicas (ACID)
* Cualquier proceso que involucre múltiples inserciones, actualizaciones o afectación de balances financieros **no debe** realizarse en código Angular de manera distribuida.
* Debe empaquetarse en un Stored Procedure de PostgreSQL (RPC) que garantice que todo se ejecuta correctamente o se aplica un `ROLLBACK` automático.
* Ejemplo: El proceso de cobro (`rpc_procesar_pago`) realiza en una sola transacción:
  * Inserción en `public.pagos` (cabecera).
  * Inserción de múltiples líneas en `public.detalle_pagos` (aplicación granular).
  * Actualización de estados en `public.montos_por_cobrar`.
  * Ajuste de `saldo_a_favor` en `public.socios` o `public.inquilinos`.

### 2. Prohibición de Borrado Físico (Soft Delete)
* Está **estrictamente prohibido** ejecutar sentencias `DELETE FROM` sobre tablas contables, de personas o de deudas en producción.
* Utiliza una estructura de "baja suave" o *Soft Delete* actualizando las columnas:
  * `deleted_at`: marca de tiempo.
  * `anulado_por` / `deleted_by`: UUID del usuario.
  * `motivo_anulacion`: texto descriptivo.
* En las consultas y vistas financieras, filtra siempre los registros anulados: `where deleted_at is null`.

### 3. Integridad Referencial Contable (Partida Doble)
* Cada cobro registrado debe estar respaldado por registros correspondientes en `detalle_pagos` que apunten a deudas reales en `montos_por_cobrar`.
* La suma de los importes en `detalle_pagos` (`monto_aplicado`) para un pago específico debe ser exactamente igual al monto del pago (`monto_total`) menos el excedente generado a favor.
* Al anular un pago (mediante `rpc_anular_pago`), el trigger correspondiente debe revertir el estado de las deudas asociadas a "Pendiente" y actualizar los balances.
