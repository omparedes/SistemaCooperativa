import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

export type Estado = 'Activo' | 'Inactivo';

export interface Socio {
  socio_id: number;
  tienda: string;
  nombres: string;
  apellidos: string;
  estado: Estado;
  deuda_total: number;
  estado_habilitado: 'Hábil' | 'Inhábil';
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

  listaSociosCompleta: Socio[] = [
    { socio_id: 1001, tienda: '1', nombres: 'Donatila', apellidos: 'Huamani Romero', estado: 'Activo', deuda_total: 120.50, estado_habilitado: 'Inhábil' },
    { socio_id: 1002, tienda: '2', nombres: 'Carmen Rosa', apellidos: 'Luna Vargas', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1003, tienda: '3', nombres: 'Juana Isabel', apellidos: 'Romero Niñahuaman', estado: 'Activo', deuda_total: 30.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1004, tienda: '4', nombres: 'Juana Isabel', apellidos: 'Sosa Valdivia', estado: 'Activo', deuda_total: 45.10, estado_habilitado: 'Inhábil' },
    { socio_id: 1005, tienda: '5', nombres: 'Vicenta', apellidos: 'Medina Cota', estado: 'Activo', deuda_total: 88.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1006, tienda: '6', nombres: 'Ruth', apellidos: 'Salas Montalvo', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1007, tienda: '7', nombres: 'Luz Emilia', apellidos: 'Uratia Cruz', estado: 'Activo', deuda_total: 15.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1008, tienda: '8', nombres: 'Eudosia', apellidos: 'Guachuyo Ccama', estado: 'Activo', deuda_total: 92.30, estado_habilitado: 'Inhábil' },
    { socio_id: 1009, tienda: '9', nombres: 'Agripina', apellidos: 'Ccama de Guachuyo', estado: 'Activo', deuda_total: 110.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1010, tienda: '10', nombres: 'Eliseo', apellidos: 'Ayala Toboada', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1011, tienda: '11', nombres: 'Norma Gladys', apellidos: 'Ayala Huarachuyo', estado: 'Activo', deuda_total: 75.50, estado_habilitado: 'Inhábil' },
    { socio_id: 1012, tienda: '12', nombres: 'Alejandrina', apellidos: 'Cardeña Villafuerte', estado: 'Activo', deuda_total: 64.20, estado_habilitado: 'Inhábil' },
    { socio_id: 1013, tienda: '13', nombres: 'Marcial', apellidos: 'Falcon Chiara Hector', estado: 'Activo', deuda_total: 22.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1014, tienda: '14', nombres: 'Nelly', apellidos: 'Mamani Ccama', estado: 'Activo', deuda_total: 50.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1015, tienda: '15', nombres: 'Elida', apellidos: 'Buga Carrasco', estado: 'Activo', deuda_total: 130.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1016, tienda: '16', nombres: 'Alberto', apellidos: 'Zuya Sanchez', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1017, tienda: '17', nombres: 'Marta Nelida', apellidos: 'Choque Alata', estado: 'Activo', deuda_total: 81.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1018, tienda: '18', nombres: 'Lucila', apellidos: 'Gutierrez Aquino', estado: 'Activo', deuda_total: 40.50, estado_habilitado: 'Inhábil' },
    { socio_id: 1019, tienda: '19', nombres: 'Diana', apellidos: 'Paredes Morales', estado: 'Activo', deuda_total: 200.10, estado_habilitado: 'Inhábil' },
    { socio_id: 1020, tienda: '20', nombres: 'Gutierrez', apellidos: 'Javier Sermeño', estado: 'Activo', deuda_total: 10.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1021, tienda: '21', nombres: 'Maximo', apellidos: 'Valero Patlona', estado: 'Activo', deuda_total: 55.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1022, tienda: '22', nombres: 'Willy Perseo Albino', apellidos: 'Valero Soto', estado: 'Inactivo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1023, tienda: '23', nombres: 'Marcos', apellidos: 'Yaurimucha Rimachi', estado: 'Activo', deuda_total: 215.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1024, tienda: '24', nombres: 'Francisca Dolores', apellidos: 'Flores Pato', estado: 'Activo', deuda_total: 90.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1025, tienda: '25', nombres: 'Zorida', apellidos: 'Lago Luna de Calvo', estado: 'Activo', deuda_total: 73.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1026, tienda: '26', nombres: 'Eugenio Joel', apellidos: 'Taype Oquendo', estado: 'Activo', deuda_total: 140.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1027, tienda: '27', nombres: 'Eulalia', apellidos: 'Clementes Llasa', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1028, tienda: '28', nombres: 'Oscar Martín', apellidos: 'Paredes Morales', estado: 'Activo', deuda_total: 60.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1029, tienda: '29', nombres: 'Geovania', apellidos: 'Pacconpia Cardeña', estado: 'Activo', deuda_total: 33.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1030, tienda: '30', nombres: 'Luciano', apellidos: 'Quispe Uribe', estado: 'Activo', deuda_total: 19.50, estado_habilitado: 'Inhábil' },
    { socio_id: 1031, tienda: '31', nombres: 'Maria', apellidos: 'Martin Huaman de Salamanca', estado: 'Inactivo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1032, tienda: '32', nombres: 'Nelly Maria', apellidos: 'Pittman Concepción', estado: 'Activo', deuda_total: 122.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1033, tienda: '33', nombres: 'Ponce', apellidos: 'Sagona Villafuerte de', estado: 'Activo', deuda_total: 48.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1034, tienda: '34', nombres: 'Rosa Florencia', apellidos: 'Espejo Uribeño', estado: 'Activo', deuda_total: 95.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1035, tienda: '35', nombres: 'Yolanda Sofia', apellidos: 'Sanchez Astos de Torres', estado: 'Activo', deuda_total: 25.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1036, tienda: '36', nombres: 'Gloria', apellidos: 'Taboada Mendoza', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1037, tienda: '37', nombres: 'Rufina', apellidos: 'Montalvo Neira de Salas', estado: 'Activo', deuda_total: 82.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1038, tienda: '38', nombres: 'Roger Reyman', apellidos: 'Gutierrez Flores', estado: 'Activo', deuda_total: 70.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1039, tienda: '39', nombres: 'Epifania', apellidos: 'Perez Quispe', estado: 'Activo', deuda_total: 66.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1040, tienda: '40', nombres: 'Leonila', apellidos: 'Rojas Bracio', estado: 'Activo', deuda_total: 115.50, estado_habilitado: 'Inhábil' },
    { socio_id: 1041, tienda: '41', nombres: 'Zosima', apellidos: 'Prado Llancari', estado: 'Activo', deuda_total: 38.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1042, tienda: '42', nombres: 'Luis Humberto', apellidos: 'Saavedra Curipuma', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1043, tienda: '43', nombres: 'Luz', apellidos: 'Vera de Salas', estado: 'Activo', deuda_total: 99.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1044, tienda: '44', nombres: 'Marino', apellidos: 'Tello Alvarez', estado: 'Activo', deuda_total: 55.80, estado_habilitado: 'Inhábil' },
    { socio_id: 1045, tienda: '45', nombres: 'Leonor', apellidos: 'Juarez Cuellar', estado: 'Activo', deuda_total: 10.50, estado_habilitado: 'Inhábil' },
    { socio_id: 1046, tienda: '46', nombres: 'Valentina', apellidos: 'Ancco Leon', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1047, tienda: '47', nombres: 'Reyman', apellidos: 'Coyllo Polanco', estado: 'Activo', deuda_total: 29.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1048, tienda: '48', nombres: 'Esteban', apellidos: 'Polanco Coyllo', estado: 'Activo', deuda_total: 77.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1049, tienda: '49', nombres: 'Cenaida', apellidos: 'Jara Alvarez Maria', estado: 'Activo', deuda_total: 12.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1050, tienda: '50', nombres: 'Idilio Félix', apellidos: 'Rodriguez Arquiniego', estado: 'Activo', deuda_total: 63.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1051, tienda: '51', nombres: 'Rosa', apellidos: 'Villanueva Cardenas', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1052, tienda: '52', nombres: 'Oscar', apellidos: 'Pareja Flores', estado: 'Activo', deuda_total: 85.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1053, tienda: '53 (CERRADO)', nombres: 'Juan', apellidos: 'Valverde Rosas', estado: 'Inactivo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1054, tienda: '54', nombres: 'Juan', apellidos: 'Quispe Huaman', estado: 'Activo', deuda_total: 135.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1055, tienda: '55', nombres: 'Judith', apellidos: 'Coyllo Shimabukay', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1056, tienda: '56', nombres: 'Fidel', apellidos: 'Calle Calle', estado: 'Activo', deuda_total: 240.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1057, tienda: '57', nombres: 'Marisol', apellidos: 'Davila Cahuana', estado: 'Activo', deuda_total: 68.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1058, tienda: '58', nombres: 'Torres', apellidos: 'Estela Calderon', estado: 'Activo', deuda_total: 91.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1059, tienda: '59', nombres: 'Nancy Gisela', apellidos: 'Alarcon Anampa', estado: 'Activo', deuda_total: 44.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1060, tienda: '60', nombres: 'Clemencia Migdonia', apellidos: 'Anampa Corahua', estado: 'Activo', deuda_total: 78.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1061, tienda: '61', nombres: 'Aurelia', apellidos: 'Natul Ruiz', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1062, tienda: '62', nombres: 'Daniel Masia', apellidos: 'Coyllo Chinchan', estado: 'Activo', deuda_total: 102.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1063, tienda: '63', nombres: 'Betsy', apellidos: 'Alarcon Anampa', estado: 'Activo', deuda_total: 51.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1064, tienda: '64', nombres: 'Ana Maritza', apellidos: 'Bravo Heredia', estado: 'Activo', deuda_total: 37.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1065, tienda: '65', nombres: 'Lucila', apellidos: 'Sanchez Soto', estado: 'Activo', deuda_total: 14.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1066, tienda: '66', nombres: 'Hilda', apellidos: 'Yrupaylla Falcon', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1067, tienda: '67', nombres: 'Jose', apellidos: 'Chuquiyauri Llasa', estado: 'Activo', deuda_total: 12.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1068, tienda: '68', nombres: 'Catalina', apellidos: 'Soria Tapia Edith', estado: 'Activo', deuda_total: 83.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1069, tienda: '69', nombres: 'Regis', apellidos: 'Rivera Callpa Juana', estado: 'Activo', deuda_total: 49.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1070, tienda: '70', nombres: 'Marcelino', apellidos: 'Torres Anyosa', estado: 'Activo', deuda_total: 61.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1071, tienda: '71', nombres: 'Enrique', apellidos: 'Cuevas Mayo', estado: 'Activo', deuda_total: 0, estado_habilitado: 'Hábil' },
    { socio_id: 1072, tienda: '72', nombres: 'Patricia', apellidos: 'Tintaya Cahuana', estado: 'Activo', deuda_total: 111.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1073, tienda: '73', nombres: 'Rolando', apellidos: 'Alvarez Ccampa', estado: 'Activo', deuda_total: 72.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1074, tienda: '74', nombres: 'Dina', apellidos: 'Bastidas Medina', estado: 'Activo', deuda_total: 28.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1075, tienda: '75', nombres: 'Felicitas', apellidos: 'Carrasco Salvatierra', estado: 'Activo', deuda_total: 53.00, estado_habilitado: 'Inhábil' },
    { socio_id: 1076, tienda: '76', nombres: 'Luis Enrique', apellidos: 'Calderon Carrasco', estado: 'Activo', deuda_total: 170.00, estado_habilitado: 'Inhábil' }
  ];

  sociosFiltrados: Socio[] = [];

  ngOnInit(): void {
    this.sociosFiltrados = [...this.listaSociosCompleta];
  }

  filtrarSocios() {
    const termino = this.terminoBusqueda.toLowerCase().trim();
    if (!termino) {
      this.sociosFiltrados = this.listaSociosCompleta;
      return;
    }

    this.sociosFiltrados = this.listaSociosCompleta.filter((socio: Socio) => {
      const tienda = socio.tienda.toString().toLowerCase();
      const nombres = socio.nombres.toLowerCase();
      const apellidos = socio.apellidos.toLowerCase();

      return (
        tienda.includes(termino) ||
        nombres.includes(termino) ||
        apellidos.includes(termino)
      );
    });
  }
}
