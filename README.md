### ✨ yashksaini-coder's Neovim Config (init.lua)

A simple yet minimal **Lua-based Neovim configuration**.  
Built while learning Neovim on **Windows 11 terminal**, using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

> [!Note]
> This is a beginner-friendly config. Since I’m experimenting and learning, some parts may not be perfect.  
> Use at your own choice 🚀

---

## ⌨️ Key Mappings

Leader key: **`<Space>`**

### Custom

| Key / CMD     | Category | Description                           |
| ----------- | ---- | ------------------------------------- |
| `<leader>` | Utility | Press Space to open all commands options using which-key |
| `<leader>ex` | File Explorer | Open file explorer (netrw by default) |
| `<leader>ct` | Theme | Switch to **Catppuccin** theme   |
| `<leader>sk` | ShowKeys | Show key mappings   |
| `<leader><Esc>` | Normal | Clear search highlights (`:nohlsearch`) |
| `<C-c>` | Visual | Copy selected text to system clipboard (uses `wl-copy`) |
| `"+y` / `"+p` | Any | Yank/Paste to system clipboard (enabled via `unnamedplus`) |




### Lazy.nvim Shortcuts

| Key / CMD     | Command         | Description                  |
| ----------- | --------------- | ---------------------------- |
| `<leader>ll` | `:Lazy`         | Open Lazy UI                 |
| `<leader>ls` | `:Lazy sync`    | Sync (install/update/remove) |
| `<leader>lu` | `:Lazy update`  | Update all plugins           |
| `<leader>li` | `:Lazy install` | Install missing plugins      |
| `<leader>lc` | `:Lazy check`   | Check plugin health          |
| `<leader>lx` | `:Lazy clean`   | Remove unused plugins        |

### 🔭 Telescope Keymaps

#### **File Searching**
| Key / CMD     | Command                                    | Description                           |
| ----------- | ------------------------------------------ | ------------------------------------- |
| `<leader>ff` | `:Telescope find_files`                    | Find files in project                |
| `<leader>fF` | `:Telescope find_files hidden=true`        | Find all files (including hidden)    |
| `<leader>fg` | `:Telescope live_grep`                     | Live grep across project             |
| `<leader>fG` | `:Telescope live_grep_args`                | Live grep with advanced arguments    |
| `<leader>fs` | `:Telescope grep_string`                   | Grep string under cursor             |

#### **Buffer & Navigation**
| Key / CMD     | Command                           | Description                           |
| ----------- | --------------------------------- | ------------------------------------- |
| `<leader>fb` | `:Telescope buffers`              | Find and switch between buffers       |
| `<leader>fh` | `:Telescope help_tags`            | Search help documentation             |
| `<leader>fc` | `:Telescope commands`             | Find and execute commands             |
| `<leader>fk` | `:Telescope keymaps`              | Search keymaps                       |
| `<leader>ft` | `:Telescope colorscheme`          | Switch between colorschemes           |

#### **LSP Integration**
| Key / CMD     | Command                              | Description                           |
| ----------- | ------------------------------------ | ------------------------------------- |
| `<leader>fl` | `:Telescope lsp_references`          | Find LSP references                  |
| `<leader>fd` | `:Telescope lsp_definitions`         | Go to LSP definitions                |
| `<leader>fi` | `:Telescope lsp_implementations`     | Find LSP implementations             |
| `<leader>fy` | `:Telescope lsp_type_definitions`    | Find LSP type definitions            |
| `<leader>fa` | `:Telescope lsp_diagnostics`         | Show LSP diagnostics                 |

#### **Extensions & Tools**
| Key / CMD     | Command                           | Description                           |
| ----------- | --------------------------------- | ------------------------------------- |
| `<leader>fs` | `:Telescope symbols`               | Search symbols in workspace          |

> [!Note]
> **Simplified Configuration:** This telescope setup focuses on core functionality with 4 essential extensions:
> - **FZF Native** - Enhanced fuzzy finding performance
> - **UI Select** - Dropdown selection interface  
> - **Symbols** - Workspace symbol search
> - **Live Grep Args** - Advanced text search with arguments

#### **Quick Access & Utilities**
| Key / CMD     | Command                                    | Description                           |
| ----------- | ------------------------------------------ | ------------------------------------- |
| `<leader>f.` | `:Telescope find_files cwd=%:p:h`         | Find files in current directory       |
| `<leader>f/` | `:Telescope live_grep cwd=%:p:h`          | Live grep in current directory        |
| `<leader>fr` | `:Telescope resume`                        | Resume last telescope search          |

#### **Git Integration**
| Key / CMD     | Command                           | Description                           |
| ----------- | --------------------------------- | ------------------------------------- |
| `<leader>fgc` | `:Telescope git_commits`          | Browse git commit history             |
| `<leader>fgb` | `:Telescope git_bcommits`         | Browse commits for current buffer     |
| `<leader>fgr` | `:Telescope git_branches`         | Switch between git branches           |
| `<leader>fgs` | `:Telescope git_status`            | Show git status and changes           |

## 🛠️ Commands & Keymaps

Here are the custom commands and key mappings I use inside Neovim.

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `<leader>ex`    | Open **explorer tab** from file level     |
| `f` (Dashboard) | 🔍 Find file using Telescope              |
| `r` (Dashboard) | 📂 Open recent files                      |
| `n` (Dashboard) | ➕ Create a new empty buffer              |
| `p` (Dashboard) | 🗂️ Open projects list (Telescope projects)| 
| `l` (Dashboard) | ⚡ Open Lazy plugin manager               |
| `u` (Dashboard) | ⬆️ Update all plugins (Lazy update)       |
| `q` (Dashboard) | 🚪 Quit Neovim                            |

  
| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `K`             | LSP Hover (hover documentation)           |
| `gd`            | Go to Definition (jump to symbol)         |
| `gr`            | Find References (find usages)             |
| `gi`            | Go to Implementation (jump to symbol)     |
| `<leader>rn`    | Rename Symbol (rename symbol under cursor)|
| `<leader>ca`    | Code Action (show code actions)           |
| `<leader>f`     | Format Buffer (format current buffer)     |

  ### Plugin Shortcuts
  - `:Alpha` → Reload dashboard screen
  - `:Lazy` → Open Lazy plugin manager
  - `:Lazy update` → Update all installed plugins
  - `:Telescope find_files` → Search files
  - `:Telescope oldfiles` → Open recent files
  - `:Telescope projects` → Browse projects (requires `telescope-projects`)

### 🔑 WhichKey Integration
- Press `<Space>` (leader) and pause to see a popup of available keymaps.
- Group headers configured: `+git`, `+lazy`, `+theme`, `+showkeys`, `+explorer`, `+colors`, `+telescope`.
- Telescope functions are organized under `<leader>f` with subgroups for git integration (`<leader>fg`).
- Notes:
  - WhichKey shows your existing mappings; it doesn’t create them.
  - Trigger is set to leader in normal/visual mode with a short delay (200ms).

### 🔭 Telescope Features
- **Simplified Setup** - Focused on essential functionality without complex actions
- **Catppuccin Theme Integration** - Clean and modern theme with excellent contrast
- **FZF Performance** - Native FZF integration for faster fuzzy finding
- **UI Select** - Dropdown interface for enhanced selection experience
- **Core Extensions** - Symbols, live grep args, and essential pickers
- **Safe Extension Loading** - Uses `pcall` for graceful fallback if extensions fail

### 🧠 LSP (Language Server) Setup
- Managed via `mason.nvim` and `mason-lspconfig.nvim`.
- Ensured/Configured LSPs (5): `lua_ls`, `pyright`, `rust_analyzer`, `gopls`, `ts_ls`.

### ⚡ Flash.nvim Navigation

**Flash.nvim** provides enhanced navigation with search labels, character motions, and Treesitter integration.

#### **Basic Navigation**
| Key / CMD | Mode | Description |
|-----------|------|-------------|
| `s` | Normal/Visual/Operator | Flash jump - Search and jump with labels |
| `S` | Normal/Operator/Visual | Flash Treesitter - Navigate Treesitter nodes |
| `r` | Operator | Remote Flash - Flash for operators (d, y, c, etc.) |
| `R` | Operator/Visual | Treesitter Search - Search within Treesitter nodes |
| `<c-s>` | Command | Toggle Flash Search - Enable/disable flash in command mode |

#### **Enhanced Character Motions**
- **f/t/F/T with labels**: When enabled, pressing `f`, `t`, `F`, or `T` will show jump labels automatically
- **Smart search**: Uses exact matching by default for precise navigation
- **Multi-window**: Treesitter modes support searching across multiple windows

#### **Features**
- 🎯 **Jump Labels** - Visual labels appear on matches for quick navigation
- 🌳 **Treesitter Integration** - Navigate code structure using Treesitter nodes
- 🔍 **Backdrop Highlighting** - Dims non-matching text for better focus
- ⚡ **Fast Navigation** - Quick character-based navigation with visual feedback
- 🎨 **Customizable** - Configurable labels, highlights, and behavior

#### **Usage Tips**
1. Press `s` to start a flash jump
2. Type characters to search for matches
3. Labels appear on all matches
4. Press the label key to jump to that match
5. Use `S` for Treesitter-based navigation (jumps to code structures)
6. Use `r` in operator mode (e.g., `rs` then `d` to delete to a flash match)

---

### 📊 Statusline (lualine.nvim)
- **Always visible at the bottom**  
- Shows:
  - Mode, branch, diagnostics  
  - Filename + relative path  
  - Encoding / fileformat / filetype  
  - Progress + location  

**Extra Integrations:**
- ✍️ **File information** → shows encoding, format, and file type  

---

## 📌 Notes

* Built & tested on **Windows 11 (CMD/Terminal)**.
* Minimal & evolving config as I learn.
* **Simplified Telescope Integration:** Streamlined configuration with 4 core extensions (FZF, UI-Select, Symbols, Live Grep Args) and Catppuccin theme integration.
* **Theme Integration:** Telescope automatically adapts to your current colorscheme (Catppuccin).
* Contributions and suggestions are welcome.
