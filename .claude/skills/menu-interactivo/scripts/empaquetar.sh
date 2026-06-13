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

rm -f "$OUT"
( cd "$SRC" && zip -qr "$OUT" . \
    -x "qr/generate_qr.py" "supabase/*" "README.md" )
echo "✅ ZIP listo: $OUT ($(du -h "$OUT" | cut -f1))"
