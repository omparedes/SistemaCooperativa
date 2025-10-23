import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { NgApexchartsModule, ApexAxisChartSeries, ApexChart, ApexXAxis, ApexDataLabels, ApexPlotOptions, ApexStroke, ApexGrid, ApexFill, ApexYAxis, ApexTooltip } from 'ng-apexcharts';

interface PagoReporte {
  pago_id: number;
  socio_id: number;
  socio_nombre: string;
  fecha_pago: string; // ISO
  monto_total: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  comprobante: string;
  concepto: string; // e.g. 'Luz', 'Agua', 'Multa'
}

@Component({
  selector: 'app-reportes',
  standalone: true,
  imports: [CommonModule, FormsModule, NgApexchartsModule],
  templateUrl: './reportes.component.html',
})
export class ReportesComponent implements OnInit {
  // Filters
  startDate: string | null = null; // YYYY-MM-DD
  endDate: string | null = null;   // YYYY-MM-DD
  availableConcepts: string[] = ['Luz', 'Agua', 'Multa'];
  selectedConcepts: string[] = [];

  // Mock payments dataset
  pagos: PagoReporte[] = [];
  pagosFiltrados: PagoReporte[] = [];

  // Computed
  totalRecaudado: number = 0;
  breakdownByConcept: { concepto: string; total: number }[] = [];
  chartData: { date: string; total: number }[] = [];

  // ApexCharts
  public chartSeries: ApexAxisChartSeries = [];
  public chartOptions: any = {};

  ngOnInit(): void {
    // Create mock payments across recent dates
    const today = new Date();
    const iso = (d: Date) => d.toISOString();

    this.pagos = [
      { pago_id: 1, socio_id: 1001, socio_nombre: 'Donatila Huamani', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate())), monto_total: 120.5, metodo_pago: 'Efectivo', comprobante: 'REC-001', concepto: 'Luz' },
      { pago_id: 2, socio_id: 1003, socio_nombre: 'Juana Isabel Romero', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-1)), monto_total: 30.0, metodo_pago: 'Transferencia', comprobante: 'REC-002', concepto: 'Agua' },
      { pago_id: 3, socio_id: 1005, socio_nombre: 'Vicenta Medina', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-2)), monto_total: 88.0, metodo_pago: 'Efectivo', comprobante: 'REC-003', concepto: 'Multa' },
      { pago_id: 4, socio_id: 1009, socio_nombre: 'Agripina Ccama', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-3)), monto_total: 110.0, metodo_pago: 'Transferencia', comprobante: 'REC-004', concepto: 'Luz' },
      { pago_id: 5, socio_id: 1023, socio_nombre: 'Marcos Yaurimucha', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-7)), monto_total: 215.0, metodo_pago: 'Efectivo', comprobante: 'REC-005', concepto: 'Luz' },
      { pago_id: 6, socio_id: 1032, socio_nombre: 'Nelly Maria Pittman', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-10)), monto_total: 122.0, metodo_pago: 'Transferencia', comprobante: 'REC-006', concepto: 'Agua' },
      { pago_id: 7, socio_id: 1056, socio_nombre: 'Fidel Calle', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-4)), monto_total: 240.0, metodo_pago: 'Efectivo', comprobante: 'REC-007', concepto: 'Multa' },
      { pago_id: 8, socio_id: 1076, socio_nombre: 'Luis Enrique Calderon', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-15)), monto_total: 170.0, metodo_pago: 'Transferencia', comprobante: 'REC-008', concepto: 'Luz' },
      // add a few more to have variety
      { pago_id: 9, socio_id: 1001, socio_nombre: 'Donatila Huamani', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-6)), monto_total: 60.0, metodo_pago: 'Efectivo', comprobante: 'REC-009', concepto: 'Agua' },
      { pago_id: 10, socio_id: 1038, socio_nombre: 'Roger Reyman', fecha_pago: iso(new Date(today.getFullYear(), today.getMonth(), today.getDate()-2)), monto_total: 70.0, metodo_pago: 'Transferencia', comprobante: 'REC-010', concepto: 'Agua' },
    ];

    // Load recaudaciones guardadas en LocalStorage y mezclarlas
    try {
      const raw = localStorage.getItem('recaudaciones_diarias');
      if (raw) {
        const recs = JSON.parse(raw) as Array<{id:number,socio_id:number,socio_nombre:string,fecha:string,monto:number}>;
        const startId = this.pagos.length ? Math.max(...this.pagos.map(p=>p.pago_id)) + 1 : 1000;
        let nextId = startId;
        for (const r of recs) {
          this.pagos.push({
            pago_id: nextId++,
            socio_id: r.socio_id,
            socio_nombre: r.socio_nombre,
            fecha_pago: r.fecha,
            monto_total: r.monto,
            metodo_pago: 'Efectivo',
            comprobante: `RD-${r.id}`,
            concepto: 'Recaudación Diaria'
          });
        }
      }
    } catch (e) {
      // ignore parse errors
    }

    // default: last 7 days
    this.quickRange('7days');
  }

  applyFilters() {
    const start = this.startDate ? new Date(this.startDate + 'T00:00:00') : null;
    const end = this.endDate ? new Date(this.endDate + 'T23:59:59') : null;

    this.pagosFiltrados = this.pagos.filter(p => {
      const fecha = new Date(p.fecha_pago);
      const inRange = (!start || fecha >= start) && (!end || fecha <= end);
      const inConcept = this.selectedConcepts.length === 0 || this.selectedConcepts.includes(p.concepto);
      return inRange && inConcept;
    });

    // totals
    this.totalRecaudado = this.pagosFiltrados.reduce((s, p) => s + p.monto_total, 0);

    // breakdown
    const map = new Map<string, number>();
    for (const p of this.pagosFiltrados) {
      map.set(p.concepto, (map.get(p.concepto) || 0) + p.monto_total);
    }
    this.breakdownByConcept = Array.from(map.entries()).map(([concepto, total]) => ({ concepto, total }));

    // chart: totals per day
    const dayMap = new Map<string, number>();
    for (const p of this.pagosFiltrados) {
      const d = new Date(p.fecha_pago);
      const key = d.toISOString().slice(0,10);
      dayMap.set(key, (dayMap.get(key) || 0) + p.monto_total);
    }
    this.chartData = Array.from(dayMap.entries()).sort((a,b) => a[0].localeCompare(b[0])).map(([date,total]) => ({ date, total }));

    // Build ApexCharts series & options
    this.chartSeries = [{ name: 'Recaudación', data: this.chartData.map(d => Number(d.total.toFixed(2))) }];
    this.chartOptions = {
      chart: { type: 'bar', height: 320 },
      plotOptions: { bar: { horizontal: false, columnWidth: '60%', borderRadius: 6 } },
      dataLabels: { enabled: false },
      xaxis: { categories: this.chartData.map(d => d.date) },
      yaxis: { labels: { formatter: (val: number) => Number(val).toFixed(2) } },
      tooltip: { y: { formatter: (val: number) => `S/ ${val.toFixed(2)}` } }
    };
  }

  quickRange(range: 'today' | '7days' | 'month') {
    const today = new Date();
    let start: Date;
    let end: Date = today;
    if (range === 'today') {
      start = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    } else if (range === '7days') {
      start = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 6);
    } else { // month
      start = new Date(today.getFullYear(), today.getMonth(), 1);
    }

    this.startDate = start.toISOString().slice(0,10);
    this.endDate = end.toISOString().slice(0,10);
    this.applyFilters();
  }

  exportToExcel() {
    // Simulate export by building CSV
    const headers = ['pago_id','socio_id','socio_nombre','fecha_pago','monto_total','metodo_pago','comprobante','concepto'];
    const rows = this.pagosFiltrados.map(p => [p.pago_id, p.socio_id, `"${p.socio_nombre}"`, p.fecha_pago, p.monto_total.toFixed(2), p.metodo_pago, p.comprobante, p.concepto].join(','));
    const csv = [headers.join(','), ...rows].join('\n');
    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `reportes_pagos_${this.startDate || 'all'}_to_${this.endDate || 'all'}.csv`;
    a.click();
    URL.revokeObjectURL(url);
  }
}
