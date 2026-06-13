-- Registro de nanku en el Supabase compartido.
-- Requisito: crear antes el usuario natxocasino@gmail.com en Authentication → Add user.
insert into public.menus (slug, owner_id, data)
select
  'nanku',
  (select id from auth.users where email = 'natxocasino@gmail.com'),
  '{
  "restaurante": {
    "nombre": "Nanku",
    "slug": "nanku",
    "lema": "Experiencia Gastronómica · Puerto Viejo",
    "logo": "",
    "tema": {
      "primario": "#3A3D3C",
      "secundario": "#8A6D3B",
      "fondo": "#F4F1EA",
      "texto": "#1F1F1E",
      "oscuro": "#161514",
      "crema": "#FBF8F2",
      "fuenteLogo": "Cinzel",
      "fuenteTitulos": "Playfair Display",
      "fuenteCuerpo": "EB Garamond",
      "googleFonts": "Cinzel:wght@500;700&family=Playfair+Display:ital,wght@0,500;0,700;0,900;1,500&family=EB+Garamond:ital,wght@0,400;0,500;0,600;1,400"
    },
    "contacto": { "telefono": "", "web": "", "direccion": "Puerto Viejo de Talamanca, Limón, Costa Rica" },
    "moneda": "₡",
    "idiomas": ["es", "en"],
    "notaPie": "Por favor, avisale al mesero si tenés intolerancia a ciertos ingredientes o alergias. // Please let your server know about any allergies or intolerances. 10% no incluido // 10% service not included"
  },
  "secciones": [
    {
      "id": "desayunos",
      "nombre": "Desayunos / Breakfast",
      "orden": 1,
      "nota": "",
      "productos": [
        {
          "id": "gallo-pinto",
          "nombre": "Gallo Pinto",
          "descripcion": {
            "es": "Típico desayuno costarricense: gallo pinto con dos huevos y plátano maduro. Extras: queso turrialba, aguacate, carne mechada, bacon, pollo en salsa caribeña, natilla.",
            "en": "Typical Costa Rican breakfast: gallo pinto with two eggs and sweet plantain. Extras: turrialba cheese, avocado, pulled beef, bacon, chicken in Caribbean sauce, sour cream."
          },
          "precio": 3000,
          "imagen": "",
          "alergenos": [],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "tostadas-francesas",
          "nombre": "Tostadas Francesas / French Toast",
          "descripcion": {
            "es": "2 tostadas francesas de pan casero de la casa servidas con mermelada o miel, acompañadas de frutas de temporada.",
            "en": "Two house-made French toasts served with jam or honey and seasonal fruit."
          },
          "precio": 3500,
          "imagen": "",
          "alergenos": ["gluten", "huevo", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "caribe-sandwich",
          "nombre": "Caribe Sándwich",
          "descripcion": {
            "es": "Sándwich relleno de queso, lechuga, tomate y proteína a elección con salsa de la casa.",
            "en": "Sandwich filled with cheese, lettuce, tomato and your choice of protein with house sauce."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Pollo / Chicken", "precio": 4600 },
            { "nombre": "Jamón / Ham", "precio": 4000 },
            { "nombre": "Carne Mechada / Pulled Beef", "precio": 5000 }
          ],
          "imagen": "",
          "alergenos": ["gluten", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "pancakes",
          "nombre": "Pancakes",
          "descripcion": {
            "es": "Acompañados de Nutella y frutas de temporada.",
            "en": "Served with Nutella and seasonal fruit."
          },
          "precio": 3500,
          "imagen": "",
          "alergenos": ["gluten", "huevo", "lacteos", "frutos secos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "omelette",
          "nombre": "Omelette",
          "descripcion": {
            "es": "Omelette de jamón y queso acompañado con frutas de temporada.",
            "en": "Ham and cheese omelette served with seasonal fruit."
          },
          "precio": 3000,
          "imagen": "",
          "alergenos": ["huevo", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "bagel-salmon-atun",
          "nombre": "Bagel de Salmón o Atún",
          "descripcion": {
            "es": "Bagel casero relleno de atún o salmón fresco con una base de verdes de estación, queso de cabra y cebolla morada. Opcional extra huevo.",
            "en": "House-made bagel filled with fresh tuna or salmon over seasonal greens, goat cheese and red onion. Optional extra egg."
          },
          "precio": 5800,
          "imagen": "",
          "alergenos": ["gluten", "pescado", "lacteos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "tostadas",
          "nombre": "Tostadas / Toast",
          "descripcion": {
            "es": "Par de tostadas con mantequilla y mermelada para untar, acompañadas con frutas de temporada.",
            "en": "Pair of toasts with butter and jam, served with seasonal fruit."
          },
          "precio": 2500,
          "imagen": "",
          "alergenos": ["gluten", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "desayuno-extras",
          "nombre": "Extras",
          "descripcion": {
            "es": "Complementos para tu desayuno.",
            "en": "Add-ons for your breakfast."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Aguacate / Avocado", "precio": 700 },
            { "nombre": "Bacon", "precio": 700 },
            { "nombre": "Mozzarella", "precio": 1000 },
            { "nombre": "Nutella", "precio": 700 },
            { "nombre": "Carne en salsa / Beef in sauce", "precio": 1500 },
            { "nombre": "Turrialba", "precio": 600 }
          ],
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "entrantes",
      "nombre": "Entrantes / Starters",
      "orden": 2,
      "nota": "",
      "productos": [
        {
          "id": "canasta-patacones",
          "nombre": "Canasta de Patacones",
          "descripcion": {
            "es": "Patacones rellenos de gallo pinto con atún y camarón.",
            "en": "Fried plantain baskets filled with gallo pinto, tuna and shrimp."
          },
          "precio": 5000,
          "imagen": "",
          "alergenos": ["pescado", "crustaceos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "papas-cheddar",
          "nombre": "Papas con Cheddar",
          "descripcion": {
            "es": "Papas fritas cubiertas de queso cheddar. Opcional extra bacon por ₡1000.",
            "en": "French fries topped with cheddar cheese. Optional extra bacon for ₡1000."
          },
          "precio": 3500,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "nachos-vegetarianos",
          "nombre": "Nachos Vegetarianos",
          "descripcion": {
            "es": "Tortillas tostadas cubiertas de frijoles molidos, natilla, pico de gallo y cheddar.",
            "en": "Toasted tortillas topped with refried beans, sour cream, pico de gallo and cheddar."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "nachos-ticos",
          "nombre": "Nachos Ticos",
          "descripcion": {
            "es": "Tortillas tostadas cubiertas de frijoles molidos, natilla, pico de gallo, cheddar y carne mechada.",
            "en": "Toasted tortillas topped with refried beans, sour cream, pico de gallo, cheddar and pulled beef."
          },
          "precio": 5000,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "guacamole",
          "nombre": "Guacamole",
          "descripcion": {
            "es": "Porción de guacamole acompañado con tortillas.",
            "en": "Portion of guacamole served with tortillas."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "tabla-de-mar",
          "nombre": "Tabla de Mar",
          "descripcion": {
            "es": "Camarones, calamar y dedos de pescado acompañados con patacones.",
            "en": "Shrimp, calamari and fish fingers served with fried plantains."
          },
          "precio": 5500,
          "imagen": "",
          "alergenos": ["pescado", "crustaceos", "moluscos", "gluten"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "almuerzos",
      "nombre": "Almuerzos / Lunch",
      "orden": 3,
      "nota": "Disponible a partir de las 12 m.d. // Available from 12 pm",
      "productos": [
        {
          "id": "casado",
          "nombre": "Casado",
          "descripcion": {
            "es": "Arroz, frijoles, ensalada del día, plátano maduro o patacones y proteína del día.",
            "en": "Rice, beans, salad of the day, sweet plantain or fried plantains and protein of the day."
          },
          "precio": 3300,
          "imagen": "",
          "alergenos": [],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "rice-and-beans",
          "nombre": "Rice and Beans",
          "descripcion": {
            "es": "Plato típico del caribe sur costarricense. Rice and beans acompañado con patacones, ensalada y proteína.",
            "en": "Typical dish of Costa Rica''s southern Caribbean. Rice and beans served with fried plantains, salad and protein."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Pollo / Chicken", "precio": 5000 },
            { "nombre": "Carne Mechada / Pulled Beef", "precio": 5500 },
            { "nombre": "Pescado / Fish", "precio": 6000 }
          ],
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "nanku-sandwich",
          "nombre": "Nanku Sándwich",
          "descripcion": {
            "es": "Cebolla caramelizada, queso mozzarella, arúgula y proteína a elección con salsa de la casa.",
            "en": "Caramelized onion, mozzarella, arugula and your choice of protein with house sauce."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Pollo / Chicken", "precio": 4600 },
            { "nombre": "Carne Mechada / Pulled Beef", "precio": 5000 }
          ],
          "imagen": "",
          "alergenos": ["gluten", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "papas-cheddar-almuerzo",
          "nombre": "Papas con Cheddar",
          "descripcion": {
            "es": "Papas fritas cubiertas de queso cheddar.",
            "en": "French fries topped with cheddar cheese."
          },
          "precio": 3500,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "nachos-almuerzo",
          "nombre": "Nachos",
          "descripcion": {
            "es": "Tortillas tostadas cubiertas de frijoles molidos, natilla, pico de gallo y cheddar.",
            "en": "Toasted tortillas topped with refried beans, sour cream, pico de gallo and cheddar."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Carne Mechada / Pulled Beef", "precio": 5000 },
            { "nombre": "Vegetales / Veggie", "precio": 4500 }
          ],
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "ensalada-mediterranea",
          "nombre": "Ensalada Mediterránea",
          "descripcion": {
            "es": "Camarones dorados sobre una base de brotes verdes con tomate cherry, queso feta y fresa, aderezado con vinagreta.",
            "en": "Seared shrimp over baby greens with cherry tomato, feta cheese and strawberry, dressed with vinaigrette."
          },
          "precio": 7500,
          "imagen": "",
          "alergenos": ["crustaceos", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "hamburguesa-casa",
          "nombre": "Hamburguesa de la Casa",
          "descripcion": {
            "es": "Pan artesanal, torta de res de 175 g, queso, cebolla caramelizada, base de brotes verdes y pepinillos. Acompañada de papas fritas.",
            "en": "Artisan bun, 175 g beef patty, cheese, caramelized onion, baby greens and pickles. Served with fries."
          },
          "precio": 7500,
          "imagen": "",
          "alergenos": ["gluten", "lacteos"],
          "destacado": true,
          "disponible": true
        }
      ]
    },
    {
      "id": "entre-panes",
      "nombre": "Entre Panes / Sandwiches",
      "orden": 4,
      "nota": "Todas las opciones se sirven con papas. // All options are served with fries.",
      "productos": [
        {
          "id": "sandwich-lomito",
          "nombre": "Sándwich de Lomito",
          "descripcion": {
            "es": "Lomito gratinado en queso mozzarella, tocineta, cebolla caramelizada y arúgula.",
            "en": "Tenderloin gratinated with mozzarella, bacon, caramelized onion and arugula."
          },
          "precio": 8000,
          "imagen": "",
          "alergenos": ["gluten", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "sandwich-pollo-miel",
          "nombre": "Sándwich Pollo Miel",
          "descripcion": {
            "es": "Pechuga de pollo a la parrilla con hongos salteados al gorgonzola y mostaza miel.",
            "en": "Grilled chicken breast with gorgonzola-sautéed mushrooms and honey mustard."
          },
          "precio": 7500,
          "imagen": "",
          "alergenos": ["gluten", "lacteos", "mostaza"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "bagel-tico",
          "nombre": "Bagel Tico",
          "descripcion": {
            "es": "Carne mechada o bacon con queso mozzarella, aguacate y huevos.",
            "en": "Pulled beef or bacon with mozzarella, avocado and eggs."
          },
          "precio": 6000,
          "imagen": "",
          "alergenos": ["gluten", "lacteos", "huevo"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "hamburguesa-casa-panes",
          "nombre": "Hamburguesa de la Casa",
          "descripcion": {
            "es": "Pan artesanal, torta de res de 175 g, queso, cebolla caramelizada, base de brotes verdes y pepinillos.",
            "en": "Artisan bun, 175 g beef patty, cheese, caramelized onion, baby greens and pickles."
          },
          "precio": 7500,
          "imagen": "",
          "alergenos": ["gluten", "lacteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "bowls",
      "nombre": "Bowls",
      "orden": 5,
      "nota": "",
      "productos": [
        {
          "id": "teriyaki-bowl",
          "nombre": "Teriyaki Bowl",
          "descripcion": {
            "es": "Pollo salteado en salsa teriyaki servido en una cama de arroz y vegetales.",
            "en": "Chicken sautéed in teriyaki sauce over a bed of rice and vegetables."
          },
          "precio": 7500,
          "imagen": "",
          "alergenos": ["soja", "gluten"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "poke-bowl",
          "nombre": "Poke Bowl",
          "descripcion": {
            "es": "Base de arroz de sushi acompañado de fruta de temporada, aguacate, cebollino, cebolla morada y zanahoria. Atún o salmón a elección.",
            "en": "Sushi rice base with seasonal fruit, avocado, chives, red onion and carrot. Tuna or salmon of your choice."
          },
          "precio": 8500,
          "imagen": "",
          "alergenos": ["pescado", "soja"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "capricho-bowl",
          "nombre": "Capricho Bowl",
          "descripcion": {
            "es": "Fajitas de pollo sobre una base verde, queso parmesano, aguacate, tomate cherry, manzana y almendras con aderezo de la casa.",
            "en": "Chicken fajitas over greens, parmesan, avocado, cherry tomato, apple and almonds with house dressing."
          },
          "precio": 7500,
          "imagen": "",
          "alergenos": ["lacteos", "frutos secos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "mediterranean-bowl",
          "nombre": "Mediterranean Bowl",
          "descripcion": {
            "es": "Camarones dorados sobre una base de brotes verdes con tomate cherry, queso feta y fresa, aderezado con vinagreta.",
            "en": "Seared shrimp over baby greens with cherry tomato, feta cheese and strawberry, dressed with vinaigrette."
          },
          "precio": 7500,
          "imagen": "",
          "alergenos": ["crustaceos", "lacteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "tacos",
      "nombre": "Tacos",
      "orden": 6,
      "nota": "",
      "productos": [
        {
          "id": "tacos-vegetales",
          "nombre": "Tacos de Vegetales",
          "descripcion": {
            "es": "Vegetales salteados con hongos, pico de gallo y queso.",
            "en": "Sautéed vegetables with mushrooms, pico de gallo and cheese."
          },
          "precio": 6000,
          "imagen": "",
          "alergenos": ["lacteos", "gluten"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "tacos-pollo",
          "nombre": "Tacos de Pollo",
          "descripcion": {
            "es": "Pollo caramelizado, cebolla y queso gorgonzola, gratinado con queso mozzarella.",
            "en": "Caramelized chicken, onion and gorgonzola, gratinated with mozzarella."
          },
          "precio": 6500,
          "imagen": "",
          "alergenos": ["lacteos", "gluten"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "tacos-carne-mechada",
          "nombre": "Tacos de Carne Mechada",
          "descripcion": {
            "es": "Carne mechada salteada con vegetales, gratinada con queso mozzarella.",
            "en": "Pulled beef sautéed with vegetables, gratinated with mozzarella."
          },
          "precio": 6500,
          "imagen": "",
          "alergenos": ["lacteos", "gluten"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "especiales",
      "nombre": "Especiales / Specials",
      "orden": 7,
      "nota": "",
      "productos": [
        {
          "id": "lomito",
          "nombre": "Lomito",
          "descripcion": {
            "es": "200 g de lomito con salsa a escoger (hongos, gorgonzola o chimichurri). Servido con dos acompañamientos: puré de papa o papas fritas y vegetales salteados.",
            "en": "200 g tenderloin with your choice of sauce (mushroom, gorgonzola or chimichurri). Served with two sides: mashed potato or fries and sautéed vegetables."
          },
          "precio": 10000,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "churrasco",
          "nombre": "Churrasco",
          "descripcion": {
            "es": "300 g de churrasco servido con chimichurri argentino, acompañado de puré de papas o papas fritas.",
            "en": "300 g churrasco served with Argentine chimichurri, with mashed potato or fries."
          },
          "precio": 9000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "bbq-ribs",
          "nombre": "BBQ Ribs",
          "descripcion": {
            "es": "350 g de costillas de cerdo en salsa barbacoa, acompañadas de puré de papas o papas fritas.",
            "en": "350 g pork ribs in barbecue sauce, with mashed potato or fries."
          },
          "precio": 9000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "fajitas-pollo",
          "nombre": "Fajitas de Pollo",
          "descripcion": {
            "es": "Fajitas de pollo servidas con puré de papa o papas fritas. Una gran opción para los más peques.",
            "en": "Chicken fajitas served with mashed potato or fries. A great option for the little ones."
          },
          "precio": 6500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "salmon-agridulce",
          "nombre": "Salmón Agridulce",
          "descripcion": {
            "es": "200 g de salmón en salsa de maracuyá servido sobre puré de papa y vegetales.",
            "en": "200 g salmon in passion fruit sauce over mashed potato and vegetables."
          },
          "precio": 10000,
          "imagen": "",
          "alergenos": ["pescado"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "pargo-entero",
          "nombre": "Pargo Entero",
          "descripcion": {
            "es": "Pargo entero en salsa caribeña servido con patacones y ensalada. Precio según tamaño, consultar.",
            "en": "Whole red snapper in Caribbean sauce served with fried plantains and salad. Price by size, please ask."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Pargo 250 g — consultar / ask", "precio": null },
            { "nombre": "Pargo 450 g — consultar / ask", "precio": null }
          ],
          "imagen": "",
          "alergenos": ["pescado"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "rice-and-beans-especial",
          "nombre": "Rice and Beans",
          "descripcion": {
            "es": "Plato típico del caribe sur costarricense. Rice and beans acompañado con patacones, ensalada y proteína. Pargo a consultar.",
            "en": "Typical dish of Costa Rica''s southern Caribbean. Rice and beans with fried plantains, salad and protein. Snapper price on request."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Pollo / Chicken", "precio": 5000 },
            { "nombre": "Carne Mechada / Pulled Beef", "precio": 5500 },
            { "nombre": "Pescado / Fish", "precio": 6000 }
          ],
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "ceviche",
          "nombre": "Ceviche",
          "descripcion": {
            "es": "A escoger entre salmón, atún o mixto en leche de tigre, acompañado de patacones.",
            "en": "Choice of salmon, tuna or mixed in leche de tigre, served with fried plantains."
          },
          "precio": 8500,
          "imagen": "",
          "alergenos": ["pescado"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "mar-y-tierra",
          "nombre": "Mar y Tierra",
          "descripcion": {
            "es": "Lomito con camarones al ajillo acompañado con puré de papa y vegetales.",
            "en": "Tenderloin with garlic shrimp, mashed potato and vegetables."
          },
          "precio": 13500,
          "imagen": "",
          "alergenos": ["crustaceos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "tabla-caribena",
          "nombre": "Tabla Caribeña",
          "descripcion": {
            "es": "Dedos de pescado, camarones y pulpo acompañados con patacones, pico de gallo, frijoles molidos y guacamole.",
            "en": "Fish fingers, shrimp and octopus with fried plantains, pico de gallo, refried beans and guacamole."
          },
          "precio": 20000,
          "imagen": "",
          "alergenos": ["pescado", "crustaceos", "moluscos", "gluten"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "tabla-mar-y-tierra",
          "nombre": "Tabla Mar y Tierra",
          "descripcion": {
            "es": "Camarones, pargo y churrasco acompañados con patacones, pico de gallo, frijoles molidos y guacamole.",
            "en": "Shrimp, snapper and churrasco with fried plantains, pico de gallo, refried beans and guacamole."
          },
          "precio": 25000,
          "imagen": "",
          "alergenos": ["pescado", "crustaceos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "arroz-con-camarones",
          "nombre": "Arroz con Camarones",
          "descripcion": {
            "es": "Arroz con camarones al coco, servido con papas fritas o patacones y ensalada.",
            "en": "Coconut shrimp rice, served with fries or fried plantains and salad."
          },
          "precio": 6500,
          "imagen": "",
          "alergenos": ["crustaceos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "fajitas-pescado",
          "nombre": "Fajitas de Pescado",
          "descripcion": {
            "es": "Fajitas de pescado servidas con puré de papa o papas fritas.",
            "en": "Fish fajitas served with mashed potato or fries."
          },
          "precio": 8500,
          "imagen": "",
          "alergenos": ["pescado"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "pastas",
          "nombre": "Pastas (Próximamente)",
          "descripcion": {
            "es": "Spaghetti en salsa blanca o roja con proteína a elegir y queso parmesano. Próximamente.",
            "en": "Spaghetti in white or red sauce with your choice of protein and parmesan. Coming soon."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Pollo / Chicken", "precio": 7000 },
            { "nombre": "Camarón / Shrimp", "precio": 9000 },
            { "nombre": "Salmón / Salmon", "precio": 10000 }
          ],
          "imagen": "",
          "alergenos": ["gluten", "lacteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "cafe",
      "nombre": "Café / Coffee",
      "orden": 8,
      "nota": "Leche de almendras o avena + ₡300. // Almond or oat milk + ₡300.",
      "productos": [
        {
          "id": "espresso",
          "nombre": "Espresso",
          "descripcion": { "es": "", "en": "" },
          "precio": 1000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "americano",
          "nombre": "Americano",
          "descripcion": { "es": "", "en": "" },
          "precio": 1200,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "latte",
          "nombre": "Latte",
          "descripcion": { "es": "", "en": "" },
          "precio": 1500,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "cappuccino",
          "nombre": "Cappuccino",
          "descripcion": { "es": "", "en": "" },
          "precio": 1800,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "mokaccino",
          "nombre": "Mokaccino",
          "descripcion": { "es": "", "en": "" },
          "precio": 2000,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "cafe-frio",
          "nombre": "Café Frío / Iced Coffee",
          "descripcion": { "es": "", "en": "" },
          "precio": 1500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "cafe-frio-leche",
          "nombre": "Café Frío con Leche / Iced Latte",
          "descripcion": { "es": "", "en": "" },
          "precio": 1800,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "frappuccino",
          "nombre": "Frappuccino",
          "descripcion": { "es": "", "en": "" },
          "precio": 2500,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "coffebon",
          "nombre": "Coffebon",
          "descripcion": {
            "es": "Café con Nutella.",
            "en": "Coffee with Nutella."
          },
          "precio": 2500,
          "imagen": "",
          "alergenos": ["lacteos", "frutos secos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "smoothies",
      "nombre": "Smoothies",
      "orden": 9,
      "nota": "Sabores: sandía, piña, papaya, mango, maracuyá, banana, fresa. // Flavors: watermelon, pineapple, papaya, mango, passion fruit, banana, strawberry.",
      "productos": [
        {
          "id": "smoothie-agua",
          "nombre": "Smoothie base en Agua / Water Base",
          "descripcion": {
            "es": "Smoothie con base de agua.",
            "en": "Smoothie with water base."
          },
          "precio": null,
          "variantes": [
            { "nombre": "1 Fruta / 1 Fruit", "precio": 1600 },
            { "nombre": "2 Frutas / 2 Fruits", "precio": 2000 }
          ],
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "smoothie-leche",
          "nombre": "Smoothie base en Leche / Milk Base",
          "descripcion": {
            "es": "Smoothie con base de leche.",
            "en": "Smoothie with milk base."
          },
          "precio": null,
          "variantes": [
            { "nombre": "1 Fruta / 1 Fruit", "precio": 2200 },
            { "nombre": "2 Frutas / 2 Fruits", "precio": 2500 }
          ],
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "limonadas",
      "nombre": "Limonadas / Lemonades",
      "orden": 10,
      "nota": "",
      "productos": [
        {
          "id": "limonada-tradicional",
          "nombre": "Tradicional",
          "descripcion": { "es": "", "en": "" },
          "precio": 2000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "limonada-menta-jengibre",
          "nombre": "Menta y Jengibre / Mint & Ginger",
          "descripcion": { "es": "", "en": "" },
          "precio": 2200,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "limonada-maracuya",
          "nombre": "Maracuyá / Passion Fruit",
          "descripcion": { "es": "", "en": "" },
          "precio": 2200,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "cocteles",
      "nombre": "Cocteles / Cocktails",
      "orden": 11,
      "nota": "",
      "productos": [
        {
          "id": "aperol-spritz",
          "nombre": "Aperol Spritz",
          "descripcion": {
            "es": "Aperol, prosecco y cáscara de naranja.",
            "en": "Aperol, prosecco and orange peel."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": ["sulfitos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "tom-collins",
          "nombre": "Tom Collins",
          "descripcion": {
            "es": "Ginebra, soda, jugo de limón y jarabe de azúcar.",
            "en": "Gin, soda, lemon juice and sugar syrup."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "chaman-pasion",
          "nombre": "Chamán Pasión",
          "descripcion": {
            "es": "Ron Malibu, crema de coco, jugo de naranja y maracuyá.",
            "en": "Malibu rum, coconut cream, orange juice and passion fruit."
          },
          "precio": 5000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "moscow-mule",
          "nombre": "Moscow Mule",
          "descripcion": {
            "es": "Ginger beer, vodka y limón.",
            "en": "Ginger beer, vodka and lime."
          },
          "precio": 5000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "cuba-libre",
          "nombre": "Cuba Libre",
          "descripcion": {
            "es": "Ron con coca y jugo de limón.",
            "en": "Rum with cola and lime juice."
          },
          "precio": 4000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "screwdriver",
          "nombre": "Screwdriver",
          "descripcion": {
            "es": "Vodka y jugo de naranja.",
            "en": "Vodka and orange juice."
          },
          "precio": 4000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "tequila-sunrise",
          "nombre": "Tequila Sunrise",
          "descripcion": {
            "es": "Tequila, granadina y jugo de naranja.",
            "en": "Tequila, grenadine and orange juice."
          },
          "precio": 4000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "sangria",
          "nombre": "Sangría",
          "descripcion": {
            "es": "Vino tinto o blanco con trozos de frutas.",
            "en": "Red or white wine with fruit pieces."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": ["sulfitos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "guaro-sour",
          "nombre": "Guaro Sour",
          "descripcion": {
            "es": "Azúcar, limón, Cacique y granadina.",
            "en": "Sugar, lime, Cacique guaro and grenadine."
          },
          "precio": 4000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "coffee-martini",
          "nombre": "Coffee Martini",
          "descripcion": {
            "es": "Vodka, Kahlúa y café espresso.",
            "en": "Vodka, Kahlúa and espresso coffee."
          },
          "precio": 5000,
          "imagen": "",
          "alergenos": ["lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "pina-colada",
          "nombre": "Piña Colada",
          "descripcion": {
            "es": "Ron, crema de coco y piña.",
            "en": "Rum, coconut cream and pineapple."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "caipirinha",
          "nombre": "Caipirinha",
          "descripcion": {
            "es": "Cachaça, jugo de limón y azúcar.",
            "en": "Cachaça, lime juice and sugar."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "mojito",
          "nombre": "Mojito",
          "descripcion": {
            "es": "Ron, soda, hierbabuena, limón y jarabe de azúcar.",
            "en": "Rum, soda, mint, lime and sugar syrup."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "negroni",
          "nombre": "Negroni",
          "descripcion": {
            "es": "Ginebra, Vermouth Rosso, Campari y cáscara de naranja.",
            "en": "Gin, Vermouth Rosso, Campari and orange peel."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": ["sulfitos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "daiquiri",
          "nombre": "Daiquiri",
          "descripcion": {
            "es": "Ron, sirope de azúcar, limón, fresa o maracuyá.",
            "en": "Rum, sugar syrup, lime, strawberry or passion fruit."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "margarita",
          "nombre": "Margarita",
          "descripcion": {
            "es": "Tequila, Cointreau, triple sec y jugo de limón.",
            "en": "Tequila, Cointreau, triple sec and lime juice."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "campeones-del-mundo",
          "nombre": "Campeones del Mundo",
          "descripcion": {
            "es": "Fernet Branca con Coca Cola.",
            "en": "Fernet Branca with Coca Cola."
          },
          "precio": 5500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "gin-tonic-tradicional",
          "nombre": "Gin Tónic Tradicional",
          "descripcion": {
            "es": "Ginebra con agua tónica.",
            "en": "Gin with tonic water."
          },
          "precio": 4000,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "gin-tonic-sabores",
          "nombre": "Gin Tónic Sabores",
          "descripcion": {
            "es": "Gin tónic con sabores.",
            "en": "Flavored gin and tonic."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "chiliguaro",
          "nombre": "Chiliguaro",
          "descripcion": {
            "es": "Shot auténtico costarricense.",
            "en": "Authentic Costa Rican shot."
          },
          "precio": 1500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "mimosa",
          "nombre": "Mimosa",
          "descripcion": {
            "es": "Prosecco con jugo de naranja.",
            "en": "Prosecco with orange juice."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": ["sulfitos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "coco-loco",
          "nombre": "Coco Loco",
          "descripcion": {
            "es": "Coctel tropical de coco.",
            "en": "Tropical coconut cocktail."
          },
          "precio": 4500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "postres",
      "nombre": "Pastelería y Postres / Desserts",
      "orden": 12,
      "nota": "",
      "productos": [
        {
          "id": "brownie-helado",
          "nombre": "Brownie con Helado",
          "descripcion": {
            "es": "Brownie acompañado de helado.",
            "en": "Brownie served with ice cream."
          },
          "precio": 3500,
          "imagen": "",
          "alergenos": ["gluten", "huevo", "lacteos", "frutos secos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "pie-limon",
          "nombre": "Pie de Limón / Lemon Pie",
          "descripcion": { "es": "", "en": "" },
          "precio": 3500,
          "imagen": "",
          "alergenos": ["gluten", "huevo", "lacteos"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "pie-maracuya",
          "nombre": "Pie de Maracuyá / Passion Fruit Pie",
          "descripcion": { "es": "", "en": "" },
          "precio": 3500,
          "imagen": "",
          "alergenos": ["gluten", "huevo", "lacteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    }
  ]
}
'::jsonb
on conflict (slug) do update
  set data = excluded.data,
      owner_id = excluded.owner_id;
