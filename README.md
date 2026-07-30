# nvim

Personal Neovim config. Lua, [lazy.nvim](https://github.com/folke/lazy.nvim), Neovim 0.11+ native LSP. Runs happily on [Omarchy](https://omarchy.org/) (Arch + Hyprland + Wayland).

**All keymaps live at [yashksaini-coder.github.io/nvim](https://yashksaini-coder.github.io/nvim/)** — searchable, up to date, organized by prefix. Reach it from inside nvim with `<leader>kk`.

---

## What's inside

**Editing** — `nvim-cmp` + `LuaSnip` completion, `autopairs`, `autotag` for JSX/HTML, `Comment.nvim`.

**UI** — `bufferline` (buffers), `lualine` (statusline), `which-key` (popup), `noice` + `nvim-notify` (cmdline & notifications), `snacks.nvim` (image viewer + indent guides + file explorer), `lspkind` (completion icons), `mini.icons` (icon set).

**Files & search** — `telescope.nvim` with `fzf-native`. File explorer is `snacks.explorer` — bound to `<leader>e`.

**LSP / diagnostics** — `mason` + `mason-tool-installer` for installing language servers and tools, `nvim-lspconfig`, `conform.nvim` for formatting, `trouble.nvim` for the diagnostic panel.

**Git** — `gitsigns.nvim` for hunks and blame, `lazygit` opened in a floating `toggleterm` via `<leader>gg`.

**Terminal** — `toggleterm.nvim` — floats, splits, REPLs, system monitor.

**Rust** — `crates.nvim` (Cargo.toml UI), `ferris.nvim` (rust-analyzer extras: `expandMacro`, `viewHIR`, etc.).

**Languages** — `nvim-treesitter` on the `master` branch (legacy API — v1.0/main removed the configs module we rely on), `render-markdown.nvim`.

**Utilities** — `compiler.nvim` (`:make` for C/C++), `lua/utils/` boilerplates + snippets, [`cord.nvim`](https://github.com/vyfor/cord.nvim) (Discord Rich Presence — needs a native Discord client running for the IPC socket at `/run/user/$UID/discord-ipc-0`), [`vim-wakatime`](https://wakatime.com/vim).

**Themes** — Catppuccin, Kanagawa, Gruvbox, Rose Pine, Chai, Osmium — switch with `<leader>tH` (Themery).

---

## Getting started

```bash
git clone https://github.com/yashksaini-coder/nvim ~/.config/nvim
nvim               # lazy.nvim bootstraps and installs everything
:Mason             # optional — install more LSPs / tools
```

Neovim 0.11+ required. A Nerd Font is recommended for icons. For WakaTime, `wakatime-cli` reads `~/.wakatime.cfg` — set your API key there.

---

## Structure

```
init.lua
lazy-lock.json
lua/
  config/           options, lazy bootstrap, diagnostics, keymap requires
  plugins/          one file per plugin (mini/ and themes/ grouped)
  lsps/             per-server LSP settings (lua_ls, ts_ls)
  utils/            boilerplates & snippets
site/               source for the keymap reference site
.github/
  workflows/
    update-plugins.yml    daily `Lazy sync` + lockfile commit
    pages.yml             deploys site/ to GitHub Pages
```

---

## CI

- **`update-plugins.yml`** — runs daily at 00:00 UTC. `Lazy sync` + `Lazy update` + `Lazy restore`, commits any `lazy-lock.json` drift as `ci: update all plugins to latest [skip ci]`. This is why `git pull` sometimes conflicts on `lazy-lock.json` — take the newer hash, it's monotonic.
- **`pages.yml`** — triggers on any change under `site/**`; builds nothing (vanilla HTML/CSS/JS) and deploys via `actions/deploy-pages`.

---

## Notes

- **File tree** — `snacks.explorer` (picker-based, not a persistent side panel). If you want a persistent tree instead, `nvim-neo-tree/neo-tree.nvim` is the closest drop-in replacement.
- **Cord (Discord RP)** — needs the *native* Discord app (or Vesktop). Doesn't work with the browser/PWA Discord that Omarchy installs by default.
- **Treesitter** — pinned to `master` (legacy API); the `main` branch is the v1.0+ rewrite with a different config surface.
