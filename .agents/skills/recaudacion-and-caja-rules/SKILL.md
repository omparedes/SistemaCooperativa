---
name: recaudacion-and-caja-rules
description: "Reglas operativas de caja y recaudación. Arqueos de caja diaria, método de pago, control de caja física y lógica de socios."
metadata:
  author: Antigravity
  version: "1.0.0"
---

# Reglas de Recaudación y Control de Caja Física

Este manual detalla los estándares de negocio para el cobro, la administración de caja chica (gaveta) y la segmentación de cobros de la cooperativa.

## Reglas Operativas y de Dominio

### 1. Control de Caja Física (Arqueo)
* El dinero físico en la gaveta (Efectivo) debe cuadrar exactamente al final del día.
* Las transferencias bancarias (PLIN, Yape, transferencias directas) **no forman parte de la caja física**. Se registran en la base de datos pero se excluyen del balance de efectivo disponible.
* La fórmula inmutable para calcular el efectivo teórico en caja es:
  `Efectivo = Apertura_Monto + Ingresos_Efectivo - Gastos_Efectivo - Faltantes + Sobrantes`
* El flujo de caja está controlado por los registros en `public.caja_aperturas` (clave por fecha única) y `public.caja_ajustes` para reportes contables.

### 2. Facturación y Cobro de Cargos Fijos
* Los cargos fijos de la cooperativa son:
  * **Gastos Administrativos**: S/ 60.00 (con excepción de Febrero que es S/ 56.00).
  * **Previsión Social**: S/ 5.00.
* Estos cargos son **exclusivos de Socios Activos**. Está prohibido facturar Gastos Administrativos o Previsión Social a Inquilinos o Almacenes pertenecientes a terceros.
* Los cargos fijos se pueden habilitar/deshabilitar de forma granular por cada socio usando los flags `cobro_admin_activo` and `cobro_prev_social_activo` en la tabla de socios.
* El sistema debe impedir la duplicidad mensual de cargos fijos. Si un socio ya tiene asignado un cobro de Admin/Previsión en el mes en curso, no se permite volver a generarlo.

### 3. Distribución de Pagos (FIFO vs Manual)
* El sistema soporta dos modos de recaudación:
  * **Automático (FIFO)**: El dinero recibido se aplica a las deudas pendientes en estricto orden cronológico (de la más antigua a la más reciente).
  * **Manual**: Permite al cajero digitar la cantidad exacta a destinar a cada deuda específica, validando que la suma aplicada no supere la suma disponible (monto recibido + saldo a favor utilizado).
