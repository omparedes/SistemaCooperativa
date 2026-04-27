import { Component, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [],
  template: `
    <div class="min-h-screen bg-gray-100 dark:bg-gray-900 flex items-center justify-center px-4">

      <div class="w-full max-w-md">

        <!-- ── Encabezado Cooperativa ─────────────────────────────────── -->
        <div class="text-center mb-8">
          <!-- Escudo / logotipo textual -->
          <div class="mx-auto mb-4 flex h-20 w-20 items-center justify-center rounded-2xl bg-brand-600 shadow-lg">
            <svg class="h-10 w-10 text-white" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round"
                d="M13.5 21v-7.5a.75.75 0 01.75-.75h3a.75.75 0 01.75.75V21m-4.5 0H2.36m11.14 0H18m0 0h3.64m-1.39 0V9.349m-16.5 11.65V9.35m0 0a3.001 3.001 0 003.75-.615A2.993 2.993 0 009.75 9.75c.896 0 1.7-.393 2.25-1.016a2.993 2.993 0 002.25 1.016c.896 0 1.7-.393 2.25-1.016a3.001 3.001 0 003.75.614m-16.5 0a3.004 3.004 0 01-.621-4.72L4.318 3.44A1.5 1.5 0 015.378 3h13.243a1.5 1.5 0 011.06.44l1.19 1.189a3 3 0 01-.621 4.72m-13.5 8.65h3.75a.75.75 0 00.75-.75V13.5a.75.75 0 00-.75-.75H6.75a.75.75 0 00-.75.75v3.75c0 .415.336.75.75.75z"/>
            </svg>
          </div>
          <h1 class="text-xl font-bold text-gray-900 dark:text-white">COOPERATIVA PRIMERO DE MAYO</h1>
          <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">Sistema Interno de Gestión · Mercado Municipal</p>
        </div>

        <!-- ── Tarjeta del formulario ─────────────────────────────────── -->
        <div class="rounded-2xl border border-gray-200 bg-white p-8 shadow-sm dark:border-gray-700 dark:bg-gray-800">

          <h2 class="mb-6 text-lg font-semibold text-gray-800 dark:text-white">Iniciar sesión</h2>

          <form (submit)="onSubmit($event)" novalidate>

            <!-- Email -->
            <div class="mb-4">
              <label for="email" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Correo electrónico
              </label>
              <input
                id="email"
                type="email"
                autocomplete="email"
                placeholder="cajero@cooperativa.pe"
                [value]="email()"
                (input)="email.set(getInputValue($event))"
                [disabled]="cargando()"
                class="h-11 w-full rounded-lg border border-gray-300 bg-gray-50 px-4 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 disabled:opacity-50 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
              />
            </div>

            <!-- Contraseña -->
            <div class="mb-6">
              <label for="password" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                Contraseña
              </label>
              <div class="relative">
                <input
                  id="password"
                  [type]="mostrarPassword() ? 'text' : 'password'"
                  autocomplete="current-password"
                  placeholder="••••••••"
                  [value]="password()"
                  (input)="password.set(getInputValue($event))"
                  [disabled]="cargando()"
                  class="h-11 w-full rounded-lg border border-gray-300 bg-gray-50 px-4 pr-11 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 disabled:opacity-50 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
                />
                <button
                  type="button"
                  (click)="mostrarPassword.set(!mostrarPassword())"
                  class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300">
                  @if (mostrarPassword()) {
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88"/>
                    </svg>
                  } @else {
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/>
                      <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                    </svg>
                  }
                </button>
              </div>
            </div>

            <!-- Error -->
            @if (errorMsg()) {
              <div class="mb-4 rounded-lg bg-red-50 border border-red-200 px-4 py-3 text-sm text-red-700 dark:bg-red-900/20 dark:border-red-800 dark:text-red-400">
                {{ errorMsg() }}
              </div>
            }

            <!-- Botón submit -->
            <button
              type="submit"
              [disabled]="cargando() || !email() || !password()"
              class="flex w-full items-center justify-center gap-2 rounded-lg bg-brand-600 px-6 py-3 text-sm font-semibold text-white transition hover:bg-brand-700 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed">
              @if (cargando()) {
                <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Verificando…
              } @else {
                Ingresar al sistema
              }
            </button>

          </form>
        </div>

        <!-- ── Pie de página ─────────────────────────────────────────── -->
        <p class="mt-6 text-center text-xs text-gray-400 dark:text-gray-500">
          Sistema interno — Uso exclusivo de personal autorizado.
        </p>

      </div>
    </div>
  `,
})
export class LoginComponent {
  private readonly authService = inject(AuthService);
  private readonly router      = inject(Router);

  readonly email          = signal('');
  readonly password       = signal('');
  readonly cargando       = signal(false);
  readonly errorMsg       = signal<string | null>(null);
  readonly mostrarPassword = signal(false);

  getInputValue(event: Event): string {
    return (event.target as HTMLInputElement).value;
  }

  async onSubmit(event: Event): Promise<void> {
    event.preventDefault();
    if (!this.email() || !this.password()) return;

    this.cargando.set(true);
    this.errorMsg.set(null);

    try {
      await this.authService.login(this.email(), this.password());
      await this.router.navigate(['/']);
    } catch (e: unknown) {
      const raw = e instanceof Error ? e.message : 'Error desconocido';
      // Mensajes amigables para errores comunes de Supabase Auth
      if (raw.toLowerCase().includes('invalid login')) {
        this.errorMsg.set('Credenciales incorrectas. Verifica tu correo y contraseña.');
      } else if (raw.toLowerCase().includes('email not confirmed')) {
        this.errorMsg.set('Confirma tu correo electrónico antes de ingresar.');
      } else {
        this.errorMsg.set(raw);
      }
    } finally {
      this.cargando.set(false);
    }
  }
}
