#!/usr/bin/env bash
# Crea la carpeta de un restaurante nuevo a partir de la plantilla.
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
# Fija el slug en config.js
sed -i "s/__SLUG__/$SLUG/" "$DEST/cliente/config.js"

echo "✅ Restaurante creado en: $DEST"
echo "   Siguiente: rellenar $DEST/cliente/menu.json (datos + tema + fuentes)."
