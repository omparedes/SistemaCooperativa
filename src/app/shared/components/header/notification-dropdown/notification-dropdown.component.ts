import { computed, Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { DropdownComponent } from '../../ui/dropdown/dropdown.component';
import {
  NotificacionesService,
  NotificacionUI,
  TipoNotificacion,
} from '../../../../core/services/notificaciones.service';

interface TipoConfig {
  emoji: string;
  badgeClass: string;
  iconBg: string;
  labelColor: string;
  label: string;
}

const TIPO_CONFIG: Record<TipoNotificacion, TipoConfig> = {
  auditoria:  {
    emoji: '🚨',
    badgeClass: 'bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-400',
    iconBg: 'bg-red-100 dark:bg-red-900/40',
    labelColor: 'text-red-600 dark:text-red-400',
    label: 'Auditoría',
  },
  inventario: {
    emoji: '📦',
    badgeClass: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/40 dark:text-yellow-400',
    iconBg: 'bg-yellow-100 dark:bg-yellow-900/40',
    labelColor: 'text-yellow-600 dark:text-yellow-400',
    label: 'Inventario',
  },
  morosidad:  {
    emoji: '💸',
    badgeClass: 'bg-orange-100 text-orange-700 dark:bg-orange-900/40 dark:text-orange-400',
    iconBg: 'bg-orange-100 dark:bg-orange-900/40',
    labelColor: 'text-orange-600 dark:text-orange-400',
    label: 'Morosidad',
  },
  caja:       {
    emoji: '📊',
    badgeClass: 'bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-400',
    iconBg: 'bg-blue-100 dark:bg-blue-900/40',
    labelColor: 'text-blue-600 dark:text-blue-400',
    label: 'Caja',
  },
};

@Component({
  selector: 'app-notification-dropdown',
  templateUrl: './notification-dropdown.component.html',
  imports: [CommonModule, RouterModule, DropdownComponent],
})
export class NotificationDropdownComponent {
  protected readonly svc = inject(NotificacionesService);

  isOpen = false;

  protected readonly badgeLabel = computed<string>(() => {
    const n = this.svc.noLeidas();
    return n === 0 ? '' : n > 9 ? '9+' : String(n);
  });

  toggleDropdown(): void {
    this.isOpen = !this.isOpen;
    if (this.isOpen) void this.svc.cargar();
  }

  closeDropdown(): void {
    this.isOpen = false;
  }

  async marcarLeidas(): Promise<void> {
    await this.svc.marcarTodasLeidas();
  }

  config(tipo: TipoNotificacion): TipoConfig {
    return TIPO_CONFIG[tipo] ?? TIPO_CONFIG['auditoria'];
  }

  recargar(): void {
    void this.svc.cargar();
  }

  formatFecha(iso: string): string {
    if (!iso) return '—';
    try {
      return new Date(iso).toLocaleString('es-PE', {
        day: '2-digit',
        month: 'short',
        hour: '2-digit',
        minute: '2-digit',
      });
    } catch {
      return '—';
    }
  }
}
