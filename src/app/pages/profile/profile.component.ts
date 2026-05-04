import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { PageBreadcrumbComponent } from '../../shared/components/common/page-breadcrumb/page-breadcrumb.component';
import { AuthService } from '../../core/services/auth.service';
import { ReportesService } from '../../core/services/reportes.service';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [
    PageBreadcrumbComponent,
  ],
  templateUrl: './profile.component.html',
  styles: ``
})
export class ProfileComponent implements OnInit {
  private readonly authSvc     = inject(AuthService);
  private readonly reportesSvc = inject(ReportesService);

  readonly email          = signal<string>('');
  readonly rol            = signal<string>('');
  readonly nombres        = signal<string | null>(null);
  readonly recaudacionHoy = signal<number>(0);
  readonly gastosMes      = signal<number>(0);
  readonly saldoBancos    = signal<number>(0);
  readonly cargando       = signal<boolean>(true);
  readonly errorMsg       = signal<string | null>(null);

  readonly inicial       = computed(() =>
    this.email() ? this.email().charAt(0).toUpperCase() : '?'
  );
  readonly nombreDisplay = computed(() => this.nombres() ?? this.email());

  async ngOnInit(): Promise<void> {
    try {
      const [, reporteHoy, reporteMes] = await Promise.all([
        this.authSvc.esperarInicializacion(),
        this.reportesSvc.cargarReporteConsolidado('hoy'),
        this.reportesSvc.cargarReporteConsolidado('mes'),
      ]);

      const perfil = this.authSvc.perfil();
      if (perfil) {
        this.email.set(perfil.email);
        this.rol.set(perfil.rol);
        this.nombres.set(perfil.nombres);
      }

      this.recaudacionHoy.set(reporteHoy.caja_ingresos);
      this.gastosMes.set(reporteMes.caja_egresos);
      this.saldoBancos.set(reporteMes.banco_saldo);
    } catch (err: unknown) {
      this.errorMsg.set(err instanceof Error ? err.message : 'Error al cargar el perfil.');
    } finally {
      this.cargando.set(false);
    }
  }

  fmtSoles(n: number): string {
    return 'S/ ' + n.toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  }
}
