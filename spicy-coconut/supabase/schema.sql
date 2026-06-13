-- ============================================================
-- Menu Interactivo · Esquema Supabase COMPARTIDO y SEGURO
-- (multi-restaurante en un solo proyecto free).
-- Ejecutar UNA vez por proyecto Supabase: SQL Editor → pegar → Run.
-- Es idempotente: se puede volver a ejecutar sin romper nada.
-- ============================================================

-- Tabla de menús: una fila por restaurante, atada a su dueño.
create table if not exists public.menus (
  slug        text primary key,
  owner_id    uuid references auth.users(id) default auth.uid(),
  data        jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- Por si la tabla ya existía de una versión anterior sin owner_id:
alter table public.menus
  add column if not exists owner_id uuid references auth.users(id) default auth.uid();

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

-- ---------- Seguridad (RLS) ----------
alter table public.menus enable row level security;

-- Limpiar políticas antiguas (de versiones permisivas)
drop policy if exists "lectura publica" on public.menus;
drop policy if exists "escritura dueno" on public.menus;
drop policy if exists "menus lectura publica" on public.menus;
drop policy if exists "menus insert propio" on public.menus;
drop policy if exists "menus update propio" on public.menus;
drop policy if exists "menus delete propio" on public.menus;

-- Lectura: pública (la necesitan las webs de clientes)
create policy "menus lectura publica" on public.menus
  for select using (true);

-- Inserción: solo te puedes asignar a ti mismo como dueño
create policy "menus insert propio" on public.menus
  for insert with check (owner_id = auth.uid());

-- Actualización: solo tu propia fila
create policy "menus update propio" on public.menus
  for update using (owner_id = auth.uid()) with check (owner_id = auth.uid());

-- Borrado: solo tu propia fila
create policy "menus delete propio" on public.menus
  for delete using (owner_id = auth.uid());

-- ---------- Storage de fotos (bucket público en lectura) ----------
insert into storage.buckets (id, name, public)
values ('platos', 'platos', true)
on conflict (id) do nothing;

drop policy if exists "platos lectura publica" on storage.objects;
drop policy if exists "platos subida dueno" on storage.objects;
drop policy if exists "platos update dueno" on storage.objects;

-- Lectura pública de las fotos
create policy "platos lectura publica" on storage.objects
  for select using (bucket_id = 'platos');

-- Subir solo a la carpeta de un restaurante que sea tuyo
-- (las fotos se guardan como "<slug>/archivo.jpg")
create policy "platos subida dueno" on storage.objects
  for insert with check (
    bucket_id = 'platos'
    and (storage.foldername(name))[1] in (
      select slug from public.menus where owner_id = auth.uid()
    )
  );

create policy "platos update dueno" on storage.objects
  for update using (
    bucket_id = 'platos'
    and (storage.foldername(name))[1] in (
      select slug from public.menus where owner_id = auth.uid()
    )
  );

-- ============================================================
-- HARDENING IMPRESCINDIBLE (hacer en el panel, no por SQL):
-- Authentication → Sign In / Providers → DESACTIVAR "Allow new
-- users to sign up". Así nadie puede crearse una cuenta con la
-- clave pública; solo tú das de alta dueños desde el panel.
-- ============================================================
