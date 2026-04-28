import { Routes } from '@angular/router';
import { adminGuard, authGuard, noAuthGuard } from './core/guards/auth.guard';
import { FacturacionMedidoresComponent } from './pages/facturacion/facturacion-medidores.component';
import { FacturacionFijaComponent } from './pages/facturacion/facturacion-fija.component';
import { TarifasComponent } from './pages/config/tarifas.component';
import { CargosExtraordinariosComponent } from './pages/facturacion/cargos-extraordinarios.component';
import { LoginComponent } from './pages/auth-pages/login/login.component';
import { EcommerceComponent } from './pages/dashboard/ecommerce/ecommerce.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { FormElementsComponent } from './pages/forms/form-elements/form-elements.component';
import { BasicTablesComponent } from './pages/tables/basic-tables/basic-tables.component';
import { BlankComponent } from './pages/blank/blank.component';
import { NotFoundComponent } from './pages/other-page/not-found/not-found.component';
import { AppLayoutComponent } from './shared/layout/app-layout/app-layout.component';
import { InvoicesComponent } from './pages/invoices/invoices.component';
import { LineChartComponent } from './pages/charts/line-chart/line-chart.component';
import { BarChartComponent } from './pages/charts/bar-chart/bar-chart.component';
import { AlertsComponent } from './pages/ui-elements/alerts/alerts.component';
import { AvatarElementComponent } from './pages/ui-elements/avatar-element/avatar-element.component';
import { BadgesComponent } from './pages/ui-elements/badges/badges.component';
import { ButtonsComponent } from './pages/ui-elements/buttons/buttons.component';
import { ImagesComponent } from './pages/ui-elements/images/images.component';
import { VideosComponent } from './pages/ui-elements/videos/videos.component';
import { SignInComponent } from './pages/auth-pages/sign-in/sign-in.component';
import { SignUpComponent } from './pages/auth-pages/sign-up/sign-up.component';
import { CalenderComponent } from './pages/calender/calender.component';
import { SocioListComponent } from './pages/socios/socio-list.component';
import { SocioDetailComponent } from './pages/socios/socio-detail.component';
import { InquilinoDetailComponent } from './pages/socios/inquilino-detail.component';
import { RegistroPagoComponent } from './pages/pagos/registro-pago.component';
import { PagoWizardComponent } from './pages/pagos/pago-wizard.component';
import { ReportesComponent } from './pages/reportes/reportes.component';
import { ArqueoCajaComponent } from './pages/reportes/arqueo-caja.component';
import { GastoListComponent } from './pages/gastos/gasto-list.component';
import { RecaudacionDiariaComponent } from './pages/pagos/recaudacion-diaria.component';
import { InventarioListComponent } from './pages/inventario/inventario-list.component';
import { BancosComponent } from './pages/bancos/bancos.component';
import { AuditoriaComponent } from './pages/auditoria/auditoria.component';
import { DocumentationComponent } from './pages/documentation/documentation.component';

export const routes: Routes = [
  {
    path: '',
    component: AppLayoutComponent,
    canActivate: [authGuard],   // ← protege todas las rutas hijas
    children: [
      {
        path: '',
        component: DashboardComponent,
        pathMatch: 'full',
        title: 'Dashboard | Mercado Primero de Mayo',
      },
      {
        path: 'calendar',
        component: CalenderComponent,
        title: 'Angular Calender | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'profile',
        component: ProfileComponent,
        title: 'Angular Profile Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'form-elements',
        component: FormElementsComponent,
        title: 'Angular Form Elements Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'basic-tables',
        component: BasicTablesComponent,
        title: 'Angular Basic Tables Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'blank',
        component: BlankComponent,
        title: 'Angular Blank Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      // support tickets
      {
        path: 'invoice',
        component: InvoicesComponent,
        title: 'Angular Invoice Details Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'line-chart',
        component: LineChartComponent,
        title: 'Angular Line Chart Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'bar-chart',
        component: BarChartComponent,
        title: 'Angular Bar Chart Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'alerts',
        component: AlertsComponent,
        title: 'Angular Alerts Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'avatars',
        component: AvatarElementComponent,
        title: 'Angular Avatars Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'badge',
        component: BadgesComponent,
        title: 'Angular Badges Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'buttons',
        component: ButtonsComponent,
        title: 'Angular Buttons Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'images',
        component: ImagesComponent,
        title: 'Angular Images Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'videos',
        component: VideosComponent,
        title: 'Angular Videos Dashboard | TailAdmin - Angular Admin Dashboard Template'
      },
      {
        path: 'socios',
        component: SocioListComponent,
        title: 'Listado de Socios | TailAdmin'
      },
      {
        path: 'pagos/registrar',
        component: PagoWizardComponent,
        title: 'Registrar Pago | Cooperativa Primero de Mayo',
      },
      {
        path: 'pagos/recaudacion-diaria',
        component: RecaudacionDiariaComponent,
        title: 'Recaudación Diaria | TailAdmin'
      },
      {
        path: 'reportes',
        component: ReportesComponent,
        title: 'Reportes de Ingresos | TailAdmin'
      },
      {
        path: 'reportes/arqueo-diario',
        component: ArqueoCajaComponent,
        title: 'Arqueo de Caja Diario | Cooperativa Primero de Mayo',
      },
      {
        path: 'reportes/gastos',
        component: ReportesComponent,
        title: 'Reportes de Gastos | TailAdmin'
      },
      {
        path: 'reportes/inventario',
        component: ReportesComponent,
        title: 'Reporte de Almacén | TailAdmin'
      },
      {
        path: 'reportes/inventario/bajo-stock',
        component: ReportesComponent,
        title: 'Reporte de Almacén - Bajo Stock | TailAdmin'
      },
      // ── Configuración (solo Administrador) ──────────────────────────────
      {
        path: 'configuracion/tarifas',
        component: TarifasComponent,
        canActivate: [adminGuard],
        title: 'Configuración de Tarifas | Cooperativa Primero de Mayo',
      },
      // ── Facturación (solo Administrador) ────────────────────────────────
      {
        path: 'facturacion/cargos-extraordinarios',
        component: CargosExtraordinariosComponent,
        canActivate: [adminGuard],
        title: 'Cargos Extraordinarios | Cooperativa Primero de Mayo',
      },
      {
        path: 'facturacion/medidores',
        component: FacturacionMedidoresComponent,
        canActivate: [adminGuard],
        title: 'Registro de Medidores | Cooperativa Primero de Mayo',
      },
      {
        path: 'facturacion/cargos-fijos',
        component: FacturacionFijaComponent,
        canActivate: [adminGuard],
        title: 'Cargos Fijos del Mes | Cooperativa Primero de Mayo',
      },
      {
        path: 'gastos',
        component: GastoListComponent,
        title: 'Gastos | TailAdmin'
      },
      {
        path: 'inventario',
        component: InventarioListComponent,
        title: 'Inventario | TailAdmin'
      },
      {
        path: 'bancos',
        component: BancosComponent,
        title: 'Bancos | TailAdmin'
      },
      {
        path: 'auditoria',
        component: AuditoriaComponent,
        title: 'Auditoría | TailAdmin'
      },
      {
        path: 'socios/:id',
        component: SocioDetailComponent,
        title: 'Detalle de Socio | TailAdmin'
      },
      {
        path: 'inquilinos/:id',
        component: InquilinoDetailComponent,
        title: 'Detalle de Inquilino | TailAdmin'
      },
      {
        path: 'documentacion',
        component: DocumentationComponent,
        title: 'Documentación Técnica | TailAdmin'
      },
      {
        path: 'pagos/registrar/:id',
        component: RegistroPagoComponent,
        title: 'Registrar Pago | TailAdmin'
      },
    ]
  },
  // ── Autenticación ────────────────────────────────────────────────────────
  {
    path: 'login',
    component: LoginComponent,
    canActivate: [noAuthGuard],  // redirige a / si ya hay sesión
    title: 'Iniciar sesión | Cooperativa Primero de Mayo',
  },
  {
    path: 'signin',
    component: SignInComponent,
    canActivate: [noAuthGuard],   // redirige a / si ya hay sesión con perfil
    title: 'Iniciar sesión | Cooperativa Primero de Mayo',
  },
  {
    path: 'signup',
    component: SignUpComponent,
    title: 'Registrar | TailAdmin'
  },
  // error pages
  {
    path: '**',
    component: NotFoundComponent,
    title: 'Angular NotFound Dashboard | TailAdmin - Angular Admin Dashboard Template'
  },
];
