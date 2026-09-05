// Filter + rail for the keymap reference.
//
// Rows show only the tail of a key sequence ("A" under <leader>c), so the full
// sequence lives in data-key and MUST be part of the search text — otherwise
// typing "leader" or "<leader>cA" would match nothing.
(function () {
  "use strict";

  var q = document.getElementById("q");
  var countEl = document.getElementById("count");
  var emptyEl = document.getElementById("empty");
  var rows = [].slice.call(document.querySelectorAll(".km"));
  var groups = [].slice.call(document.querySelectorAll(".grp"));
  var links = [].slice.call(document.querySelectorAll(".rail a"));
  if (!q || !rows.length) return;

  var TOTAL = rows.length;
  var linkFor = {};
  links.forEach(function (a) { linkFor[a.getAttribute("href").slice(1)] = a; });

  // Pre-index once: row text + full key + the group's tags.
  var hay = rows.map(function (r) {
    var g = r.closest(".grp");
    return (
      r.textContent + " " + (r.dataset.key || "") + " " + ((g && g.dataset.tags) || "")
    ).toLowerCase();
  });

  function apply(push) {
    var term = q.value.trim().toLowerCase();
    var shown = 0;

    for (var i = 0; i < TOTAL; i++) {
      var hit = !term || hay[i].indexOf(term) !== -1;
      rows[i].classList.toggle("hide", !hit);
      if (hit) shown++;
    }

    groups.forEach(function (g) {
      var any = !!g.querySelector(".km:not(.hide)");
      g.classList.toggle("hide", !any);
      var a = linkFor[g.id];
      if (a) a.classList.toggle("dim", !any);
    });

    if (emptyEl) emptyEl.hidden = shown !== 0;
    if (countEl) countEl.textContent = term ? shown + "/" + TOTAL : TOTAL + " keymaps";
    if (push) sync();
  }

  function sync() {
    if (!history.replaceState) return;
    var url = new URL(location.href);
    if (q.value) url.searchParams.set("q", q.value);
    else url.searchParams.delete("q");
    history.replaceState(null, "", url.pathname + url.search + url.hash);
  }

  q.addEventListener("input", function () { apply(true); });

  q.addEventListener("keydown", function (e) {
    if (e.key !== "Escape") return;
    if (q.value) { q.value = ""; apply(true); }
    else q.blur();
  });

  // "/" focuses the filter, the way it would in the editor this documents.
  document.addEventListener("keydown", function (e) {
    if (e.key !== "/" || e.metaKey || e.ctrlKey || e.altKey) return;
    var t = e.target;
    if (t === q || (t && (t.tagName === "INPUT" || t.tagName === "TEXTAREA" || t.isContentEditable))) return;
    e.preventDefault();
    q.focus();
    q.select();
  });

  if (emptyEl) {
    emptyEl.addEventListener("click", function (e) {
      var b = e.target.closest("button[data-q]");
      if (!b) return;
      q.value = b.dataset.q;
      apply(true);
      q.focus();
    });
  }

  // Mark the group you are currently reading. rootMargin pins the trigger just
  // under the sticky command line rather than at the viewport edge.
  if ("IntersectionObserver" in window && links.length) {
    var seen = new Set();
    var io = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (en) {
          if (en.isIntersecting) seen.add(en.target.id);
          else seen.delete(en.target.id);
        });
        var first = groups.filter(function (g) { return seen.has(g.id); })[0];
        links.forEach(function (a) {
          a.classList.toggle("on", !!first && a.getAttribute("href") === "#" + first.id);
        });
      },
      { rootMargin: "-4.5rem 0px -70% 0px" }
    );
    groups.forEach(function (g) { io.observe(g); });
  }

  var initial = new URLSearchParams(location.search).get("q");
  if (initial) q.value = initial;
  apply(false);
})();
