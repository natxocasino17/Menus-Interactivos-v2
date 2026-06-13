#!/usr/bin/env bash
# Verifica que la web de un restaurante RENDERIZA de verdad, abriéndola en un
# navegador headless (Playwright) antes de entregarla. Evita entregar webs rotas.
# Uso: scripts/verificar.sh <slug>
set -euo pipefail

SLUG="${1:?Uso: verificar.sh <slug>}"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REPO_DIR="$(cd "$SKILL_DIR/../../.." && pwd)"
SRC="$REPO_DIR/$SLUG"
PORT=$(( (RANDOM % 1000) + 8500 ))
PW="$(npm root -g 2>/dev/null)/playwright"

[ -d "$SRC" ] || { echo "❌ No existe $SRC"; exit 1; }
[ -d "$PW" ] || { echo "⚠️  Playwright no disponible; salto verificación visual."; exit 0; }

# Asegura el menú embebido al día
[ -f "$SRC/cliente/menu.json" ] && python3 - "$SRC/cliente/menu.json" "$SRC/cliente/menu-data.js" <<'PY'
import sys
open(sys.argv[2],"w").write("window.MENU_FALLBACK = " + open(sys.argv[1]).read() + ";\n")
PY

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
  await page.goto('http://localhost:'+process.env.PORT+'/cliente/', { waitUntil: 'load' });
  await page.waitForTimeout(3000);
  const sections = await page.locator('.section').count();
  const cards = await page.locator('.card').count();
  const errMsg = await page.locator('#menu .loading').count();
  let modal = false;
  if (cards > 0) { await page.locator('.card').first().click(); await page.waitForTimeout(400);
    modal = await page.locator('#modal.is-open').count() > 0; }
  const ok = sections > 0 && cards > 0 && errMsg === 0 && modal && errs.length === 0;
  console.log(`Secciones: ${sections} | Platos: ${cards} | Modal: ${modal} | Errores JS: ${errs.length ? errs.join('; ') : 'ninguno'}`);
  console.log(ok ? '✅ VERIFICACIÓN OK — la carta carga y el modal funciona.'
                 : '❌ VERIFICACIÓN FALLÓ — revisar antes de entregar.');
  await browser.close();
  process.exit(ok ? 0 : 1);
})();
EOF
STATUS=$?
kill $SERVER_PID 2>/dev/null || true
exit $STATUS
