import { CommonModule } from '@angular/common';
import { Component, ElementRef, QueryList, ViewChildren, ChangeDetectorRef } from '@angular/core';
import { SidebarService } from '../../../core/services/sidebar.service';
import { NavigationEnd, Router, RouterModule } from '@angular/router';
import { SafeHtmlPipe } from '../../pipe/safe-html.pipe';
import { SidebarWidgetComponent } from './app-sidebar-widget.component';
import { combineLatest, Subscription } from 'rxjs';

type NavItem = {
  name: string;
  icon: string;
  path?: string;
  new?: boolean;
  subItems?: { name: string; path: string; pro?: boolean; new?: boolean }[];
};

@Component({
  selector: 'app-sidebar',
  imports: [
    CommonModule,
    RouterModule,
    SafeHtmlPipe,
    SidebarWidgetComponent
  ],
  templateUrl: './app-sidebar.component.html',
})
export class AppSidebarComponent {

  // Main nav items
  navItems: NavItem[] = [
    {
      icon: `<svg width="1em" height="1em" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M5.5 3.25C4.25736 3.25 3.25 4.25736 3.25 5.5V8.99998C3.25 10.2426 4.25736 11.25 5.5 11.25H9C10.2426 11.25 11.25 10.2426 11.25 8.99998V5.5C11.25 4.25736 10.2426 3.25 9 3.25H5.5ZM4.75 5.5C4.75 5.08579 5.08579 4.75 5.5 4.75H9C9.41421 4.75 9.75 5.08579 9.75 5.5V8.99998C9.75 9.41419 9.41421 9.74998 9 9.74998H5.5C5.08579 9.74998 4.75 9.41419 4.75 8.99998V5.5ZM5.5 12.75C4.25736 12.75 3.25 13.7574 3.25 15V18.5C3.25 19.7426 4.25736 20.75 5.5 20.75H9C10.2426 20.75 11.25 19.7427 11.25 18.5V15C11.25 13.7574 10.2426 12.75 9 12.75H5.5ZM4.75 15C4.75 14.5858 5.08579 14.25 5.5 14.25H9C9.41421 14.25 9.75 14.5858 9.75 15V18.5C9.75 18.9142 9.41421 19.25 9 19.25H5.5C5.08579 19.25 4.75 18.9142 4.75 18.5V15ZM12.75 5.5C12.75 4.25736 13.7574 3.25 15 3.25H18.5C19.7426 3.25 20.75 4.25736 20.75 5.5V8.99998C20.75 10.2426 19.7426 11.25 18.5 11.25H15C13.7574 11.25 12.75 10.2426 12.75 8.99998V5.5ZM15 4.75C14.5858 4.75 14.25 5.08579 14.25 5.5V8.99998C14.25 9.41419 14.5858 9.74998 15 9.74998H18.5C18.9142 9.74998 19.25 9.41419 19.25 8.99998V5.5C19.25 5.08579 18.9142 4.75 18.5 4.75H15ZM15 12.75C13.7574 12.75 12.75 13.7574 12.75 15V18.5C12.75 19.7426 13.7574 20.75 15 20.75H18.5C19.7426 20.75 20.75 19.7427 20.75 18.5V15C20.75 13.7574 19.7426 12.75 18.5 12.75H15ZM14.25 15C14.25 14.5858 14.5858 14.25 15 14.25H18.5C18.9142 14.25 19.25 14.5858 19.25 15V18.5C19.25 18.9142 18.9142 19.25 18.5 19.25H15C14.5858 19.25 14.25 18.9142 14.25 18.5V15Z" fill="currentColor"></path></svg>`,
      name: "Dashboard",
      subItems: [
        { name: "Metricas", path: "/" },
      ],
    },

    {
      name: 'Padrón',
      icon: `<svg width="1em" height="1em" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 12c2.7614 0 5-2.2386 5-5s-2.2386-5-5-5-5 2.2386-5 5 2.2386 5 5 5zm0 2c-3.866 0-7 3.134-7 7h2c0-2.7614 2.2386-5 5-5s5 2.2386 5 5h2c0-3.866-3.134-7-7-7z" fill="currentColor"/></svg>`,
      subItems: [
        { name: 'Listado de Personas',    path: '/socios', pro: false },
      ]
    },
    {
      name: 'Caja e Ingresos',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>`,
      subItems: [
        { name: 'Registrar Pago',       path: '/pagos/registrar',           pro: false },
        { name: 'Recaudación Tarjeta',  path: '/recaudacion',               pro: false },
        { name: 'Caja Rápida',          path: '/pagos/ingresos-internos',   pro: false },
      ]
    },
    {
      name: 'Cuenta Corriente',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="5" width="20" height="14" rx="2"/><path stroke-linecap="round" d="M2 10h20M6 15h4M14 15h4"/></svg>`,
      subItems: [
        { name: 'Gestión Financiera',   path: '/cuenta-corriente', pro: false },
      ]
    },
    {
      name: 'Reportes',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none"><path d="M3 13h2v6H3v-6zm4-8h2v14H7V5zm4 6h2v8h-2v-8zm4-4h2v12h-2V7zm4-6h2v18h-2V1z" fill="currentColor"/></svg>`,
      subItems: [
        { name: 'Arqueo de Caja Diario', path: '/reportes/arqueo-diario', pro: false },
        { name: 'Central de Reportes', path: '/reportes', pro: false }
      ]
    },
    {
      name: 'Facturación',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z"/></svg>`,
      subItems: [
        { name: 'Lectura de Medidores',     path: '/facturacion/medidores',              pro: false },
        { name: 'Cargos Fijos del Mes',    path: '/facturacion/cargos-fijos',           pro: false },
        { name: 'Cargos Extraordinarios',  path: '/facturacion/cargos-extraordinarios', pro: false }
      ]
    },
    {
      name: 'Configuración',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 011.37.49l1.296 2.247a1.125 1.125 0 01-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 010 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 01-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 01-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 01-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 01-1.369-.49l-1.297-2.247a1.125 1.125 0 01.26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 010-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 01-.26-1.43l1.297-2.247a1.125 1.125 0 011.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>`,
      subItems: [
        { name: 'Tarifas del Sistema', path: '/configuracion/tarifas', pro: false }
      ]
    },
    {
      name: 'Gastos',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none"><path d="M6 2h12v2H6V2zm-2 6h16v12a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V8zm4 3v6h2v-6H8zm4 0v6h2v-6h-2z" fill="currentColor"/></svg>`,
      subItems: [
        { name: 'Lista de Gastos', path: '/gastos', pro: false }
      ]
    },
    {
      name: 'Bancos',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none"><path d="M12 3L2 7v6c0 5 4 9 10 9s10-4 10-9V7l-10-4zM8 13h8v2H8v-2z" fill="currentColor"/></svg>`,
      subItems: [
        { name: 'Movimientos Bancarios', path: '/bancos', pro: false }
      ]
    },
    {
      name: 'Inventario',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none"><path d="M3 6h18v2H3V6zm0 4h18v10H3V10zm2 2v6h14v-6H5z" fill="currentColor"/></svg>`,
      subItems: [
        { name: 'Almacén Interno', path: '/inventario', pro: false }
      ]
    },
    {
      name: 'Auditoría',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none"><path d="M12 1C5.925 1 1 5.925 1 12s4.925 11 11 11 11-4.925 11-11S18.075 1 12 1zm1 17h-2v-2h2v2zm0-4h-2V6h2v8z" fill="currentColor"/></svg>`,
      subItems: [
        { name: 'Auditoría de Cambios', path: '/auditoria', pro: false }
      ]
    },
  ];
  // Others nav items
  othersItems: NavItem[] = [
    {
      name: 'Documentación',
      icon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24" fill="none"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8l-6-6zM6 20V4h7v5h5v11H6z" fill="currentColor"/><path d="M8 12h8v2H8zm0 4h8v2H8z" fill="currentColor"/></svg>`,
      path: '/documentacion'
    },
    {
      icon: `<svg width="1em" height="1em" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M14 2.75C14 2.33579 14.3358 2 14.75 2C15.1642 2 15.5 2.33579 15.5 2.75V5.73291L17.75 5.73291H19C19.4142 5.73291 19.75 6.0687 19.75 6.48291C19.75 6.89712 19.4142 7.23291 19 7.23291H18.5L18.5 12.2329C18.5 15.5691 15.9866 18.3183 12.75 18.6901V21.25C12.75 21.6642 12.4142 22 12 22C11.5858 22 11.25 21.6642 11.25 21.25V18.6901C8.01342 18.3183 5.5 15.5691 5.5 12.2329L5.5 7.23291H5C4.58579 7.23291 4.25 6.89712 4.25 6.48291C4.25 6.0687 4.58579 5.73291 5 5.73291L6.25 5.73291L8.5 5.73291L8.5 2.75C8.5 2.33579 8.83579 2 9.25 2C9.66421 2 10 2.33579 10 2.75L10 5.73291L14 5.73291V2.75ZM7 7.23291L7 12.2329C7 14.9943 9.23858 17.2329 12 17.2329C14.7614 17.2329 17 14.9943 17 12.2329L17 7.23291L7 7.23291Z" fill="currentColor"></path></svg>`,
      name: "Autenticación",
      subItems: [
        { name: "Iniciar sesión", path: "/signin", pro: false },
        { name: "Registrar", path: "/signup", pro: false },
      ],
    },
  ];

  openSubmenu: string | null | number = null;
  subMenuHeights: { [key: string]: number } = {};
  @ViewChildren('subMenu') subMenuRefs!: QueryList<ElementRef>;

  readonly isExpanded$;
  readonly isMobileOpen$;
  readonly isHovered$;

  // dynamic counts shown as badges
  lowStockCount: number = 0;
  auditCount: number = 0;

  private subscription: Subscription = new Subscription();

  constructor(
    public sidebarService: SidebarService,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) {
    this.isExpanded$ = this.sidebarService.isExpanded$;
    this.isMobileOpen$ = this.sidebarService.isMobileOpen$;
    this.isHovered$ = this.sidebarService.isHovered$;
  }

  ngOnInit() {
    // Subscribe to router events
    this.subscription.add(
      this.router.events.subscribe(event => {
        if (event instanceof NavigationEnd) {
          this.setActiveMenuFromRoute(this.router.url);
        }
      })
    );

    // Subscribe to combined observables to close submenus when all are false
    this.subscription.add(
      combineLatest([this.isExpanded$, this.isMobileOpen$, this.isHovered$]).subscribe(
        ([isExpanded, isMobileOpen, isHovered]) => {
          if (!isExpanded && !isMobileOpen && !isHovered) {
            // this.openSubmenu = null;
            // this.savedSubMenuHeights = { ...this.subMenuHeights };
            // this.subMenuHeights = {};
            this.cdr.detectChanges();
          } else {
            // Restore saved heights when reopening
            // this.subMenuHeights = { ...this.savedSubMenuHeights };
            // this.cdr.detectChanges();
          }
        }
      )
    );

    // Initial load
    this.setActiveMenuFromRoute(this.router.url);
    this.loadCounts();

    // refresh counts when storage changes or after navigation
    window.addEventListener('storage', () => this.loadCounts());
    this.subscription.add(
      this.router.events.subscribe(() => this.loadCounts())
    );
  }

  ngOnDestroy() {
    // Clean up subscriptions
    this.subscription.unsubscribe();
  }

  isActive(path: string): boolean {
    return this.router.url === path;
  }

  toggleSubmenu(section: string, index: number) {
    const key = `${section}-${index}`;

    if (this.openSubmenu === key) {
      this.openSubmenu = null;
      this.subMenuHeights[key] = 0;
    } else {
      this.openSubmenu = key;

      setTimeout(() => {
        const el = document.getElementById(key);
        if (el) {
          this.subMenuHeights[key] = el.scrollHeight;
          this.cdr.detectChanges(); // Ensure UI updates
        }
      });
    }
  }

  onSidebarMouseEnter() {
    this.isExpanded$.subscribe(expanded => {
      if (!expanded) {
        this.sidebarService.setHovered(true);
      }
    }).unsubscribe();
  }

  private setActiveMenuFromRoute(currentUrl: string) {
    const menuGroups = [
      { items: this.navItems, prefix: 'main' },
      { items: this.othersItems, prefix: 'others' },
    ];

    menuGroups.forEach(group => {
      group.items.forEach((nav, i) => {
        if (nav.subItems) {
          nav.subItems.forEach(subItem => {
            if (currentUrl === subItem.path) {
              const key = `${group.prefix}-${i}`;
              this.openSubmenu = key;

              setTimeout(() => {
                const el = document.getElementById(key);
                if (el) {
                  this.subMenuHeights[key] = el.scrollHeight;
                  this.cdr.detectChanges(); // Ensure UI updates
                }
              });
            }
          });
        }
      });
    });
  }

  onSubmenuClick() {
    this.isMobileOpen$.subscribe(isMobile => {
      if (isMobile) {
        this.sidebarService.setMobileOpen(false);
      }
    }).unsubscribe();
  }

  loadCounts() {
    interface ProductoBadge { stock_actual: unknown; stock_minimo: unknown }
    try {
      const rawP = localStorage.getItem('productos_almacen');
      const prods: unknown = rawP ? JSON.parse(rawP) : [];
      this.lowStockCount = Array.isArray(prods)
        ? (prods as ProductoBadge[]).filter(p => Number(p.stock_actual) <= Number(p.stock_minimo)).length
        : 0;

      const rawA = localStorage.getItem('AuditoriaDeCambios');
      const aud: unknown = rawA ? JSON.parse(rawA) : [];
      this.auditCount = Array.isArray(aud) ? aud.length : 0;
    } catch (_e: unknown) {
      this.lowStockCount = 0;
      this.auditCount = 0;
    }
    this.cdr.detectChanges();
  }


}
