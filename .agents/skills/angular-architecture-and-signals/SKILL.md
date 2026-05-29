---
name: angular-architecture-and-signals
description: "Asegura la adherencia a Angular 20 Standalone Components, Tailwind CSS v4 y manejo de estado reactivo mediante Signals."
metadata:
  author: Antigravity
  version: "1.0.0"
---

# Arquitectura Angular 20 y Patrones de UI

Este manual asegura la coherencia visual, de rendimiento y mantenibilidad del frontend basado en Angular standalone y Tailwind CSS v4.

## Directivas de Frontend

### 1. Componentes Standalone Estrictos
* NUNCA utilices `NgModule`. Todos los componentes, directivas y pipes nuevos deben declararse con `standalone: true`:
  ```typescript
  @Component({
    selector: 'app-mi-componente',
    standalone: true,
    imports: [CommonModule, FormsModule],
    template: `...`
  })
  ```
* Declara las rutas mediante carga perezosa (*Lazy Loading*) en `app.routes.ts` utilizando `loadComponent`.

### 2. Reactividad con Signals
* Reemplaza el uso de RxJS para el estado interno y lógica de componentes en favor de Angular **Signals**.
* Utiliza:
  * `signal` para estado mutable (ej. filtros de búsqueda, tab activa).
  * `computed` para derivar estados en cadena de forma óptima y automática.
  * `effect` únicamente para efectos colaterales (ej. persistencia local, llamadas externas al DOM).
* Evita suscripciones manuales (`subscribe`) en servicios o componentes para prevenir fugas de memoria. Si usas HTTP client, consume con `firstValueFrom` o maneja el ciclo de vida.

### 3. Estética de Diseño TailAdmin
* Todos los componentes deben respetar el sistema de diseño basado en la plantilla TailAdmin.
* Soporta siempre la directiva `dark:` para garantizar que la interfaz se renderice correctamente en el modo oscuro.
* Asegura un diseño móvil responsivo utilizando los breakpoints estándar de Tailwind (`sm:`, `md:`, `lg:`).
* Utiliza animaciones y micro-interacciones suaves (`transition`, `hover:`, `active:`) para dar una sensación de fluidez en las acciones del cajero o administrador.
