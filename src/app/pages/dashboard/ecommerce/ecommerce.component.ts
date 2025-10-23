import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { NgApexchartsModule, ApexAxisChartSeries, ApexChart, ApexXAxis, ApexDataLabels, ApexStroke, ApexGrid, ApexFill, ApexYAxis, ApexTooltip } from 'ng-apexcharts';

@Component({
  selector: 'app-ecommerce',
  standalone: true,
  imports: [CommonModule, FormsModule, NgApexchartsModule],
  templateUrl: './ecommerce.component.html',
})
export class EcommerceComponent implements OnInit {
  totalRecaudacion = 0;
  totalGastos = 0;
  lowStockCount = 0;
  bancosBalance = 0;

  // Charts
  public chartDailySeries: ApexAxisChartSeries = [];
  public chartDailyOptions: any = {};

  public chartWeeklySeries: ApexAxisChartSeries = [];
  public chartWeeklyOptions: any = {};

  public chartMonthlySeries: ApexAxisChartSeries = [];
  public chartMonthlyOptions: any = {};

  // series selector: 'both' | 'recaudacion' | 'gastos'
  selectedSeries: 'both' | 'recaudacion' | 'gastos' = 'both';

  ngOnInit(): void {
    this.loadMetrics();
    // listen to storage changes from other tabs
    window.addEventListener('storage', () => this.loadMetrics());
    this.buildCharts();
    window.addEventListener('storage', () => this.buildCharts());
  }

  private loadMetrics() {
    try {
      // Recaudaciones
      const rawRec = localStorage.getItem('recaudaciones_diarias');
      const recs = rawRec ? JSON.parse(rawRec) : [];
      this.totalRecaudacion = Array.isArray(recs) ? recs.reduce((s: number, r: any) => s + (Number(r.monto) || 0), 0) : 0;

      // Gastos
      const rawG = localStorage.getItem('gastos');
      const gastos = rawG ? JSON.parse(rawG) : [];
      this.totalGastos = Array.isArray(gastos) ? gastos.reduce((s: number, g: any) => s + (Number(g.monto) || 0), 0) : 0;

      // Inventario bajo stock
      const rawP = localStorage.getItem('productos_almacen');
      const prods = rawP ? JSON.parse(rawP) : [];
      this.lowStockCount = Array.isArray(prods) ? prods.filter((p: any) => Number(p.stock_actual) <= Number(p.stock_minimo)).length : 0;

      // Bancos balance = sum(abono) - sum(cargo)
      const rawB = localStorage.getItem('movimientos_bancarios');
      const movs = rawB ? JSON.parse(rawB) : [];
      if (Array.isArray(movs)) {
        const totalAbono = movs.reduce((s: number, m: any) => s + (Number(m.abono) || 0), 0);
        const totalCargo = movs.reduce((s: number, m: any) => s + (Number(m.cargo) || 0), 0);
        this.bancosBalance = totalAbono - totalCargo;
      } else {
        this.bancosBalance = 0;
      }
    } catch (e) {
      console.error('Error cargando métricas', e);
      this.totalRecaudacion = this.totalGastos = this.lowStockCount = this.bancosBalance = 0;
    }
  }

  private buildCharts() {
    try {
      // Load raw data
      const rawRec = localStorage.getItem('recaudaciones_diarias');
      const recs = rawRec ? JSON.parse(rawRec) : [];
      const rawG = localStorage.getItem('gastos');
      const gastos = rawG ? JSON.parse(rawG) : [];

      // DAILY - last 7 days
      const days = 7;
      const labelsDaily: string[] = [];
      const recDaily: number[] = [];
      const gasDaily: number[] = [];
      for (let i = days - 1; i >= 0; i--) {
        const d = new Date();
        d.setDate(d.getDate() - i);
        const key = d.toISOString().slice(0,10);
        labelsDaily.push(key);
        const sumRec = (recs || []).filter((r:any) => (new Date(r.fecha || r.fecha_pago).toISOString().slice(0,10)) === key).reduce((s:number, x:any) => s + (Number(x.monto || x.monto_total || 0)), 0);
        const sumGas = (gastos || []).filter((g:any) => (new Date(g.fecha).toISOString().slice(0,10)) === key).reduce((s:number, x:any) => s + (Number(x.monto || 0)), 0);
        recDaily.push(Number(sumRec.toFixed(2)));
        gasDaily.push(Number(sumGas.toFixed(2)));
      }
      const seriesDailyAll = [ { name: 'Recaudación', data: recDaily }, { name: 'Gastos', data: gasDaily } ];
      this.chartDailySeries = this.selectedSeries === 'both' ? seriesDailyAll : (this.selectedSeries === 'recaudacion' ? [seriesDailyAll[0]] : [seriesDailyAll[1]]);
      this.chartDailyOptions = {
        chart: { type: 'area', height: 280 },
        stroke: { curve: 'smooth' },
        xaxis: { categories: labelsDaily },
        yaxis: { labels: { formatter: (val:number) => `S/ ${Number(val).toFixed(2)}` } },
        tooltip: { y: { formatter: (v:number) => `S/ ${v.toFixed(2)}` } }
      };

      // WEEKLY - last 8 weeks
      const weeks = 8;
      const labelsWeek: string[] = [];
      const recWeek: number[] = [];
      const gasWeek: number[] = [];
      const now = new Date();
      for (let w = weeks - 1; w >= 0; w--) {
        const end = new Date(now.getFullYear(), now.getMonth(), now.getDate() - (w * 7));
        const start = new Date(end);
        start.setDate(end.getDate() - 6);
        const label = `${start.toISOString().slice(0,10)}..${end.toISOString().slice(0,10)}`;
        labelsWeek.push(label);
        const sumRec = (recs || []).filter((r:any) => {
          const d = new Date(r.fecha || r.fecha_pago);
          return d >= start && d <= end;
        }).reduce((s:number, x:any) => s + (Number(x.monto || x.monto_total || 0)), 0);
        const sumGas = (gastos || []).filter((g:any) => {
          const d = new Date(g.fecha);
          return d >= start && d <= end;
        }).reduce((s:number, x:any) => s + (Number(x.monto || 0)), 0);
        recWeek.push(Number(sumRec.toFixed(2)));
        gasWeek.push(Number(sumGas.toFixed(2)));
      }
  const seriesWeekAll = [ { name: 'Recaudación', data: recWeek }, { name: 'Gastos', data: gasWeek } ];
  this.chartWeeklySeries = this.selectedSeries === 'both' ? seriesWeekAll : (this.selectedSeries === 'recaudacion' ? [seriesWeekAll[0]] : [seriesWeekAll[1]]);
  this.chartWeeklyOptions = { chart: { type: 'bar', height: 300 }, plotOptions: { bar: { horizontal: false, columnWidth: '55%' } }, xaxis: { categories: labelsWeek }, yaxis: { labels: { formatter: (val:number) => `S/ ${Number(val).toFixed(2)}` } }, tooltip: { y: { formatter: (v:number) => `S/ ${v.toFixed(2)}` } } };

      // MONTHLY - last 12 months
      const months = 12;
      const labelsMonth: string[] = [];
      const recMonth: number[] = [];
      const gasMonth: number[] = [];
      for (let m = months - 1; m >= 0; m--) {
        const d = new Date(now.getFullYear(), now.getMonth() - m, 1);
        const y = d.getFullYear();
        const mo = d.getMonth();
        const label = `${y}-${String(mo+1).padStart(2,'0')}`;
        labelsMonth.push(label);
        const sumRec = (recs || []).filter((r:any) => {
          const dt = new Date(r.fecha || r.fecha_pago);
          return dt.getFullYear() === y && dt.getMonth() === mo;
        }).reduce((s:number, x:any) => s + (Number(x.monto || x.monto_total || 0)), 0);
        const sumGas = (gastos || []).filter((g:any) => {
          const dt = new Date(g.fecha);
          return dt.getFullYear() === y && dt.getMonth() === mo;
        }).reduce((s:number, x:any) => s + (Number(x.monto || 0)), 0);
        recMonth.push(Number(sumRec.toFixed(2)));
        gasMonth.push(Number(sumGas.toFixed(2)));
      }
  const seriesMonthAll = [ { name: 'Recaudación', data: recMonth }, { name: 'Gastos', data: gasMonth } ];
  this.chartMonthlySeries = this.selectedSeries === 'both' ? seriesMonthAll : (this.selectedSeries === 'recaudacion' ? [seriesMonthAll[0]] : [seriesMonthAll[1]]);
  this.chartMonthlyOptions = { chart: { type: 'line', height: 300 }, stroke: { curve: 'smooth' }, xaxis: { categories: labelsMonth }, yaxis: { labels: { formatter: (val:number) => `S/ ${Number(val).toFixed(2)}` } }, tooltip: { y: { formatter: (v:number) => `S/ ${v.toFixed(2)}` } } };

    } catch (e) {
      console.error('Error construyendo charts', e);
      this.chartDailySeries = this.chartWeeklySeries = this.chartMonthlySeries = [];
      this.chartDailyOptions = this.chartWeeklyOptions = this.chartMonthlyOptions = {};
    }
  }

  // called when user toggles the selector
  onSelectorChange() {
    this.buildCharts();
  }
}
