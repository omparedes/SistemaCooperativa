/**
 * Configuración canónica de versionado y metadatos del ERP.
 * Fuente única de la verdad (Single Source of Truth) para la aplicación.
 */

export interface ReleaseNote {
  version: string;
  fecha: string;
  titulo: string;
  tipo: 'Mayor' | 'Menor' | 'Parche';
  resumenAdministrativo: string[];
  detallesTecnicos: {
    categoria: string;
    items: string[];
  }[];
  commits?: string[];
  migraciones?: string[];
}

export interface AppVersionMetadata {
  versionActual: string;
  fechaActualizacion: string;
  ambiente: 'Producción' | 'Desarrollo';
  arquitectura: string;
  historial: ReleaseNote[];
}

export const APP_VERSION_DATA: AppVersionMetadata = {
  versionActual: '2.5.0',
  fechaActualizacion: 'Noviembre 2026',
  ambiente: 'Producción',
  arquitectura: 'Angular 20 Standalone · Supabase PostgreSQL 15 · Tailwind CSS v4',
  historial: [
    {
      version: '2.5.0',
      fecha: '02/11/2026',
      titulo: 'Auditoría, Dietas/Provisión, Arqueo Matriz y Saldo a Favor',
      tipo: 'Menor',
      resumenAdministrativo: [
        'Edición y eliminación de Dietas y Provisión Social directamente desde el perfil del socio (exclusivo para Administrador) con registro inmutable en auditoría.',
        'Pagos cancelados 100% con saldo a favor acumulado en tarjeta (efectivo S/ 0.00), emitiendo comprobante oficial sin distorsionar la recaudación de la caja física del día.',
        'Reorganización integral del Arqueo de Caja Diario en 3 bloques independientes (Efectivo, Tarjeta y Depósitos Bancarios) con matriz consolidada, subtotales y exclusión total de comprobantes anulados tanto en vista web como en PDF a 2 niveles.',
        'Protección de datos personales en el repositorio del proyecto e institucionalización del sistema de versiones y novedades.'
      ],
      detallesTecnicos: [
        {
          categoria: 'Base de Datos (Supabase / PostgreSQL)',
          items: [
            'Migración 00098: Columnas updated_at y updated_by en beneficios_socios, políticas RLS restrictivas a rol Administrador, RPCs transaccionales rpc_editar_beneficio_socio y rpc_eliminar_beneficio_socio con bloqueo FOR UPDATE y trigger trg_audit_beneficios_socios.',
            'Migración 00097: Habilitación de pagos con monto_total = 0 y p_monto_recibido = 0 en rpc_registrar_pago_completo, impidiendo ingresos fantasma en caja.',
            'Soporte de auditoría narrativa en rpc_auditoria_timeline para beneficios_socios.'
          ]
        },
        {
          categoria: 'Frontend (Angular 20 & Servicios)',
          items: [
            'Componente socio-detail.component.ts: Modales reactivos de edición y confirmación de baja lógica gobernados por Signals.',
            'Componente arqueo-caja.component.ts: Rediseño de matriz consolidada y filtrado estricto de registros con deleted_at IS NOT NULL.',
            'Servicio pdf-generator.service.ts: Impresión de tickets térmicos con desglose de saldo aplicado y arqueo diario en dos niveles (resumen gerencial y detalle transaccional).'
          ]
        }
      ],
      commits: ['1eec4fe', 'd2385b1', 'ede8fff'],
      migraciones: ['00097_pagos_saldo_a_favor_cero_efectivo.sql', '00098_beneficios_edicion_eliminacion_auditoria.sql']
    },
    {
      version: '2.4.0',
      fecha: '14/10/2026',
      titulo: 'Gestión de Ingresos Internos (Caja Rápida) y Cobranza a Inquilinos',
      tipo: 'Menor',
      resumenAdministrativo: [
        'Módulo de Gestión de Ingresos Internos para registrar y auditar recaudaciones diarias de servicios sin recibo oficial (baños públicos, parqueo, servicios varios) con trazabilidad de anulaciones.',
        'Habilitación completa de ventanilla de cobro y emisión de recibos oficiales para inquilinos que arriendan almacenes o mantienen deudas directas.',
        'Corrección de la asociación de cargos mensuales en cuenta corriente para inquilinos sin puesto comercial asignado.'
      ],
      detallesTecnicos: [
        {
          categoria: 'Base de Datos y Procedimientos',
          items: [
            'Migración 00096: Tabla public.ingresos_internos con control transaccional, RPC rpc_anular_ingreso_interno y trigger a public.audit_logs.',
            'Adecuación de rpc_registrar_pago_completo para admitir pagos asociados a inquilino_id con socio_id nulo.'
          ]
        },
        {
          categoria: 'Frontend',
          items: [
            'Módulo pages/cuenta-corriente/gestion-ingresos con modales de registro, detalle y anulación con motivo obligatorio.',
            'Desacoplamiento de puesto_id obligatorio en pago-wizard.component.ts e inquilino-detail.component.ts.'
          ]
        }
      ],
      commits: ['4c5d302', '5e60904', 'b11b3ea'],
      migraciones: ['00096_gestion_ingresos_seguridad_auditoria.sql']
    },
    {
      version: '2.3.0',
      fecha: '08/10/2026',
      titulo: 'Tesorería Bancaria y Estados de Cuenta Consolidados',
      tipo: 'Menor',
      resumenAdministrativo: [
        'Módulo de Movimientos Bancarios para registro, edición y anulación de ingresos y egresos en cuentas bancarias con recálculo atómico de saldos y reporte PDF.',
        'Módulo gerencial de Estados de Cuenta y Resumen Consolidado de Deudas por puesto y socio, con filtros por sector y exportación a PDF y Excel multi-hoja.'
      ],
      detallesTecnicos: [
        {
          categoria: 'Base de Datos y Procedimientos',
          items: [
            'Migración 00094: Trigger tg_actualizar_saldo_banco() en public.movimientos_bancarios para actualización atómica y segura de saldos.',
            'Migración 00095: Procedimiento almacenado rpc_reporte_estados_cuenta para consolidación de deudas por pagador.'
          ]
        },
        {
          categoria: 'Frontend y Reportes',
          items: [
            'Componente pages/bancos/bancos.component.ts con soporte Realtime de saldos bancarios.',
            'Componente pages/reportes/estados-cuenta-reporte.component.ts y servicio excel-export.service.ts con import() dinámico de SheetJS.'
          ]
        }
      ],
      commits: ['c4410fd', '1bbb067'],
      migraciones: ['00094_movimientos_bancarios_crud_y_reporte.sql', '00095_reporte_estados_cuenta.sql']
    },
    {
      version: '2.2.0',
      fecha: '09/07/2026',
      titulo: 'Padrón de Asambleas, Central de Reportes v2 y Portal Móvil',
      tipo: 'Menor',
      resumenAdministrativo: [
        'Módulo de Padrón Electoral para Asambleas Generales con control de socios hábiles y morosos.',
        'Central de Reportes v2 con visualización rápida de recaudación y desglose hasta nivel de recibo.',
        'Optimización visual responsive para celulares y tabletas en el portal público de consultas.'
      ],
      detallesTecnicos: [
        {
          categoria: 'Base de Datos y RPCs',
          items: [
            'Migraciones 00084 y 00085: RPC rpc_reportes_drilldown con agregación server-side que elimina el límite de 1000 filas de PostgREST.',
            'Migraciones 00087 y 00088: RPC rpc_padron_electoral para verificación de socios hábiles en asambleas.'
          ]
        },
        {
          categoria: 'Frontend',
          items: [
            'Componente pages/asambleas/asambleas.component.ts y exportación de padrones electorales.',
            'Reestructuración responsiva en pages/consultas/consultas.component.ts para dispositivos móviles.'
          ]
        }
      ],
      commits: ['a01e083', 'ea297f5', 'feff237'],
      migraciones: ['00085_rpc_reportes_drilldown.sql', '00088_rpc_padron_electoral.sql']
    },
    {
      version: '2.1.0',
      fecha: '10/06/2026',
      titulo: 'Facturación y Arrendamiento de Almacenes Comerciales',
      tipo: 'Menor',
      resumenAdministrativo: [
        'Módulo de administración y facturación mensual de alquiler de almacenes comerciales para socios e inquilinos.',
        'Asignación de almacenes y generación masiva de cargos fijos de arriendo.'
      ],
      detallesTecnicos: [
        {
          categoria: 'Base de Datos',
          items: [
            'Migración 00072: Tabla public.ocupaciones_almacenes y triggers de consistencia de titularidad.'
          ]
        },
        {
          categoria: 'Frontend',
          items: [
            'Componente pages/facturacion/facturacion-almacenes.component.ts y diálogo asignar-almacen-dialog.component.ts.'
          ]
        }
      ],
      commits: ['f6dc793', '58d2e81', 'd7528ba'],
      migraciones: ['00072_alquiler_almacenes.sql']
    },
    {
      version: '2.0.0',
      fecha: '29/05/2026',
      titulo: 'Lanzamiento Oficial del ERP en Producción (Go-Live)',
      tipo: 'Mayor',
      resumenAdministrativo: [
        'Puesta en marcha del ERP del Mercado Cooperativo Primero de Mayo en producción.',
        'Padrón maestro de socios, espacios y giros comerciales.',
        'Facturación mensual de cuotas comunitarias (Gastos Administrativos, Previsión Social, distribución de Agua y Luz).',
        'Ventanilla de cobranzas con soporte de pagos en efectivo, tarjeta y emisión de recibos térmicos y A4.',
        'Portal público de consultas en línea con enmascaramiento de datos personales.',
        'Manual de usuario y documentación técnica del sistema.'
      ],
      detallesTecnicos: [
        {
          categoria: 'Arquitectura Base',
          items: [
            'Angular 20 Standalone Components con Signals y Tailwind CSS v4.',
            'Backend en Supabase con políticas RLS y Procedimientos Almacenados ACID.',
            'Migración 00047: Enmascaramiento de PII en portal de consultas públicas.'
          ]
        }
      ],
      commits: ['650c839'],
      migraciones: ['00047_enmascarar_pii_portal_publico.sql']
    }
  ]
};
