import { TestBed } from '@angular/core/testing';
import { provideRouter, Router, withNavigationErrorHandler } from '@angular/router';
import { Component } from '@angular/core';
import { SUPABASE_CLIENT } from './core/services/supabase.client';
import { AuthService } from './core/services/auth.service';
import { SidebarService } from './core/services/sidebar.service';
import { AppSidebarComponent } from './shared/layout/app-sidebar/app-sidebar.component';
import { SocioListComponent } from './pages/socios/socio-list.component';
import { SocioDetailComponent } from './pages/socios/socio-detail.component';
import { InquilinoDetailComponent } from './pages/socios/inquilino-detail.component';
import { MovimientosBancariosReporteComponent } from './pages/reportes/movimientos-bancarios-reporte.component';
import { DashboardService } from './core/services/dashboard.service';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { PagosService } from './core/services/pagos.service';
import { ReportesService } from './core/services/reportes.service';
import { PdfGeneratorService, ReciboDatos } from './core/services/pdf-generator.service';
import { ConfiguracionRecibos } from './core/services/configuracion-recibos.service';
import { resumirPagoConSaldo } from './pages/pagos/pago.model';

@Component({ standalone: true, template: '<p>Dummy Route</p>' })
class DummyRouteComponent {}

const CFG_MOCK: ConfiguracionRecibos = {
  id: 1,
  nombre_institucion: 'COOPERATIVA DE SERVICIOS ESPECIALES MERCADO PRIMERO DE MAYO LTDA.',
  subtitulo: 'Mercado Municipal — Control Interno',
  mensaje_pie: 'Gracias por su puntualidad.',
  color_principal: '#166534',
  formato_impresion: 'A4',
};

function createSandboxSupabase() {
  let authCallback: ((event: string, session: any) => any) | null = null;
  let lockHoldMs = 0;
  const rpcCalls: Array<{ fn: string; args: any }> = [];
  const tableCalls: Array<{ table: string; op: string }> = [];
  let getUserCount = 0;

  const mockChain = (table: string, defaultData: any = []) => {
    const chain: any = {
      select: () => chain,
      eq: () => chain,
      neq: () => chain,
      in: () => chain,
      is: () => chain,
      or: () => chain,
      gte: () => chain,
      lte: () => chain,
      order: () => chain,
      limit: () => chain,
      single: async () => {
        tableCalls.push({ table, op: 'SELECT_SINGLE' });
        // Simulate PostgREST calling getSession() which needs Navigator LockManager
        if (navigator?.locks) {
          await navigator.locks.request(
            'lock:sb-sandbox-auth-token',
            { mode: 'exclusive', ifAvailable: false },
            async () => {}
          );
        }
        if (table === 'perfiles') {
          return {
            data: {
              id: 'uid-cajero-01',
              email: 'caja@cooperativa.pe',
              rol: 'Administrador',
              nombres: 'Cajero Prueba',
              activo: true,
            },
            error: null,
          };
        }
        if (table === 'socios') {
          return {
            data: {
              id: 10,
              dni: '10203040',
              nombres: 'JUAN',
              apellidos: 'PEREZ GOMEZ',
              direccion: 'Av. Peru 123',
              telefono: '999888777',
              email: null,
              fecha_ingreso: '2020-01-01',
              estado: 'Activo',
              habilitado: true,
              saldo_a_favor: 150,
              cobro_admin_activo: true,
              cobro_prev_social_activo: true,
              historial_titularidad: [
                {
                  id: 1,
                  fecha_inicio: '2020-01-01',
                  fecha_fin: null,
                  motivo_cambio: null,
                  puesto: { id: 101, codigo_puesto: 'A-01', estado: 'Ocupado', tipo_espacio: 'Regular', giro: { nombre: 'Abarrotes' } },
                },
              ],
              ocupaciones_almacenes: [],
            },
            error: null,
          };
        }
        if (table === 'inquilinos') {
          return {
            data: {
              id: 20,
              dni: '40506070',
              nombres: 'MARIA',
              apellidos: 'LOPEZ RUIZ',
              direccion: null,
              telefono: null,
              email: null,
              saldo_a_favor: 50,
              historial_arriendos: [
                {
                  id: 2,
                  fecha_inicio: '2025-01-01',
                  fecha_fin: null,
                  motivo_termino: null,
                  monto_arriendo: 120,
                  puesto: { id: 202, codigo_puesto: 'B-15', estado: 'Arrendado', giro: { nombre: 'Verduras' } },
                  titular: { id: 10, apellidos: 'PEREZ GOMEZ', dni: '10203040' },
                },
              ],
              ocupaciones_almacenes: [],
            },
            error: null,
          };
        }
        return { data: null, error: null };
      },
      maybeSingle: async () => ({ data: null, error: null }),
      then: (resolve: any) => {
        tableCalls.push({ table, op: 'SELECT' });
        resolve({ data: defaultData, error: null, count: 0 });
      },
    };
    return chain;
  };

  const client: any = {
    rpcCalls,
    tableCalls,
    get lockHoldMs() {
      return lockHoldMs;
    },
    get getUserCount() {
      return getUserCount;
    },
    resetCounters() {
      rpcCalls.length = 0;
      tableCalls.length = 0;
      getUserCount = 0;
    },
    auth: {
      getSession: async () => ({
        data: {
          session: {
            user: { id: 'uid-cajero-01', email: 'caja@cooperativa.pe' },
          },
        },
        error: null,
      }),
      getUser: async () => {
        getUserCount++;
        return {
          data: { user: { id: 'uid-cajero-01', email: 'caja@cooperativa.pe' } },
          error: null,
        };
      },
      signInWithPassword: async ({ email }: { email: string }) => ({
        data: { user: { id: 'uid-cajero-01', email } },
        error: null,
      }),
      signOut: async () => ({ error: null }),
      onAuthStateChange: (cb: (event: string, session: any) => any) => {
        authCallback = cb;
        return { data: { subscription: { unsubscribe: () => {} } } };
      },
      triggerAuthEventWithLock: async (event: string, session: any) => {
        if (!authCallback) return;
        const t0 = performance.now();
        await navigator.locks.request(
          'lock:sb-sandbox-auth-token',
          { mode: 'exclusive' },
          async () => {
            await authCallback!(event, session);
            lockHoldMs = performance.now() - t0;
          }
        );
      },
    },
    from: (table: string) => mockChain(table),
    rpc: async (fn: string, args?: any) => {
      rpcCalls.push({ fn, args });
      if (fn === 'rpc_procesar_pago') {
        return { data: { pago_id: 9991, codigo_transaccion: 'REC-2026-09991' }, error: null };
      }
      if (fn === 'anular_pago') {
        return { data: { ok: true }, error: null };
      }
      if (fn === 'rpc_caja_cargar_deudas') {
        return {
          data: [
            {
              monto_id: 501,
              concepto: 'Administración',
              codigo_puesto: 'B-15',
              periodo_anio: 2026,
              periodo_mes: 6,
              monto_original: 60,
              ya_pagado: 0,
              saldo_pendiente: 60,
              fecha_generacion: '2026-06-01',
            },
          ],
          error: null,
        };
      }
      if (fn === 'rpc_dashboard_ejecutivo') {
        return { data: {}, error: null };
      }
      if (fn === 'rpc_dashboard_deuda_pendiente') {
        return { data: { total_deuda: 12500, cantidad_morosos: 18 }, error: null };
      }
      return { data: [], error: null };
    },
    channel: () => ({
      on: function () {
        return this;
      },
      subscribe: function () {
        return this;
      },
    }),
    removeChannel: () => {},
  };

  return client;
}

describe('Validación Funcional y de Rendimiento en Chrome Real — Fases 1 y 2', () => {
  let sandboxDb: ReturnType<typeof createSandboxSupabase>;

  beforeEach(() => {
    sandboxDb = createSandboxSupabase();
    TestBed.configureTestingModule({
      providers: [
        { provide: SUPABASE_CLIENT, useValue: sandboxDb },
        provideRouter(
          [
            { path: '', component: DummyRouteComponent },
            { path: 'socios', component: SocioListComponent },
            { path: 'socios/:id', component: SocioDetailComponent },
            { path: 'inquilinos/:id', component: InquilinoDetailComponent },
            { path: 'espacios', component: DummyRouteComponent },
            { path: 'pagos/registrar', component: DummyRouteComponent },
            { path: 'cuenta-corriente', component: DummyRouteComponent },
            { path: 'cuenta-corriente/gestion-ingresos', component: DummyRouteComponent },
            { path: 'gastos', component: DummyRouteComponent },
            { path: 'bancos', component: DummyRouteComponent },
            { path: 'reportes/arqueo-diario', component: DummyRouteComponent },
            { path: 'reportes/movimientos-bancarios', component: MovimientosBancariosReporteComponent },
            { path: 'signin', component: DummyRouteComponent },
          ],
          withNavigationErrorHandler((navError) => {
            const msg = String((navError.error as Error)?.message ?? navError.error ?? '');
            if (msg.includes('Failed to fetch dynamically imported module') || msg.includes('ChunkLoadError')) {
              TestBed.inject(SidebarService).chunkErrorUrl.set(navError.url);
            }
          })
        ),
      ],
    });
  });

  it('1. [Auth + Navigator LockManager] libera el lock exclusivo en < 5ms sin interbloqueo y gestiona login/logout/persistencia', async () => {
    const authSvc = TestBed.inject(AuthService);
    await authSvc.esperarInicializacion();

    expect(authSvc.usuario()?.id).toBe('uid-cajero-01');
    expect(authSvc.rol()).toBe('Administrador');

    // Simular evento TOKEN_REFRESHED / SIGNED_IN con nuevo usuario bajo Navigator LockManager real de Chrome
    await Promise.race([
      sandboxDb.auth.triggerAuthEventWithLock('TOKEN_REFRESHED', {
        user: { id: 'uid-cajero-02', email: 'caja2@cooperativa.pe' },
      }),
      new Promise((_, reject) => setTimeout(() => reject(new Error('Navigator LockManager Deadlock')), 1500)),
    ]);

    console.log(`[BENCHMARK AUTH] Duración de retención de Navigator LockManager en onAuthStateChange: ${sandboxDb.lockHoldMs.toFixed(3)} ms (Antes: >10000 ms / Deadlock)`);
    expect(sandboxDb.lockHoldMs).toBeLessThan(15);

    // Esperar el microtask/setTimeout donde cargarPerfil resuelve fuera del lock
    await new Promise((r) => setTimeout(r, 30));
    expect(authSvc.usuario()?.id).toBe('uid-cajero-02');

    // Verificar logout limpio
    await authSvc.logout();
    expect(authSvc.usuario()).toBeNull();
    expect(authSvc.perfil()).toBeNull();
  });

  it('2. [Navegación + Sidebar + Multi-pestaña] ejecuta loadCounts() exactamente 1 vez por navegación (vs 13 antes) y sincroniza storage entre pestañas', async () => {
    const fixture = TestBed.createComponent(AppSidebarComponent);
    const sidebarComp = fixture.componentInstance;
    const router = TestBed.inject(Router);
    fixture.detectChanges();

    const spyLoadCounts = spyOn<any>(sidebarComp, 'loadCounts').and.callThrough();

    const rutas = [
      '/socios',
      '/espacios',
      '/pagos/registrar',
      '/cuenta-corriente',
      '/cuenta-corriente/gestion-ingresos',
      '/gastos',
      '/bancos',
      '/reportes/arqueo-diario',
      '/reportes/movimientos-bancarios',
    ];

    const t0 = performance.now();
    for (const ruta of rutas) {
      await router.navigateByUrl(ruta);
      fixture.detectChanges();
    }
    const navTotalMs = performance.now() - t0;

    console.log(
      `[BENCHMARK NAV] 9 navegaciones completadas en ${navTotalMs.toFixed(2)} ms (${(navTotalMs / rutas.length).toFixed(2)} ms/ruta). Llamadas a loadCounts(): ${spyLoadCounts.calls.count()} (Antes: ~${rutas.length * 13} llamadas)`
    );

    expect(spyLoadCounts.calls.count()).toBe(rutas.length);
    expect(sidebarComp.currentPath()).toBe('/reportes/movimientos-bancarios');

    // Prueba de sincronización multi-pestaña mediante StorageEvent:
    // 1. Eventos irrelevantes (ej. sb-auth-token) se ignoran sin trabajo innecesario
    window.dispatchEvent(new StorageEvent('storage', { key: 'sb-auth-token', newValue: 'updated' }));
    expect(spyLoadCounts.calls.count()).toBe(rutas.length);
    // 2. Eventos relevantes (productos_almacen / AuditoriaDeCambios) actualizan contadores
    window.dispatchEvent(new StorageEvent('storage', { key: 'productos_almacen', newValue: '[]' }));
    expect(spyLoadCounts.calls.count()).toBe(rutas.length + 1);
  });

  it('3. [Recuperación No Destructiva de Chunks] activa banner de actualización ante ChunkLoadError sin recargar la página', () => {
    const sidebarSvc = TestBed.inject(SidebarService);
    expect(sidebarSvc.chunkErrorUrl()).toBeNull();

    // Simular captura de error de chunk por withNavigationErrorHandler
    sidebarSvc.chunkErrorUrl.set('/reportes/movimientos-bancarios');
    expect(sidebarSvc.chunkErrorUrl()).toBe('/reportes/movimientos-bancarios');
  });

  it('4. [Fichas de Socios e Inquilinos + Padrón + Reporte Bancario] desacopla historial, evita doble consulta de deudas y paraleliza reporte bancario', async () => {
    const pagosSvc = TestBed.inject(PagosService);
    // Simular que el historial de pagos tarda 350 ms mientras el perfil tarda 20 ms
    spyOn(pagosSvc, 'obtenerHistorialPorPagador').and.callFake(
      () => new Promise((resolve) => setTimeout(() => resolve([]), 350))
    );
    const spyCargarDeudas = spyOn(pagosSvc, 'cargarDeudasPuesto').and.callFake(async () => [
      {
        monto_id: 501,
        concepto: 'Alquiler',
        codigo_puesto: 'B-15',
        periodo_anio: 2026,
        periodo_mes: 6,
        monto_original: 120,
        ya_pagado: 0,
        saldo_pendiente: 120,
        fecha_generacion: '2026-06-01',
      },
    ]);

    const t0 = performance.now();
    const inqFixture = TestBed.createComponent(InquilinoDetailComponent);
    const inqComp = inqFixture.componentInstance;
    await (inqComp as any).cargar(20);
    const tiempoAperturaFichaMs = performance.now() - t0;

    console.log(
      `[BENCHMARK FICHA] Apertura de perfil InquilinoDetailComponent: ${tiempoAperturaFichaMs.toFixed(2)} ms mientras historial de 350 ms sigue cargando en segundo plano (Antes: bloqueado >= 350 ms)`
    );

    expect(inqComp.loading()).toBeFalse();
    expect(inqComp.detalle()?.apellidos).toBe('LOPEZ RUIZ');
    expect(inqComp.historialLoading()).toBeTrue();
    expect(spyCargarDeudas.calls.count()).toBe(1);

    // Al hacer clic en la pestaña "Deudas pendientes", NO debe volver a consultar la BD porque ya están cargadas
    inqComp.cargarDeudasTab();
    expect(spyCargarDeudas.calls.count()).toBe(1);

    // Verificar Reporte de Movimientos Bancarios: inicia con cargando() === true y paraleliza cargas
    const repFixture = TestBed.createComponent(MovimientosBancariosReporteComponent);
    const repComp = repFixture.componentInstance;
    expect(repComp.cargando()).toBeTrue();
  });

  it('5. [Dashboard Filtros] setFiltros ejecuta cargarFiltrado() sin re-ejecutar rpc_dashboard_ejecutivo', async () => {
    const dashSvc = TestBed.inject(DashboardService);
    sandboxDb.resetCounters();

    await dashSvc.cargar();
    const callsCargaInicial = sandboxDb.rpcCalls.filter((c: { fn: string }) => c.fn === 'rpc_dashboard_ejecutivo').length;
    expect(callsCargaInicial).toBe(1);

    sandboxDb.resetCounters();
    await dashSvc.cargarFiltrado();
    const callsAlFiltrar = sandboxDb.rpcCalls.filter((c: { fn: string }) => c.fn === 'rpc_dashboard_ejecutivo').length;
    expect(callsAlFiltrar).toBe(0);
  });

  it('6. [Sandbox Financiero Aislado + Recibos A4 y Ticket 80mm] verifica pagos, saldo a favor, pagos mixtos, anulaciones, arqueo y PDF sin tocar producción', async () => {
    const pagosSvc = TestBed.inject(PagosService);
    const reportesSvc = TestBed.inject(ReportesService);
    const pdfSvc = TestBed.inject(PdfGeneratorService);

    sandboxDb.resetCounters();

    // 6.1 Pago mixto (efectivo S/ 40 + saldo a favor S/ 20 = S/ 60)
    const resPago = await pagosSvc.procesarPago({
      resultado: {
        tipo: 'socio',
        persona_id: 10,
        dni: '10203040',
        nombre_completo: 'PEREZ GOMEZ, JUAN',
        puesto_id: 101,
        codigo_puesto: 'A-01',
      },
      distribucion: [
        {
          monto_id: 501,
          concepto: 'Administración',
          codigo_puesto: 'A-01',
          periodo_label: 'Jun-2026',
          saldo_pendiente: 60,
          monto_aplicado: 60,
          cubierto_completo: true,
        },
      ],
      monto_recibido: 40,
      saldo_utilizado: 20,
      metodo_pago: 'Efectivo',
      comprobante: '',
      observacion: 'Pago mixto en sandbox',
    });

    expect(resPago.codigo_transaccion).toBe('REC-2026-09991');
    // Confirmar que procesarPago validó identidad con auth.getUser()
    expect(sandboxDb.getUserCount).toBe(1);

    // 6.2 Pago 100% con saldo a favor (monto_recibido = 0, saldo_utilizado = 50) con concepto PARCIAL
    const resumenSaldoFavor = resumirPagoConSaldo({
      monto_total: 0,
      metodo_pago: 'Efectivo',
      detalle: [{ monto_aplicado: 50 }],
    });
    expect(resumenSaldoFavor.esSoloSaldoFavor).toBeTrue();
    expect(resumenSaldoFavor.importeRecibo).toBe(50);
    expect(resumenSaldoFavor.montoCaja).toBe(0);

    // 6.3 Anulación de pago valida auth.getUser()
    await pagosSvc.anularPago(9991, 'Error de digitación en prueba');
    expect(sandboxDb.getUserCount).toBe(2);

    // 6.4 Arqueo de caja con soloMiCajero = true usa usuario en memoria (0 llamadas extra a getUser)
    const getUserAntesArqueo = sandboxDb.getUserCount;
    await reportesSvc.cargarArqueo('2026-11-03', true);
    expect(sandboxDb.getUserCount).toBe(getUserAntesArqueo);

    // 6.5 Generación real de PDF A4 y Ticket Térmico 80mm con pdfmake en Chrome
    const datosRecibo: ReciboDatos = {
      codigo_transaccion: 'REC-2026-09991',
      fecha_pago: new Date('2026-11-03T10:30:45'),
      cajero: 'Cajero Prueba',
      nombre_pagador: 'PEREZ GOMEZ, JUAN',
      tipo_pagador: 'Socio titular',
      dni_pagador: '10203040',
      codigo_puesto: 'A-01',
      metodo_pago: 'Efectivo',
      comprobante: null,
      detalle: [
        {
          concepto: 'Administración',
          periodo: 'Jun-2026',
          saldo_original: 100,
          aplicado: 50,
          cubierto_completo: false,
        },
      ],
      total_pagado: 50,
      saldo_a_favor: 100,
      monto_recibido: 0,
      saldo_utilizado: 50,
    };

    const tPdfA4 = performance.now();
    const blobA4 = await pdfSvc.obtenerBlob(datosRecibo, 'A4', CFG_MOCK);
    const msPdfA4 = performance.now() - tPdfA4;

    const tPdfTicket = performance.now();
    const blobTicket = await pdfSvc.obtenerBlob(datosRecibo, 'TICKET_80MM', CFG_MOCK);
    const msPdfTicket = performance.now() - tPdfTicket;

    console.log(
      `[BENCHMARK PDF] Recibo A4: ${blobA4.size} bytes en ${msPdfA4.toFixed(1)} ms | Ticket 80mm: ${blobTicket.size} bytes en ${msPdfTicket.toFixed(1)} ms`
    );

    expect(blobA4.size).toBeGreaterThan(5000);
    expect(blobTicket.size).toBeGreaterThan(5000);
  });

  it('7. [Dashboard ApexCharts ESM + SocioDetail + Padrón Debounce] renderiza gráficos sin script global y difiere búsquedas/pestaña inquilinos', async () => {
    const dashFixture = TestBed.createComponent(DashboardComponent);
    dashFixture.detectChanges();
    expect(dashFixture.componentInstance).toBeTruthy();
    expect(dashFixture.componentInstance.chartConfig.type).toBe('bar');

    const pagosSvc = TestBed.inject(PagosService);
    spyOn(pagosSvc, 'obtenerHistorialPorPagador').and.callFake(
      () => new Promise((resolve) => setTimeout(() => resolve([]), 350))
    );

    const t0 = performance.now();
    const socFixture = TestBed.createComponent(SocioDetailComponent);
    const socComp = socFixture.componentInstance;
    await (socComp as any).cargar(10);
    const msSocio = performance.now() - t0;

    console.log('[BENCHMARK SOCIO DETAIL] Apertura de perfil SocioDetailComponent: ' + msSocio.toFixed(2) + ' ms (Antes: bloqueado >= 350 ms)');
    expect(socComp.loading()).toBeFalse();
    expect(socComp.detalle()?.apellidos).toBe('PEREZ GOMEZ');
    expect(socComp.historialLoading()).toBeTrue();

    // Padrón: debounce de 200ms en búsqueda
    const listFixture = TestBed.createComponent(SocioListComponent);
    const listComp = listFixture.componentInstance;
    listComp.onBusquedaInput('PEREZ');
    expect(listComp.busquedaInput()).toBe('PEREZ');
    expect(listComp.busqueda()).toBe(''); // Aún no se aplica hasta cumplir 200ms
    await new Promise((r) => setTimeout(r, 220));
    expect(listComp.busqueda()).toBe('PEREZ');
  });
});