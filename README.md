# nvim

Personal Neovim config. Lua, [lazy.nvim](https://github.com/folke/lazy.nvim), Neovim 0.11+ native LSP. Runs happily on [Omarchy](https://omarchy.org/) (Arch + Hyprland + Wayland).

**All keymaps live at [yashksaini-coder.github.io/nvim](https://yashksaini-coder.github.io/nvim/)** — searchable, up to date, organized by prefix. Reach it from inside nvim with `<leader>kk`.

---

## What's inside

**Editing** — `nvim-cmp` completion (`LuaSnip` is the expander for LSP snippets, not a snippet library), `autopairs`, `autotag` for JSX/HTML, `mini.surround` on `gs`, `mini.ai` text objects (`af`/`if`, `ac`/`ic`), `flash.nvim` for `s`-jumps. Commenting is Neovim's built-in `gc` — it reads `commentstring` from treesitter metadata, so JSX comments come out right without a plugin.

**UI** — `barbar` (buffer tabs), `lualine` (statusline + winbar), `which-key` (popup), `noice` + `nvim-notify` (cmdline & notifications), `snacks.nvim` (indent guides, dashboard, bigfile/quickfile — image rendering is explicitly off), `lspkind` (completion icons), `mini.icons` (icon set).

**Files & search** — `telescope.nvim` with `fzf-native`. File explorer is `snacks.explorer` — bound to `<leader>e`. `todo-comments` for TODO/FIXME, `grug-far` for project-wide find-and-replace on `<leader>fS`.

**LSP / diagnostics** — `mason` + `mason-tool-installer`, `nvim-lspconfig`, `conform.nvim` for formatting, `trouble.nvim` for the diagnostic panel, `lazydev.nvim` so `lua_ls` understands this config. Servers are only enabled when their binary is actually on `$PATH` (see `lua/plugins/lsp.lua`); per-server settings live in `lua/lsps/`.

**Git** — `gitsigns.nvim` for hunks and blame, `lazygit` in a floating window via `<leader>gg` (snacks), `diffview.nvim` for a changed-files panel with per-file line counts (`<leader>gv`), `octo.nvim` for GitHub issues and PR review without leaving the editor (`<leader>go` — needs the `gh` CLI, authenticated).

**Rust** — `rustaceanvim` drives rust-analyzer (clippy on save, `allFeatures`, inlay hints, `<leader>rr` runnables), `crates.nvim` for the `Cargo.toml` UI, and a two-key `ferris.nvim` for the memory-layout and item-tree views rustaceanvim does not implement.

**Languages** — `nvim-treesitter` on the `main` branch (the v1.0 rewrite — highlighting, indent and selection are Neovim's own features now; see the header comment in `lua/plugins/treesitter.lua`), `render-markdown.nvim`.

**Utilities** — `compile-mode.nvim` for build & run (`<leader>mm`; runs on a pty, so `scanf`/`cin` actually block for input), [`cord.nvim`](https://github.com/vyfor/cord.nvim) (Discord Rich Presence — needs a native Discord client running for the IPC socket at `/run/user/$UID/discord-ipc-0`).

**Themes** — Catppuccin, Kanagawa, Gruvbox, Rose Pine, Chai, Osmium — switch with `<leader>tH` (Themery).

---

## Getting started

```bash
git clone https://github.com/yashksaini-coder/nvim ~/.config/nvim
nvim               # lazy.nvim bootstraps and installs everything
:Mason             # optional — install more LSPs / tools
```

Neovim 0.11+ required. A Nerd Font is recommended for icons.

---

## Structure

```
init.lua
lazy-lock.json
lua/
  config/           options, lazy bootstrap, diagnostics, keymap requires
    keymap-export.lua  builds the site's keymap rows from the live keymaps
  plugins/          one file per plugin (mini/ and themes/ grouped)
  lsps/             per-server LSP settings (clangd, gopls, pyright, tailwindcss, ts_ls)
site/               keymap reference site (index.html rows are GENERATED)
.github/
  workflows/
    update-plugins.yml    daily `Lazy sync` + lockfile commit
    pages.yml             deploys site/ to GitHub Pages
```

---

## Checks

`make` runs both gates: `stylua` (format — auto-fixes in place) and `luacheck` (lint — expect 0 warnings across 63 files). `make fmt` and `make lint` run them separately. `make site` regenerates the keymap site (below).

`stylua` comes from Mason. `luacheck` deliberately does not — Mason builds it against whatever Lua is current, and the 5.5 build dies on its own source with `attempt to assign to const variable 'field_name'`, so it is not in `ensure_installed`. Install a working one instead:

```bash
luarocks --local --lua-version=5.4 install luacheck   # no sudo
sudo pacman -S luacheck                               # or Arch's 1.2.0, built against lua54
```

The Makefile puts `~/.luarocks/bin` ahead of Mason's on `PATH`, so either choice wins over the broken one.

---

## Keymap site

`site/index.html` is not hand-written. Everything between `<!-- BEGIN GENERATED -->` and `<!-- END GENERATED -->` comes from `:KeymapExport` (or `make site`), which reads the live keymap table after force-loading every plugin. The shell around it — hero, search, empty state, footer — is hand-owned and never touched.

Three tables in `lua/config/keymap-export.lua` are maintained by hand because nothing can derive them:

- **`GROUPS`** — group titles, hints and search tags.
- **`ROUTE`** — which group a key belongs to; first match wins, fallthrough is `misc`.
- **`BUFLOCAL`** — buffer-local maps. `nvim_get_keymap` cannot see rustaceanvim's `<leader>r*`, gitsigns' `<leader>h*` or the LSP maps, because they do not exist until the right buffer is open. They are listed explicitly and tagged on the page with the plugin that owns them.

There is also a **`DENY`** list. A raw dump is mostly noise — Neovim's own bracket maps (`[A` → `:rewind`), its built-in LSP defaults (`gra`), and mini.surround's full l/n variant matrix would bury the keys you actually look up.

Run `make site` after adding or removing a keymap; the output is deterministic, so a no-op change produces an empty diff.

---

## CI

- **`update-plugins.yml`** — runs daily at 00:00 UTC. `Lazy sync` + `Lazy update` + `Lazy restore`, commits any `lazy-lock.json` drift as `ci: update all plugins to latest [skip ci]`. This is why `git pull` sometimes conflicts on `lazy-lock.json` — take the newer hash, it's monotonic.
- **`pages.yml`** — triggers on any change under `site/**`; builds nothing (vanilla HTML/CSS/JS) and deploys via `actions/deploy-pages`.

---

## Notes

- **File tree** — `snacks.explorer` on `<leader>e`, a persistent side panel. Calling it while open closes it, so the one mapping is a toggle. It is a picker underneath: a real split (`snacks_layout_box`) hosting the list and filter input as floats — which is why lualine hides all three filetypes and barbar offsets against the box, not the list. `replace_netrw` stays off on purpose so `nvim .` lands on `snacks.dashboard`; `lua/config/autocmds.lua` then opens the side panel on `UIEnter`.
- **Cord (Discord RP)** — needs the *native* Discord app (or Vesktop). Doesn't work with the browser/PWA Discord that Omarchy installs by default.
- **Treesitter** — on `main` (the v1.0 rewrite; `master` is archived). Parsers *and* queries install together under `~/.local/share/nvim/site/`, which is what stops them drifting apart — a stale parser paired with newer queries dies with `Invalid node type "..."` on every file open. Feature modules are gone: highlight, indent and selection are Neovim's own, wired up in `lua/plugins/treesitter.lua`.
- **Diffview vs Octo** — both draw a "changed files" panel with line counts, and neither substitutes for the other. `diffview` reads the local working tree, index, or any git rev, and needs no network; `octo` reads a GitHub PR over the `gh` CLI. Octo renders the diffstat as a *bar*, diffview as numeric `+N, -M`. Inside a diffview panel, `i` toggles list/tree and `<tab>`/`<s-tab>` cycle files.
