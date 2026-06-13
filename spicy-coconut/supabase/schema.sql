-- ============================================================
-- Spicy Coconut · Esquema Supabase (opcional, free tier)
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- ============================================================

-- Tabla del menú: una fila por restaurante, datos en JSONB
create table if not exists public.menus (
  slug        text primary key,
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

-- Mantener updated_at al día
create or replace function public.touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

drop trigger if exists menus_touch on public.menus;
create trigger menus_touch before update on public.menus
  for each row execute function public.touch_updated_at();

-- RLS: lectura pública (Web de Clientes), escritura solo autenticados (dueño)
alter table public.menus enable row level security;

drop policy if exists "lectura publica" on public.menus;
create policy "lectura publica" on public.menus
  for select using (true);

drop policy if exists "escritura dueno" on public.menus;
create policy "escritura dueno" on public.menus
  for all using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

-- Bucket de fotos de platos (público en lectura)
insert into storage.buckets (id, name, public)
values ('platos', 'platos', true)
on conflict (id) do nothing;

drop policy if exists "platos lectura publica" on storage.objects;
create policy "platos lectura publica" on storage.objects
  for select using (bucket_id = 'platos');

drop policy if exists "platos subida dueno" on storage.objects;
create policy "platos subida dueno" on storage.objects
  for insert with check (bucket_id = 'platos' and auth.role() = 'authenticated');

-- Carga inicial del menú (pegar el contenido de cliente/menu.json donde se indica)
-- insert into public.menus (slug, data) values ('spicy-coconut', '<PEGAR_MENU_JSON_AQUI>'::jsonb)
--   on conflict (slug) do update set data = excluded.data;

-- Crear el usuario del dueño: Dashboard → Authentication → Add user (email + contraseña)
