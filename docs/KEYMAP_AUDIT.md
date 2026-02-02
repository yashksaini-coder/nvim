# Keymap Audit

Single source of truth for all keymaps. Generated from `lua/plugins/` and `lua/config/keymaps/`.

## Conflicts Resolved (see git history)

| Key | Was (conflict) | Now |
|-----|----------------|-----|
| `<leader>th` | Themery vs Terminal horizontal | `th` = Terminal horizontal, `tH` = Themery |
| `<leader>tn` | Node REPL vs New tab | `tn` = New tab, `tN` = Node REPL |
| `<leader>t1`–`t4` | Terminal 1–4 vs Go to tab 1–4 | `t1`–`t4` = Terminal, `T1`–`T9` = Go to tab |
| `<leader>cR` | Compiler redo vs Crates repo vs LeetCode reset | `cR` = Crates repo, `cy` = Compiler redo, `LR` = LeetCode reset |
| `<leader>cr` | Compiler run vs Crates reload vs LeetCode run | `cr` = Crates reload, `mr` = Compiler run, `Lr` = LeetCode run |
| `<leader>ct` | Compiler toggle vs Crates toggle | `ct` = Crates toggle, `mT` = Compiler toggle |
| `<leader>ca` | LSP code action vs Crates update all | `ca` = Code action, `cpa` = Crates update all |
| `<leader>cd` | LeetCode daily vs Crates dependencies | `cd` = Crates dependencies, `Ld` = LeetCode daily |
| `<leader>cs` | Trouble symbols vs LeetCode submit | `cs` = Trouble symbols, `Ls` = LeetCode submit |
| `<leader>cl` | Trouble LSP vs LeetCode list | `cl` = Trouble LSP, `Ll` = LeetCode list |
| `<leader>cx` | Compiler run vs Crates expand | `cx` = Crates expand, `mx` = Compiler run |
| `<leader>mt` | Make toggle vs Mini Map toggle | `mt` = Mini Map toggle, `mT` = Make toggle (F7) |
| `<S-l>` | LSP hover vs Buffer next | `<S-l>` = Buffer next, `K` = LSP hover |

## Normal mode (no leader)

| Key | Source | Action |
|-----|--------|--------|
| `<Esc>` | general | Clear search highlights |
| `<C-h/j/k/l>` | general | Window navigation |
| `<C-s>` | general | Save |
| `<C-\>` | terminal | Toggle terminal |
| `<C-p>` | telescope | Find files |
| `K` | lsp | LSP hover |
| `<C-i>` | lsp | Goto definition |
| `<S-h>` | bufferline | Prev buffer |
| `<S-l>` | bufferline | Next buffer |
| `[b` `]b` | bufferline | Prev/next buffer |
| `gt` `gT` | mini-tabline | Next/prev tab |
| `F5`–`F8` | compiler | Build, Build&Run, Toggle results, Run |
| `<leader>?` | which-key | Buffer keymaps |
| `<C-w><space>` | which-key | Window hydra |

## Leader groups

- `a` animations | `b` buffer | `c` code/crates/compiler | `e` explorer | `f` find | `g` git/goto | `h` hunks | `l` lazy | `L` LeetCode | `m` markdown/make | `M` Mason | `n` noice | `r` rust (ferris) | `t` terminal/tabs | `T` go to tab | `x` trouble | `i` image

## Full leader key list (after resolution)

See README.md "Keymap Quick Reference" and per-plugin sections.
