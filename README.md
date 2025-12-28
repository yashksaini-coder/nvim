### ✨ yashksaini-coder's Neovim Config (init.lua)

A powerful and feature-rich **Lua-based Neovim configuration**.  
Built with modern best practices, optimized for performance, and enhanced with completion, diagnostics, formatting, and Git integration.  
Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

> [!Note]
> This config has been significantly enhanced with professional features including completion, diagnostics UI, auto-formatting, and more.  
> Fully organized with proper directory structure following Neovim best practices 🚀

## 📝 Recent Changes

### ✨ Added
- **snacks.indent** - Indent highlighting plugin (same as LazyVim) for visual code structure
- **mini.completion** - Lightweight completion engine for LSP code completion
- **persistence.nvim** - Session management with auto-save/restore functionality
- **Enhanced Telescope keymaps** - Added `<leader>fR` (recent files in cwd) and `<leader>fd` (diagnostics)
- **Improved Dashboard** - All alpha dashboard buttons now functional with proper keybindings

### 🔄 Changed
- **Indent Highlighting** - Replaced mini.indentscope with snacks.indent (LazyVim's choice)
- **Git Integration** - Replaced mini.diff and mini.git with gitsigns.nvim for standard Git integration
- **Completion Engine** - Switched from blink.cmp to mini.completion for better stability and performance
- **Telescope Configuration** - Keymaps now properly defined in plugin file using lazy.nvim keys table
- **Dashboard Event** - Fixed alpha dashboard to use `LazyDone` event instead of `LazyVimStarted`
- **Terminal Configuration** - Simplified terminal setup with minimal bootstrap approach; keymaps moved to `lua/config/keymaps/terminal.lua` with clean direction-specific toggles (`<leader>th/tv/tf`)

### 🗑️ Removed
- **mini.diff** - Replaced with gitsigns.nvim
- **mini.git** - Replaced with gitsigns.nvim
- **noice.nvim** - Removed notification/command line UI plugin
- **blink.cmp** - Removed due to fuzzy matching library issues, replaced with mini.completion
- **fff plugin** - Removed (was already deleted in previous changes)

--

## ⌨️ Key Mappings

Leader key: **`<Space>`**

Press `<Space>` and pause to see all available keymaps via which-key.

### 🎯 General Keymaps

| Key | Description |
|-----|-------------|
| `<Esc>` | Clear search highlights |
| `<leader>sk` | Toggle ShowKeys display |
| `<C-h>` | Move to left window |
| `<C-j>` | Move to lower window |
| `<C-k>` | Move to upper window |
| `<C-l>` | Move to right window |
| `<C-s>` | Save file |
| `<leader>q` | Quit all |
| `<leader>mp` | Toggle Markdown Render |
| `<C-/>` | Toggle comment (Visual mode) |

### 📦 Lazy.nvim Plugin Manager

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ll` | `:Lazy` | Open Lazy menu |
| `<leader>ls` | `:Lazy sync` | Sync plugins (install/update/remove) |
| `<leader>lu` | `:Lazy update` | Update all plugins |
| `<leader>li` | `:Lazy install` | Install missing plugins |
| `<leader>lc` | `:Lazy check` | Check plugin health |
| `<leader>lx` | `:Lazy clean` | Remove unused plugins |

### 🔭 Telescope (Fuzzy Finder)

| Key | Command | Description |
|-----|---------|-------------|
| `<C-p>` | `:Telescope find_files` | Find files (quick access) |
| `<leader>ff` | `:Telescope find_files` | Find files (hidden included) |
| `<leader>fr` | `:Telescope oldfiles` | Open recent files |
| `<leader>fR` | `:Telescope oldfiles only_cwd=true` | Recent files (current directory) |
| `<leader>fg` | `:Telescope live_grep` | Live grep search in project |
| `<leader>fs` | `:Telescope grep_string` | Grep word under cursor |
| `<leader>fb` | `:Telescope buffers` | Find and switch between buffers |
| `<leader>fh` | `:Telescope help_tags` | Search Neovim help documentation |
| `<leader>fd` | `:Telescope diagnostics` | Show LSP diagnostics |

### 📂 Nvim-tree (File Explorer)

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>e` | `:NvimTreeToggle` | Toggle file explorer |
| `<leader>ef` | `:NvimTreeFindFile` | Find current file in explorer |

**Nvim-tree Features:**
- Git integration (shows git status icons)
- Diagnostics integration (shows error/warning icons)
- Auto-refresh on file changes
- Default keymaps available inside tree (see `:help nvim-tree`)

### 🗺️ Mini Map

| Key | Description |
|-----|-------------|
| `<leader>mt` | Toggle Mini Map |
| `<leader>mo` | Open Mini Map |
| `<leader>mc` | Close Mini Map |
| `<leader>mf` | Focus Mini Map |
| `<leader>mr` | Refresh Mini Map |
| `<leader>ms` | Toggle Mini Map position (left/right) |

### 🎨 Themes

| Key | Theme | Description |
|-----|-------|-------------|
| `<leader>co` | Osmium | Switch to Osmium theme |
| `<leader>ct` | Tokyonight | Switch to Tokyonight (default) |
| `<leader>cts` | Tokyonight Storm | Switch to Tokyonight Storm variant |
| `<leader>ctn` | Tokyonight Night | Switch to Tokyonight Night variant |
| `<leader>ctm` | Tokyonight Moon | Switch to Tokyonight Moon variant |
| `<leader>ctd` | Tokyonight Day | Switch to Tokyonight Day (light) |
| `<leader>cc` | Chai | Switch to Chai theme |
| `<leader>th` | Themery | Open Themery theme picker |

### 💻 Terminal (ToggleTerm)

**ToggleTerm** provides integrated terminal management with multiple display modes.

#### **Terminal Toggle Keymaps**

| Key | Description |
|-----|-------------|
| `<C-\>` | Toggle default terminal (floating, 50% width × 40% height) |

#### **Direction-Specific Terminals**

| Key | Description |
|-----|-------------|
| `<leader>th` | Toggle horizontal terminal (15 lines) |
| `<leader>tv` | Toggle vertical terminal (30% of screen width) |
| `<leader>tf` | Toggle floating terminal (50% width × 40% height) |

#### **Terminal Features**

- **Multiple Display Modes**: Horizontal, vertical, and floating terminals
- **Auto-insert Mode**: Automatically enters insert mode when terminal opens
- **Auto-exit Insert**: Automatically exits insert mode when leaving terminal buffer
- **Smart Sizing**: 
  - Horizontal terminals: 15 lines
  - Vertical terminals: 30% of screen width
  - Floating terminals: 50% width × 40% height with single border
- **Clean UI**: Line numbers and sign column disabled in terminal buffers

### 📏 Indent Highlighting (snacks.indent)

**Features:**
- Visual indent guides showing code structure
- Scope highlighting for current indentation level
- Smooth animations (Neovim 0.10+)
- Auto-excludes help, dashboard, and other special buffers

**Visual Indicators:**
- `│` character for indent guides
- Highlighted current scope
- Configurable highlight groups

### 🧠 LSP & Mason (Language Servers)

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>M` | `:Mason` | Open Mason package manager |
| `K` | `vim.lsp.buf.hover` | Show hover documentation |
| `<leader>gd` | `vim.lsp.buf.definition` | Go to definition |
| `<leader>gr` | `vim.lsp.buf.references` | Find all references |
| `<leader>ca` | `vim.lsp.buf.code_action` | Show code actions |
| `<leader>d` | `vim.diagnostic.open_float` | Show diagnostics at cursor |

### 🔧 Oil (File Buffer Editor)

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>o` | `:Oil` | Open oil file explorer |
| `<leader>O` | `:Oil --floating` | Open oil in floating window |

**Oil Keyboard Shortcuts (inside oil buffer):**
- `<CR>` - Open/select file
- `<C-s>` - Open in vertical split
- `<C-h>` - Open in horizontal split
- `<C-t>` - Open in new tab
- `<C-p>` - Preview file
- `<C-l>` - Refresh
- `-` - Go to parent directory
- `_` - Open current working directory
- `` ` `` - Change directory
- `~` - Change working directory
- `gs` - Change sort order
- `gx` - Open file with external program
- `g.` - Toggle hidden files
- `g?` - Show help

### 📋 Bufferline (Buffer Navigation)

| Key | Command | Description |
|-----|---------|-------------|
| `<S-h>` or `[b` | Prev Buffer | Navigate to previous buffer |
| `<S-l>` or `]b` | Next Buffer | Navigate to next buffer |
| `<leader>bp` | `:BufferLineTogglePin` | Pin/unpin current buffer |
| `<leader>bP` | Close unpinned | Delete all non-pinned buffers |
| `<leader>bo` | Close others | Close all other buffers |
| `<leader>br` | Close right | Close all buffers to the right |
| `<leader>bl` | Close left | Close all buffers to the left |

### ⌨️ Keymap Quick Reference (All `<leader>` Mappings)

**Navigation & Files:**
- `ff` - Find files | `fg` - Live grep | `fb` - Buffers | `fh` - Help
- `fs` - Grep string | `fr` - Recent files | `fR` - Recent files (cwd) | `fd` - Diagnostics
- `e` - Toggle explorer | `ef` - Find file in explorer

**Themes & UI:**
- `co` - Osmium theme | `ct` - Tokyonight | `cts/ctn/ctm/ctd` - Variants
- `cc` - Chai theme | `th` - Themery picker
- `mt/mo/mc/mf/mr/ms` - Mini map controls

**Terminal:**
- `<C-\>` - Toggle default terminal (float) | `th` - Horizontal | `tv` - Vertical | `tf` - Float


**Plugins & Tools:**
- `ll` - Lazy menu | `ls` - Lazy sync | `lu` - Lazy update
- `li` - Lazy install | `lc` - Lazy check | `lx` - Lazy clean
- `M` - Mason packages | `sk` - ShowKeys

**Sessions:**
- `qs` - Restore session | `ql` - Restore last session | `qd` - Don't save session

**Git Operations:**
- `]c` / `[c` - Navigate diff hunks | `<leader>hs` - Stage hunk | `<leader>hr` - Reset hunk | `<leader>gb` - Full buffer blame

**Code & Diagnostics:**
- `gd` - Definition | `gr` - References | `ca` - Code action | `d` - Show diagnostics
- `fm` - Format file/range | `xx` - Trouble diagnostics | `xX` - Buffer diagnostics

**Buffers:**
- `bp` - Pin buffer | `bP` - Delete unpinned | `bo` - Delete others
- `br` - Delete right | `bl` - Delete left

**Oil (File Editor):**
- `o` - Oil explorer | `O` - Oil floating

### ✨ Code Completion (mini.completion)

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `<C-Space>`     | Insert | Force two-step completion                 |
| `<A-Space>`     | Insert | Force fallback completion                 |
| `<C-f>`         | Insert | Scroll info/signature window down         |
| `<C-b>`         | Insert | Scroll info/signature window up           |
| `<C-n>`         | Insert | Fallback to built-in completion           |

**Features:**
- **LSP Integration** - Automatic LSP completion setup on buffer enter
- **Auto-completion** - Intelligent completion with configurable delays
- **Info Windows** - Hover documentation and signature help
- **Snippet Support** - Works with mini.snippets or vim.snippet.expand

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

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `<leader>fm`    | Normal/Visual | Format file or range (in visual mode)     |
| *Auto-format*   | -    | Formats on save (if formatter available)  |

**Supported Formatters:**
- Lua: `stylua`
- Python: `isort`, `black`
- Rust: `rustfmt`
- Go: `gofumpt`, `goimports`
- JS/TS/JSON/YAML/MD/HTML/CSS: `prettier`/`prettierd`

### 🔀 Git Integration (gitsigns.nvim)

**Features:**
- **Git Signs** - Visual indicators for added/changed/deleted lines in the sign column
- **Hunk Navigation** - Jump between changes with `]c`/`[c`
- **Hunk Management** - Stage, reset, and preview hunks directly in editor
- **Blame** - Show git blame information for lines
- **Diff View** - Compare current file with HEAD or other commits
- **Quickfix Integration** - Populate quickfix list with hunks or all changes

**Hunk Navigation & Actions:**

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `]c` / `[c`     | Normal | Navigate to next/previous hunk          |
| `<leader>hs`    | Normal | Stage hunk                                |
| `<leader>hr`    | Normal | Reset hunk                                |
| `<leader>hS`    | Normal | Stage buffer                              |
| `<leader>hR`    | Normal | Reset buffer                              |
| `<leader>hp`    | Normal | Preview hunk                              |
| `<leader>hi`    | Normal | Preview hunk inline                       |

**Blame & Diff:**

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `<leader>hb`    | Normal | Blame line (full info)                    |
| `<leader>hd`    | Normal | Diff this file                            |
| `<leader>hD`    | Normal | Diff this file (~HEAD)                    |

**Quickfix & Toggles:**

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `<leader>hq`    | Normal | Set quickfix list (current file)          |
| `<leader>hQ`    | Normal | Set quickfix list (all files)             |
| `<leader>tb`    | Normal | Toggle current line blame                 |
| `<leader>gb`    | Normal | Toggle full-buffer blame window           |
| `<leader>tw`    | Normal | Toggle word diff                          |
| `ih`            | Operator/Visual | Select hunk (text object)        |

###  Dashboard (Alpha)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `f`             | 🔍 Find file using Telescope (`<leader>ff`) |
| `n`             | ➕ Create a new empty buffer              |
| `r`             | 📂 Open recent files (Telescope)          |
| `g`             | 🔍 Find text (`<leader>fg`)               |
| `c`             | ⚙️ Open Neovim config files               |
| `s`             | 💾 Restore session (persistence)          |
| `M`             | 📦 Open Mason menu (`<leader>M`)           |
| `l`             | ⚡ Open Lazy plugin manager (`<leader>ll`) |
| `q`             | 🚪 Quit Neovim (`<leader>q`)              |

### 💾 Session Management (persistence.nvim)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `<leader>qs`    | Restore session                           |
| `<leader>ql`    | Restore last session                      |
| `<leader>qd`    | Don't save current session                 |

**Features:**
- **Auto-save** - Sessions automatically saved on exit
- **Session Directory** - Stored in `~/.config/nvim/sessions/`
- **Selective Restore** - Choose which session to restore
- **Session Options** - Saves buffers, cursor position, windows, tabs, and more

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
  - `<leader>f` - **+telescope** (file search, buffers, grep, etc.)
  - `<leader>l` - **+lazy** (plugin manager)
  - `<leader>c` - **+code** (code actions, symbols, LSP)
  - `<leader>f` - **+format** (formatting)
  - `<leader>x` - **+diagnostics** (trouble diagnostics)
  - `<leader>g` - **+git** (git operations)
  - `<leader>n` - **+config** (neovim config)
  - `<leader>r` - **+rename** (symbol rename)
  - `<leader>w` - **+workspace** (workspace management)
- Notes:
  - WhichKey shows your existing mappings; it doesn't create them.
  - Trigger is set to leader in normal/visual mode with a short delay (200ms).

### 🔭 Telescope Features
- **FZF Native Integration** - Native FZF sorter for optimal performance and fuzzy file support
- **Fast File Finding** - Optimized file and generic sorters for quick navigation
- **Comprehensive Keymaps** - Quick access with `<C-p>` and full leader-based mappings
- **Diagnostics Integration** - Quick access to LSP diagnostics via `<leader>fd`

### 🧠 LSP (Language Server) Setup
- Managed via `mason.nvim` and `mason-lspconfig.nvim`.
- Enhanced with diagnostic signs, hover on cursor, and better UI.
- Ensured/Configured LSPs (3): `lua_ls`, `pyright`, `rust_analyzer`.
- Integrated with **mini.completion** for intelligent LSP completion.
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
- **mini.completion** - Lightweight, fast completion engine
- **LSP Integration** - Automatic setup with completefunc source
- **Auto-completion** - Intelligent completion with configurable delays
- **Info Windows** - Signature help and documentation popups
- **Snippet Support** - Works with mini.snippets or native vim.snippet.expand

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
- **mini.diff** for Git diff visualization and hunk management
- **mini.git** for Git command integration and repository tracking
- Inline diff signs showing added/changed/deleted lines
- Navigate hunks with `]h` / `[h`
- Apply/reset hunks with `gha` / `ghr`
- Execute git commands with `:Git <command>`

#### Session Management
- **persistence.nvim** - Automatic session save/restore
- Sessions saved to `~/.config/nvim/sessions/`
- Restore last session or choose specific session
- Auto-save on exit, manual control available

#### Performance
- Lazy loading for better startup time
- Disabled unused rtp plugins
- Plugin update checker (runs hourly)
- Lightweight completion engine (mini.completion)  

---

## 📌 Notes

* Built & tested on **Windows 11 (CMD/Terminal)** and **Linux**.
* **Enhanced Configuration:** Now includes completion, diagnostics, formatting, Git integration, and session management.
* **Performance Optimized:** Lazy loading, disabled unused plugins, optimized settings, lightweight completion engine.
* **Well Organized:** Proper directory structure following Neovim best practices.
* **Telescope Integration:** Streamlined configuration with FZF native sorter for optimal performance.
* **Theme Integration:** Telescope automatically adapts to your current colorscheme.
* **Auto-Formatting:** Configured for Lua, Python, Rust, Go, JS/TS, JSON, YAML, Markdown, HTML, CSS.
* **Session Management:** Automatic session save/restore with persistence.nvim.
* **Modern Completion:** Using mini.completion for fast, lightweight LSP completion.

## 🚀 Getting Started

1. **Install dependencies:** The config uses Mason for LSP servers, but you may need to install formatters:
   - `stylua` for Lua
   - `black` and `isort` for Python  
   - `prettierd` or `prettier` for JS/TS/JSON/YAML/MD
   - `rustfmt` for Rust (usually comes with Rust toolchain)
   - `gofumpt` and `goimports` for Go

2. **First launch:** Run `:Lazy sync` to install all plugins.

3. **LSP Setup:** LSP servers will be auto-installed via Mason on first use.

4. **Completion:** Start typing in insert mode for auto-completion, or use `<C-Space>` to force completion.

5. **Diagnostics:** Use `<leader>xx` to open Trouble diagnostics panel.

6. **Formatting:** Code auto-formats on save. Use `<leader>fm` to format manually (or in visual mode for range).

## 📚 Keymap Reference Summary

- **General:** `<leader>ex` (explorer), `<leader>nc` (config), window navigation
- **Telescope:** `<leader>f*` (file search, grep, buffers, etc.)
- **LSP:** `K` (hover), `gd` (definition), `gr` (references), `<leader>ca` (code action), `<leader>d` (diagnostics)
- **Formatting:** `<leader>fm` (format), auto-format on save
- **Completion:** `<C-Space>` (force), `<A-Space>` (fallback), `<C-f>/<C-b>` (scroll docs)
- **Sessions:** `<leader>qs` (restore), `<leader>ql` (last), `<leader>qd` (don't save)
- **Diagnostics:** `<leader>xx` (trouble), `[d`/`]d` (navigate)
- **Git:** `]h`/`[h` (hunks), `gha` (apply), `ghr` (reset)
- **Terminal:** `<C-\>` (toggle default), `<leader>th` (horizontal), `<leader>tv` (vertical), `<leader>tf` (float)
- **Lazy:** `<leader>ll` (menu), `<leader>ls` (sync), `<leader>lu` (update)

