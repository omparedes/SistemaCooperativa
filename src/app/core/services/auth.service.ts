import { computed, inject, Injectable, signal } from '@angular/core';
import { Router } from '@angular/router';
import { User } from '@supabase/supabase-js';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos de dominio
// ---------------------------------------------------------------------------
export type TipoRol = 'Administrador' | 'Caja' | 'Asistente';

export interface Perfil {
  id: string;
  email: string;
  rol: TipoRol;
  nombres: string | null;
  activo: boolean;
}

// ---------------------------------------------------------------------------
// Servicio de autenticación
// Gestiona la sesión Supabase y expone el usuario/perfil/rol como Signals.
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly db     = inject(SUPABASE_CLIENT);
  private readonly router = inject(Router);

  // --- Estado ---
  private readonly _usuario  = signal<User | null>(null);
  private readonly _perfil   = signal<Perfil | null>(null);
  private readonly _cargando = signal(true);  // true hasta que getSession() responda

  // --- API pública de solo lectura ---
  readonly usuario  = this._usuario.asReadonly();
  readonly perfil   = this._perfil.asReadonly();
  readonly cargando = this._cargando.asReadonly();

  // --- Computed de roles (para usar en templates / guards) ---
  readonly rol        = computed(() => this._perfil()?.rol ?? null);
  readonly esAdmin    = computed(() => this.rol() === 'Administrador');
  readonly esCaja     = computed(() => this.rol() === 'Caja' || this.rol() === 'Administrador');
  readonly esLectura  = computed(() => this._usuario() !== null); // cualquier usuario autenticado

  // --- Promesa interna para que el guard pueda esperar la inicialización ---
  private readonly initPromise: Promise<void>;

  constructor() {
    this.initPromise = this.inicializar();
  }

  /** El guard la llama antes de decidir si permite o redirige. */
  async esperarInicializacion(): Promise<void> {
    return this.initPromise;
  }

  // -------------------------------------------------------------------------
  // Login / Logout
  // -------------------------------------------------------------------------
  async login(email: string, password: string): Promise<void> {
    const { error } = await this.db.auth.signInWithPassword({ email, password });
    if (error) throw new Error(error.message);
    // onAuthStateChange se dispara automáticamente y actualiza los signals.
  }

  async logout(): Promise<void> {
    await this.db.auth.signOut();
    this._usuario.set(null);
    this._perfil.set(null);
    void this.router.navigate(['/login']);
  }

  // -------------------------------------------------------------------------
  // Inicialización interna
  // -------------------------------------------------------------------------
  private async inicializar(): Promise<void> {
    try {
      // 1. Verificar sesión persistida en localStorage
      const { data: { session } } = await this.db.auth.getSession();
      if (session?.user) {
        this._usuario.set(session.user);
        await this.cargarPerfil(session.user.id);
      }
    } finally {
      this._cargando.set(false);
    }

    // 2. Escuchar cambios de sesión (login, logout, token refresh)
    this.db.auth.onAuthStateChange(async (event, session) => {
      if (session?.user) {
        this._usuario.set(session.user);
        // Solo recargamos el perfil si cambió el usuario
        if (session.user.id !== this._perfil()?.id) {
          await this.cargarPerfil(session.user.id);
        }
      } else {
        this._usuario.set(null);
        this._perfil.set(null);
      }
    });
  }

  private async cargarPerfil(userId: string): Promise<void> {
    const { data, error } = await this.db
      .from('perfiles')
      .select('id, email, rol, nombres, activo')
      .eq('id', userId)
      .single();

    if (!error && data) {
      this._perfil.set(data as Perfil);
    }
  }
}
