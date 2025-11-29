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
| `<Esc>` | Clear search highlights |
| `<leader>sk` | Toggle ShowKeys |
| `<C-h/j/k/l>` | Navigate windows (left/down/up/right) |
| `<C-s>` | Save file (Insert/Normal/Visual) |
| `<leader>q` | Quit all |
| `<leader>mp` | Toggle Markdown Render |

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

| Key / CMD     | Command                                    | Description                           |
| ----------- | ------------------------------------------ | ------------------------------------- |
| `<leader>ff` | `:Telescope find_files hidden=true`        | Find files (including hidden)         |
| `<leader>fg` | `:Telescope live_grep`                     | Live grep across project             |
| `<leader>fb` | `:Telescope buffers`                       | Find and switch between buffers       |
| `<leader>fh` | `:Telescope help_tags`                     | Search help documentation             |
| `<leader>fs` | `:Telescope grep_string`                   | Grep string under cursor             |

### 📂 Neo-tree (File Explorer)

| Key / CMD     | Command                                    | Description                           |
| ----------- | ------------------------------------------ | ------------------------------------- |
| `<leader>e`  | `:Neotree toggle`                          | Toggle Explorer                       |
| `<leader>eo` | `:Neotree focus`                           | Focus Explorer                        |
| `<leader>er` | `:Neotree reveal`                          | Reveal current file in Explorer       |
| `<leader>ef` | `:Neotree filesystem reveal left`          | Show Filesystem Explorer              |
| `<leader>eb` | `:Neotree buffers reveal float`            | Show Buffer Explorer                  |
| `<leader>eg` | `:Neotree git_status reveal float`         | Show Git Status Explorer              |

### 🎨 Themes

| Key / CMD     | Description                           |
| ----------- | ------------------------------------- |
| `<leader>co` | Switch to **Osmium** theme            |
| `<leader>ct` | Switch to **Tokyonight** (Default)    |
| `<leader>cts`| Switch to **Tokyonight Storm**        |
| `<leader>ctn`| Switch to **Tokyonight Night**        |
| `<leader>ctm`| Switch to **Tokyonight Moon**         |
| `<leader>ctd`| Switch to **Tokyonight Day**          |

### 🔔 Noice (Notifications & Cmdline)

| Key / CMD     | Command                                    | Description                           |
| ----------- | ------------------------------------------ | ------------------------------------- |
| `<leader>nh` | `:Noice history`                           | Show notification history             |
| `<leader>nl` | `:Noice last`                              | Show last message                     |
| `<leader>ne` | `:Noice errors`                            | Show errors                           |
| `<leader>nd` | `:Noice dismiss`                           | Dismiss all notifications             |
| `<leader>np` | `:Noice pick`                              | Open Noice picker (Telescope)         |
| `<leader>ns` | `:Noice stats`                             | Show Noice stats                      |

### 🧠 LSP & Mason

| Key / CMD     | Description                           |
| ----------- | ------------------------------------- |
| `<leader>M`  | Open Mason command menu               |
| `K`          | Hover documentation                   |
| `<leader>gd` | Go to Definition                      |
| `<leader>gr` | Find References                       |
| `<leader>ca` | Code Action                           |


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

### 📑 Bufferline.nvim

**Bufferline.nvim** provides a modern, snazzy buffer line with tab integration for Neovim.

#### **Buffer Navigation**
| Key / CMD | Description |
|-----------|-------------|
| `<S-h>` or `[b` | Navigate to previous buffer |
| `<S-l>` or `]b` | Navigate to next buffer |
| `<leader>bp` | Toggle pin current buffer |
| `<leader>bP` | Delete all non-pinned buffers |
| `<leader>bo` | Close all other buffers |
| `<leader>br` | Close all buffers to the right |
| `<leader>bl` | Close all buffers to the left |

#### **Features**
- 🎨 **Modern Design** - Clean, snazzy buffer tabs with icons
- 🔍 **LSP Integration** - Shows diagnostic indicators (errors/warnings) on buffers
- 📌 **Buffer Pinning** - Pin important buffers to prevent accidental closure
- 🎯 **Smart Sorting** - Buffers sorted by insertion order after current
- 🖱️ **Mouse Support** - Click to switch buffers, middle-click to close
- 📊 **Hover Preview** - Hover over buffers to see full path and information
- 🎭 **File Icons** - Colored filetype icons using nvim-web-devicons
- 🔄 **Persistent Order** - Buffer order persists between sessions

#### **Visual Features**
- **Separator Style**: Slant separators between buffers
- **Close Icons**: Visual close buttons on each buffer
- **Modified Indicator**: Shows dot (●) for modified buffers
- **Diagnostics**: Displays error/warning counts on buffers
- **Active Buffer Highlighting**: Clear visual indication of current buffer

#### **Configuration Highlights**
- Excludes alpha dashboard from bufferline
- Supports sidebar offsets for file explorers (neo-tree, NvimTree)
- Customizable diagnostics indicator
- Hover events enabled for better UX

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