-- Registro de spicy-coconut en el Supabase compartido.
-- Requisito: crear antes el usuario natxocasino@gmail.com en Authentication → Add user.
insert into public.menus (slug, owner_id, data)
select
  'spicy-coconut',
  (select id from auth.users where email = 'natxocasino@gmail.com'),
  '{
  "restaurante": {
    "nombre": "Spicy Coconut",
    "slug": "spicy-coconut",
    "lema": "menu",
    "logo": "",
    "tema": {
      "primario": "#DE5C26",
      "secundario": "#B8431A",
      "fondo": "#F3EDE0",
      "texto": "#2B2118",
      "oscuro": "#161310",
      "fuenteLogo": "Shrikhand",
      "fuenteTitulos": "Cinzel Decorative",
      "fuenteCuerpo": "Poppins"
    },
    "contacto": { "telefono": "", "web": "", "direccion": "" },
    "moneda": "₡",
    "idiomas": ["es", "en"],
    "notaPie": "10% de servicio no incluido // 10% service not included"
  },
  "secciones": [
    {
      "id": "entradas",
      "nombre": "Entradas / Starters",
      "orden": 1,
      "nota": "",
      "productos": [
        {
          "id": "paradis-spring-rolls",
          "nombre": "Paradis Spring Rolls",
          "descripcion": {
            "es": "Spring rolls al estilo vietnamita enrollados en papel de arroz, rellenos de camarones sazonados, pepino, repollo, mango, zanahoria y aguacate, listos para dipear en salsa ponzu y satay.",
            "en": "Vietnamese-style rice paper rolls filled with seasoned poached shrimps, cucumber, cabbage, mango, carrot, and avocado. Served with ponzu and satay dipping sauces."
          },
          "precio": 7900,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "tropical-yakuza",
          "nombre": "Tropical Yakuza",
          "descripcion": {
            "es": "Ceviche de salmón en una fusión asiática de aceite de sésamo, toques de soya, naranja y sriracha con un toque tropical de cubos de mango, aguacate, pepino y notas de jengibre. Acompañados de chips de plátano.",
            "en": "Asian-inspired fusion with sesame oil, hints of soy sauce, orange, and sriracha, blended with tropical notes of mango, avocado, cucumber, and a touch of ginger. Served with plantain chips."
          },
          "precio": 8800,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "tuna-tartar",
          "nombre": "Tuna Tartar",
          "descripcion": {
            "es": "Atún marinado en nuestro dressing asiático montado sobre mango y aguacate en una base de salsa caribeña de maracuyá aromatizada con chile panameño. Acompañada de chips de camote.",
            "en": "Tuna marinated in our Asian-style dressing, layered over mango and avocado on a base of passion fruit–Panamanian chili sauce."
          },
          "precio": 8900,
          "imagen": "",
          "alergenos": [],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "spicy-ceviche",
          "nombre": "Spicy Ceviche",
          "descripcion": {
            "es": "Un plato colorido a base de pescado fresco, trozos de aguacate, cebolla morada, chile dulce y culantro en nuestro dressing de toques cítricos y picantes. Acompañados de chips de plátano.",
            "en": "A colorful dish of fresh fish, avocado chunks, red onion, sweet pepper, and cilantro in our citrusy and spicy dressing. Served with plantain chips."
          },
          "precio": 6600,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "cancun-quesadillas",
          "nombre": "Cancún Quesadillas",
          "descripcion": {
            "es": "Fajitas de pollo salteadas con cebolla, chile dulce, cheddar fundido, terminadas con salsa atomatada, acompañadas de guacamole y pico de gallo.",
            "en": "Sautéed chicken with onions, sweet peppers, and melted cheddar, all this cooked in tomato-based sauce. Served with guacamole and pico de gallo."
          },
          "precio": 5900,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "riviera-maya-tacos",
          "nombre": "Riviera Maya Tacos",
          "descripcion": {
            "es": "Tacos de camarones frescos empanizados, acompañados de nuestra ensalada coleslaw-tequila sunrise y servidas sobre tortillas palmeadas en casa.",
            "en": "Fresh tempura shrimp tacos with a spicy tequila sunrise-style coleslaw salad, served on our homemade tortilla."
          },
          "precio": 5900,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "polynesian-hot-chicken-wings",
          "nombre": "Polynesian Hot Chicken Wings",
          "descripcion": {
            "es": "Alitas de pollo asadas y glaseadas con nuestra salsa Polinésica de mango-chile panameño acompañadas de pepino, zanahoria, piña y cilantro.",
            "en": "Grilled chicken wings glazed with our mango–Panamanian chili Polynesian sauce. Served with cucumber, carrot, pineapple, and fresh cilantro."
          },
          "precio": 6500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "sopa-rostizada",
          "nombre": "Sopa Rostizada",
          "descripcion": {
            "es": "Sopa de vegetales asados con notas ahumadas, acompañadas de nuestro brioche casero, aguacate y cheddar fundido.",
            "en": "Smokey roasted vegetable soup served with house-made brioche, avocado, and melted cheddar."
          },
          "precio": 5200,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "caribenos",
      "nombre": "Caribeños",
      "orden": 2,
      "nota": "",
      "productos": [
        {
          "id": "rice-and-beans",
          "nombre": "Rice and Beans",
          "descripcion": {
            "es": "Arroz y frijoles cocinados en leche de coco con hierbas locales y aromatizados con delicioso chile panameño. Tradicionalmente es servido con Pollo Caribeño, pero tienes opciones de camarones, pesca del día o vegetariano.",
            "en": "Flavorful mix of rice and beans cooked in coconut milk with local herbs and the unique touch of spicy Panamanian chili. Traditionally served with Caribbean-style chicken, but also available with shrimp, catch of the day, or vegetarian."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Pollo Caribeño / Caribbean chicken", "precio": 6800 },
            { "nombre": "Camarones / Shrimp", "precio": 7800 },
            { "nombre": "Vegetariano / Vegetarian", "precio": 6500 },
            { "nombre": "Pesca del día / Catch of the day", "precio": 7200 }
          ],
          "imagen": "",
          "alergenos": [],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "rude-buay-sandwich",
          "nombre": "Rude Buay Sandwich",
          "descripcion": {
            "es": "Pollo desmenuzado cubierto con nuestra deliciosa salsa caribeña y pepinillos frescos. Servido con chips de papa y un extra de salsa para intensificar aún más el sabor de esta receta exclusiva de Spicy Coconut.",
            "en": "Shredded chicken sandwich topped with our flavorful Caribbean sauce and fresh pickles. Served with crispy potato chips and an extra side of sauce to enhance the taste of this unique Spicy Coconut recipe."
          },
          "precio": 7900,
          "imagen": "",
          "alergenos": [],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "patacones",
          "nombre": "Patacones",
          "descripcion": {
            "es": "Crujiente de plátano verde frito, típico del Caribe. Servido con frijoles molidos, pico de gallo, guacamole y queso cheddar derretido.",
            "en": "Crunchy fried green plantain, served with refried beans, pico de gallo, guacamole and melted cheddar cheese."
          },
          "precio": 5900,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "thai-asian",
      "nombre": "Thai Asian",
      "orden": 3,
      "nota": "Todos nuestros currys se sirven con arroz jasmine y pan de la casa. / All our currys are served with jasmine rice and homemade bread.",
      "productos": [
        {
          "id": "curry-queen",
          "nombre": "Curry Queen",
          "descripcion": {
            "es": "Pasta de curry, jengibre, yogur y el sabor del maracuyá se mezclan armoniosamente para crear este plato.",
            "en": "Curry paste, ginger, yogurt, and the exotic touch of passion fruit come together in this aromatic dish."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Camarón / Shrimp", "precio": 10200 },
            { "nombre": "Pescado / Fish", "precio": 9200 },
            { "nombre": "Pollo / Chicken", "precio": 8200 },
            { "nombre": "Veggie", "precio": 7400 }
          ],
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "captain-sandokan",
          "nombre": "Captain Sandokan",
          "descripcion": {
            "es": "Imaginen la mejor receta satay. Mantequilla de maní, pasta de curry, agregue algunas especias, sabores locales y ahí lo tienes!",
            "en": "Picture the best satay recipe: peanut butter, curry paste, a blend of spices and local flavors—this is it!"
          },
          "precio": null,
          "variantes": [
            { "nombre": "Camarón / Shrimp", "precio": 10200 },
            { "nombre": "Pescado / Fish", "precio": 9200 },
            { "nombre": "Pollo / Chicken", "precio": 8200 },
            { "nombre": "Veggie", "precio": 7400 }
          ],
          "imagen": "",
          "alergenos": ["maní"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "smoked-salad",
          "nombre": "Smoked Salad",
          "descripcion": {
            "es": "Remolacha rostizada, mango maduro caramelizado y tomates cherrys deshidratados sobre una fresca cama verde, semillas de girasol tostadas, queso de cabra y acompañado con nuestro relish asiático de mandarina. Puedes pedirla con atún fresco o pechuga de pollo a la plancha como extra.",
            "en": "Roasted beets, caramelized ripe mango and dehydrated cherry tomatoes on a fresh green bed, toasted sunflower seeds, goat cheese and accompanied with our Asian tangerine relish. You can order it with fresh tuna or grilled chicken breast as an extra."
          },
          "precio": 6700,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "char-siu",
          "nombre": "Char Siu",
          "descripcion": {
            "es": "Lechón en salsa Barbacoa asiática, conocido como Char Siu. Servido en una cama de arroz gohan, bok choy en ponzu y huevos marinados en salsa de soya.",
            "en": "Suckling pig in Asian Barbecue sauce, known as Char Siu. Served on a bed of gohan rice, bok choy in ponzu and marinated eggs in soy sauce."
          },
          "precio": 8200,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "thai-noodles",
          "nombre": "Thai Noodles",
          "descripcion": {
            "es": "Fideos de arroz, estilo thai en salsa de tamarindo, con zucchini, brócoli, zanahoria, hongos frescos, maní, cebollino, semillas de sésamo y huevo. Viene con camarones y mejillones. Puedes elegir este platillo con opción de pollo, vegano o gluten free.",
            "en": "Thai-style rice noodles in our tamarind sauce, with zucchini, broccoli, carrot, fresh mushrooms, peanuts, fresh chive, sesame seeds and egg. This recipe comes with shrimp and mussels. You can also order this dish in a chicken, vegan or gluten free option."
          },
          "precio": null,
          "variantes": [
            { "nombre": "Camarones y mejillones", "precio": 9400 },
            { "nombre": "Pollo", "precio": 8600 },
            { "nombre": "Veggie", "precio": 8200 }
          ],
          "imagen": "",
          "alergenos": ["maní", "sésamo"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "stake-ribs-fish",
      "nombre": "Stake · Ribs · Fish",
      "orden": 4,
      "nota": "",
      "productos": [
        {
          "id": "jugoso-corte-de-lomito",
          "nombre": "Jugoso Corte de Lomito",
          "descripcion": {
            "es": "Acompañado de rúcula fresca, papa gratinada, zanahoria y remolacha rostizadas, nueces tostadas, parmesano, un toque de oliva y pimienta. Disponible en dos versiones: salsa de hongos cremosos o salsa de gorgonzola intensa.",
            "en": "Juicy tenderloin cut served with fresh arugula, gratin potatoes, roasted carrots and beets, toasted walnuts, parmesan, and a touch of olive oil and pepper. Available in two versions: with creamy mushroom sauce or with bold gorgonzola sauce."
          },
          "precio": 11900,
          "imagen": "",
          "alergenos": ["nueces", "lácteos"],
          "destacado": true,
          "disponible": true
        },
        {
          "id": "smokey-ribs",
          "nombre": "Smokey Ribs",
          "descripcion": {
            "es": "Deliciosas costillas de cerdo, cocinadas lentamente hasta alcanzar una textura tierna y jugosa, bañadas en una reducción de su propio jugo y transformada en una salsa rica y sofisticada. Acompañadas de papitas doradas al romero, con un toque de frescura y dulzura de manzanas rostizadas.",
            "en": "Tender pork ribs, slow-cooked to perfection and coated in a rich reduction of their own juices, transformed into a sophisticated sauce. Served alongside golden rosemary-infused potatoes and roasted apples, offering a perfect balance of flavors in every bite."
          },
          "precio": 9500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "lomito-avocado-taco",
          "nombre": "Lomito Avocado Taco",
          "descripcion": {
            "es": "Tacos de lomito jugoso en tortillas caseras recién palmeadas servido con guacamole, pico de gallo y acompañados de salsa verde de jalapeños y la salsa picante de la casa.",
            "en": "Juicy tenderloin tacos on freshly hand-pressed tortillas, served with guacamole, pico de gallo, and served with jalapeño green sauce and the house''s hot sauce."
          },
          "precio": 10500,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "purple-mahi-mahi",
          "nombre": "Purple Mahi-Mahi",
          "descripcion": {
            "es": "Medallón de 250 gramos de dorado del Caribe, montado sobre nuestro puré de remolacha y leche de coco, acompañado de vegetales grillados y un relish asiático en base a mandarina, chile dulce, cilantro, soya, oliva y cítricos.",
            "en": "250g medallion of Caribbean mahi mahi on a creamy beet and coconut milk purée, served with grilled vegetables and a mandarin-based Asian relish with sweet pepper, cilantro, soy, olive oil, and citrus notes."
          },
          "precio": 9900,
          "imagen": "",
          "alergenos": ["soja"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "pokes",
      "nombre": "Pokes",
      "orden": 5,
      "nota": "Todos nuestros pokes se preparan con arroz de sushi, incluye pepino, tomates cherry, noodles de zanahoria, aguacate, edamame y salsa ponzu. / All our pokes are prepared with sushi rice, including cucumber, cherry tomatoes, carrot noodles, avocado, edamame and ponzu sauce.",
      "productos": [
        {
          "id": "tiki-totem",
          "nombre": "Tiki Totem",
          "descripcion": {
            "es": "Camarones tempura acompañados de nuestra salsa estilo japonés, trozos de piña y hojas frescas de albahaca.",
            "en": "Crispy tempura shrimp served with our Japanese-style sauce, pineapple chunks, and fresh basil leaves."
          },
          "precio": 9200,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "maui",
          "nombre": "Maui",
          "descripcion": {
            "es": "Crocantes de pollo cubiertos con salsa satay (deliciosa y picante combinación a base de maní) con topping de cebollino fresco.",
            "en": "Crispy chicken bites coated in satay sauce (a rich and mildly spicy peanut-based sauce) with fresh scallion topping."
          },
          "precio": 7800,
          "imagen": "",
          "alergenos": ["maní"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "cahuita-veggie",
          "nombre": "Cahuita Veggie",
          "descripcion": {
            "es": "Vegetales salteados (brócoli, zucchini, zanahoria, repollo morado) preparados en aceite de sésamo, acompañado de plátano maduro.",
            "en": "Stir-fried vegetables (broccoli, zucchini, carrot, and red cabbage) prepared with sesame oil, accompanied by sweet plantain."
          },
          "precio": 7800,
          "imagen": "",
          "alergenos": ["sésamo"],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "beach-boys",
          "nombre": "Beach Boys",
          "descripcion": {
            "es": "Salmón en dressing estilo asiático de mayo-sriracha, aguacate, cebollino fresco y topping de chips de camote.",
            "en": "Salmon tossed in a sriracha-mayo Asian dressing, served with avocado, fresh scallions, and sweet potato chips."
          },
          "precio": 8900,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "the-atlantics",
          "nombre": "The Atlantics",
          "descripcion": {
            "es": "Tartar de atún estilo Spicy Coconut con notas de soya, aceite de ajonjolí y terminado con cebollino y topping de chips de camote.",
            "en": "Tuna tartar in our Spicy Coconut style with notes of soy, sesame oil, fresh scallion, and a topping of sweet potato chips."
          },
          "precio": 8900,
          "imagen": "",
          "alergenos": ["soja", "sésamo"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "burgers",
      "nombre": "Burgers",
      "orden": 6,
      "nota": "Hechas con pan casero, acompañadas de un mix de camotes y papas fritas. / Made with our homemade bread, accompanied with potato and sweet potato fries.",
      "productos": [
        {
          "id": "shake-and-bake",
          "nombre": "Shake and Bake",
          "descripcion": {
            "es": "Pechuga de pollo super crispy bañada en mostaza miel y acompañada de tocino, cheddar fundido y terminado con una combinación de hongos y cebollas caramelizadas.",
            "en": "Super crispy chicken breast glazed with honey mustard, topped with bacon, melted cheddar, and finished with a blend of caramelised mushrooms and onions."
          },
          "precio": 7600,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "boston-beef-down",
          "nombre": "Boston Beef Down",
          "descripcion": {
            "es": "Torta de carne premium hecha en casa, cheddar fundido, tocineta, pepinillos, lechuga, tomate y terminada con nuestra salsa BBQ.",
            "en": "Premium house-made beef patty with melted cheddar, crispy bacon, pickles, lettuce, and tomato, finished with our house BBQ sauce."
          },
          "precio": 7900,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "hawaiian-burger",
          "nombre": "Hawaiian Burger",
          "descripcion": {
            "es": "Torta casera de carne premium, queso fundido, tocineta y una caramelización de piñas y cebollas, terminada con nuestra salsa BBQ.",
            "en": "Premium house-made beef patty with melted cheese, crispy bacon, and a caramelized blend of pineapple and onions, finished with our house BBQ sauce."
          },
          "precio": 8200,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "la-veggiesima",
          "nombre": "La Veggiesima",
          "descripcion": {
            "es": "Hecha con nuestra torta crunchy de lentejas y frijoles bañada en mayonesa de albahaca, cheddar fundido, pepino fresco, lechuga y tomate. Preparación no vegana.",
            "en": "Crispy lentil and bean patty coated in basil mayo, topped with melted cheddar, fresh cucumber, lettuce, and tomato."
          },
          "precio": 7200,
          "imagen": "",
          "alergenos": ["lácteos"],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "postres",
      "nombre": "Postres / Desserts",
      "orden": 7,
      "nota": "No olvides preguntar por nuestro helado hecho en casa. / Don''t forget to ask for our homemade ice cream.",
      "productos": [
        {
          "id": "choco-chilli",
          "nombre": "Choco Chilli",
          "descripcion": {
            "es": "Crepas con mermelada de piña casera y una infusión de chocolate picante.",
            "en": "Crepes, with homemade pineapple marmalade, and infused with spicy chocolate."
          },
          "precio": 4800,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "ginger-orange",
          "nombre": "Ginger Orange",
          "descripcion": {
            "es": "Crepas con mermelada de papaya casera y una reducción de naranja y jengibre.",
            "en": "Crepe with homemade papaya marmalade and an orange and ginger reduction."
          },
          "precio": 4800,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "drunken-bananas",
          "nombre": "Drunken Bananas",
          "descripcion": {
            "es": "Crepas con banano caramelizado y ron.",
            "en": "Caramelized bananas, salted caramel cream and rum."
          },
          "precio": 4800,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "bebidas",
      "nombre": "Bebidas / Drinks",
      "orden": 8,
      "nota": "",
      "productos": [
        {
          "id": "pipa-pina",
          "nombre": "Pipa Piña",
          "descripcion": {
            "es": "Piña con agua de pipa, de la línea Under the Palms.",
            "en": "Pineapple with coconut water, from the Under the Palms line."
          },
          "precio": 2800,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "pipa-sandia",
          "nombre": "Pipa Sandía",
          "descripcion": {
            "es": "Sandía con agua de pipa, de la línea Under the Palms.",
            "en": "Watermelon with coconut water, from the Under the Palms line."
          },
          "precio": 2800,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "limonada-coco",
          "nombre": "Limonada Coco",
          "descripcion": {
            "es": "Limonada con leche de coco.",
            "en": "Coconut milk lemonade."
          },
          "precio": 3600,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "sandia-coco",
          "nombre": "Sandía Coco",
          "descripcion": {
            "es": "Sandía con leche de coco.",
            "en": "Watermelon coconut milk."
          },
          "precio": 3600,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        },
        {
          "id": "beach-shakes",
          "nombre": "Beach Shakes",
          "descripcion": {
            "es": "Sabores: maracuyá piña jengibre · papaya banano miel · piña albahaca · limonada con hierbabuena · flor de Jamaica jengibre · Passion Hibiscus Mocktail.",
            "en": "Flavors: passion fruit pineapple ginger · papaya banana honey · pineapple basil · lemonade with mint · hibiscus ginger · Passion Hibiscus Mocktail."
          },
          "precio": 3400,
          "imagen": "",
          "alergenos": [],
          "destacado": false,
          "disponible": true
        }
      ]
    },
    {
      "id": "cafe",
      "nombre": "Café / Coffee",
      "orden": 9,
      "nota": "",
      "productos": [
        { "id": "americano", "nombre": "Americano", "descripcion": { "es": "", "en": "" }, "precio": 1800, "imagen": "", "alergenos": [], "destacado": false, "disponible": true },
        { "id": "latte", "nombre": "Latte", "descripcion": { "es": "", "en": "" }, "precio": 2200, "imagen": "", "alergenos": [], "destacado": false, "disponible": true },
        { "id": "cappuccino", "nombre": "Cappuccino", "descripcion": { "es": "", "en": "" }, "precio": 2400, "imagen": "", "alergenos": [], "destacado": false, "disponible": true },
        { "id": "espresso", "nombre": "Espresso", "descripcion": { "es": "", "en": "" }, "precio": 1500, "imagen": "", "alergenos": [], "destacado": false, "disponible": true },
        { "id": "iced-coffee", "nombre": "Iced Coffee", "descripcion": { "es": "", "en": "" }, "precio": 2200, "imagen": "", "alergenos": [], "destacado": false, "disponible": true },
        { "id": "iced-caramel-macchiato", "nombre": "Iced Caramel Macchiato", "descripcion": { "es": "", "en": "" }, "precio": 3400, "imagen": "", "alergenos": [], "destacado": false, "disponible": true },
        { "id": "mint-mocaccino", "nombre": "Mint Mocaccino", "descripcion": { "es": "", "en": "" }, "precio": 3400, "imagen": "", "alergenos": [], "destacado": false, "disponible": true },
        { "id": "cold-brew", "nombre": "Cold Brew", "descripcion": { "es": "", "en": "" }, "precio": 2600, "imagen": "", "alergenos": [], "destacado": false, "disponible": true }
      ]
    }
  ]
}
'::jsonb
on conflict (slug) do update
  set data = excluded.data,
      owner_id = excluded.owner_id;
