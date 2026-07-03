// Minimal client-side filter with result count + URL persistence.
// - "/" focuses the search input (mirrors nvim's own /)
// - Esc clears and unfocuses
// - Filter query synced to URL ?q= so links are shareable
// - Search matches key text, description, and each row/group's data-tags
(function () {
  "use strict";

  var q = document.getElementById("q");
  var countEl = document.getElementById("count");
  var emptyEl = document.getElementById("empty");
  var items = document.querySelectorAll(".km");
  var groups = document.querySelectorAll(".group");
  if (!q || !items.length) return;

  var TOTAL = items.length;

  // Pre-index each row to avoid re-reading textContent on every keystroke.
  var index = new Array(TOTAL);
  for (var i = 0; i < TOTAL; i++) {
    var it = items[i];
    var hay = it.textContent + " " + (it.dataset.tags || "");
    var g = it.closest(".group");
    if (g && g.dataset.tags) hay += " " + g.dataset.tags;
    index[i] = hay.toLowerCase();
  }

  function updateCount(visible) {
    if (!countEl) return;
    countEl.textContent = (!q.value || visible === TOTAL)
      ? TOTAL + " keymaps"
      : visible + " of " + TOTAL;
  }

  function updateURL() {
    if (!history.replaceState) return;
    var url = new URL(location.href);
    if (q.value) url.searchParams.set("q", q.value);
    else url.searchParams.delete("q");
    // Preserve hash so #anchor navigation still works
    history.replaceState(null, "", url.pathname + url.search + url.hash);
  }

  function apply(pushURL) {
    var term = q.value.trim().toLowerCase();
    var visible = 0;
    for (var i = 0; i < TOTAL; i++) {
      var match = !term || index[i].indexOf(term) !== -1;
      items[i].classList.toggle("hidden", !match);
      if (match) visible++;
    }
    for (var j = 0; j < groups.length; j++) {
      var any = groups[j].querySelector(".km:not(.hidden)");
      groups[j].classList.toggle("empty", !any);
    }
    if (emptyEl) emptyEl.hidden = visible !== 0;
    updateCount(visible);
    if (pushURL) updateURL();
  }

  q.addEventListener("input", function () { apply(true); });

  q.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      if (q.value) { q.value = ""; apply(true); }
      q.blur();
    }
  });

  // Global "/" hotkey — focus search unless the user is already typing somewhere.
  document.addEventListener("keydown", function (e) {
    if (e.target === q) return;
    var t = e.target;
    if (t && (t.tagName === "INPUT" || t.tagName === "TEXTAREA" || t.isContentEditable)) return;
    if (e.key !== "/") return;
    if (e.metaKey || e.ctrlKey || e.altKey) return;
    e.preventDefault();
    q.focus();
    q.select();
  });

  // Initial load: hydrate query from URL if present.
  var initial = new URLSearchParams(location.search).get("q");
  if (initial) {
    q.value = initial;
    apply(false);
  } else {
    updateCount(TOTAL);
  }
})();
