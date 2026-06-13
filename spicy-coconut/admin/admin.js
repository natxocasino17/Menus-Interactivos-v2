/* ============================================================
   Menu Interactivo · Plantilla Web de Admin (panel privado)
   - Login: Supabase (email + contraseña) o modo local (contraseña)
   - CRUD secciones/platos: precios, descripciones, variantes, fotos
   - Persistencia: Supabase (instantáneo) o borrador local + export JSON
   - Botón para que el dueño cambie su propia contraseña
   GENÉRICO: no editar por restaurante.
   ============================================================ */
(function () {
  "use strict";

  const cfg = window.MENU_CONFIG || {};
  const SUPA = Boolean(cfg.SUPABASE_URL && cfg.SUPABASE_ANON_KEY);
  const DRAFT_KEY = "mi-admin-draft:" + (cfg.RESTAURANT_SLUG || "menu");
  const SESSION_KEY = "mi-admin-session:" + (cfg.RESTAURANT_SLUG || "menu");

  /* Contraseña del modo local (SHA-256). Por defecto: "admin1234".
     Solo se usa si NO hay Supabase configurado. */
  const DEFAULT_PASS_HASH = "7a9a22ed6180a51e4b951adcf473b6f0bf43456dfa3ab25999c861d1eeea1268";

  const $ = (s) => document.querySelector(s);
  let menu = null, editing = null, accessToken = null;

  async function hashPass(text) {
    const buf = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
    return [...new Uint8Array(buf)].map((b) => b.toString(16).padStart(2, "0")).join("");
  }
  window.hashPass = hashPass;

  const slugify = (s) => s.toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "")
    .replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)/g, "") || "item";
  const fmtPrice = (n, m) => m + String(n).replace(/\B(?=(\d{3})+(?!\d))/g, ".");
  const esc = (s) => String(s ?? "").replace(/[&<>"']/g, (c) =>
    ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

  function hint(msg) {
    $("#save-hint").textContent = msg;
    setTimeout(() => { if ($("#save-hint").textContent === msg) $("#save-hint").textContent = ""; }, 4000);
  }

  function fileToDataURL(file, maxSide = 1600) {
    return new Promise((resolve, reject) => {
      const img = new Image();
      img.onload = () => {
        const scale = Math.min(1, maxSide / Math.max(img.width, img.height));
        const canvas = document.createElement("canvas");
        canvas.width = Math.round(img.width * scale);
        canvas.height = Math.round(img.height * scale);
        canvas.getContext("2d").drawImage(img, 0, 0, canvas.width, canvas.height);
        resolve(canvas.toDataURL("image/jpeg", 0.85));
      };
      img.onerror = reject;
      img.src = URL.createObjectURL(file);
    });
  }

  /* ---------- Login ---------- */
  async function tryLogin(email, pass) {
    if (SUPA) {
      if (!email) throw new Error("Escribe tu email");
      let res, data;
      try {
        res = await fetch(cfg.SUPABASE_URL + "/auth/v1/token?grant_type=password", {
          method: "POST",
          headers: { apikey: cfg.SUPABASE_ANON_KEY, "Content-Type": "application/json" },
          body: JSON.stringify({ email: email.trim(), password: pass }),
        });
        data = await res.json();
      } catch (_) {
        throw new Error("No se pudo conectar con el servidor. Revisa tu conexión.");
      }
      if (!data.access_token) throw new Error(data.error_description || data.msg || "Email o contraseña incorrectos");
      accessToken = data.access_token;
    } else {
      const stored = localStorage.getItem("mi-admin-hash") || DEFAULT_PASS_HASH;
      if ((await hashPass(pass)) !== stored) throw new Error("Contraseña incorrecta");
    }
    sessionStorage.setItem(SESSION_KEY, "1");
  }

  $("#login-form").addEventListener("submit", async (e) => {
    e.preventDefault();
    $("#login-error").textContent = "";
    try {
      await tryLogin($("#login-email").value, $("#login-pass").value);
      await start();
    } catch (err) { $("#login-error").textContent = err.message; }
  });

  $("#btn-logout").addEventListener("click", () => {
    sessionStorage.removeItem(SESSION_KEY);
    location.reload();
  });

  /* ---------- Cambiar contraseña ---------- */
  $("#btn-password").addEventListener("click", async () => {
    const nueva = prompt("Nueva contraseña (mínimo 6 caracteres):");
    if (nueva === null) return;
    if (nueva.length < 6) { hint("❌ Mínimo 6 caracteres."); return; }
    if (prompt("Repite la nueva contraseña:") !== nueva) { hint("❌ No coinciden."); return; }
    try {
      if (SUPA && accessToken) {
        const res = await fetch(cfg.SUPABASE_URL + "/auth/v1/user", {
          method: "PUT",
          headers: { apikey: cfg.SUPABASE_ANON_KEY, Authorization: "Bearer " + accessToken, "Content-Type": "application/json" },
          body: JSON.stringify({ password: nueva }),
        });
        if (!res.ok) throw new Error("Supabase rechazó el cambio");
        hint("✅ Contraseña actualizada.");
      } else {
        localStorage.setItem("mi-admin-hash", await hashPass(nueva));
        hint("✅ Contraseña actualizada en este navegador.");
      }
    } catch (e) { hint("❌ No se pudo cambiar: " + e.message); }
  });

  /* ---------- Carga / guardado ---------- */
  async function loadMenu() {
    const draft = localStorage.getItem(DRAFT_KEY);
    if (draft) {
      try { const d = JSON.parse(draft); if (d?.secciones?.length) return d; } catch (_) {}
    }
    if (SUPA) {
      try {
        const res = await fetch(cfg.SUPABASE_URL + "/rest/v1/rpc/get_menu", {
          method: "POST",
          headers: {
            apikey: cfg.SUPABASE_ANON_KEY,
            Authorization: "Bearer " + (accessToken || cfg.SUPABASE_ANON_KEY),
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ p_slug: cfg.RESTAURANT_SLUG }),
        });
        const data = await res.json();
        if (data?.secciones?.length) return data;
      } catch (_) { /* cae al JSON estático */ }
    }
    return (await fetch("../cliente/menu.json", { cache: "no-store" })).json();
  }

  async function saveMenu() {
    localStorage.setItem(DRAFT_KEY, JSON.stringify(menu));
    if (SUPA && accessToken) {
      const res = await fetch(cfg.SUPABASE_URL + "/rest/v1/menus", {
        method: "POST",
        headers: { apikey: cfg.SUPABASE_ANON_KEY, Authorization: "Bearer " + accessToken, "Content-Type": "application/json", Prefer: "resolution=merge-duplicates" },
        body: JSON.stringify({ slug: cfg.RESTAURANT_SLUG, data: menu }),
      });
      if (!res.ok) throw new Error("Error guardando en Supabase");
      hint("✅ Guardado en Supabase — los clientes ya ven los cambios.");
    } else {
      hint("✅ Borrador guardado. Descarga menu.json y súbelo al hosting para publicar.");
    }
  }
  $("#btn-save").addEventListener("click", () => saveMenu().catch((e) => hint("❌ " + e.message)));

  $("#btn-export").addEventListener("click", () => {
    const blob = new Blob([JSON.stringify(menu, null, 2)], { type: "application/json" });
    const a = document.createElement("a");
    a.href = URL.createObjectURL(blob); a.download = "menu.json"; a.click();
  });
  $("#btn-import").addEventListener("click", () => $("#import-input").click());
  $("#import-input").addEventListener("change", async (e) => {
    const file = e.target.files[0];
    if (!file) return;
    menu = JSON.parse(await file.text());
    render();
    hint("JSON importado. Revisa y pulsa Guardar.");
  });

  /* ---------- Render del editor ---------- */
  function render() {
    if (menu.restaurante?.nombre) {
      $("#topbar-logo").innerHTML = esc(menu.restaurante.nombre) + " <span>admin</span>";
      $("#login-logo").textContent = menu.restaurante.nombre;
    }
    const editor = $("#editor");
    editor.innerHTML = "";
    const moneda = menu.restaurante.moneda || "₡";
    menu.secciones.sort((a, b) => a.orden - b.orden);

    menu.secciones.forEach((sec, si) => {
      const box = document.createElement("section");
      box.className = "sec";
      const head = document.createElement("div");
      head.className = "sec__head";
      head.innerHTML =
        '<input class="sec__name" value="' + esc(sec.nombre) + '">' +
        '<div class="sec__btns">' +
        '<button class="btn" data-act="up" title="Subir">↑</button>' +
        '<button class="btn" data-act="down" title="Bajar">↓</button>' +
        '<button class="btn" data-act="add">+ Plato</button>' +
        '<button class="btn btn--danger" data-act="del">Eliminar</button></div>';
      head.querySelector(".sec__name").addEventListener("change", (e) => { sec.nombre = e.target.value; });
      head.querySelector('[data-act="up"]').addEventListener("click", () => moveSection(si, -1));
      head.querySelector('[data-act="down"]').addEventListener("click", () => moveSection(si, 1));
      head.querySelector('[data-act="add"]').addEventListener("click", () => addProduct(sec));
      head.querySelector('[data-act="del"]').addEventListener("click", () => {
        if (confirm('¿Eliminar la sección "' + sec.nombre + '" y todos sus platos?')) {
          menu.secciones.splice(si, 1); render();
        }
      });

      const list = document.createElement("div");
      list.className = "sec__list";
      sec.productos.forEach((p) => {
        const row = document.createElement("button");
        row.type = "button"; row.className = "row";
        const price = p.variantes?.length
          ? "desde " + fmtPrice(Math.min(...p.variantes.map((v) => v.precio)), moneda)
          : p.precio != null ? fmtPrice(p.precio, moneda) : "—";
        row.innerHTML =
          '<img class="row__thumb" src="' + (p.imagen || "../cliente/img/placeholder.svg") + '" alt="">' +
          '<span class="row__name">' + (p.destacado ? "★ " : "") + esc(p.nombre) +
          (p.disponible === false ? ' <span class="off">NO DISPONIBLE</span>' : "") + "</span>" +
          '<span class="row__price">' + price + "</span>";
        row.addEventListener("click", () => openEdit(sec, p));
        list.appendChild(row);
      });
      box.appendChild(head); box.appendChild(list); editor.appendChild(box);
    });
  }

  function moveSection(i, dir) {
    const j = i + dir;
    if (j < 0 || j >= menu.secciones.length) return;
    [menu.secciones[i], menu.secciones[j]] = [menu.secciones[j], menu.secciones[i]];
    menu.secciones.forEach((s, k) => (s.orden = k + 1));
    render();
  }

  $("#btn-add-section").addEventListener("click", () => {
    const nombre = prompt("Nombre de la nueva sección:");
    if (!nombre) return;
    menu.secciones.push({ id: slugify(nombre), nombre, orden: menu.secciones.length + 1, nota: "", productos: [] });
    render();
  });

  function addProduct(sec) {
    const p = { id: "nuevo-" + Date.now(), nombre: "Nuevo plato", descripcion: { es: "", en: "" }, precio: 0, imagen: "", alergenos: [], destacado: false, disponible: true };
    sec.productos.push(p);
    openEdit(sec, p);
  }

  /* ---------- Modal de edición ---------- */
  const modal = $("#edit-modal");
  function openEdit(sec, p) {
    editing = { sec, prod: p };
    $("#edit-title").textContent = p.nombre || "Editar plato";
    $("#f-nombre").value = p.nombre || "";
    $("#f-desc-es").value = p.descripcion?.es || "";
    $("#f-desc-en").value = p.descripcion?.en || "";
    $("#f-precio").value = p.precio ?? "";
    $("#f-variantes").value = (p.variantes || []).map((v) => v.nombre + " = " + v.precio).join("\n");
    $("#f-alergenos").value = (p.alergenos || []).join(", ");
    $("#f-destacado").checked = Boolean(p.destacado);
    $("#f-disponible").checked = p.disponible !== false;
    $("#f-imagen").value = "";
    const prev = $("#f-imagen-preview");
    prev.src = p.imagen || ""; prev.hidden = !p.imagen;
    modal.hidden = false;
  }

  $("#f-imagen").addEventListener("change", async (e) => {
    const file = e.target.files[0];
    if (!file || !editing) return;
    let url;
    if (SUPA && accessToken) {
      const path = cfg.RESTAURANT_SLUG + "/" + editing.prod.id + "-" + Date.now() + ".jpg";
      const res = await fetch(cfg.SUPABASE_URL + "/storage/v1/object/platos/" + path, {
        method: "POST",
        headers: { apikey: cfg.SUPABASE_ANON_KEY, Authorization: "Bearer " + accessToken },
        body: file,
      });
      if (!res.ok) { hint("❌ Error subiendo la imagen"); return; }
      url = cfg.SUPABASE_URL + "/storage/v1/object/public/platos/" + path;
    } else {
      url = await fileToDataURL(file);
    }
    editing.prod.imagen = url;
    $("#f-imagen-preview").src = url;
    $("#f-imagen-preview").hidden = false;
  });

  $("#edit-form").addEventListener("submit", (e) => {
    e.preventDefault();
    const p = editing.prod;
    p.nombre = $("#f-nombre").value.trim();
    p.descripcion = { es: $("#f-desc-es").value.trim(), en: $("#f-desc-en").value.trim() };
    p.precio = $("#f-precio").value === "" ? null : Number($("#f-precio").value);
    p.variantes = $("#f-variantes").value.split("\n").map((l) => {
      const i = l.lastIndexOf("=");
      return i > 0 ? { nombre: l.slice(0, i).trim(), precio: Number(l.slice(i + 1).trim()) } : null;
    }).filter((v) => v && v.nombre && !isNaN(v.precio));
    if (!p.variantes.length) delete p.variantes;
    p.alergenos = $("#f-alergenos").value.split(",").map((s) => s.trim()).filter(Boolean);
    p.destacado = $("#f-destacado").checked;
    p.disponible = $("#f-disponible").checked;
    modal.hidden = true;
    render();
    hint("Cambios aplicados. Pulsa Guardar para publicar.");
  });

  $("#btn-delete-product").addEventListener("click", () => {
    if (!editing) return;
    if (confirm('¿Eliminar "' + editing.prod.nombre + '"?')) {
      const i = editing.sec.productos.indexOf(editing.prod);
      if (i >= 0) editing.sec.productos.splice(i, 1);
      modal.hidden = true; render();
    }
  });
  modal.addEventListener("click", (e) => { if (e.target.closest("[data-close]")) modal.hidden = true; });

  /* ---------- Arranque ---------- */
  async function start() {
    menu = await loadMenu();
    $("#login-screen").style.display = "none";
    $("#panel").hidden = false;
    render();
  }
  if (sessionStorage.getItem(SESSION_KEY) && !SUPA) start();
})();
