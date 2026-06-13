#!/usr/bin/env bash
# Crea la carpeta de un restaurante nuevo a partir de la plantilla y lo engancha
# automáticamente al Supabase COMPARTIDO (multi-restaurante).
# Uso: scripts/nuevo_restaurante.sh <slug>
set -euo pipefail

SLUG="${1:?Uso: nuevo_restaurante.sh <slug>}"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REPO_DIR="$(cd "$SKILL_DIR/../../.." && pwd)"
DEST="$REPO_DIR/$SLUG"

if [ -e "$DEST" ]; then
  echo "❌ Ya existe $DEST"; exit 1
fi

cp -r "$SKILL_DIR/template" "$DEST"
mv "$DEST/cliente/menu.example.json" "$DEST/cliente/menu.json"

CONFIG="$DEST/cliente/config.js"
# Fija el slug en config.js
sed -i "s/__SLUG__/$SLUG/" "$CONFIG"

# Inyecta las credenciales del Supabase compartido (si existen) → el restaurante
# nuevo nace YA conectado al proyecto multi-restaurante, sin tocar nada a mano.
ENVFILE="$SKILL_DIR/supabase_compartido.env"
if [ -f "$ENVFILE" ]; then
  # shellcheck disable=SC1090
  source "$ENVFILE"
fi
URL="${SUPABASE_URL:-}"
KEY="${SUPABASE_ANON_KEY:-}"

if [ -n "$URL" ] && [ -n "$KEY" ]; then
  python3 - "$CONFIG" "$URL" "$KEY" "$SLUG" <<'PY'
import sys
cfg_path, url, key, slug = sys.argv[1:5]
open(cfg_path, "w").write(f'''/* Configuración de la Web de Clientes — {slug}
   Supabase COMPARTIDO (multi-restaurante). El slug separa cada carta.
   La anon key es pública (segura en el front). */
window.MENU_CONFIG = {{
  SUPABASE_URL: "{url}",
  SUPABASE_ANON_KEY: "{key}",
  RESTAURANT_SLUG: "{slug}",
  MENU_JSON: "menu.json"
}};
''')
PY
  SUPA_MSG="✅ Conectado al Supabase compartido (multi-restaurante)."
else
  SUPA_MSG="ℹ️  Sin credenciales en supabase_compartido.env → arranca en modo menu.json."
fi

echo "✅ Restaurante creado en: $DEST"
echo "   $SUPA_MSG"
echo "   Siguiente: rellenar $DEST/cliente/menu.json (datos + tema + fuentes)."
