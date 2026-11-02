import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { APP_VERSION_DATA } from '../../../core/config/version.config';

@Component({
  selector: 'app-sidebar-widget',
  standalone: true,
  imports: [RouterModule],
  template: `
    <div class="mx-auto mb-8 w-full max-w-60 rounded-2xl bg-gray-50 p-4 text-center border border-gray-200/60 dark:bg-white/[0.03] dark:border-gray-800">
      <div class="flex items-center justify-center gap-1.5 mb-1.5">
        <span class="inline-block h-2 w-2 rounded-full bg-emerald-500 animate-pulse"></span>
        <span class="text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Sistema Primero de Mayo</span>
      </div>
      <div class="my-1.5">
        <span class="inline-flex items-center gap-1 rounded-full bg-brand-50 px-2.5 py-0.5 text-xs font-bold text-brand-700 dark:bg-brand-900/30 dark:text-brand-300">
          v{{ versionData.versionActual }}
        </span>
      </div>
      <p class="text-xs text-gray-400 dark:text-gray-500 mb-2.5">
        {{ versionData.ambiente }} · {{ versionData.fechaActualizacion }}
      </p>
      <a routerLink="/documentacion/novedades"
        class="inline-flex items-center gap-1 text-xs font-medium text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300 transition group">
        <span>Ver novedades</span>
        <svg class="h-3 w-3 transform transition-transform group-hover:translate-x-0.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
        </svg>
      </a>
    </div>
  `
})
export class SidebarWidgetComponent {
  readonly versionData = APP_VERSION_DATA;
}
