import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { APP_VERSION_DATA, ReleaseNote } from '../../core/config/version.config';

type VistaNovedades = 'admin' | 'tecnica';

@Component({
  selector: 'app-novedades',
  standalone: true,
  imports: [CommonModule, RouterModule],
  template: `
    <div class="p-4 md:p-6 max-w-7xl mx-auto space-y-6">

      <!-- ── Encabezado Institucional ────────────────────────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white p-6 md:p-8 shadow-xs dark:border-gray-800 dark:bg-gray-900">
        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-gray-100 pb-6 dark:border-gray-800">
          <div>
            <div class="flex items-center gap-2 mb-2">
              <span class="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-0.5 text-xs font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400">
                <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>
                {{ versionData.ambiente }}
              </span>
              <span class="rounded-full bg-brand-50 px-2.5 py-0.5 text-xs font-bold text-brand-700 dark:bg-brand-900/30 dark:text-brand-300">
                v{{ versionData.versionActual }}
              </span>
            </div>
            <h1 class="text-2xl md:text-3xl font-bold text-gray-900 dark:text-white">
              Novedades y Registro de Versiones
            </h1>
            <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
              ERP Mercado Cooperativo Primero de Mayo · Publicación oficial {{ versionData.fechaActualizacion }}
            </p>
          </div>

          <!-- Selector de Modo de Lectura -->
          <div class="inline-flex rounded-xl border border-gray-200 bg-gray-50 p-1 dark:border-gray-700 dark:bg-gray-800 self-start md:self-auto">
            <button
              (click)="modoVista.set('admin')"
              [class]="modoVista() === 'admin'
                ? 'bg-white text-gray-900 shadow-xs dark:bg-gray-700 dark:text-white'
                : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
              class="flex items-center gap-1.5 rounded-lg px-3 py-1.5 text-xs font-semibold transition">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
              </svg>
              Vista Administrativa
            </button>
            <button
              (click)="modoVista.set('tecnica')"
              [class]="modoVista() === 'tecnica'
                ? 'bg-white text-gray-900 shadow-xs dark:bg-gray-700 dark:text-white'
                : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
              class="flex items-center gap-1.5 rounded-lg px-3 py-1.5 text-xs font-semibold transition">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>
              Vista Técnica / Auditoría
            </button>
          </div>
        </div>

        <!-- Metadatos de Arquitectura -->
        <div class="mt-4 flex flex-wrap items-center gap-y-2 gap-x-6 text-xs text-gray-500 dark:text-gray-400">
          <div class="flex items-center gap-1.5">
            <span class="font-medium text-gray-700 dark:text-gray-300">Arquitectura:</span>
            <span>{{ versionData.arquitectura }}</span>
          </div>
          <div class="flex items-center gap-1.5">
            <span class="font-medium text-gray-700 dark:text-gray-300">Cumplimiento:</span>
            <span>ACID Transaccional · RLS Activo</span>
          </div>
          <div class="flex items-center gap-3 ml-auto">
            <a routerLink="/documentacion/manual" class="text-brand-600 hover:underline dark:text-brand-400 font-medium">Manual de Usuario →</a>
            <a routerLink="/documentacion/tecnica" class="text-brand-600 hover:underline dark:text-brand-400 font-medium">Documentación Técnica →</a>
          </div>
        </div>
      </div>

      <!-- ── Versión Actual Destacada ────────────────────────────────────── -->
      @if (versionActual(); as actual) {
        <div class="rounded-2xl border-2 border-brand-500/30 bg-white p-6 shadow-sm dark:border-brand-500/40 dark:bg-gray-900">
          <div class="flex flex-wrap items-center justify-between gap-3 border-b border-gray-100 pb-4 dark:border-gray-800">
            <div class="flex items-center gap-3">
              <span class="rounded-xl bg-brand-600 px-3 py-1 text-sm font-bold text-white shadow-xs">
                v{{ actual.version }}
              </span>
              <div>
                <span class="inline-block rounded-full bg-brand-50 px-2 py-0.5 text-[11px] font-semibold text-brand-700 dark:bg-brand-900/40 dark:text-brand-300 mr-2">
                  Versión Vigente
                </span>
                <span class="text-xs text-gray-500 dark:text-gray-400">{{ actual.fecha }}</span>
              </div>
            </div>
            <h2 class="text-lg font-bold text-gray-900 dark:text-white">
              {{ actual.titulo }}
            </h2>
          </div>

          <!-- Contenido según modo de lectura -->
          <div class="mt-5">
            @if (modoVista() === 'admin') {
              <div class="space-y-3">
                <p class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500">
                  Mejoras Operativas para la Administración y Caja
                </p>
                <div class="grid gap-3 sm:grid-cols-2">
                  @for (item of actual.resumenAdministrativo; track item) {
                    <div class="flex items-start gap-3 rounded-xl border border-gray-100 bg-gray-50/70 p-3.5 dark:border-gray-800 dark:bg-gray-800/40">
                      <div class="rounded-lg bg-emerald-100 p-1.5 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400 mt-0.5 shrink-0">
                        <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                        </svg>
                      </div>
                      <p class="text-xs text-gray-700 dark:text-gray-300 leading-relaxed">{{ item }}</p>
                    </div>
                  }
                </div>
              </div>
            } @else {
              <div class="space-y-4">
                <p class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500">
                  Especificaciones Técnicas, Base de Datos y Commits
                </p>
                @for (sec of actual.detallesTecnicos; track sec.categoria) {
                  <div class="rounded-xl border border-gray-100 bg-gray-50/60 p-4 dark:border-gray-800 dark:bg-gray-800/30">
                    <h3 class="text-xs font-bold text-gray-900 dark:text-white mb-2">{{ sec.categoria }}</h3>
                    <ul class="space-y-1.5 text-xs text-gray-600 dark:text-gray-300 list-disc list-inside">
                      @for (t of sec.items; track t) {
                        <li>{{ t }}</li>
                      }
                    </ul>
                  </div>
                }
                @if (actual.commits?.length || actual.migraciones?.length) {
                  <div class="flex flex-wrap items-center gap-4 pt-2 text-[11px] text-gray-500 dark:text-gray-400">
                    @if (actual.commits?.length) {
                      <div>
                        <span class="font-semibold text-gray-700 dark:text-gray-300">Commits Git:</span>
                        <span class="font-mono ml-1">{{ actual.commits?.join(', ') }}</span>
                      </div>
                    }
                    @if (actual.migraciones?.length) {
                      <div>
                        <span class="font-semibold text-gray-700 dark:text-gray-300">Migraciones SQL:</span>
                        <span class="font-mono ml-1">{{ actual.migraciones?.join(', ') }}</span>
                      </div>
                    }
                  </div>
                }
              </div>
            }
          </div>
        </div>
      }

      <!-- ── Historial de Versiones Anteriores (Acordeón) ─────────────────── -->
      <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-xs dark:border-gray-800 dark:bg-gray-900 space-y-4">
        <h2 class="text-base font-bold text-gray-900 dark:text-white">
          Historial de Versiones Anteriores
        </h2>
        <p class="text-xs text-gray-500 dark:text-gray-400 -mt-2">
          Evolución del ERP desde el lanzamiento inicial de producción (Go-Live)
        </p>

        <div class="space-y-3 pt-2">
          @for (rel of versionesAnteriores(); track rel.version) {
            <div class="rounded-xl border border-gray-200 dark:border-gray-800 overflow-hidden">
              <button
                type="button"
                (click)="toggleVersion(rel.version)"
                class="w-full flex items-center justify-between p-4 text-left bg-gray-50/70 hover:bg-gray-100/60 dark:bg-gray-800/40 dark:hover:bg-gray-800/80 transition">
                <div class="flex flex-wrap items-center gap-3">
                  <span class="rounded-lg bg-gray-200 dark:bg-gray-700 px-2.5 py-1 text-xs font-bold text-gray-800 dark:text-gray-200">
                    v{{ rel.version }}
                  </span>
                  <span class="text-xs text-gray-500 dark:text-gray-400">{{ rel.fecha }}</span>
                  <span class="text-sm font-semibold text-gray-900 dark:text-white">{{ rel.titulo }}</span>
                </div>
                <svg
                  [class.rotate-180]="isVersionOpen(rel.version)"
                  class="h-4 w-4 text-gray-400 transform transition-transform shrink-0"
                  fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7"/>
                </svg>
              </button>

              @if (isVersionOpen(rel.version)) {
                <div class="p-4 bg-white dark:bg-gray-900 border-t border-gray-100 dark:border-gray-800 space-y-3">
                  @if (modoVista() === 'admin') {
                    <ul class="space-y-2 text-xs text-gray-600 dark:text-gray-300">
                      @for (p of rel.resumenAdministrativo; track p) {
                        <li class="flex items-start gap-2">
                          <span class="text-emerald-500 font-bold shrink-0">✓</span>
                          <span>{{ p }}</span>
                        </li>
                      }
                    </ul>
                  } @else {
                    <div class="space-y-3">
                      @for (sec of rel.detallesTecnicos; track sec.categoria) {
                        <div>
                          <h4 class="text-xs font-bold text-gray-800 dark:text-gray-200 mb-1">{{ sec.categoria }}</h4>
                          <ul class="space-y-1 text-xs text-gray-600 dark:text-gray-300 list-disc list-inside">
                            @for (it of sec.items; track it) {
                              <li>{{ it }}</li>
                            }
                          </ul>
                        </div>
                      }
                      @if (rel.commits?.length || rel.migraciones?.length) {
                        <div class="pt-2 border-t border-gray-100 dark:border-gray-800 text-[11px] text-gray-400 flex flex-wrap gap-4">
                          @if (rel.commits?.length) {
                            <span>Commits: <strong class="font-mono">{{ rel.commits?.join(', ') }}</strong></span>
                          }
                          @if (rel.migraciones?.length) {
                            <span>Migraciones: <strong class="font-mono">{{ rel.migraciones?.join(', ') }}</strong></span>
                          }
                        </div>
                      }
                    </div>
                  }
                </div>
              }
            </div>
          }
        </div>
      </div>

    </div>
  `
})
export class NovedadesComponent {
  readonly versionData = APP_VERSION_DATA;
  readonly modoVista = signal<VistaNovedades>('admin');
  readonly versionesAbiertas = signal<Record<string, boolean>>({
    '2.4.0': true
  });

  readonly versionActual = signal<ReleaseNote | undefined>(
    APP_VERSION_DATA.historial[0]
  );

  readonly versionesAnteriores = signal<ReleaseNote[]>(
    APP_VERSION_DATA.historial.slice(1)
  );

  toggleVersion(version: string): void {
    const current = { ...this.versionesAbiertas() };
    current[version] = !current[version];
    this.versionesAbiertas.set(current);
  }

  isVersionOpen(version: string): boolean {
    return !!this.versionesAbiertas()[version];
  }
}
