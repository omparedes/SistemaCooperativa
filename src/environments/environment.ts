export const environment = {
  production: false,
  supabaseUrl: 'https://sucnpjawtpattgkatqqn.supabase.co',
  supabaseAnonKey: 'sb_publishable_8gK3qybWbVbtItp-NjNq7g_bBHrcftu',
} as const;

export type Environment = typeof environment;
