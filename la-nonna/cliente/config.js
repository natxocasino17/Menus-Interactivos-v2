/* Configuración por restaurante.
   - Modo simple (sin backend): deja SUPABASE_* vacíos → usa menu.json.
   - Modo Supabase (publicación instantánea): rellena URL y ANON_KEY.
   Cambia RESTAURANT_SLUG por el slug del restaurante. */
window.MENU_CONFIG = {
  SUPABASE_URL: "",
  SUPABASE_ANON_KEY: "",
  RESTAURANT_SLUG: "la-nonna",
  MENU_JSON: "menu.json"
};
