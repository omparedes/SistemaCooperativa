import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';

interface Socio {
  socio_id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  saldo_a_favor?: number;
}

interface MontoPorCobrar {
  monto_id: number;
  puesto_id: number;
  concepto_nombre: string;
  periodo_mes: number;
  periodo_anio: number;
  monto: number;
  fecha_generacion: string;
  estado: 'Pendiente' | 'Pagado' | 'Cancelado';
  isChecked: boolean;
}

@Component({
  selector: 'app-registro-pago',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './registro-pago.component.html',
})
export class RegistroPagoComponent implements OnInit {
  step: 1 | 2 | 3 = 1;
  socio!: Socio;
  deudasPendientes: MontoPorCobrar[] = [];

  tipoPago: 'Total' | 'Parcial' = 'Total';
  montoTotalSeleccionado: number = 0;
  montoParcial: number = 0;
  metodoPago: 'Efectivo' | 'Transferencia' | 'Saldo' | 'Saldo y Efectivo' = 'Efectivo';
  usarSaldo: boolean = false;
  saldoAplicado: number = 0;

  today: Date = new Date();

  constructor(private route: ActivatedRoute, private router: Router) {}

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id')) || 0;
    // Mock socio
    this.socio = {
      socio_id: id,
      dni: '00000000',
      nombres: 'Socio Ejemplo',
      apellidos: 'Apellido Ejemplo',
      saldo_a_favor: 45.25,
    };

    // Mock deudas: different fecha_generacion to test ordering
    this.deudasPendientes = [
      { monto_id: 1, puesto_id: 10, concepto_nombre: 'Luz Eléctrica', periodo_mes: 6, periodo_anio: 2025, monto: 120.5, fecha_generacion: '2025-06-01T08:00:00Z', estado: 'Pendiente', isChecked: false },
      { monto_id: 2, puesto_id: 11, concepto_nombre: 'Agua Potable', periodo_mes: 7, periodo_anio: 2025, monto: 80.0, fecha_generacion: '2025-07-01T08:00:00Z', estado: 'Pendiente', isChecked: false },
      { monto_id: 3, puesto_id: 12, concepto_nombre: 'Multa', periodo_mes: 5, periodo_anio: 2025, monto: 50.0, fecha_generacion: '2025-05-15T08:00:00Z', estado: 'Pendiente', isChecked: false },
    ];

    // Sort by fecha_generacion ascending (older first)
    this.deudasPendientes.sort((a, b) => new Date(a.fecha_generacion).getTime() - new Date(b.fecha_generacion).getTime());
  }

  actualizarSeleccion() {
    this.montoTotalSeleccionado = this.deudasPendientes.reduce((sum, item) => sum + (item.isChecked ? item.monto : 0), 0);
    if (this.tipoPago === 'Total') {
      this.montoParcial = 0;
    }
  }

  seleccionarTodos(event: any) {
    const checked = !!event.target.checked;
    this.deudasPendientes.forEach(d => (d.isChecked = checked));
    this.actualizarSeleccion();
  }

  cambiarTipoPago() {
    if (this.tipoPago === 'Total') {
      this.montoParcial = 0;
    }
  }

  getMontoFinalAPagar() {
    const base = this.tipoPago === 'Total' ? this.montoTotalSeleccionado : this.montoParcial;
    if (this.usarSaldo && this.socio && this.socio.saldo_a_favor) {
      const aplicar = Math.min(base, this.socio.saldo_a_favor);
      this.saldoAplicado = aplicar;
      return Math.max(0, base - aplicar);
    }
    this.saldoAplicado = 0;
    return base;
  }

  irPaso2() {
    const monto = this.getMontoFinalAPagar();
    if (monto <= 0) return; // no avanzar

    if (this.tipoPago === 'Parcial') {
      const totalDeudas = this.deudasPendientes.reduce((s, d) => s + d.monto, 0);
      if (this.montoParcial > totalDeudas) {
        alert('El monto parcial no puede ser mayor que el total de deudas.');
        return;
      }
    }

    // proceed to confirmation
    this.step = 2;
  }

  irPaso1() {
    this.step = 1;
  }

  confirmarPago() {
    const montoFinal = this.getMontoFinalAPagar();
    // Adjust metodoPago to reflect saldo usage
    let metodo = this.metodoPago;
    if (this.usarSaldo && this.saldoAplicado > 0) {
      metodo = montoFinal === 0 ? 'Saldo' : 'Saldo y Efectivo';
    }

    const pagoObj = {
      socio_id: this.socio.socio_id,
      tipo: this.tipoPago,
      monto: montoFinal,
      metodo: metodo,
      saldo_aplicado: this.saldoAplicado,
      items_seleccionados: this.tipoPago === 'Total' ? this.deudasPendientes.filter(d => d.isChecked) : [],
    };

    console.log('Pago registrado (simulado):', pagoObj);
    this.step = 3;
  }

  reiniciarFlujo() {
    this.router.navigate(['/socios']);
  }
}
