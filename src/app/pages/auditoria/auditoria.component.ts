import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

interface AuditoriaRegistro {
  id?: number;
  fecha: string; // ISO
  usuario: string;
  accion: string;
  tabla: string;
  ip_origen?: string;
  valor_anterior?: any; // JSON
  valor_nuevo?: any; // JSON
}

@Component({
  selector: 'app-auditoria',
  templateUrl: './auditoria.component.html',
  standalone: true,
  imports: [CommonModule, FormsModule],
})
export class AuditoriaComponent implements OnInit {
  registros: AuditoriaRegistro[] = [];
  filtered: AuditoriaRegistro[] = [];

  // Filters
  filtroUsuario = '';
  filtroTabla = '';
  fechaDesde: string | null = null; // yyyy-mm-dd
  fechaHasta: string | null = null; // yyyy-mm-dd

  constructor() {}

  ngOnInit(): void {
    this.seedIfEmpty();
    this.cargar();
  }

  private seedIfEmpty() {
    try {
      const key = 'AuditoriaDeCambios';
      const raw = localStorage.getItem(key);
      if (!raw || raw === '[]') {
        const now = new Date();
        const samples: AuditoriaRegistro[] = [
          {
            id: 1,
            fecha: new Date(now.getTime() - 1000 * 60 * 60 * 24 * 2).toISOString(),
            usuario: 'admin',
            accion: 'INSERT',
            tabla: 'socios',
            ip_origen: '192.168.1.10',
            valor_anterior: null,
            valor_nuevo: { id: 101, nombre: 'Garcia, Juan', cuota: 100 }
          },
          {
            id: 2,
            fecha: new Date(now.getTime() - 1000 * 60 * 60 * 24).toISOString(),
            usuario: 'operador',
            accion: 'UPDATE',
            tabla: 'pagos',
            ip_origen: '10.0.0.5',
            valor_anterior: { id: 501, monto: 500, estado: 'pendiente' },
            valor_nuevo: { id: 501, monto: 500, estado: 'confirmado' }
          },
          {
            id: 3,
            fecha: now.toISOString(),
            usuario: 'conta',
            accion: 'DELETE',
            tabla: 'gastos',
            ip_origen: '172.16.0.2',
            valor_anterior: { id: 301, descripcion: 'Compra insumos', monto: 1200 },
            valor_nuevo: null
          }
        ];

        localStorage.setItem(key, JSON.stringify(samples));
      }
    } catch (e) {
      console.error('No se pudo crear datos de auditoría de ejemplo', e);
    }
  }

  cargar() {
    try {
      const raw = localStorage.getItem('AuditoriaDeCambios') || '[]';
      const parsed = JSON.parse(raw) as AuditoriaRegistro[];
      // normalize dates to ISO strings
      this.registros = parsed.map((r, idx) => ({ id: r.id ?? idx + 1, ...r }));
      this.aplicarFiltros();
    } catch (e) {
      console.error('No se pudo cargar AuditoriaDeCambios desde LocalStorage', e);
      this.registros = [];
      this.filtered = [];
    }
  }

  aplicarFiltros() {
    const desde = this.fechaDesde ? new Date(this.fechaDesde) : null;
    const hasta = this.fechaHasta ? new Date(this.fechaHasta) : null;

    this.filtered = this.registros.filter(r => {
      // fecha filter
      if (desde || hasta) {
        const d = new Date(r.fecha);
        if (desde && d < new Date(desde.setHours(0,0,0,0))) return false;
        if (hasta && d > new Date(hasta.setHours(23,59,59,999))) return false;
      }

      if (this.filtroUsuario && !r.usuario.toLowerCase().includes(this.filtroUsuario.toLowerCase())) return false;
      if (this.filtroTabla && !r.tabla.toLowerCase().includes(this.filtroTabla.toLowerCase())) return false;
      return true;
    });
  }

  resetFilters() {
    this.filtroUsuario = '';
    this.filtroTabla = '';
    this.fechaDesde = null;
    this.fechaHasta = null;
    this.aplicarFiltros();
  }

  pretty(json: any) {
    try {
      if (typeof json === 'string') return JSON.stringify(JSON.parse(json), null, 2);
      return JSON.stringify(json, null, 2);
    } catch (e) {
      // fallback: show as-is
      return String(json);
    }
  }
}
