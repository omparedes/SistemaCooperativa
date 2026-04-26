import { InjectionToken } from '@angular/core';
import { createClient, SupabaseClient } from '@supabase/supabase-js';
import { environment } from '../../../environments/environment';

export const SUPABASE_CLIENT = new InjectionToken<SupabaseClient>('SUPABASE_CLIENT', {
  providedIn: 'root',
  factory: () => {
    const { supabaseUrl, supabaseAnonKey } = environment;

    if (!supabaseUrl || !supabaseAnonKey) {
      throw new Error(
        '[Supabase] Faltan supabaseUrl o supabaseAnonKey en src/environments/environment.ts. ' +
        'Copia los valores desde tu .env (ver .env.example).'
      );
    }

    return createClient(supabaseUrl, supabaseAnonKey, {
      auth: {
        persistSession: true,
        autoRefreshToken: true,
        detectSessionInUrl: true,
      },
      db: {
        schema: 'public',
      },
    });
  },
});

export type { SupabaseClient } from '@supabase/supabase-js';
