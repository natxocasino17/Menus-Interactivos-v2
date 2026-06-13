# 🥥🌶️ Spicy Coconut · Menú Digital Interactivo

Paquete generado con la Skill **Menu Interactivo**. Autocontenido y listo para
vender: HTML/CSS/JS puro, sin build, hosting y backend en free tier (coste 0 €).

## Contenido

```
spicy-coconut/
├── cliente/            # Web de Clientes (pública, solo lectura)
│   ├── index.html      # portada + secciones + modal de producto
│   ├── styles.css      # estilo clonado del menú físico
│   ├── app.js          # render + modal (foto, descripción ES/EN, precio)
│   ├── config.js       # config compartida (Supabase opcional)
│   ├── menu.json       # datos del menú (9 secciones, 45 productos)
│   └── img/            # imágenes (placeholder incluido)
├── admin/              # Web de Admin (privada, con login)
├── qr/                 # qr.png + script para regenerarlo
├── supabase/schema.sql # backend opcional (tiempo real)
└── README.md
```

## 🚀 Despliegue gratis (modo simple, sin backend)

1. Entra en [Netlify Drop](https://app.netlify.com/drop) y arrastra la carpeta
   `spicy-coconut/` completa. Obtendrás una URL tipo
   `https://spicy-coconut.netlify.app` (puedes personalizar el nombre en
   *Site settings → Change site name*).
2. Regenera el QR con la URL real:
   ```bash
   cd qr && pip install qrcode[pil] && python3 generate_qr.py https://TU-URL.netlify.app
   ```
3. Imprime `qr/qr.png` para las mesas. La web del cliente queda en `/cliente/`
   y el panel en `/admin/` (ej. `https://TU-URL.netlify.app/cliente/`).

> Alternativa: GitHub Pages (Settings → Pages → deploy from branch).

## 🔑 Panel de Admin

- URL: `/admin/`
- Contraseña por defecto (modo local): **`spicy2026`** — entrégala al dueño y
  pídele cambiarla: abrir la consola del navegador en `/admin/` y ejecutar
  `localStorage.setItem("mi-admin-hash", await hashPass("NUEVA_CONTRASEÑA"))`.
- El dueño puede: editar nombres, precios, descripciones (ES/EN), variantes,
  alérgenos, marcar destacado/no disponible, subir fotos, crear/eliminar platos
  y secciones, y reordenar secciones.
- **Modo simple (sin backend):** los cambios se guardan como borrador en el
  navegador. Para publicarlos: `Descargar menu.json` → reemplazar
  `cliente/menu.json` en el hosting (en Netlify: volver a arrastrar la carpeta).

## ⚡ Modo Supabase (opcional: cambios publicados al instante)

1. Crea un proyecto gratis en [supabase.com](https://supabase.com).
2. Ejecuta `supabase/schema.sql` en el SQL Editor (incluye tabla, RLS y bucket
   de fotos). Inserta el menú inicial pegando `cliente/menu.json` donde indica
   el comentario final.
3. Crea el usuario del dueño en *Authentication → Add user*.
4. Rellena `SUPABASE_URL` y `SUPABASE_ANON_KEY` en `cliente/config.js`.
5. En el login del Admin se entra con `email:contraseña`. Al guardar, los
   clientes ven los cambios al recargar — sin tocar el hosting.

## 🖼️ Fotos de platos

- Donde no hay foto se muestra un placeholder con la marca.
- Sube fotos reales desde el Admin (se redimensionan a 1600 px máx.) o coloca
  archivos en `cliente/img/` y referencia la ruta en `menu.json`
  (`"imagen": "img/tuna-tartar.jpg"`).

## 🎨 Tema (clonado del menú físico)

| Elemento | Valor |
|---|---|
| Naranja terracota | `#DE5C26` |
| Naranja oscuro (motivos) | `#B8431A` |
| Crema (fondo) | `#F3EDE0` |
| Oscuro (portada) | `#161310` |
| Logo | Shrikhand (groovy 70s) |
| Títulos de sección | Cinzel Decorative (art déco) |
| Cuerpo | Poppins (ES en cursiva, EN regular) |

Todo el tema vive en variables CSS al inicio de `cliente/styles.css`.
