---
name: menu-interactivo
description: >-
  Genera de forma automatizada el paquete completo para vender un menú digital
  a un restaurante. A partir de fotos del menú físico + una ficha de texto del
  negocio, produce: (1) el código QR de acceso, (2) la Web de Clientes (no
  editable, interactiva, clonando el estilo del menú físico, con modal de
  foto 4K + descripción + precio al tocar un producto) y (3) la Web de Admin
  (panel privado para que el dueño edite precios, platos, descripciones e
  imágenes). Usar cuando el usuario suba material de un restaurante nuevo o
  diga "activa Menu Interactivo".
---

# Skill: Menu Interactivo

Herramienta automatizada para generar, por restaurante, un paquete de menú
digital **listo para vender de forma individual**. Stack 100 % gratuito.

## Stack fijado (todo gratis)

- **Web Clientes + Web Admin:** HTML + CSS + JavaScript puro (sin build, sin
  framework). Se entrega como una carpeta autocontenida.
- **Hosting + URL del QR:** Netlify o GitHub Pages (free tier). El QR apunta al
  subdominio gratuito (ej. `nombrerestaurante.netlify.app`).
- **Persistencia del Admin:** Supabase (free tier) → Postgres (datos del menú)
  + Storage (fotos 4K) + Auth (login del dueño). Los cambios del Admin se ven
  en la Web de Clientes al instante.
- **Generación del QR:** en local, apuntando a la URL gratuita.
- **Fallback sin backend:** si un cliente no quiere Supabase, el menú puede
  vivir en un `menu.json` estático y el Admin exporta/importa ese JSON.

## Material de entrada (lo que el usuario me pasa al activar la Skill)

Formato preferido: **Fotos + ficha de texto**.

### 1. Ficha de texto del restaurante
```
Nombre del restaurante:
Tipo de cocina:
Logo: (adjunta archivo; opcional)
Colores de marca: (principal / secundario / fondo)  — o escribe "deducir de las fotos"
Tipografía: (nombre o ejemplo)  — o "deducir de las fotos"
Idioma(s) de la carta:
Contacto: (teléfono / web / redes / dirección)
Moneda y símbolo: (ej. EUR €)
Notas: (secciones a forzar, platos a destacar, alérgenos, etc.)
```

### 2. Fotos
- **Menú físico:** todas las páginas, bien iluminadas y legibles (de ahí extraigo
  secciones, nombres de plato, descripciones y precios).
- **Platos individuales (opcional pero recomendado):** la mejor resolución
  posible (ideal 4K) para el modal. Nómbralas o asócialas al plato.

> Al activar la Skill, **siempre recordar al usuario esta estructura** antes de
> empezar a generar.

## Modelo de datos del menú (canónico)

```json
{
  "restaurante": {
    "nombre": "",
    "logo": "",
    "tema": { "primario": "", "secundario": "", "fondo": "", "texto": "", "fuente": "" },
    "contacto": { "telefono": "", "web": "", "direccion": "" },
    "moneda": "€"
  },
  "secciones": [
    {
      "id": "",
      "nombre": "",
      "orden": 0,
      "productos": [
        {
          "id": "",
          "nombre": "",
          "descripcion": "",
          "precio": 0.0,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    }
  ]
}
```

## Estructura de salida (por restaurante)

```
<slug-restaurante>/
├── cliente/            # Web de Clientes (pública, no editable)
│   ├── index.html
│   ├── styles.css      # clona estilo/colores/fuentes del menú físico
│   ├── app.js          # render por secciones + modal foto 4K/desc/precio
│   └── menu.json       # o lectura desde Supabase
├── admin/              # Web de Admin (privada, login)
│   ├── index.html
│   ├── styles.css
│   └── admin.js        # CRUD precios/platos/descripciones/imágenes
├── qr/
│   └── qr.png          # apunta a la URL de la Web de Clientes
├── supabase/
│   └── schema.sql      # tablas + storage + RLS (si se usa backend)
└── README.md           # cómo desplegar gratis + credenciales del dueño
```

## Flujo de trabajo de la Skill

1. **Recopilar:** pedir/confirmar ficha de texto + fotos (ver estructura arriba).
2. **Extraer:** leer las fotos del menú físico → poblar el modelo de datos
   canónico (secciones, platos, descripciones, precios). Mostrar al usuario el
   `menu.json` resultante para validación rápida.
3. **Clonar estilo:** deducir colores, tipografía y maquetación del menú físico
   y reflejarlos en `styles.css`.
4. **Generar Web Clientes:** render por secciones; tocar producto → modal con
   foto 4K + descripción + precio. No editable.
5. **Generar Web Admin:** panel con login; CRUD de precios, platos, descripciones
   e imágenes; guarda en Supabase (o exporta JSON en modo fallback).
6. **Generar QR:** apuntando a la URL gratuita de despliegue.
7. **Empaquetar:** entregar la carpeta `<slug-restaurante>/` modular y limpia,
   con README de despliegue gratis paso a paso.

## Principios

- Código **limpio, modular y autocontenido** por restaurante (se vende suelto).
- Cero costes: solo servicios free tier.
- La Web de Clientes nunca expone edición; la de Admin siempre va protegida.
- Reutilizar la plantilla base entre restaurantes; solo cambian datos y tema.
