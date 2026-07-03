// Minimal client-side filter. Zero deps. ~1KB.
// - "/" focuses the search input (thematic — same as :h /)
// - Esc clears and unfocuses
// - Filter matches across key, description, and each section's data-tags
(function () {
  "use strict";

  var q = document.getElementById("q");
  var items = document.querySelectorAll(".km");
  var groups = document.querySelectorAll(".group");
  if (!q || !items.length) return;

  // pre-index rows to avoid re-reading textContent on every keystroke
  var index = new Array(items.length);
  for (var i = 0; i < items.length; i++) {
    var it = items[i];
    var haystack = (it.textContent + " " + (it.dataset.tags || ""));
    // include the enclosing group's tags so "buffer" matches everything in #buffer
    var g = it.closest(".group");
    if (g && g.dataset.tags) haystack += " " + g.dataset.tags;
    index[i] = haystack.toLowerCase();
  }

  function apply() {
    var term = q.value.trim().toLowerCase();
    var visible = 0;
    for (var i = 0; i < items.length; i++) {
      var match = !term || index[i].indexOf(term) !== -1;
      items[i].classList.toggle("hidden", !match);
      if (match) visible++;
    }
    // hide sections that ended up empty
    for (var j = 0; j < groups.length; j++) {
      var any = groups[j].querySelector(".km:not(.hidden)");
      groups[j].classList.toggle("empty", !any);
    }
  }

  q.addEventListener("input", apply);
  q.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      q.value = "";
      apply();
      q.blur();
    }
  });

  document.addEventListener("keydown", function (e) {
    // "/" focuses filter unless user is already typing somewhere
    if (e.target === q) return;
    var t = e.target;
    if (t && (t.tagName === "INPUT" || t.tagName === "TEXTAREA" || t.isContentEditable)) return;
    if (e.key !== "/") return;
    if (e.metaKey || e.ctrlKey || e.altKey) return;
    e.preventDefault();
    q.focus();
    q.select();
  });
})();
