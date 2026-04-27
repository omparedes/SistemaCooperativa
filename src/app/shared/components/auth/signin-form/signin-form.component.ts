import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../../core/services/auth.service';

@Component({
  selector: 'app-signin-form',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './signin-form.component.html',
})
export class SigninFormComponent {
  private readonly authService = inject(AuthService);
  private readonly router      = inject(Router);

  email       = '';
  password    = '';
  showPassword = false;
  cargando    = false;
  errorMsg: string | null = null;

  togglePasswordVisibility(): void {
    this.showPassword = !this.showPassword;
  }

  async onSignIn(): Promise<void> {
    if (!this.email || !this.password) return;

    this.cargando = true;
    this.errorMsg = null;

    try {
      await this.authService.login(this.email, this.password);
      await this.router.navigate(['/']);
    } catch (e: unknown) {
      const raw = e instanceof Error ? e.message : 'Error desconocido';
      if (raw.toLowerCase().includes('invalid login credentials') ||
          raw.toLowerCase().includes('invalid login')) {
        this.errorMsg = 'Correo o contraseña incorrectos. Verifica tus datos.';
      } else if (raw.toLowerCase().includes('email not confirmed')) {
        this.errorMsg = 'Debes confirmar tu correo electrónico antes de ingresar.';
      } else {
        this.errorMsg = raw;
      }
    } finally {
      this.cargando = false;
    }
  }
}
