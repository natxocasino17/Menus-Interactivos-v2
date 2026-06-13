-- ============================================================
-- Registrar un restaurante en el Supabase COMPARTIDO.
-- Pasos previos en el panel de Supabase:
--   1) Authentication → Add user → crea el usuario del dueño
--      (su email + su contraseña). Marca "Auto Confirm User".
-- Luego: SQL Editor → pega esto (yo lo relleno con el menú real
-- de cada restaurante) → Run.
--
-- Ata el menú a su dueño buscándolo por email (sin copiar UIDs).
-- ============================================================
insert into public.menus (slug, owner_id, data)
select
  '__SLUG__',
  (select id from auth.users where email = '__EMAIL_DUENO__'),
  '__MENU_JSON__'::jsonb
on conflict (slug) do update
  set data = excluded.data,
      owner_id = excluded.owner_id;
