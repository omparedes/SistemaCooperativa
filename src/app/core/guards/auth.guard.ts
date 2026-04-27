import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';

/**
 * Protege todas las rutas bajo AppLayoutComponent.
 * Espera a que AuthService termine de verificar la sesión persistida
 * antes de decidir si permite el acceso o redirige a /login.
 */
export const authGuard: CanActivateFn = async () => {
  const auth   = inject(AuthService);
  const router = inject(Router);

  await auth.esperarInicializacion();

  // Requerimos usuario Y perfil: las sesiones anónimas previas tienen usuario
  // pero no tienen fila en public.perfiles, así que caen al /signin.
  if (auth.usuario() !== null && auth.perfil() !== null) return true;

  return router.createUrlTree(['/signin']);
};

/**
 * Redirige a / si el usuario ya está autenticado.
 * Usado en la ruta /login para evitar que un usuario logueado vea el login.
 */
export const noAuthGuard: CanActivateFn = async () => {
  const auth   = inject(AuthService);
  const router = inject(Router);

  await auth.esperarInicializacion();

  if (auth.usuario() === null || auth.perfil() === null) return true;

  return router.createUrlTree(['/']);
};
