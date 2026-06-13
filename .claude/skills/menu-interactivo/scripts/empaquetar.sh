#!/usr/bin/env bash
# Empaqueta un restaurante en un ZIP listo para arrastrar a Netlify Drop.
# Incluye solo lo público (cliente + admin + qr + index). Excluye supabase,
# README y scripts internos.
# Uso: scripts/empaquetar.sh <slug>
set -euo pipefail

SLUG="${1:?Uso: empaquetar.sh <slug>}"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REPO_DIR="$(cd "$SKILL_DIR/../../.." && pwd)"
SRC="$REPO_DIR/$SLUG"
OUT="/tmp/$SLUG-netlify.zip"

[ -d "$SRC" ] || { echo "❌ No existe $SRC"; exit 1; }

# Regenera el menú embebido (window.MENU_FALLBACK) a partir de menu.json,
# para que la carta se muestre siempre, aunque falle la red o Supabase.
if [ -f "$SRC/cliente/menu.json" ]; then
  python3 - "$SRC/cliente/menu.json" "$SRC/cliente/menu-data.js" <<'PY'
import sys
data = open(sys.argv[1]).read()
open(sys.argv[2], "w").write("window.MENU_FALLBACK = " + data + ";\n")
PY
fi

rm -f "$OUT"
( cd "$SRC" && zip -qr "$OUT" . \
    -x "qr/generate_qr.py" "supabase/*" "README.md" )
echo "✅ ZIP listo: $OUT ($(du -h "$OUT" | cut -f1))"
