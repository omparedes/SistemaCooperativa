import { ApplicationConfig, importProvidersFrom, inject, provideZoneChangeDetection } from '@angular/core';
import { provideRouter, withNavigationErrorHandler } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { Observable, of } from 'rxjs';

import { routes } from './app.routes';
import { es } from './i18n/es';
import { SidebarService } from './core/services/sidebar.service';

export class CustomTranslateLoader implements TranslateLoader {
  getTranslation(_lang: string): Observable<Record<string, unknown>> {
    return of(es);
  }
}

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(
      routes,
      withNavigationErrorHandler((navError) => {
        const msg = String((navError.error as Error | undefined)?.message ?? navError.error ?? '');
        const isChunkError =
          msg.includes('Failed to fetch dynamically imported module') ||
          msg.includes('Importing a module script failed') ||
          msg.includes('ChunkLoadError') ||
          msg.includes('error loading dynamically imported module');

        if (isChunkError) {
          // Aviso seguro sin recarga automática para evitar pérdida de datos en formularios o cobros en curso.
          const sidebarSvc = inject(SidebarService);
          sidebarSvc.chunkErrorUrl.set(navError.url || '/');
        }
      }),
    ),
    provideHttpClient(),
    importProvidersFrom(
      TranslateModule.forRoot({
        defaultLanguage: 'es',
        loader: { provide: TranslateLoader, useClass: CustomTranslateLoader }
      })
    )
  ]
};
