---
name: supabase-patterns
description: Guía para trabajar con la capa de datos del SistemaCooperativa. Hoy todo es Mock/LocalStorage; la Fase 2 migra a servicios HTTP contra Supabase. Úsala al crear/modificar servicios de negocio, modelos de dominio o cualquier código que toque persistencia.
---

# Skill: Supabase Patterns (SistemaCooperativa)

Guía sobre cómo manejamos la capa de datos **hoy** y cómo debemos manejarla en la **Fase 2** (Supabase).

---

## 1. Estado Actual (Fase 1 — Prototipo)

La aplicación **no tiene backend**. La persistencia se resuelve de dos formas:

| Mecanismo | Dónde se usa | Ejemplo |
|---|---|---|
| **Mock data hardcoded** | Listados grandes de catálogo (socios, inquilinos) | Array estático dentro del componente o un `*.mock.ts` |
| **`localStorage`** | Datos que el usuario edita y debe ver al recargar | `GastoListComponent` (CRUD de gastos) |

### Reglas mientras estemos en Fase 1
- Centralizar mocks en archivos `*.mock.ts` por feature, **no** dispersos dentro de componentes.
- El acceso a `localStorage` debe pasar por un servicio del feature (ej. `GastosService`), nunca directo desde el componente. Esto facilita el reemplazo en Fase 2.
- Tipar todo el mock con la misma interfaz que usará Supabase. **Si el modelo está bien tipado hoy, la migración será un cambio de implementación del servicio, no una reescritura.**
- Nunca persistir información sensible (DNI completo, tokens) en `localStorage`.

---

## 2. Fase 2 — Migración a Supabase

**Objetivo:** reemplazar Mock/LocalStorage por servicios HTTP que consumen Supabase (PostgreSQL + Auth + Storage + RLS).

### 2.1. Stack
- `@supabase/supabase-js` como cliente.
- Variables de entorno en `src/environments/environment.ts` (`SUPABASE_URL`, `SUPABASE_ANON_KEY`).
- Cliente único expuesto desde `core/services/supabase.client.ts` con `providedIn: 'root'`.

### 2.2. Patrón de Servicio de Negocio

Cada feature tiene un servicio `<Feature>Service` en `core/services/` o dentro del feature, que:

1. Inyecta el `SupabaseClient` (NO instancia uno nuevo).
2. Expone métodos asíncronos tipados que devuelven `Promise<T>` u `Observable<T>` (preferir `signal`/`toSignal` para integrarse con el resto del estado).
3. Maneja errores convirtiendo `PostgrestError` en una excepción de dominio (`SupabaseError` o similar) — nunca devolver `any`.
4. **Jamás** filtra o elimina fila por fila desde el frontend cuando hay políticas RLS — confiar en RLS y validar permisos en el server.

```ts
// Esqueleto de referencia (Fase 2)
@Injectable({ providedIn: 'root' })
export class SociosService {
  private readonly db = inject(SupabaseClient);

  async listar(): Promise<Socio[]> {
    const { data, error } = await this.db.from('socios').select('*').order('apellido');
    if (error) throw new SupabaseError(error);
    return data;
  }
}
```

### 2.3. Reglas de Dominio Aplicadas a Supabase
- **No `DELETE` físicos** sobre `pagos`, `recibos`, `recaudacion_diaria`, `movimientos_bancarios`, `auditoria`. Usar columnas `deleted_at`, `anulado_por`, `motivo_anulacion` y filtrar en el `select`.
- Las correcciones de pagos son **asientos compensatorios**, no `UPDATE` sobre el original.
- La tabla `auditoria` es **append-only**. Configurar RLS para denegar `UPDATE` y `DELETE` a todos los roles excepto `service_role`.
- Toda mutación crítica (pago, anulación, cierre de caja) debe disparar un `INSERT` en `auditoria` — preferir un trigger en Supabase, no confiarlo al cliente.

### 2.4. Migración Incremental
1. Definir el modelo TS y el schema Supabase a la vez (mismas columnas, mismos tipos).
2. Crear el servicio HTTP en paralelo al mock; exponer una bandera `USE_SUPABASE` en `environment.ts` durante la transición.
3. Migrar feature por feature: socios → pagos → gastos → bancos → inventario → reportes → auditoría.
4. Eliminar el mock y la lectura de `localStorage` solo cuando el servicio Supabase pase QA.

### 2.5. Auth y Roles
- Roles previstos: `admin`, `cajero`, `auditor`. Implementar con `auth.users` + tabla `perfiles(role)` y políticas RLS por rol.
- El `auditor` es **solo lectura** sobre todas las tablas históricas.
- El `cajero` puede `INSERT` en `pagos` y `recaudacion_diaria`, pero no `UPDATE`/`DELETE`.

---

## 3. Anti-patrones a evitar

- ❌ Llamar `createClient()` dentro de un componente o servicio de feature.
- ❌ Usar `any` para el resultado de `.select()` — siempre tipar con `<Tabla>`.
- ❌ Hacer joins en el cliente cuando Supabase puede hacerlos con `.select('*, relacion(*)')`.
- ❌ Eliminar registros históricos.
- ❌ Confiar en validaciones del frontend para permisos — usar RLS.
- ❌ Hardcodear `SUPABASE_URL`/`SUPABASE_ANON_KEY` fuera de `environments/`.
