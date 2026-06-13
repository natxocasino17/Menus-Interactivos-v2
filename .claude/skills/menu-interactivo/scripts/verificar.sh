#!/usr/bin/env bash
# Verifica que la web de un restaurante funciona ANTES de entregarla:
#   1) Chequeo estático: los index.html tienen los id que el JS usa (evita el
#      bug de "pantalla en blanco" por elementos inexistentes).
#   2) Chequeo en navegador (Playwright): la carta de clientes renderiza
#      secciones + platos + modal sin errores JS.
# Uso: scripts/verificar.sh <slug>
set -euo pipefail

SLUG="${1:?Uso: verificar.sh <slug>}"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REPO_DIR="$(cd "$SKILL_DIR/../../.." && pwd)"
SRC="$REPO_DIR/$SLUG"
PORT=$(( (RANDOM % 1000) + 8500 ))
PW="$(npm root -g 2>/dev/null)/playwright"

[ -d "$SRC" ] || { echo "❌ No existe $SRC"; exit 1; }

# --- 1) Chequeo estático de id requeridos ---
FAIL=0
check_id () { # <archivo> <id>
  grep -q "id=\"$2\"" "$1" 2>/dev/null || { echo "❌ Falta id=\"$2\" en $1"; FAIL=1; }
}
for id in hero-logo hero-sub footer-brand footer-note footer-contact menu nav-chips \
          modal modal-img modal-title modal-desc-es modal-desc-en modal-variants modal-price modal-allergens; do
  check_id "$SRC/cliente/index.html" "$id"
done
for id in login-logo login-email login-pass topbar-logo editor save-hint edit-modal \
          f-nombre f-desc-es f-desc-en f-precio f-variantes f-alergenos f-imagen; do
  check_id "$SRC/admin/index.html" "$id"
done
[ "$FAIL" = "0" ] && echo "✅ Estático: todos los id requeridos están presentes."

# Mantener el menú embebido al día
[ -f "$SRC/cliente/menu.json" ] && python3 - "$SRC/cliente/menu.json" "$SRC/cliente/menu-data.js" <<'PY'
import sys
open(sys.argv[2],"w").write("window.MENU_FALLBACK = " + open(sys.argv[1]).read() + ";\n")
PY

# --- 2) Chequeo en navegador (si Playwright está disponible) ---
if [ ! -d "$PW" ]; then
  echo "⚠️  Playwright no disponible; salto el chequeo visual."
  [ "$FAIL" = "0" ] && exit 0 || exit 1
fi

( cd "$SRC" && python3 -m http.server "$PORT" >/dev/null 2>&1 ) &
SERVER_PID=$!
sleep 1

PW="$PW" PORT="$PORT" node - <<'EOF'
const { chromium } = require(process.env.PW);
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  const errs = [];
  page.on('pageerror', e => errs.push(e.message));
  await page.goto('http://localhost:' + process.env.PORT + '/cliente/', { waitUntil: 'load' });
  await page.waitForTimeout(3000);
  const sections = await page.locator('.section').count();
  const cards = await page.locator('.card').count();
  const errMsg = await page.locator('#menu .loading').count();
  let modal = false;
  if (cards > 0) { await page.locator('.card').first().click(); await page.waitForTimeout(400);
    modal = await page.locator('#modal.is-open').count() > 0; }
  const ok = sections > 0 && cards > 0 && errMsg === 0 && modal && errs.length === 0;
  console.log(`CLIENTE → Secciones: ${sections} | Platos: ${cards} | Modal: ${modal} | Errores JS: ${errs.length ? errs.join('; ') : 'ninguno'}`);
  console.log(ok ? '✅ Navegador: la carta carga y el modal funciona.'
                 : '❌ Navegador: la carta NO renderiza bien. Revisar antes de entregar.');
  await browser.close();
  process.exit(ok ? 0 : 1);
})();
EOF
STATUS=$?
kill $SERVER_PID 2>/dev/null || true
[ "$FAIL" = "0" ] && exit $STATUS || exit 1
