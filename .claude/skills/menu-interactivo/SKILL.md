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

**Hay una PLANTILLA reutilizable (`template/`)**: el esqueleto HTML/CSS/JS no se
reescribe nunca. Lo único que cambia por restaurante es:
- `cliente/menu.json` → datos (carta) + tema (colores y fuentes) + nombre.
- `cliente/config.js` → solo el slug (las claves del Supabase compartido se
  inyectan **solas** desde `supabase_compartido.env`; ver abajo).

**Supabase ya es multi-restaurante y automático.** Las credenciales del proyecto
compartido viven en `supabase_compartido.env` (URL + anon key, fuente única de la
verdad). `nuevo_restaurante.sh` las inyecta en el `config.js` de cada restaurante
nuevo, así que **nace ya conectado** sin tocar nada a mano. Un restaurante NO es
un proyecto Supabase: es una **fila** en la tabla `menus` (lo separa el `slug`).

La plantilla es **data-driven**: `cliente/app.js` lee `menu.json → restaurante.tema`
e inyecta en runtime colores (variables CSS), fuentes (Google Fonts vía
`tema.googleFonts`), nombre, lema, contacto y nota de pie. Por eso un restaurante
con otras fuentes y otra carta NO requiere tocar código.

## Stack (todo gratis)
- **Webs:** HTML + CSS + JS puro, sin build. Carpeta autocontenida.
- **Hosting + QR:** Netlify (free). El QR apunta al subdominio gratuito.
- **Backend (publicación instantánea):** UN SOLO proyecto Supabase free,
  COMPARTIDO por todos los restaurantes (el free tier limita a ~2 proyectos, así
  que nunca se crea uno por restaurante). Tabla `menus` multi-restaurante (JSONB)
  + Storage (bucket `platos`) + Auth (un usuario por dueño). Seguro: cada menú
  atado a su `owner_id`; cada dueño solo edita el suyo (RLS) y nadie puede
  listar/descubrir los demás restaurantes (lectura vía función `get_menu`).
- **Fallback sin backend:** el menú vive en `menu.json` (+ `menu-data.js`
  embebido); el Admin exporta el JSON y se re-sube al hosting.

## Flujo de trabajo (al activar la Skill)
1. **Recordar el material** que se prefiere (ver abajo) y avisar de lo que falte.
   Sin ficha de texto, **deducir** tema/fuentes/idiomas de las fotos.
2. **Crear el restaurante:**
   `bash .claude/skills/menu-interactivo/scripts/nuevo_restaurante.sh <slug>`
3. **Rellenar `<slug>/cliente/menu.json`:** extraer de las fotos secciones,
   platos, descripciones (es/en), precios y variantes; fijar el `tema` (colores +
   fuentes + `googleFonts`) clonando el estilo del menú físico. Validar el JSON y
   mostrar al usuario un resumen (nº secciones / nº platos).
4. **Supabase compartido (ya conectado):** el `config.js` viene con las claves
   inyectadas por `nuevo_restaurante.sh` (no hay que pegarlas). Solo generar el
   SQL de registro:
   `bash .claude/skills/menu-interactivo/scripts/registrar_sql.sh <slug> <email-dueño>`
   El usuario hará 2 pasos en SU panel (el mismo proyecto de siempre, no uno
   nuevo): (a) **Authentication → Add user** — *solo si el email es nuevo*; si
   reutiliza un email ya dado de alta, saldrá "already registered" y eso es
   normal, se salta este paso; (b) **SQL Editor → registrar.sql → Run**.
5. **Generar el QR:** `cd <slug>/qr && python3 generate_qr.py <URL-final>`
6. **VERIFICAR (obligatorio):**
   `bash .claude/skills/menu-interactivo/scripts/verificar.sh <slug>`
   Chequea (a) que los `index.html` tienen los `id` que el JS usa, y (b) que la
   carta renderiza en un navegador headless sin errores. **No entregar si falla.**
7. **Empaquetar:** `bash .claude/skills/menu-interactivo/scripts/empaquetar.sh <slug>`
   → genera el menú embebido y el ZIP en `/tmp/<slug>-netlify.zip`. Enviar con
   SendUserFile (nombre distintivo si hay riesgo de confusión con descargas previas).
8. **Commit + push** a la rama de trabajo.

## Scripts (`scripts/`)
| Script | Qué hace |
|---|---|
| `nuevo_restaurante.sh <slug>` | Copia `template/` a `/<slug>/`, renombra `menu.example.json`→`menu.json`, fija el slug y **conecta el restaurante al Supabase compartido** inyectando URL + anon key desde `supabase_compartido.env`. |
| `registrar_sql.sh <slug> <email>` | Genera `<slug>/supabase/registrar.sql` (slug + email del dueño + menú) para el Supabase compartido. |
| `verificar.sh <slug>` | Chequeo estático de `id` + render en navegador (Playwright). |
| `empaquetar.sh <slug>` | Regenera `menu-data.js` y crea el ZIP para Netlify. |

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
resolución (opcional, para el modal). Sin foto de plato se usa un placeholder.

## Modelo de datos (`menu.json`)
Ver `template/cliente/menu.example.json`. Campos de tema:
`primario, secundario, fondo, texto, oscuro, crema, fuenteLogo, fuenteTitulos,
fuenteCuerpo, googleFonts`. Cada producto admite `precio` o `variantes`
(`[{nombre, precio}]`), `alergenos`, `destacado`, `disponible`, `imagen`.

## Guía de despliegue para el usuario (entregar con el ZIP)
1. **Netlify:** arrastrar el **ZIP** (sin descomprimir) a
   [app.netlify.com/drop](https://app.netlify.com/drop) (sitio nuevo) o, para
   actualizar uno existente, en el sitio → **Deploys** → arrastrar el ZIP.
   - Cliente: `…/cliente/` · Admin: `…/admin/` · La raíz redirige al cliente.
2. **Supabase compartido (publicación instantánea):**
   - **Solo la 1ª vez (un proyecto para todos):**
     - New project (free, región Europa).
     - **SQL Editor** → pegar `supabase/schema.sql` → Run.
     - **Authentication → Sign In / Providers → DESACTIVAR "Allow new users to
       sign up"** (solo tú das de alta dueños).
     - **Project Settings → API** → guardar **Project URL** + **anon public**
       (sirven para todos los restaurantes; van en cada `config.js`).
   - **Por cada restaurante (2 pasos, en el MISMO proyecto, no uno nuevo):**
     1. **Authentication → Add user** → email + contraseña del dueño (Auto Confirm).
        *Solo si el email es nuevo.* Si reutilizas un email ya dado de alta
        (un mismo usuario puede ser dueño de varias cartas), Supabase dirá
        "already registered" → ignóralo y salta al paso 2. En ese caso la
        contraseña del Admin es la que ya tenía ese usuario (cambiable luego
        desde el botón del panel).
     2. **SQL Editor** → pegar `supabase/registrar.sql` → Run (crea su fila atada a él).
   - El `config.js` ya trae URL + anon key (las inyecta `nuevo_restaurante.sh`).
     No hay que pegarlas a mano; solo re-empaquetar y subir el ZIP.
3. **QR:** regenerar con la URL final y entregar `qr/qr.png`.

## Login del Admin
- **Con Supabase:** dos campos (email + contraseña). El dueño cambia su
  contraseña desde el botón del panel; el email se cambia desde Supabase.
- **Sin Supabase:** contraseña local (plantilla: `admin1234`; cambiar el hash).

## ⚠️ Lecciones aprendidas (no tropezar de nuevo)
- **Supabase es UN solo proyecto compartido; NO hay proyecto por restaurante.**
  No busques (ni crees) un proyecto llamado como el restaurante: cada uno es una
  **fila** en `menus`. Las credenciales viven en `supabase_compartido.env` y
  `nuevo_restaurante.sh` las inyecta solo. Para cambiar de proyecto compartido,
  edita ese `.env` (afecta solo a los restaurantes nuevos; los ya creados son
  copias congeladas y hay que parchear su `config.js`).
- **Un mismo email/usuario puede ser dueño de varias cartas.** Al dar de alta el
  dueño, si reutilizas un email ya registrado Supabase responde "A user with this
  email address has already been registered" → es NORMAL, no es un error: salta
  el "Add user" y corre directamente el `registrar.sql` (busca al usuario por
  email y le ata la fila). La contraseña del Admin será la que ese usuario ya
  tenía; se cambia desde el botón del panel. Para cuentas independientes por
  dueño, usa un email distinto por restaurante.
- **SIEMPRE `verificar.sh` antes de entregar.** Un error JS en el render deja la
  carta en blanco; el navegador headless lo detecta, la vista de código no.
- **`app.js`/`admin.js` e `index.html` van SIEMPRE de la misma versión.** Bug
  recurrente: copiar el JS data-driven sobre un `index.html` sin los `id`
  (`#hero-logo`, `#hero-sub`, `#footer-brand`, `#topbar-logo`, `#login-logo`) →
  el render petaba y la web quedaba en blanco. Mitigado en dos frentes: el JS
  comprueba que el elemento existe antes de escribir, y `verificar.sh` revisa los
  `id`. Si se actualiza el JS de un restaurante, actualizar también su `index.html`.
- **Restaurantes existentes NO se actualizan solos** al mejorar la plantilla:
  cada `<slug>/` es una copia congelada. Para llevar una mejora hay que recopiar
  de `template/` (conservando su `menu.json` y `config.js`) o parchear a mano.
- **Caché del navegador:** los `<script>`/`<link>` llevan `?v=N`; subir N al
  cambiar JS/CSS (los móviles cachean agresivamente). Para probar, usar incógnito.
- **Menú embebido:** `empaquetar.sh`/`verificar.sh` generan `cliente/menu-data.js`
  (`window.MENU_FALLBACK`) desde `menu.json`; `app.js` lo usa si Supabase y
  `menu.json` fallan → la carta nunca queda en blanco.
- **Probar en local sirviendo desde la carpeta del restaurante**
  (`cd <slug> && python3 -m http.server`), NO desde la raíz (si no `/cliente/` da 404).
- **Raíz del sitio:** `index.html` que redirige a `cliente/` (si no, la URL base
  da 404). Ya está en la plantilla.
- **URL de Supabase:** deducirla del campo `ref` del JWT anon (`base64 -d` del
  payload), NO escribirla a mano (un carácter mal → "failed to fetch").
  URL = `https://<ref>.supabase.co`.
- **anon key** es pública (segura en `config.js`); la **service/secret key NUNCA**
  va en el front.
- **Pausa free tier:** Supabase pausa el proyecto tras 7 días sin visitas; se
  reactiva con "Restore project" en ~2 min sin perder datos.

## Estructura de salida (por restaurante)
```
<slug>/
├── index.html              # redirige a cliente/
├── cliente/  index.html · styles.css · app.js · config.js · menu.json · menu-data.js · img/
├── admin/    index.html · styles.css · admin.js
├── qr/       generate_qr.py · qr.png
├── supabase/ schema.sql · registrar.sql
└── README.md
```

## Principios
- Plantilla intacta y reutilizable; por restaurante solo `menu.json` + `config.js`.
- Cero costes (solo free tier). Cliente no editable; Admin siempre con login.
- Restaurantes aislados entre sí. Verificar SIEMPRE antes de entregar.
