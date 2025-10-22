import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { SocioListComponent } from './socio-list.component';

@NgModule({
  imports: [CommonModule, FormsModule, SocioListComponent],
  exports: [SocioListComponent],
})
export class SociosModule {}
