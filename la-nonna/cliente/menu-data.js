window.MENU_FALLBACK = {
  "restaurante": {
    "nombre": "La Nonna",
    "slug": "la-nonna",
    "lema": "trattoria",
    "logo": "",
    "tema": {
      "primario": "#2E7D32",
      "secundario": "#1B5E20",
      "fondo": "#FBF6EC",
      "texto": "#2B2118",
      "oscuro": "#1A2E1C",
      "crema": "#F4EFE2",
      "fuenteLogo": "Pacifico",
      "fuenteTitulos": "Playfair Display",
      "fuenteCuerpo": "Poppins",
      "googleFonts": "Pacifico&family=Playfair+Display:wght@500;700&family=Poppins:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400"
    },
    "contacto": { "telefono": "2222-3333", "web": "", "direccion": "Calle Roma 12" },
    "moneda": "₡",
    "idiomas": ["es", "en"],
    "notaPie": "10% de servicio no incluido // 10% service not included"
  },
  "secciones": [
    {
      "id": "pizzas",
      "nombre": "Pizzas",
      "orden": 1,
      "nota": "Masa madre fermentada 48h, horno de leña. / 48h sourdough, wood-fired oven.",
      "productos": [
        {
          "id": "margherita",
          "nombre": "Margherita",
          "descripcion": {
            "es": "Salsa de tomate San Marzano, mozzarella fior di latte y albahaca fresca.",
            "en": "San Marzano tomato sauce, fior di latte mozzarella and fresh basil."
          },
          "precio": 6500,
          "imagen": "",
          "alergenos": ["gluten", "lácteos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "diavola",
          "nombre": "Diavola",
          "descripcion": {
            "es": "Salami picante, mozzarella y un toque de aceite de chile.",
            "en": "Spicy salami, mozzarella and a touch of chili oil."
          },
          "precio": 7800,
          "imagen": "",
          "alergenos": ["gluten", "lácteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "quattro-formaggi",
          "nombre": "Quattro Formaggi",
          "descripcion": {
            "es": "Mozzarella, gorgonzola, parmesano y fontina.",
            "en": "Mozzarella, gorgonzola, parmesan and fontina."
          },
          "precio": 8200,
          "imagen": "",
          "alergenos": ["gluten", "lácteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "pastas",
      "nombre": "Pastas",
      "orden": 2,
      "nota": "",
      "productos": [
        {
          "id": "carbonara",
          "nombre": "Carbonara",
          "descripcion": {
            "es": "Guanciale, huevo, pecorino romano y pimienta negra. La receta original, sin nata.",
            "en": "Guanciale, egg, pecorino romano and black pepper. The original recipe, no cream."
          },
          "precio": 7200,
          "imagen": "",
          "alergenos": ["gluten", "huevo", "lácteos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "lasagna",
          "nombre": "Lasagna della Nonna",
          "descripcion": {
            "es": "Capas de pasta fresca, ragú de res cocinado 6 horas y bechamel.",
            "en": "Layers of fresh pasta, 6-hour beef ragù and béchamel."
          },
          "precio": 7900,
          "imagen": "",
          "alergenos": ["gluten", "lácteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "postres",
      "nombre": "Dolci",
      "orden": 3,
      "nota": "",
      "productos": [
        {
          "id": "tiramisu",
          "nombre": "Tiramisú",
          "descripcion": {
            "es": "Mascarpone, café espresso y cacao. Hecho en casa.",
            "en": "Mascarpone, espresso coffee and cocoa. Homemade."
          },
          "precio": 4200,
          "imagen": "",
          "alergenos": ["gluten", "huevo", "lácteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    }
  ]
}
;
