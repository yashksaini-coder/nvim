# Getting Started

## Requirements

- Neovim **0.11+** (uses `vim.lsp.config()` API)
- Git, make, a C compiler (`gcc`/`clang`), Node 20+ for AI plugins
- Optional: Go, Rust, Python toolchains for those languages

## Install

```bash
git clone https://github.com/yashksaini-coder/nvim ~/.config/nvim
nvim --headless "+Lazy! sync" "+MasonToolsInstall" "+qall"
```

## First boot

- The dashboard appears (NEOVIM banner)
- Use `<leader>?` to discover keymaps via which-key
- `:checkhealth` to confirm runtimes resolve
