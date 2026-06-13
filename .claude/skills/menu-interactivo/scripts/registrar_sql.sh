#!/usr/bin/env bash
# Genera <slug>/supabase/registrar.sql con el slug, el email del dueño y el
# menu.json incrustado, listo para pegar en el SQL Editor del Supabase
# compartido (tras crear el usuario del dueño en Authentication).
# Uso: scripts/registrar_sql.sh <slug> <email-dueno>
set -euo pipefail

SLUG="${1:?Uso: registrar_sql.sh <slug> <email-dueno>}"
EMAIL="${2:?Falta el email del dueño}"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REPO_DIR="$(cd "$SKILL_DIR/../../.." && pwd)"
SRC="$REPO_DIR/$SLUG"

[ -f "$SRC/cliente/menu.json" ] || { echo "❌ No existe $SRC/cliente/menu.json"; exit 1; }

python3 - "$SLUG" "$EMAIL" "$SRC/cliente/menu.json" "$SRC/supabase/registrar.sql" <<'PY'
import sys
slug, email, menu_path, out_path = sys.argv[1:5]
data = open(menu_path).read().replace("'", "''")  # escapar comillas para SQL
sql = f"""-- Registro de {slug} en el Supabase compartido.
-- Requisito: crear antes el usuario {email} en Authentication → Add user.
insert into public.menus (slug, owner_id, data)
select
  '{slug}',
  (select id from auth.users where email = '{email}'),
  '{data}'::jsonb
on conflict (slug) do update
  set data = excluded.data,
      owner_id = excluded.owner_id;
"""
open(out_path, "w").write(sql)
print(f"✅ Generado {out_path}")
PY
