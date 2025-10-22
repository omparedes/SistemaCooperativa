import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

export type Estado = 'Activo' | 'Inactivo';

export interface Socio {
  socio_id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  estado: Estado;
}

@Component({
  selector: 'app-socio-list',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './socio-list.component.html',
  styleUrls: [],
})
export class SocioListComponent implements OnInit {
  terminoBusqueda: string = '';

  socios: Socio[] = [
    { socio_id: 1, dni: '12345678', nombres: 'Juan', apellidos: 'Pérez', estado: 'Activo' },
    { socio_id: 2, dni: '87654321', nombres: 'María', apellidos: 'Gómez', estado: 'Inactivo' },
    { socio_id: 3, dni: '11223344', nombres: 'Carlos', apellidos: 'Ramírez', estado: 'Activo' },
    { socio_id: 4, dni: '44332211', nombres: 'Ana', apellidos: 'López', estado: 'Activo' },
    { socio_id: 5, dni: '55667788', nombres: 'Luis', apellidos: 'Torres', estado: 'Inactivo' },
  ];

  sociosFiltrados: Socio[] = [];

  ngOnInit(): void {
    this.sociosFiltrados = [...this.socios];
  }

  filtrarSocios() {
    const termino = this.terminoBusqueda.trim().toLowerCase();
    if (!termino) {
      this.sociosFiltrados = [...this.socios];
      return;
    }

    this.sociosFiltrados = this.socios.filter(s => {
      return (
        s.dni.toLowerCase().includes(termino) ||
        s.nombres.toLowerCase().includes(termino) ||
        s.apellidos.toLowerCase().includes(termino)
      );
    });
  }
}
