# Keymaps

Leader is `<Space>`. Local leader is `\\`.

## Global

| Keys | Action |
|---|---|
| `<leader>?` | Show buffer keymaps (which-key) |
| `<leader>q` | Quit all |
| `<leader>D` | Open online docs (this site) |

## LSP

| Keys | Action |
|---|---|
| `K` | Hover |
| `<leader>gd` / `<leader>gD` | Definition / Declaration |
| `<leader>gi` / `<leader>gt` | Implementation / Type definition |
| `<leader>gr` | References |
| `<leader>gci` / `<leader>gco` | Incoming / Outgoing calls |
| `<leader>fS` / `<leader>fW` | Document / Workspace symbols |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>uh` | Toggle inlay hints |
| `<C-k>` | Signature help |

## DAP

| Keys | Action |
|---|---|
| `<leader>db` / `<leader>dB` | Toggle / conditional breakpoint |
| `<leader>dc` | Continue / start |
| `<leader>di` / `<leader>do` / `<leader>dO` | Step into / over / out |
| `<leader>dr` | Toggle REPL |
| `<leader>du` | Toggle DAP UI |
| `<leader>dh` | Hover variable |
| `<leader>dS` / `<leader>df` | Scopes / frames float |
| `<leader>de` | Evaluate expression |

## AI

| Keys | Action |
|---|---|
| `<leader>ic` | Claude Code toggle |
| `<leader>iC` | Claude continue |
| `<leader>iX` | Copilot Chat |
| `<leader>io` | OpenCode toggle |
| `<leader>ia` | OpenCode ask buffer |

## Productivity

| Keys | Action |
|---|---|
| `s` / `S` | Flash jump / treesitter jump |
| `<leader>j1`–`<leader>j5` | Harpoon to mark 1–5 |
| `<leader>jj` / `<leader>ja` | Harpoon menu / add |
| `-` | Open parent dir (oil.nvim) |
| `<leader>uu` | Toggle undotree |
| `<leader>uz` / `<leader>uT` | Zen / Twilight |
| `<leader>pp` | Pomo timer prompt |
| `<leader>pP` | Pomodoro 25m repeat |

For the full list, run `<leader>?` inside Neovim.
