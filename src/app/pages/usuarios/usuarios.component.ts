import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { SlicePipe } from '@angular/common';
import { createClient } from '@supabase/supabase-js';
import { environment } from '../../../environments/environment';
import { SUPABASE_CLIENT } from '../../core/services/supabase.client';
import { AuthService, TipoRol } from '../../core/services/auth.service';

interface PerfilRow {
  id: string;
  email: string;
  rol: TipoRol;
  nombres: string | null;
  activo: boolean;
  created_at: string;
}

const ROLES: TipoRol[] = ['Administrador', 'Caja', 'Asistente'];

@Component({
  selector: 'app-usuarios',
  standalone: true,
  imports: [FormsModule, SlicePipe],
  template: `
    <div class="p-6 max-w-5xl mx-auto">

      <!-- Cabecera -->
      <header class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 mb-6">
        <div>
          <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Gestión de Usuarios</h2>
          <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
            {{ usuariosFiltrados().length }} usuario{{ usuariosFiltrados().length !== 1 ? 's' : '' }}
          </p>
        </div>
        <button (click)="abrirModal()"
          class="inline-flex items-center gap-2 px-4 py-2 bg-brand-600 hover:bg-brand-700 text-white rounded-lg shadow-sm font-medium transition text-sm">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
          </svg>
          Nuevo Usuario
        </button>
      </header>

      <!-- Error global -->
      @if (error()) {
        <div class="mb-4 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm flex items-start gap-2">
          <svg class="w-4 h-4 mt-0.5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M12 8v4m0 4h.01"/>
          </svg>
          <span>{{ error() }}</span>
        </div>
      }

      <!-- Buscador -->
      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-3 mb-4">
        <input
          type="search"
          placeholder="Buscar por nombre, email o rol..."
          [ngModel]="busqueda()" (ngModelChange)="busqueda.set($event)"
          class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
      </div>

      <!-- Tabla -->
      <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm overflow-hidden">
        @if (loading()) {
          <div class="p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
            <span class="h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
            Cargando usuarios...
          </div>
        } @else if (usuariosFiltrados().length === 0) {
          <div class="p-12 text-center text-gray-400 dark:text-gray-500 text-sm">
            No se encontraron usuarios.
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs tracking-wider">
                <tr>
                  <th class="px-4 py-3 text-left font-semibold">Usuario</th>
                  <th class="px-4 py-3 text-left font-semibold">Rol</th>
                  <th class="px-4 py-3 text-center font-semibold">Estado</th>
                  <th class="px-4 py-3 text-left font-semibold">Creado</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (u of usuariosFiltrados(); track u.id) {
                  <tr class="hover:bg-gray-50 dark:hover:bg-white/[0.02] transition-colors"
                      [class.opacity-50]="!u.activo">
                    <!-- Usuario: avatar + nombre + email -->
                    <td class="px-4 py-3">
                      <div class="flex items-center gap-3">
                        <span class="flex items-center justify-center rounded-full h-9 w-9 shrink-0 font-semibold text-sm text-white select-none"
                          [class]="avatarClass(u.rol)">
                          {{ inicial(u) }}
                        </span>
                        <div class="min-w-0">
                          <p class="font-medium text-gray-900 dark:text-white truncate">
                            {{ u.nombres ?? '—' }}
                            @if (u.id === miId()) {
                              <span class="ml-1 text-xs text-gray-400 dark:text-gray-500">(yo)</span>
                            }
                          </p>
                          <p class="text-xs text-gray-500 dark:text-gray-400 truncate">{{ u.email }}</p>
                        </div>
                      </div>
                    </td>

                    <!-- Rol: select inline -->
                    <td class="px-4 py-3">
                      <select
                        [ngModel]="u.rol"
                        (ngModelChange)="cambiarRol(u, $event)"
                        [disabled]="u.id === miId()"
                        class="border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white rounded-lg px-2 py-1 text-xs focus:outline-none focus:ring-2 focus:ring-brand-500 disabled:opacity-50 disabled:cursor-not-allowed">
                        @for (r of roles; track r) {
                          <option [value]="r">{{ r }}</option>
                        }
                      </select>
                    </td>

                    <!-- Estado: toggle activo -->
                    <td class="px-4 py-3 text-center">
                      <button
                        (click)="toggleActivo(u)"
                        [disabled]="u.id === miId()"
                        [title]="u.activo ? 'Desactivar usuario' : 'Activar usuario'"
                        class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium transition disabled:cursor-not-allowed"
                        [class]="u.activo
                          ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 hover:bg-green-200 dark:hover:bg-green-900/50'
                          : 'bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-600'">
                        <span class="h-1.5 w-1.5 rounded-full"
                          [class]="u.activo ? 'bg-green-500' : 'bg-gray-400'"></span>
                        {{ u.activo ? 'Activo' : 'Inactivo' }}
                      </button>
                    </td>

                    <!-- Fecha creación -->
                    <td class="px-4 py-3 text-gray-500 dark:text-gray-400 text-xs whitespace-nowrap">
                      {{ u.created_at | slice:0:10 }}
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        }
      </div>

    </div>

    <!-- ── Modal: Nuevo Usuario ───────────────────────────────────────────── -->
    @if (modalAbierto()) {
      <div class="fixed inset-0 z-[9999] flex items-center justify-center bg-black/50 px-4"
           (click)="cerrarModal()">
        <div class="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md p-6"
             (click)="$event.stopPropagation()">

          <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Nuevo Usuario</h3>

          @if (errorModal()) {
            <div class="mb-4 p-3 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-300 text-sm">
              {{ errorModal() }}
            </div>
          }

          <div class="flex flex-col gap-4">

            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Nombre completo</label>
              <input type="text" [ngModel]="nuevoNombre()" (ngModelChange)="nuevoNombre.set($event)"
                placeholder="Ej: María García"
                class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
            </div>

            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Correo electrónico <span class="text-red-500">*</span></label>
              <input type="email" [ngModel]="nuevoEmail()" (ngModelChange)="nuevoEmail.set($event)"
                placeholder="usuario@correo.com"
                class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
            </div>

            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Contraseña temporal <span class="text-red-500">*</span></label>
              <input type="password" [ngModel]="nuevaContrasena()" (ngModelChange)="nuevaContrasena.set($event)"
                placeholder="Mínimo 6 caracteres"
                class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
            </div>

            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Rol</label>
              <select [ngModel]="nuevoRol()" (ngModelChange)="nuevoRol.set($event)"
                class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                @for (r of roles; track r) {
                  <option [value]="r">{{ r }}</option>
                }
              </select>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">
                @if (nuevoRol() === 'Administrador') { Acceso total al sistema. }
                @if (nuevoRol() === 'Caja') { Operación diaria: pagos, gastos y recaudación. }
                @if (nuevoRol() === 'Asistente') { Solo lectura. }
              </p>
            </div>

          </div>

          <div class="flex justify-end gap-3 mt-6">
            <button (click)="cerrarModal()" [disabled]="guardando()"
              class="px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5 transition disabled:opacity-50">
              Cancelar
            </button>
            <button (click)="crearUsuario()" [disabled]="guardando() || !nuevoEmail() || !nuevaContrasena()"
              class="inline-flex items-center gap-2 px-4 py-2 bg-brand-600 hover:bg-brand-700 text-white rounded-lg text-sm font-medium shadow-sm transition disabled:opacity-50 disabled:cursor-not-allowed">
              @if (guardando()) {
                <span class="h-4 w-4 rounded-full border-2 border-white border-t-transparent animate-spin"></span>
                Creando...
              } @else {
                Crear Usuario
              }
            </button>
          </div>
        </div>
      </div>
    }
  `,
})
export class UsuariosComponent implements OnInit {
  private readonly db   = inject(SUPABASE_CLIENT);
  private readonly auth = inject(AuthService);

  readonly roles = ROLES;

  readonly usuarios  = signal<PerfilRow[]>([]);
  readonly loading   = signal(true);
  readonly error     = signal<string | null>(null);
  readonly busqueda  = signal('');

  readonly miId = computed(() => this.auth.perfil()?.id ?? null);

  readonly usuariosFiltrados = computed(() => {
    const q = this.busqueda().toLowerCase().trim();
    if (!q) return this.usuarios();
    return this.usuarios().filter(u =>
      (u.nombres ?? '').toLowerCase().includes(q) ||
      u.email.toLowerCase().includes(q) ||
      u.rol.toLowerCase().includes(q)
    );
  });

  // Modal
  readonly modalAbierto    = signal(false);
  readonly guardando       = signal(false);
  readonly nuevoEmail      = signal('');
  readonly nuevoNombre     = signal('');
  readonly nuevaContrasena = signal('');
  readonly nuevoRol        = signal<TipoRol>('Asistente');
  readonly errorModal      = signal<string | null>(null);

  async ngOnInit(): Promise<void> {
    await this.cargar();
  }

  async cargar(): Promise<void> {
    this.loading.set(true);
    this.error.set(null);
    const { data, error } = await this.db
      .from('perfiles')
      .select('id, email, rol, nombres, activo, created_at')
      .order('created_at', { ascending: true });
    if (error) {
      this.error.set(error.message);
    } else {
      this.usuarios.set((data ?? []) as PerfilRow[]);
    }
    this.loading.set(false);
  }

  async cambiarRol(u: PerfilRow, rol: TipoRol): Promise<void> {
    const { error } = await this.db
      .from('perfiles')
      .update({ rol })
      .eq('id', u.id);
    if (error) {
      this.error.set('Error al cambiar rol: ' + error.message);
    } else {
      this.usuarios.update(list => list.map(x => x.id === u.id ? { ...x, rol } : x));
    }
  }

  async toggleActivo(u: PerfilRow): Promise<void> {
    const activo = !u.activo;
    const { error } = await this.db
      .from('perfiles')
      .update({ activo })
      .eq('id', u.id);
    if (error) {
      this.error.set('Error al cambiar estado: ' + error.message);
    } else {
      this.usuarios.update(list => list.map(x => x.id === u.id ? { ...x, activo } : x));
    }
  }

  async crearUsuario(): Promise<void> {
    this.guardando.set(true);
    this.errorModal.set(null);

    // Cliente temporal para no reemplazar la sesión del administrador
    const tempClient = createClient(environment.supabaseUrl, environment.supabaseAnonKey);

    const { data, error } = await tempClient.auth.signUp({
      email: this.nuevoEmail().trim(),
      password: this.nuevaContrasena(),
      options: { data: { nombres: this.nuevoNombre().trim() || null } },
    });

    if (error) {
      this.errorModal.set(error.message);
      this.guardando.set(false);
      await tempClient.auth.signOut();
      return;
    }

    // Si el rol es distinto de Asistente, actualizarlo con el cliente admin
    if (data.user && this.nuevoRol() !== 'Asistente') {
      const { error: rolError } = await this.db
        .from('perfiles')
        .update({ rol: this.nuevoRol() })
        .eq('id', data.user.id);
      if (rolError) {
        this.errorModal.set('Usuario creado, pero no se pudo asignar el rol: ' + rolError.message);
        this.guardando.set(false);
        await tempClient.auth.signOut();
        return;
      }
    }

    await tempClient.auth.signOut();
    this.cerrarModal();
    await this.cargar();
  }

  abrirModal(): void {
    this.nuevoEmail.set('');
    this.nuevoNombre.set('');
    this.nuevaContrasena.set('');
    this.nuevoRol.set('Asistente');
    this.errorModal.set(null);
    this.modalAbierto.set(true);
  }

  cerrarModal(): void {
    this.modalAbierto.set(false);
    this.guardando.set(false);
  }

  inicial(u: PerfilRow): string {
    const n = u.nombres?.trim();
    return (n ? n[0] : u.email[0]).toUpperCase();
  }

  avatarClass(rol: TipoRol): string {
    switch (rol) {
      case 'Administrador': return 'bg-brand-600';
      case 'Caja':          return 'bg-amber-500';
      case 'Asistente':     return 'bg-gray-500';
    }
  }
}
