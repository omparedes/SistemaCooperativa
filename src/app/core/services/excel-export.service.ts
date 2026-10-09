import { Injectable } from '@angular/core';

export interface HojaExcel {
  /** Nombre de la pestaña (máx. 31 caracteres, límite de Excel). */
  nombre: string;
  /** Filas como objetos planos; las claves se usan como encabezados. */
  filas: Record<string, unknown>[];
}

/**
 * Exportación a Excel con SheetJS (xlsx), cargado con import() dinámico
 * para no engordar el bundle inicial: la librería solo se descarga la
 * primera vez que el usuario exporta.
 */
@Injectable({ providedIn: 'root' })
export class ExcelExportService {
  async exportar(nombreArchivo: string, hojas: HojaExcel[]): Promise<void> {
    const XLSX = await import('xlsx');
    const wb = XLSX.utils.book_new();

    for (const hoja of hojas) {
      const ws = XLSX.utils.json_to_sheet(hoja.filas.length > 0 ? hoja.filas : [{ '(sin datos)': '' }]);
      if (hoja.filas.length > 0) {
        const keys = Object.keys(hoja.filas[0]);
        ws['!cols'] = keys.map(k => {
          let maxLen = k.length;
          const sampleRows = Math.min(hoja.filas.length, 50);
          for (let i = 0; i < sampleRows; i++) {
            const v = String(hoja.filas[i][k] ?? '');
            if (v.length > maxLen) maxLen = v.length;
          }
          return { wch: Math.min(Math.max(maxLen + 3, 10), 45) };
        });
        if (ws['!ref']) {
          ws['!autofilter'] = { ref: ws['!ref'] };
        }
      }
      XLSX.utils.book_append_sheet(wb, ws, hoja.nombre.slice(0, 31));
    }

    XLSX.writeFile(wb, nombreArchivo.endsWith('.xlsx') ? nombreArchivo : `${nombreArchivo}.xlsx`);
  }
}
