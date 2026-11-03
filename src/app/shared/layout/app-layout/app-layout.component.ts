import { Component, signal, OnInit } from '@angular/core';
import { SidebarService } from '../../../core/services/sidebar.service';
import { CommonModule } from '@angular/common';
import { AppSidebarComponent } from '../app-sidebar/app-sidebar.component';
import { BackdropComponent } from '../backdrop/backdrop.component';
import { RouterModule } from '@angular/router';
import { AppHeaderComponent } from '../app-header/app-header.component';
import { APP_VERSION_DATA } from '../../../core/config/version.config';

@Component({
  selector: 'app-layout',
  imports: [
    CommonModule,
    RouterModule,
    AppHeaderComponent,
    AppSidebarComponent,
    BackdropComponent
  ],
  templateUrl: './app-layout.component.html',
})
export class AppLayoutComponent implements OnInit {
  readonly isExpanded$;
  readonly isHovered$;
  readonly isMobileOpen$;

  readonly versionActual = APP_VERSION_DATA.versionActual;
  readonly mostrarAvisoVersion = signal(false);

  constructor(public sidebarService: SidebarService) {
    this.isExpanded$ = this.sidebarService.isExpanded$;
    this.isHovered$ = this.sidebarService.isHovered$;
    this.isMobileOpen$ = this.sidebarService.isMobileOpen$;
  }

  ngOnInit(): void {
    try {
      const ack = localStorage.getItem('erp_last_ack_version');
      if (ack !== this.versionActual) {
        this.mostrarAvisoVersion.set(true);
      }
    } catch {
      // Ignorar si localStorage no está disponible
    }
  }

  descartarAvisoVersion(): void {
    this.mostrarAvisoVersion.set(false);
    try {
      localStorage.setItem('erp_last_ack_version', this.versionActual);
    } catch {}
  }

  recargarHaciaModuloActualizado(): void {
    const targetUrl = this.sidebarService.chunkErrorUrl() || '/';
    this.sidebarService.chunkErrorUrl.set(null);
    window.location.assign(targetUrl);
  }

  descartarAvisoChunk(): void {
    this.sidebarService.chunkErrorUrl.set(null);
  }

  get containerClasses() {
    return [
      'flex-1',
      'transition-all',
      'duration-300',
      'ease-in-out',
      (this.sidebarService.isExpandedValue || this.sidebarService.isHoveredValue) ? 'xl:ml-[290px]' : 'xl:ml-[90px]',
      this.sidebarService.isMobileOpenValue ? 'ml-0' : ''
    ];
  }
}
