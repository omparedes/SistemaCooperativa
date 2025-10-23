import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { GastoListComponent } from './gasto-list.component';
import { GastoFormComponent } from './gasto-form.component';

@NgModule({
  imports: [CommonModule, FormsModule, GastoListComponent, GastoFormComponent],
  exports: [GastoListComponent, GastoFormComponent],
})
export class GastosModule {}
