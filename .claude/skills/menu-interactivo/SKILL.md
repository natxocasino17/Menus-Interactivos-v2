---
name: menu-interactivo
description: >-
  Genera de forma automatizada el paquete completo para vender un menú digital
  a un restaurante. A partir de fotos del menú físico + (opcional) una ficha de
  texto, produce: (1) Web de Clientes (no editable, interactiva, clona el estilo
  del menú físico, modal con foto + descripción + precio), (2) Web de Admin
  (panel privado con login para editar precios, platos, descripciones e
  imágenes) y (3) el código QR. Stack 100% gratis (HTML/CSS/JS + Netlify +
  Supabase). Usar cuando el usuario suba material de un restaurante nuevo o diga
  "activa Menu Interactivo".
---

# Skill: Menu Interactivo

Genera, por restaurante, un paquete de menú digital **listo para vender**.
**Existe una PLANTILLA reutilizable** (`template/`): el esqueleto (HTML/CSS/JS)
no se reescribe nunca. Lo único que cambia por restaurante es el **`menu.json`**
(datos + tema + fuentes) y el **`config.js`** (slug + claves Supabase).

## Stack fijado (todo gratis)
- **Webs:** HTML + CSS + JS puro, sin build. Carpeta autocontenida.
- **Hosting + QR:** Netlify Drop (free). El QR apunta al subdominio gratuito.
- **Backend (publicación instantánea):** **UN SOLO** proyecto Supabase free
  COMPARTIDO por todos los restaurantes (el free tier limita a ~2 proyectos, así
  que NO se crea uno por restaurante). Postgres (tabla `menus` multi-restaurante
  con JSONB) + Storage (bucket `platos`) + Auth (un usuario por dueño).
  Seguro por diseño: cada menú está atado a su `owner_id` y cada dueño solo
  edita el suyo (RLS).
- **Sin backend (fallback):** el menú vive en `menu.json`; el Admin exporta el
  JSON y se vuelve a subir al hosting.

## ⚙️ La plantilla es data-driven (clave para ir rápido)
`template/cliente/app.js` lee `menu.json → restaurante.tema` e **inyecta en
runtime**: colores (variables CSS), fuentes (carga el `<link>` de Google Fonts
desde `tema.googleFonts`), nombre, lema, contacto y nota de pie. Por eso un
restaurante con **otras fuentes y otros platos** NO requiere tocar el código:
basta con su `menu.json`.

Campos de tema en `menu.json` (ver `template/cliente/menu.example.json`):
`primario, secundario, fondo, texto, oscuro, crema, fuenteLogo, fuenteTitulos,
fuenteCuerpo, googleFonts`.

## Flujo de trabajo (qué hago al activar la Skill)
1. **Recordar el material** que prefiero recibir (ver abajo) y avisar de lo que
   falte. Si no hay ficha de texto, **deduzco** tema/fuentes/idiomas de las fotos.
2. **Crear el restaurante** desde la plantilla:
   `bash .claude/skills/menu-interactivo/scripts/nuevo_restaurante.sh <slug>`
   (copia `template/` a `/<slug>/`, renombra `menu.example.json`→`menu.json` y
   fija el slug en `config.js`).
3. **Rellenar `<slug>/cliente/menu.json`**: extraer secciones, platos,
   descripciones (es/en), precios y variantes de las fotos; y fijar el **tema**
   (colores + fuentes) clonando el estilo del menú físico. Validar con `python3
   -c "import json,...; json.load(...)"` y enseñar al usuario un resumen
   (nº secciones / nº productos).
4. **(Opcional) Supabase compartido**: rellenar `config.js` con la URL + anon key
   del proyecto compartido (las mismas para todos). Generar
   `supabase/registrar.sql` a partir de `registrar.example.sql` sustituyendo
   `__SLUG__`, `__EMAIL_DUENO__` y `__MENU_JSON__` (con el menu.json en una línea,
   escapando comillas simples `'`→`''`). El usuario lo ejecuta tras crear el
   usuario del dueño.
5. **Generar el QR**: `cd <slug>/qr && python3 generate_qr.py <URL-final>`.
6. **VERIFICAR (obligatorio antes de entregar)**:
   `bash .claude/skills/menu-interactivo/scripts/verificar.sh <slug>`
   Abre la web en un navegador headless (Playwright) y confirma que renderiza
   secciones + platos + modal sin errores JS. NO entregar si falla.
7. **Empaquetar**: `bash .claude/skills/menu-interactivo/scripts/empaquetar.sh
   <slug>` → genera el menú embebido y el ZIP en `/tmp/<slug>-netlify.zip`.
   Enviarlo con SendUserFile.
8. **Commit + push** a la rama de trabajo.

## Material de entrada (recordar SIEMPRE al activar)
Formato preferido: **Fotos + ficha de texto**.
```
Nombre del restaurante:
Tipo de cocina:
Logo: (opcional)
Colores de marca / tipografía:  — o "deducir de las fotos"
Idioma(s):
Contacto: (teléfono / web / redes / dirección)
Moneda y símbolo:
Notas:
```
Fotos: todas las páginas del menú físico (legibles) + fotos de platos en alta
resolución (opcional, para el modal). Sin fotos de plato se usa un placeholder.

## Guía de despliegue para el usuario (entregar con el ZIP)
1. **Netlify:** arrastrar el **ZIP** (sin descomprimir) a
   [app.netlify.com/drop](https://app.netlify.com/drop). Da una URL
   `https://<algo>.netlify.app`. Personalizar en *Site settings → Change site name*.
   - Cliente: `…/cliente/` · Admin: `…/admin/` · La raíz redirige al cliente.
2. **Supabase (publicación instantánea) — proyecto COMPARTIDO:**
   - **Solo la 1ª vez en la vida** (un proyecto para todos los restaurantes):
     - [supabase.com](https://supabase.com) → New project (free, región Europa).
     - **SQL Editor** → pegar `supabase/schema.sql` → Run (tabla multi-restaurante
       + RLS por dueño + bucket `platos`).
     - **Authentication → Sign In / Providers → DESACTIVAR "Allow new users to
       sign up"** (hardening: solo tú das de alta dueños).
     - **Project Settings → API** → guardar **Project URL** + **anon public**
       (sirven para TODOS los restaurantes; van en cada `config.js`).
   - **Por cada restaurante nuevo (2 pasos):**
     1. **Authentication → Add user** → email + contraseña del dueño (Auto Confirm).
     2. **SQL Editor** → pegar el `supabase/registrar.sql` que yo genero (lleva el
        slug, el email del dueño y el menú) → Run. Esto crea su fila atada a él.
   - Pegar URL + anon key en `cliente/config.js`, re-empaquetar, re-subir a Netlify.
   - Tras esto, el dueño edita y publica al instante; solo puede tocar SU menú.
3. **QR:** regenerar con la URL final y entregar `qr/qr.png`.

## Login del Admin
- **Con Supabase:** dos campos (email + contraseña). Cambio de contraseña desde
  el botón del panel o desde Supabase. Cambio de email desde Supabase.
- **Sin Supabase:** contraseña local (por defecto `admin1234`, cambiar el hash).

## ⚠️ Lecciones aprendidas (no tropezar de nuevo)
- **SIEMPRE verificar con `verificar.sh` antes de entregar.** Un error JS en el
  render deja la carta en blanco con "No se pudo cargar". El navegador headless
  lo detecta; la vista de código no.
- **`app.js` y `index.html` deben ir SIEMPRE juntos y de la misma versión.** El
  bug de hoy: se copió el `app.js` data-driven sobre un `index.html` antiguo sin
  los `id` (`#hero-logo`, `#hero-sub`, `#footer-brand`) → `applyTheme` petaba.
  Por eso `applyTheme` usa ahora `setText()` que comprueba que el elemento existe.
  Si se actualiza el `app.js` de un restaurante, actualizar también su `index.html`.
- **Restaurantes existentes NO se actualizan solos al mejorar la plantilla:**
  cada `<slug>/` es una copia congelada. Para llevar una mejora a un restaurante
  ya creado hay que recopiar los archivos de `template/` (conservando su
  `menu.json` y `config.js`) o parchearlo a mano.
- **Caché del navegador:** los `<script>`/`<link>` llevan `?v=N`. Subir N cada vez
  que cambie el JS/CSS para forzar recarga (móviles cachean agresivamente).
- **Menú embebido de respaldo:** `empaquetar.sh` genera `cliente/menu-data.js`
  (`window.MENU_FALLBACK`) desde `menu.json`; `app.js` lo usa si Supabase y
  `menu.json` fallan. Garantiza que la carta nunca quede en blanco.
- **Probar en local sirviendo desde la carpeta del restaurante** (`cd <slug> &&
  python3 -m http.server`), NO desde la raíz del repo (si no, `/cliente/` da 404).
- **Raíz del sitio:** incluir `index.html` que redirige a `cliente/` (si no, la
  URL base da 404). Ya está en la plantilla.
- **Entrega:** generar un **ZIP** y enviarlo; al usuario no técnico le cuesta
  descomprimir/seleccionar carpetas. Netlify Drop acepta el ZIP tal cual. Darle
  un nombre distintivo si hay riesgo de confundirlo con descargas anteriores.
- **URL de Supabase:** deducirla del campo `ref` del JWT anon
  (`base64 -d` del payload), NO escribirla a mano (un carácter mal → "failed to
  fetch"). La URL es `https://<ref>.supabase.co`.
- **Login:** campos **email y contraseña separados** (no `email:contraseña`).
- **anon key** es pública (segura de poner en `config.js`); la **service/secret
  key NUNCA** se usa en el front.
- **Aislamiento entre restaurantes:** la web lee con la función `get_menu(slug)`
  (no lista la tabla) y la tabla tiene RLS por `owner_id`; así un restaurante no
  puede descubrir ni editar los de otros. Ver `template/supabase/schema.sql`.
- **Pausa free tier:** Supabase pausa el proyecto tras 7 días sin visitas; se
  reactiva con "Restore project" en ~2 min sin perder datos. Para un restaurante
  activo no ocurre.
- Mostrar al usuario un **resumen del menú extraído** para validar antes de seguir.

## Estructura de salida (por restaurante)
```
<slug>/
├── index.html              # redirige a cliente/
├── cliente/  index.html · styles.css · app.js · config.js · menu.json · img/
├── admin/    index.html · styles.css · admin.js
├── qr/       generate_qr.py · qr.png
├── supabase/ schema.sql
└── README.md
```

## Principios
- Plantilla intacta y reutilizable; por restaurante solo `menu.json` + `config.js`.
- Cero costes: solo free tier. Cliente no editable; Admin siempre con login.
