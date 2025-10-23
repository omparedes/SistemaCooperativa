import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { InventarioListComponent } from './inventario-list.component';
import { MovimientoFormComponent } from './movimiento-form.component';

@NgModule({
  imports: [CommonModule, FormsModule, InventarioListComponent, MovimientoFormComponent],
  exports: [InventarioListComponent, MovimientoFormComponent],
})
export class InventarioModule {}
