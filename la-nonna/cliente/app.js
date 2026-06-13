/* ============================================================
   Menu Interactivo · Plantilla Web de Clientes (solo lectura)
   - Carga el menú desde Supabase (si está configurado) o menu.json
   - Inyecta tema (colores + fuentes) y nombre desde menu.json
   - Render por secciones + modal de producto
   GENÉRICO: no editar por restaurante. Lo único que cambia es
   menu.json (datos + tema) y config.js (slug + claves Supabase).
   ============================================================ */
(function () {
  "use strict";

  const cfg = window.MENU_CONFIG || {};
  const $ = (sel) => document.querySelector(sel);

  const MOTIF_SVG =
    '<svg class="section__motif" viewBox="0 0 100 100" fill="currentColor" aria-hidden="true">' +
    '<path d="M50 8c4 14-2 20 6 28s20 2 30 8c-12 8-22 2-28 10s0 20-8 30c-6-12-2-22-10-28s-20 0-30-8c12-6 22-2 28-10s2-20 12-30z"/>' +
    "</svg>";
  const PLACEHOLDER_IMG = "img/placeholder.svg";

  /* ---------- Tema (colores + fuentes) desde menu.json ---------- */
  function applyTheme(rest) {
    const t = rest.tema || {};
    const root = document.documentElement.style;
    const map = {
      "--primario": t.primario, "--secundario": t.secundario, "--fondo": t.fondo,
      "--texto": t.texto, "--oscuro": t.oscuro, "--crema": t.crema,
    };
    for (const k in map) if (map[k]) root.setProperty(k, map[k]);
    if (t.fuenteLogo) root.setProperty("--f-logo", "'" + t.fuenteLogo + "', cursive");
    if (t.fuenteTitulos) root.setProperty("--f-titulo", "'" + t.fuenteTitulos + "', serif");
    if (t.fuenteCuerpo) root.setProperty("--f-cuerpo", "'" + t.fuenteCuerpo + "', sans-serif");

    if (t.googleFonts) {
      const link = document.createElement("link");
      link.rel = "stylesheet";
      link.href = "https://fonts.googleapis.com/css2?family=" + t.googleFonts + "&display=swap";
      document.head.appendChild(link);
    }
    /* Nombre del restaurante en portada/pie/título */
    document.title = rest.nombre || "Menú";
    $("#hero-logo").textContent = rest.nombre || "Menú";
    $("#hero-sub").textContent = rest.lema || "menu";
    $("#footer-brand").textContent = rest.nombre || "";
  }

  /* ---------- Carga de datos ---------- */
  async function loadMenu() {
    if (cfg.SUPABASE_URL && cfg.SUPABASE_ANON_KEY) {
      try {
        /* Lee SOLO su propio menú por slug (función get_menu). No se puede
           listar la tabla → ningún restaurante puede ver a los demás. */
        const res = await fetch(cfg.SUPABASE_URL + "/rest/v1/rpc/get_menu", {
          method: "POST",
          headers: {
            apikey: cfg.SUPABASE_ANON_KEY,
            Authorization: "Bearer " + cfg.SUPABASE_ANON_KEY,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ p_slug: cfg.RESTAURANT_SLUG }),
        });
        const data = await res.json();
        if (data && data.secciones && data.secciones.length) return data;
      } catch (_) { /* cae al JSON estático si Supabase falla o está vacío */ }
    }
    const res = await fetch(cfg.MENU_JSON || "menu.json", { cache: "no-store" });
    return res.json();
  }

  /* ---------- Utilidades ---------- */
  const fmtPrice = (n, m) => m + String(n).replace(/\B(?=(\d{3})+(?!\d))/g, ".");

  function el(tag, className, html) {
    const node = document.createElement(tag);
    if (className) node.className = className;
    if (html !== undefined) node.innerHTML = html;
    return node;
  }
  const esc = (s) => String(s ?? "").replace(/[&<>"']/g, (c) =>
    ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

  /* ---------- Render ---------- */
  function render(menu) {
    applyTheme(menu.restaurante || {});
    const moneda = menu.restaurante.moneda || "₡";
    const main = $("#menu");
    const chips = $("#nav-chips");
    main.innerHTML = "";
    chips.innerHTML = "";

    [...menu.secciones].sort((a, b) => a.orden - b.orden).forEach((sec, i) => {
      const chip = el("button", "nav__chip", esc(sec.nombre));
      chip.addEventListener("click", () =>
        document.getElementById("sec-" + sec.id)?.scrollIntoView({ behavior: "smooth" }));
      chips.appendChild(chip);

      const section = el("section", "section " + (i % 2 === 0 ? "section--orange" : "section--cream"));
      section.id = "sec-" + sec.id;
      const inner = el("div", "section__inner");
      inner.innerHTML = MOTIF_SVG +
        '<h2 class="section__title">' + esc(sec.nombre) + "</h2>" +
        (sec.nota ? '<p class="section__note">' + esc(sec.nota) + "</p>" : "");

      const grid = el("div", "section__grid");
      sec.productos.forEach((p) => {
        if (p.disponible === false) return;
        const card = el("button", "card");
        const priceText = p.variantes && p.variantes.length
          ? "desde " + fmtPrice(Math.min(...p.variantes.map((v) => v.precio)), moneda)
          : p.precio != null ? fmtPrice(p.precio, moneda) : "";
        card.innerHTML =
          '<span class="card__head"><span class="card__name">' + esc(p.nombre) + "</span>" +
          (p.destacado ? '<span class="card__star">★</span>' : "") + "</span>" +
          (p.descripcion?.es ? '<span class="card__desc">' + esc(p.descripcion.es) + "</span>" : "") +
          '<span class="card__price">' + priceText + "</span>";
        card.addEventListener("click", () => openModal(p, moneda));
        grid.appendChild(card);
      });
      inner.appendChild(grid);
      section.appendChild(inner);
      main.appendChild(section);
    });

    $("#footer-note").textContent = menu.restaurante.notaPie || "";
    const c = menu.restaurante.contacto || {};
    $("#footer-contact").textContent = [c.direccion, c.telefono, c.web].filter(Boolean).join(" · ");
  }

  /* ---------- Modal ---------- */
  const modal = $("#modal");
  function openModal(p, moneda) {
    $("#modal-img").src = p.imagen || PLACEHOLDER_IMG;
    $("#modal-img").alt = p.nombre;
    $("#modal-title").textContent = p.nombre;
    $("#modal-desc-es").textContent = p.descripcion?.es || "";
    $("#modal-desc-en").textContent = p.descripcion?.en || "";
    const variants = $("#modal-variants");
    variants.innerHTML = "";
    (p.variantes || []).forEach((v) =>
      variants.appendChild(el("li", "", "<span>" + esc(v.nombre) + "</span><span>" + fmtPrice(v.precio, moneda) + "</span>")));
    $("#modal-price").textContent = p.precio != null && !(p.variantes && p.variantes.length) ? fmtPrice(p.precio, moneda) : "";
    $("#modal-allergens").textContent = p.alergenos && p.alergenos.length ? "Alérgenos: " + p.alergenos.join(", ") : "";
    modal.classList.add("is-open");
    modal.setAttribute("aria-hidden", "false");
    document.body.classList.add("modal-open");
  }
  function closeModal() {
    modal.classList.remove("is-open");
    modal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("modal-open");
  }
  modal.addEventListener("click", (e) => { if (e.target.closest("[data-close]")) closeModal(); });
  document.addEventListener("keydown", (e) => { if (e.key === "Escape") closeModal(); });

  /* ---------- Arranque ---------- */
  loadMenu().then(render).catch(() => {
    $("#menu").innerHTML = '<p class="loading">No se pudo cargar la carta. Inténtalo de nuevo.</p>';
  });
})();
