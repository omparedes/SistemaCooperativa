/**
 * Traduce errores técnicos (Postgres/PostgREST/Supabase/red) a lenguaje humano.
 * Los RAISE EXCEPTION de los RPCs ya vienen en español y se respetan tal cual.
 */
const PATRONES: Array<{ re: RegExp; msg: string }> = [
  { re: /duplicate key|23505|already exists/i,
    msg: 'Este registro ya existe o la operación ya fue procesada. Actualice la pantalla para verificar.' },
  { re: /violates foreign key|23503/i,
    msg: 'Este registro está vinculado a otra información y no se puede modificar así.' },
  { re: /check constraint|23514|invalid input value/i,
    msg: 'Alguno de los datos ingresados no es válido. Revise los montos y campos.' },
  { re: /jwt|token.*expired|refresh_token/i,
    msg: 'Su sesión expiró. Por favor vuelva a iniciar sesión.' },
  { re: /permission denied|row-level security|42501/i,
    msg: 'Su usuario no tiene permisos para realizar esta operación.' },
  { re: /failed to fetch|networkerror|load failed|timeout|fetch/i,
    msg: 'No hay conexión con el servidor. Revise su internet e intente nuevamente.' },
  { re: /could not serialize|deadlock/i,
    msg: 'Otra persona está registrando una operación sobre los mismos datos. Espere un momento e intente de nuevo.' },
];

/** Heurística: los mensajes de los RPCs propios vienen en español legible. */
function pareceMensajePropio(msg: string): boolean {
  return /[áéíóúñ¿¡]| el | la | de | no | ya /i.test(msg) && !/constraint|violates|jsonb|syntax/i.test(msg);
}

export function mensajeAmigable(e: unknown, fallback: string): string {
  const crudo = e instanceof Error ? e.message : String(e ?? '');
  if (!crudo) return fallback;
  for (const p of PATRONES) {
    if (p.re.test(crudo)) return p.msg;
  }
  return pareceMensajePropio(crudo) ? crudo : fallback;
}
