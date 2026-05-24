import { Component, computed, inject } from '@angular/core';
import { DropdownComponent } from '../../ui/dropdown/dropdown.component';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { DropdownItemTwoComponent } from '../../ui/dropdown/dropdown-item/dropdown-item.component-two';
import { AuthService } from '../../../../core/services/auth.service';

@Component({
  selector: 'app-user-dropdown',
  templateUrl: './user-dropdown.component.html',
  imports: [CommonModule, RouterModule, DropdownComponent, DropdownItemTwoComponent]
})
export class UserDropdownComponent {
  private readonly auth = inject(AuthService);

  readonly perfil = this.auth.perfil;

  readonly inicial = computed(() => {
    const nombres = this.auth.perfil()?.nombres;
    if (nombres?.trim()) return nombres.trim()[0].toUpperCase();
    const email = this.auth.perfil()?.email;
    if (email) return email[0].toUpperCase();
    return '?';
  });

  isOpen = false;

  toggleDropdown() {
    this.isOpen = !this.isOpen;
  }

  closeDropdown() {
    this.isOpen = false;
  }

  cerrarSesion(): void {
    void this.auth.logout();
  }
}