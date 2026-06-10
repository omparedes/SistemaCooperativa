import { Routes } from '@angular/router';
import { adminGuard, authGuard, noAuthGuard } from './core/guards/auth.guard';
import { LoginComponent } from './pages/auth-pages/login/login.component';
import { NotFoundComponent } from './pages/other-page/not-found/not-found.component';
import { AppLayoutComponent } from './shared/layout/app-layout/app-layout.component';
import { SignInComponent } from './pages/auth-pages/sign-in/sign-in.component';
import { SignUpComponent } from './pages/auth-pages/sign-up/sign-up.component';
import { DocumentationComponent } from './pages/documentation/documentation.component';

export const routes: Routes = [
  {
    path: '',
    component: AppLayoutComponent,
    canActivate: [authGuard],
    children: [
      {
        path: '',
        loadComponent: () =>
          import('./pages/dashboard/dashboard.component').then(m => m.DashboardComponent),
        pathMatch: 'full',
        title: 'Dashboard | Mercado Primero de Mayo',
      },
      {
        path: 'socios',
        loadComponent: () =>
          import('./pages/socios/socio-list.component').then(m => m.SocioListComponent),
        title: 'Listado de Socios | TailAdmin'
      },
      // ── CRUD Socios (solo Administrador) ────────────────────────────────
      {
        path: 'socios/nuevo',
        loadComponent: () =>
          import('./pages/socios/socio-form.component').then(m => m.SocioFormComponent),
        canActivate: [adminGuard],
        title: 'Nuevo Socio | Cooperativa Primero de Mayo',
      },
      {
        path: 'socios/editar/:id',
        loadComponent: () =>
          import('./pages/socios/socio-form.component').then(m => m.SocioFormComponent),
        canActivate: [adminGuard],
        title: 'Editar Socio | Cooperativa Primero de Mayo',
      },
      // ── CRUD Inquilinos (solo Administrador) ─────────────────────────────
      {
        path: 'inquilinos/nuevo',
        loadComponent: () =>
          import('./pages/socios/inquilino-form.component').then(m => m.InquilinoFormComponent),
        canActivate: [adminGuard],
        title: 'Nuevo Inquilino | Cooperativa Primero de Mayo',
      },
      {
        path: 'inquilinos/editar/:id',
        loadComponent: () =>
          import('./pages/socios/inquilino-form.component').then(m => m.InquilinoFormComponent),
        canActivate: [adminGuard],
        title: 'Editar Inquilino | Cooperativa Primero de Mayo',
      },
      {
        path: 'pagos/registrar',
        loadComponent: () =>
          import('./pages/pagos/pago-wizard.component').then(m => m.PagoWizardComponent),
        title: 'Registrar Pago | Cooperativa Primero de Mayo',
      },
      {
        path: 'pagos/recaudacion-diaria',
        loadComponent: () =>
          import('./pages/pagos/recaudacion-diaria.component').then(m => m.RecaudacionDiariaComponent),
        title: 'Recaudación Diaria | TailAdmin'
      },
      {
        path: 'pagos/ingresos-internos',
        loadComponent: () =>
          import('./pages/pagos/ingresos-internos.component').then(m => m.IngresosInternosComponent),
        title: 'Caja Rápida — Ingresos sin Recibo | Cooperativa Primero de Mayo',
      },
      {
        path: 'reportes',
        loadComponent: () =>
          import('./pages/reportes/reportes.component').then(m => m.ReportesComponent),
        title: 'Central de Reportes | Cooperativa Primero de Mayo'
      },
      {
        path: 'reportes/arqueo-diario',
        loadComponent: () =>
          import('./pages/reportes/arqueo-caja.component').then(m => m.ArqueoCajaComponent),
        title: 'Arqueo de Caja Diario | Cooperativa Primero de Mayo',
      },
      // ── Configuración (solo Administrador) ──────────────────────────────
      {
        path: 'configuracion/tarifas',
        loadComponent: () =>
          import('./pages/config/tarifas.component').then(m => m.TarifasComponent),
        canActivate: [adminGuard],
        title: 'Configuración de Tarifas | Cooperativa Primero de Mayo',
      },
      {
        path: 'configuracion/recibos',
        loadComponent: () =>
          import('./pages/config/recibos-config.component').then(m => m.RecibosConfigComponent),
        canActivate: [adminGuard],
        title: 'Ajustes de Recibos | Cooperativa Primero de Mayo',
      },
      // ── Facturación (solo Administrador) ────────────────────────────────
      {
        path: 'facturacion/luz',
        loadComponent: () =>
          import('./pages/facturacion/facturacion-distribucion.component').then(m => m.FacturacionDistribucionComponent),
        canActivate: [adminGuard],
        data: { servicio: 'Luz' },
        title: 'Facturación de Luz | Cooperativa Primero de Mayo',
      },
      {
        path: 'facturacion/agua',
        loadComponent: () =>
          import('./pages/facturacion/facturacion-distribucion.component').then(m => m.FacturacionDistribucionComponent),
        canActivate: [adminGuard],
        data: { servicio: 'Agua' },
        title: 'Facturación de Agua | Cooperativa Primero de Mayo',
      },
      {
        path: 'facturacion/cargos-extraordinarios',
        loadComponent: () =>
          import('./pages/facturacion/cargos-extraordinarios.component').then(m => m.CargosExtraordinariosComponent),
        canActivate: [adminGuard],
        title: 'Cargos Extraordinarios | Cooperativa Primero de Mayo',
      },
      {
        path: 'facturacion/medidores',
        loadComponent: () =>
          import('./pages/facturacion/facturacion-medidores.component').then(m => m.FacturacionMedidoresComponent),
        canActivate: [adminGuard],
        title: 'Registro de Medidores | Cooperativa Primero de Mayo',
      },
      {
        path: 'facturacion/cargos-fijos',
        loadComponent: () =>
          import('./pages/facturacion/facturacion-fija.component').then(m => m.FacturacionFijaComponent),
        canActivate: [adminGuard],
        title: 'Cargos Fijos del Mes | Cooperativa Primero de Mayo',
      },
      {
        path: 'facturacion/alquiler-almacenes',
        loadComponent: () =>
          import('./pages/facturacion/facturacion-almacenes.component').then(m => m.FacturacionAlmacenesComponent),
        canActivate: [adminGuard],
        title: 'Alquiler de Almacenes | Cooperativa Primero de Mayo',
      },
      {
        path: 'recaudacion',
        loadComponent: () =>
          import('./pages/recaudacion/recaudacion.component')
            .then(m => m.RecaudacionComponent),
        title: 'Recaudación por Tarjeta | Cooperativa Primero de Mayo',
      },
      {
        path: 'cuenta-corriente',
        loadComponent: () =>
          import('./pages/cuenta-corriente/cuenta-corriente-list.component')
            .then(m => m.CuentaCorrienteListComponent),
        title: 'Cuenta Corriente | Cooperativa Primero de Mayo',
      },
      {
        path: 'cuenta-corriente/:tipo/:id',
        loadComponent: () =>
          import('./pages/cuenta-corriente/cuenta-corriente-detail.component')
            .then(m => m.CuentaCorrienteDetailComponent),
        title: 'Detalle de Cuenta | Cooperativa Primero de Mayo',
      },
      {
        path: 'gastos',
        loadComponent: () =>
          import('./pages/gastos/gasto-list.component').then(m => m.GastoListComponent),
        title: 'Gastos | TailAdmin'
      },
      {
        path: 'inventario',
        loadComponent: () =>
          import('./pages/inventario/inventario-list.component').then(m => m.InventarioListComponent),
        title: 'Almacén Interno | Cooperativa Primero de Mayo',
      },
      {
        path: 'bancos',
        loadComponent: () =>
          import('./pages/bancos/bancos.component').then(m => m.BancosComponent),
        title: 'Movimientos Bancarios | Cooperativa Primero de Mayo',
      },
      {
        path: 'auditoria',
        loadComponent: () =>
          import('./pages/auditoria/auditoria-list.component').then(m => m.AuditoriaListComponent),
        canActivate: [adminGuard],
        title: 'Auditoría de Cambios | Cooperativa Primero de Mayo',
      },
      {
        path: 'socios/:id',
        loadComponent: () =>
          import('./pages/socios/socio-detail.component').then(m => m.SocioDetailComponent),
        title: 'Detalle de Socio | TailAdmin'
      },
      {
        path: 'inquilinos/:id',
        loadComponent: () =>
          import('./pages/socios/inquilino-detail.component').then(m => m.InquilinoDetailComponent),
        title: 'Detalle de Inquilino | TailAdmin'
      },
      {
        path: 'documentacion',
        children: [
          { path: '', redirectTo: 'manual', pathMatch: 'full' },
          {
            path: 'manual',
            loadComponent: () =>
              import('./pages/documentation/user-manual.component')
                .then(m => m.UserManualComponent),
            title: 'Manual de Usuario | Cooperativa Primero de Mayo'
          },
          {
            path: 'tecnica',
            component: DocumentationComponent,
            title: 'Documentación Técnica | Cooperativa Primero de Mayo'
          }
        ]
      },
      // ── Gestión de Espacios (Puestos + Almacenes) ───────────────────────
      {
        path: 'espacios',
        loadComponent: () =>
          import('./pages/espacios/gestion-espacios.component')
            .then(m => m.GestionEspaciosComponent),
        title: 'Gestión de Espacios | Cooperativa Primero de Mayo',
      },
      // ── Gestión de Giros Comerciales ────────────────────────────────────
      {
        path: 'giros',
        loadComponent: () =>
          import('./pages/giros/giro-list.component').then(m => m.GiroListComponent),
        title: 'Catálogo de Giros Comerciales | Cooperativa Primero de Mayo',
      },
      {
        path: 'giros/:id',
        loadComponent: () =>
          import('./pages/giros/giro-detail.component').then(m => m.GiroDetailComponent),
        title: 'Relación de Puestos por Giro | Cooperativa Primero de Mayo',
      },
      // ── Administración de usuarios (solo Administrador) ──────────────────
      {
        path: 'admin/usuarios',
        loadComponent: () =>
          import('./pages/usuarios/usuarios.component').then(m => m.UsuariosComponent),
        canActivate: [adminGuard],
        title: 'Gestión de Usuarios | Cooperativa Primero de Mayo',
      },
      {
        path: 'pagos/registrar/:id',
        loadComponent: () =>
          import('./pages/pagos/registro-pago.component').then(m => m.RegistroPagoComponent),
        title: 'Registrar Pago | TailAdmin'
      },
    ]
  },
  // ── Autenticación ────────────────────────────────────────────────────────
  {
    path: 'login',
    component: LoginComponent,
    canActivate: [noAuthGuard],
    title: 'Iniciar sesión | Cooperativa Primero de Mayo',
  },
  {
    path: 'signin',
    component: SignInComponent,
    canActivate: [noAuthGuard],
    title: 'Iniciar sesión | Cooperativa Primero de Mayo',
  },
  {
    path: 'signup',
    component: SignUpComponent,
    title: 'Registrar | TailAdmin'
  },
  // ── Portal público (sin auth) ────────────────────────────────────────────
  {
    path: 'consultas',
    loadComponent: () =>
      import('./pages/consultas/consultas.component').then(m => m.ConsultasComponent),
    title: 'Consultas | Cooperativa Primero de Mayo',
  },
  {
    path: '**',
    component: NotFoundComponent,
    title: '404 | Cooperativa Primero de Mayo'
  },
];
