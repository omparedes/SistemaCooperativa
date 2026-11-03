import { ApplicationConfig, inject, provideZoneChangeDetection } from '@angular/core';
import { provideRouter, withNavigationErrorHandler } from '@angular/router';

import { routes } from './app.routes';
import { SidebarService } from './core/services/sidebar.service';

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(
      routes,
      withNavigationErrorHandler((navError) => {
        const msg = String((navError.error as Error)?.message ?? navError.error ?? '');
        const isChunkError =
          msg.includes('Failed to fetch dynamically imported module') ||
          msg.includes('ChunkLoadError') ||
          msg.includes('Importing a module script failed') ||
          msg.includes('error loading dynamically imported module');

        if (isChunkError) {
          const sidebarSvc = inject(SidebarService);
          sidebarSvc.chunkErrorUrl.set(navError.url);
        }
      }),
    ),
  ],
};
