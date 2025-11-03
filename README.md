### ✨ yashksaini-coder's Neovim Config (init.lua)

A powerful and feature-rich **Lua-based Neovim configuration**.  
Built with modern best practices, optimized for performance, and enhanced with completion, diagnostics, formatting, and Git integration.  
Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

> [!Note]
> This config has been significantly enhanced with professional features including completion, diagnostics UI, auto-formatting, and more.  
> Fully organized with proper directory structure following Neovim best practices 🚀

---

## ⌨️ Key Mappings

Leader key: **`<Space>`**

Press `<Space>` and pause to see all available keymaps via which-key.

### 🎯 General Keymaps

| Key / CMD     | Description                           |
| ----------- | ------------------------------------- |
| `<leader><Esc>` | Clear search highlights |
| `<leader>ex` | Open file explorer (netrw) |
| `<leader>nc` | Edit Neovim configuration files |
| `<leader>sk` | Toggle ShowKeys |
| `<C-h/j/k/l>` | Navigate windows (left/down/up/right) |
| `<Left/Right/Up/Down>` | Resize windows |
| `<A-j>` / `<A-k>` | Move line/selection down/up |
| `<` / `>` | Indent left/right (visual mode) |
| `"+y` / `"+p` | Yank/Paste to system clipboard |




### 📦 Lazy.nvim Plugin Manager

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
| `<leader>fx` | `:Telescope symbols`               | Search symbols in workspace          |

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

## 🛠️ Advanced Features & Keymaps

### 🧠 LSP (Language Server Protocol)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `K`             | LSP Hover (show documentation)           |
| `gd`            | Go to Definition                          |
| `gr`            | Find References                           |
| `gi`            | Go to Implementation                      |
| `<leader>rn`    | Rename Symbol                             |
| `<leader>ca`    | Code Action                               |
| `<leader>cf`    | Format Buffer (formatter)                |
| `<leader>ws`    | Workspace Symbol                          |
| `<leader>wa`    | Add Workspace Folder                      |
| `<leader>wr`    | Remove Workspace Folder                   |
| `<leader>wl`    | List Workspace Folders                    |
| `<leader>td`    | Type Definition                           |
| `<leader>ds`    | Document Symbol                           |
| `<C-k>`         | Signature Help (in insert/normal mode)    |

### ✨ Code Completion (nvim-cmp)

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `<C-Space>`     | Insert | Trigger completion                        |
| `<C-j>` / `<C-k>` | Insert | Navigate completion suggestions          |
| `<Tab>`         | Insert | Select next / Expand snippet              |
| `<S-Tab>`       | Insert | Select previous / Jump snippet backward   |
| `<CR>`          | Insert | Confirm selection                          |
| `<C-e>`         | Insert | Close completion window                    |
| `<C-b>` / `<C-f>` | Insert | Scroll documentation up/down              |

### 🩺 Diagnostics & Troubleshooting (Trouble.nvim)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `<leader>xx`    | Toggle Diagnostics (all)                  |
| `<leader>xX`    | Toggle Buffer Diagnostics                 |
| `<leader>cs`    | Toggle Symbols                            |
| `<leader>cl`    | Toggle LSP Definitions/References        |
| `<leader>xL`    | Toggle Location List                      |
| `<leader>xQ`    | Toggle Quickfix List                      |
| `[d`            | Previous Diagnostic                       |
| `]d`            | Next Diagnostic                           |

### 🔧 Code Formatting (conform.nvim)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `<leader>cf`    | Format Buffer                             |
| *Auto-format*   | Formats on save (if formatter available)  |

**Supported Formatters:**
- Lua: `stylua`
- Python: `isort`, `black`
- Rust: `rustfmt`
- Go: `gofumpt`, `goimports`
- JS/TS/JSON/YAML/MD/HTML/CSS: `prettier`/`prettierd`

### 🔀 Git Integration (gitsigns.nvim)

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `]c` / `[c`     | Normal | Navigate to next/previous hunk          |
| `<leader>hs`    | Normal/Visual | Stage hunk                               |
| `<leader>hr`    | Normal/Visual | Reset hunk                                |
| `<leader>hS`    | Normal | Stage buffer                              |
| `<leader>hu`    | Normal | Undo stage hunk                           |
| `<leader>hR`    | Normal | Reset buffer                              |
| `<leader>hp`    | Normal | Preview hunk                               |
| `<leader>hb`    | Normal | Blame line                                |
| `<leader>tb`    | Normal | Toggle line blame                         |
| `<leader>hd`    | Normal | Diff this                                 |
| `<leader>hD`    | Normal | Diff this ~                               |
| `<leader>td`    | Normal | Toggle deleted                            |
| `ih`            | Operator/Visual | Select hunk (text object)                |

### 📂 Git (Telescope)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `<leader>gs`    | Git Status                                |
| `<leader>gc`    | Git Commits                               |
| `<leader>gb`    | Git Branches                              |
| `<leader>fgc`   | Git Commits (Telescope)                    |
| `<leader>fgb`   | Git Buffer Commits                        |
| `<leader>fgr`   | Git Branches (Telescope)                   |
| `<leader>fgs`   | Git Status (Telescope)                     |

### 📋 Dashboard

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `f`             | 🔍 Find file using Telescope              |
| `r`             | 📂 Open recent files                      |
| `n`             | ➕ Create a new empty buffer              |
| `p`             | 🗂️ Open projects list (Telescope projects)| 
| `l`             | ⚡ Open Lazy plugin manager               |
| `u`             | ⬆️ Update all plugins (Lazy update)       |
| `q`             | 🚪 Quit Neovim                            |

  ### Plugin Shortcuts
  - `:Alpha` → Reload dashboard screen
  - `:Lazy` → Open Lazy plugin manager
  - `:Lazy update` → Update all installed plugins
  - `:Telescope find_files` → Search files
  - `:Telescope oldfiles` → Open recent files
  - `:Telescope projects` → Browse projects (requires `telescope-projects`)

### 🔑 WhichKey Integration
- Press `<Space>` (leader) and pause to see a popup of available keymaps.
- Group headers configured:
  - `<leader>f` - **+telescope** (file search, buffers, grep, etc.)
  - `<leader>fg` - **+git** (git integration via telescope)
  - `<leader>l` - **+lazy** (plugin manager)
  - `<leader>c` - **+code** (code actions, formatting)
  - `<leader>x` - **+diagnostics** (trouble diagnostics)
  - `<leader>h` - **+git hunks** (gitsigns operations)
  - `<leader>g` - **+git** (git telescope)
  - `<leader>n` - **+config** (neovim config)
  - `<leader>r` - **+rename** (symbol rename)
  - `<leader>w` - **+workspace** (workspace management)
- Notes:
  - WhichKey shows your existing mappings; it doesn't create them.
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
- Enhanced with diagnostic signs, hover on cursor, and better UI.
- Ensured/Configured LSPs (5): `lua_ls`, `pyright`, `rust_analyzer`, `gopls`, `tsserver`.
- Integrated with nvim-cmp for intelligent completion.
- Auto-formatting via conform.nvim with LSP fallback.

## 📂 Directory Structure

```markdown
lua/yashksaini-coder/
├── init.lua              # Entry point (loads all modules)
├── lazy.lua              # Lazy.nvim setup with performance optimizations
├── options.lua           # Neovim options and settings
├── autocmds.lua         # All autocmd definitions
├── highlights.lua      # Custom highlight groups
├── keymaps/             # Organized keymap modules
│   ├── init.lua        # Loads all keymap modules
│   ├── general.lua     # General keymaps
│   ├── lazy.lua        # Lazy plugin manager keymaps
│   ├── telescope.lua   # Telescope keymaps
│   ├── lsp.lua         # LSP on_attach function
│   ├── diagnostics.lua # Diagnostics (Trouble) keymaps
│   └── git.lua         # Git-related keymaps
└── plugins/             # Plugin configurations
    ├── completion.lua  # nvim-cmp setup
    ├── conform.lua     # Code formatting
    ├── trouble.lua     # Diagnostics UI
    ├── gitsigns.lua   # Git integration
    ├── lsp.lua         # LSP configuration
    ├── telescope.lua   # Telescope setup
    ├── treesitter.lua  # Treesitter setup
    ├── colorscheme.lua # Colorscheme configuration
    ├── dashboard.lua  # Dashboard/startup screen
    ├── lualine.lua     # Statusline
    ├── showkeys.lua   # ShowKeys plugin
    └── which-key.lua   # Which-key configuration
```

---

### 📊 Statusline (lualine.nvim)
- **Always visible at the bottom** (global statusline)
- Shows:
  - Mode, branch, diff, diagnostics  
  - Filename + relative path  
  - Encoding / fileformat / filetype  
  - Progress + location  

**Extra Integrations:**
- ✍️ **File information** → shows encoding, format, and file type
- 🔍 **Diagnostics** → error/warning counts
- 🌿 **Git branch** → current branch name

### 🎨 New Features

#### Code Completion
- **nvim-cmp** with LSP, buffer, and path completion
- **LuaSnip** for snippets with VSCode snippet support
- Intelligent completion with icons via lspkind

#### Diagnostics
- **Trouble.nvim** for beautiful diagnostics UI
- Navigate diagnostics with `[d` and `]d`
- Quick access to all error/warning/info/hint lists

#### Auto-Formatting
- **conform.nvim** for code formatting
- Auto-format on save
- Support for multiple formatters per language
- LSP fallback if formatter not available

#### Git Integration
- **gitsigns.nvim** for Git gutter signs
- Stage/reset hunks inline
- Blame line with `<leader>hb`
- Navigate hunks with `]c` / `[c`

#### Performance
- Lazy loading for better startup time
- Disabled unused rtp plugins
- Plugin update checker (runs hourly)
- Optimized completion timeout  

---

## 📌 Notes

* Built & tested on **Windows 11 (CMD/Terminal)** and **Linux**.
* **Enhanced Configuration:** Now includes completion, diagnostics, formatting, and Git integration.
* **Performance Optimized:** Lazy loading, disabled unused plugins, optimized settings.
* **Well Organized:** Proper directory structure following Neovim best practices.
* **Telescope Integration:** Streamlined configuration with 4 core extensions (FZF, UI-Select, Symbols, Live Grep Args).
* **Theme Integration:** Telescope automatically adapts to your current colorscheme.
* **Auto-Formatting:** Configured for Lua, Python, Rust, Go, JS/TS, JSON, YAML, Markdown, HTML, CSS.
* **LSP Fixed:** Updated deprecated `ts_ls` to `tsserver`.

## 🚀 Getting Started

1. **Install dependencies:** The config uses Mason for LSP servers, but you may need to install formatters:
   - `stylua` for Lua
   - `black` and `isort` for Python  
   - `prettierd` or `prettier` for JS/TS/JSON/YAML/MD
   - `rustfmt` for Rust (usually comes with Rust toolchain)
   - `gofumpt` and `goimports` for Go

2. **First launch:** Run `:Lazy sync` to install all plugins.

3. **LSP Setup:** LSP servers will be auto-installed via Mason on first use.

4. **Completion:** Start typing in insert mode and use `<C-Space>` to trigger completion.

5. **Diagnostics:** Use `<leader>xx` to open Trouble diagnostics panel.

6. **Formatting:** Code auto-formats on save. Use `<leader>cf` to format manually.

## 📚 Keymap Reference Summary

- **General:** `<leader>ex` (explorer), `<leader>nc` (config), window navigation
- **Telescope:** `<leader>f*` (file search, grep, buffers, etc.)
- **LSP:** `K` (hover), `gd` (definition), `<leader>rn` (rename), `<leader>cf` (format)
- **Completion:** `<C-Space>` (trigger), `<Tab>` (select/expand), `<C-j/k>` (navigate)
- **Diagnostics:** `<leader>xx` (trouble), `[d`/`]d` (navigate)
- **Git:** `]c`/`[c` (hunks), `<leader>hs` (stage), `<leader>hp` (preview)
- **Lazy:** `<leader>ll` (menu), `<leader>ls` (sync), `<leader>lu` (update)

*Contributions and suggestions are welcome!*
