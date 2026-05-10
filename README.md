### ✨ yashksaini-coder's Neovim Config (init.lua)

A powerful and feature-rich **Lua-based Neovim configuration**.  
Built with modern best practices, optimized for performance, and enhanced with completion, diagnostics, formatting, and Git integration.  
Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

> [!Note]
> This config has been significantly enhanced with professional features including completion, diagnostics UI, auto-formatting, and more.  
> Fully organized with proper directory structure following Neovim best practices 🚀

## Highlights

- **Full IDE for systems languages.** First-class LSP + DAP for **C, C++, Rust, Go, Python, JS/TS** with rename, signature help, type definitions, implementations, document/workspace symbols, call hierarchy, scopes, watches, and a hover-variable widget.
- **AI assistants built in.** Claude Code, GitHub Copilot, and OpenCode coexist under the `<leader>i` prefix.
- **Productivity stack.** flash.nvim, harpoon, oil.nvim, refactoring.nvim, neogit, diffview, undotree, zen-mode, twilight.
- **Time discipline.** Pomodoro timer (`<leader>pp`) with live countdown rendered in the lualine statusline, plus a clock segment.
- **Hosted docs.** Live keymap and plugin reference at <https://yashksaini-coder.github.io/nvim/>. Open it from inside the editor with `<leader>D`.
- **Tested.** plenary-based test harness; PR-blocking lint + test CI; daily lockfile drift PR via existing CI.

> Press `<leader>?` inside Neovim to discover everything else interactively.

## 📝 Recent Changes

### ✨ Added (Latest)
- **Utils (Boilerplates & Snippets)** - Full-buffer boilerplates (C/C++/Go/Rust, LeetCode, CSES) and insert-at-cursor snippets (primes, mod inverse, diophantine, PBDS, pow, loops). Keymaps via `config.keymaps.utils`.
- **Native C/C++ Compiler** - Built-in compilation support using Neovim's `:make` and quickfix features (no external plugins)
- **Telescope + snacks.nvim integration** - Added snacks.nvim as a dependency to Telescope for enhanced file preview capabilities
- **snacks.nvim (image)** - Image preview with Kitty Graphics Protocol support for viewing images, PDFs, videos, and math expressions inline
- **which-key.nvim** - Interactive keymap popup with LazyVim-style UI showing all available keybindings
- **bufferline.nvim** - LazyVim-style buffer/tab management with always-visible tabline, LSP diagnostics, and git status integration
- **leetcode.nvim** - Solve LeetCode problems directly in Neovim with integrated testing and submission
- **ferris.nvim** - Rust Analyzer extensions (macro expansion, HIR/MIR, memory layout viewing)
- **crates.nvim** - Interactive Cargo.toml dependency manager with version checking and updates
- **cord.nvim** - Discord Rich Presence integration for showing activity

### ✨ Added (Previous)
- **dashboard-nvim** - Modern, feature-rich dashboard with shortcuts and theme support
- **nvim-cmp** - Powerful completion engine with LSP integration and snippet support
- **mason.nvim** - Package manager for LSP servers, linters, and formatters
- **mason-lspconfig.nvim** - Bridge between Mason and nvim-lspconfig
- **LuaSnip** - Snippet engine for code completion
- **cmp_luasnip** - Integration between nvim-cmp and LuaSnip
- **conform.nvim** - Code formatting with LSP fallback
- **trouble.nvim** - Beautiful diagnostics UI
- **gitsigns.nvim** - Git integration with signs, hunks, and blame
- **mini.map** - Code minimap for navigation
- **render-markdown.nvim** - Enhanced markdown rendering
- **cellular-automaton.nvim** - Fun cellular automaton animations
- **smear-cursor.nvim** - Smooth cursor animations
- **tip.nvim** - Helpful tips and shortcuts
- **numb.nvim** - Peek buffer lines when entering `:{number}` commands
- **Enhanced Telescope keymaps** - Added `<leader>fR` (recent files in cwd) and `<leader>fd` (diagnostics)

### 🔄 Changed
- **Terminal Configuration** - Upgraded to full LazyVim-style terminal with:
  - Specialized terminals (LazyGit, Python REPL, Node REPL, System Monitor)
  - Enhanced UI with curved borders and 80% × 80% floating windows
  - Better navigation with `<C-h/j/k/l>` in terminal mode
  - Numbered terminal quick access (`<leader>t1-4`)
  - Send visual selection to terminal (`<leader>ts` in visual mode)
  - Winbar showing terminal ID
  - Professional window styling and proper highlight groups
- **Dashboard** - Replaced alpha with dashboard-nvim for better aesthetics and functionality
- **File Explorer** - Simplified nvim-tree to basic configuration for stability
- **LSP Setup** - Migrated to Neovim 0.11 native LSP API with Mason for tool installation
- **Completion** - Replaced blink.cmp with nvim-cmp for broader compatibility
- **Treesitter** - Streamlined to essential languages (Rust, Python, TypeScript, JavaScript, C, C++)

### 🗑️ Removed
- **compiler.nvim & overseer.nvim** - Replaced with native Neovim compilation features (fixes buffer errors)
- **krust.nvim** - Removed enhanced Rust diagnostics (restored standard diagnostics)
- **alpha** - Replaced with dashboard-nvim
- **blink.cmp** - Replaced with nvim-cmp for compatibility
- **auto-session** - Removed session management (can be re-added if needed)
- **mini.diff** - Replaced with gitsigns.nvim
- **mini.git** - Replaced with gitsigns.nvim
- **noice.nvim** - Removed notification/command line UI plugin
- **mini.completion** - Replaced with nvim-cmp
- **fff plugin** - Removed (was already deleted in previous changes)
- **persistence.nvim** - Replaced with auto-session (now removed)
- **image.nvim** - Removed due to loading conflicts

--

## ⌨️ Key Mappings

Leader key: **`<Space>`**

Press `<Space>` and pause to see all available keymaps via which-key.

### 🔑 Which-Key (Interactive Keymap Display)

**Which-Key** shows a popup with all available keybindings when you start typing a command, helping you discover and remember keymaps.

**Features:**
- **LazyVim-style UI** - Beautiful Helix preset matching LazyVim's aesthetic
- **Organized Groups** - Keymaps grouped by category (buffer, code, file, git, etc.)
- **Buffer Keymaps** - Press `<leader>?` to show buffer-local keymaps
- **Window Hydra Mode** - Press `<C-w><space>` for repeatable window commands
- **Auto-discovery** - Automatically shows available completions as you type

**Main Keymap Groups:**
- `<leader>a` - Animations (cellular automaton)
- `<leader>b` - Buffer operations
- `<leader>c` - Code/Crates (ct/cr/ca/etc = crates)
- `<leader>f` - File/Find operations
- `<leader>g` - Git/Goto operations
- `<leader>h` - Git hunks (stage, reset, preview)
- `<leader>l` - Lazy plugin manager
- `<leader>L` - LeetCode
- `<leader>m` - Markdown/Make (F5–F8: mb/mr/mT/mx)/MiniMap
- `<leader>r` - Rust tools (Ferris)
- `<leader>t` - Terminal/Tabs (t1–t4 = terminals; tn = new tab; tN = Node REPL; tH = Themery)
- `<leader>T` - Go to tab (T1–T9)
- `<leader>x` - Trouble diagnostics
- **Utils** - Boilerplates (`blp`/`blc`/`got`/`rst`/`plc`/`cse`), snippets (`pov`/`mod`/`dio`), loops (`sfor`/`swh`/`sdo`/`srange`)

**Function Keys (C/C++ Compilation):**
- `F5` - Build current C/C++ file
- `F6` - Build and run program
- `F7` - Toggle quickfix (compilation results)
- `F8` - Run last compiled program
- `<leader>mb` / `mr` / `mT` / `mx` - Same as F5/F6/F7/F8 (leader alternatives)

**Special Keys:**
- `<leader>?` - Show buffer-local keymaps
- `<C-w><space>` - Window Hydra Mode (repeat window operations)

### 🎯 General Keymaps

| Key | Description |
|-----|-------------|
| `<Esc>` | Clear search highlights |
| `<C-h>` | Move to left window |
| `<C-j>` | Move to lower window |
| `<C-k>` | Move to upper window |
| `<C-l>` | Move to right window |
| `<C-s>` | Save file |
| `<leader>q` | Quit all |
| `<leader>bd` | Delete current buffer |
| `<leader>mp` | Toggle markdown preview |
| `<C-/>` | Toggle comment (Visual mode) |

### 📦 Lazy.nvim Plugin Manager

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ll` | `:Lazy` | Open Lazy menu |
| `<leader>ls` | `:Lazy sync` | Sync plugins (install/update/remove) |
| `<leader>lu` | `:Lazy update` | Update all plugins |
| `<leader>li` | `:Lazy install` | Install missing plugins |
| `<leader>lx` | `:Lazy clean` | Remove unused plugins |

### 💡 LeetCode (leetcode.nvim)

**LeetCode** plugin for solving competitive programming problems directly in Neovim. Uses `<leader>L` prefix to avoid conflicts with crates/Trouble.

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>L` | `:Leet` | Open LeetCode |
| `<leader>Lr` | `:Leet run` | Run the current problem with test cases |
| `<leader>Ls` | `:Leet submit` | Submit your solution to LeetCode |
| `<leader>Ll` | `:Leet list` | Show all LeetCode problems |
| `<leader>Ld` | `:Leet daily` | Load today's daily challenge |
| `<leader>LR` | `:Leet reset` | Reset the current problem |

**LeetCode Features:**
- Default language: **C++** (configurable to Python, Java, JavaScript, etc.)
- Integrated test case runner with real-time feedback
- Problem description viewer with stats
- Solution submission to LeetCode
- Code caching for offline access
- Problem progress tracking

### 🔭 Telescope (Fuzzy Finder)

**Telescope** is a powerful fuzzy finder with extensive search capabilities and file preview support.

**Dependencies:**
- `telescope-fzf-native.nvim` - Native FZF sorter for improved performance
- `nvim-treesitter` - Syntax highlighting in previews
- `snacks.nvim` - Image preview support (automatically renders images in preview pane)

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

**Features:**
- **Fast fuzzy finding** - Native FZF algorithm for optimal performance
- **File preview** - Live preview of file contents with syntax highlighting
- **Smart search** - Respects `.gitignore` and follows symlinks
- **Horizontal layout** - 55% preview width for optimal viewing

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

### ⚙️ Compiler (Native :make)

**Native C/C++ compiler** using Neovim's `:make` and quickfix. No picker UI; keymaps only.

**Function Keys (C/C++):**

| Key | Action | Description |
|-----|--------|-------------|
| `F5` | Build | Compile current C/C++ file to `bin/program` |
| `F6` | Build & Run | Compile and run if successful |
| `F7` | Toggle Results | Show/hide compilation errors (quickfix) |
| `F8` | Run Only | Run last compiled program |

**Leader alternatives:** `<leader>mb` (build), `<leader>mr` (build & run), `<leader>mT` (toggle results), `<leader>mx` (run). Same as F5–F8; `m` prefix avoids conflict with crates/LeetCode. (`mt` = Mini Map toggle.)

**How it works:**
1. Open any `.c` or `.cpp` file
2. Press `F5` to compile (creates `bin/program`)
3. Press `F6` to compile and run automatically
4. If compilation fails, press `F7` to view errors
5. Navigate errors with `:cnext` and `:cprev`

**Compilation flags:**
- C files: `gcc -Wall -g <file> -o bin/program`
- C++ files: `g++ -Wall -g <file> -o bin/program`

### 🎨 Themes

| Key | Theme | Description |
|-----|-------|-------------|
| `<leader>tH` | Themery | Open Themery theme picker (`tH` avoids conflict with terminal horizontal) |

### 💻 Terminal (ToggleTerm) - LazyVim Style

**ToggleTerm** provides LazyVim-style integrated terminal management with multiple display modes, specialized terminals, and professional UI.

#### **Quick Terminal Access**

| Key | Mode | Description |
|-----|------|-------------|
| `<C-\>` | Normal/Terminal | Quick toggle terminal (80% × 80% floating) |
| `<Esc><Esc>` | Terminal | Exit terminal mode |

#### **Direction-Specific Terminals**

| Key | Description |
|-----|-------------|
| `<leader>tf` | Toggle floating terminal (80% × 80%) |
| `<leader>th` | Toggle horizontal terminal (bottom, 15 lines) |
| `<leader>tv` | Toggle vertical terminal (40% width) |

#### **Specialized Terminals**

| Key | Description | Tool |
|-----|-------------|------|
| `<leader>gg` | LazyGit - Full-screen git interface | lazygit |
| `<leader>tp` | Python REPL - Interactive Python shell | python3 |
| `<leader>tN` | Node REPL - Interactive Node.js shell | node (`tN`; `tn` = new tab) |
| `<leader>tm` | System Monitor - Resource monitoring | btop/htop |

#### **Terminal & Tab Management**

| Key | Description |
|-----|-------------|
| `<leader>t1`–`t4` | Quick access to terminals 1–4 |
| `<leader>tn` | New tab |
| `<leader>T1`–`T9` | Go to tab 1–9 |
| `<leader>ta` | Toggle all terminals |
| `<leader>ts` | Select terminal (or send selection in visual mode) |

#### **Terminal Navigation (Within Terminal Mode)**

| Key | Description |
|-----|-------------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to bottom window |
| `<C-k>` | Move to top window |
| `<C-l>` | Move to right window |
| `<C-w>` | Window command prefix |

#### **LazyVim Terminal Features**

- **Enhanced UI**: Larger, more immersive floating terminals with curved borders
- **Winbar Info**: Shows terminal ID in the window title bar
- **Specialized Terminals**: Pre-configured for LazyGit, Python REPL, Node REPL, and system monitoring
- **Smart Navigation**: Navigate between windows seamlessly while in terminal mode
- **Auto-insert Mode**: Automatically enters insert mode when terminal opens
- **Auto-exit Insert**: Automatically exits insert mode when leaving terminal buffer
- **Professional Styling**: 
  - Floating: 80% width × 80% height with curved borders
  - Horizontal: 15 lines at bottom
  - Vertical: 40% of screen width
  - Proper highlight groups for consistent theming
- **Visual Selection to Terminal**: Send selected text directly to terminal
- **Clean UI**: Line numbers, signs, folds, and spell checker disabled in terminal buffers
- **Auto-cleanup**: Terminals are automatically closed on Neovim exit to prevent job warnings
- **Multiple Terminal Management**: Easily switch between multiple terminal instances

### 📝 Markdown Preview (markdown-preview.nvim)

**Features:**
- **Live Preview** - Real-time markdown preview in your browser
- **Synchronized Scrolling** - Preview scrolls with your markdown file
- **Dark/Light Theme** - Automatically matches system preferences or set manually
- **Rich Features** - Supports KaTeX math, PlantUML diagrams, Mermaid charts, and more
- **Auto-close** - Automatically closes preview when switching buffers

**Markdown Preview Keymaps:**

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `<leader>mp`   | Normal | Toggle markdown preview                    |

**How it works:**
- Open a markdown file (`.md`)
- Press `<leader>mp` to toggle the preview
- The preview opens in your default browser
- Changes in your markdown file are automatically reflected in the preview
- The preview scrolls in sync with your cursor position

**Supported Features:**
- **Math** - KaTeX for mathematical expressions
- **Diagrams** - PlantUML, Mermaid, flowchart, sequence diagrams
- **Tables** - Full markdown table support
- **Code Blocks** - Syntax highlighting for code blocks
- **Task Lists** - Checkbox lists
- **And more** - Full markdown-it feature set

**Note:** Requires Node.js to be installed. The plugin will automatically build on first install.

### �️ Image Preview (snacks.nvim)

**Snacks.nvim Image Viewer** provides powerful image preview capabilities using the Kitty Graphics Protocol.

**Features:**
- **Wide Format Support** - View images in formats: `png`, `jpg`, `jpeg`, `gif`, `bmp`, `webp`, `tiff`, `heic`, `avif`
- **Video Support** - Preview videos: `mp4`, `mov`, `avi`, `mkv`, `webm`
- **PDF Viewing** - View PDF documents directly in Neovim
- **Inline Rendering** - Images rendered inline in supported document formats: `markdown`, `html`, `norg`, `tsx`, `javascript`, `css`, `vue`, `svelte`, `scss`, `latex`, `typst`
- **Math Expressions** - LaTeX math expressions in `markdown` and `latex` documents
- **Auto-display** - Automatically shows images when opening image files

**Terminal Support:**
- ✅ Kitty
- ✅ Ghostty
- ✅ WezTerm (limited support, inline rendering not supported)
- ⚠️ Tmux (requires `allow-passthrough=on`)

**Keymaps:**

| Key | Description |
|-----|-------------|
| `<leader>is` | Show image at cursor position |

**Usage:**
- Open an image file - it will be displayed automatically
- In markdown/HTML: place cursor on image link and press `<leader>is` to preview
- Math expressions in markdown are automatically rendered inline
- Images are cached for better performance

**Requirements:**
- Terminal with Kitty Graphics Protocol support (Kitty, Ghostty, or WezTerm)
- [ImageMagick](https://imagemagick.org/) for format conversion
- Run `:checkhealth snacks` to verify setup

### �📏 Indent Highlighting (snacks.indent)

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
| `<C-i>` | `vim.lsp.buf.definition` | Go to definition |
| `<leader>gd` | `vim.lsp.buf.definition` | Go to definition (alternative) |
| `<leader>gr` | `vim.lsp.buf.references` | Find all references |
| `<leader>ca` | `vim.lsp.buf.code_action` | Show code actions |
| `<leader>d` | `vim.diagnostic.open_float` | Show diagnostics at cursor |

### 📦 Utils (Boilerplates & Snippets)

Boilerplates replace the whole buffer; snippets insert at cursor. Templates live in `lua/utils/boilerplates/` and `lua/utils/snippets/`. Keymaps load via `config.keymaps.utils`.

#### Boilerplates (full buffer)

| Key | Description |
|-----|-------------|
| `<leader>blp` | C++ competitive programming template |
| `<leader>blc` | C competitive programming template |
| `<leader>got` | Go competitive programming template |
| `<leader>rst` | Rust competitive programming template |
| `<leader>plc` | LeetCode C++ template |
| `<leader>cse` | CSES C++ template |

#### Snippets (insert at cursor)

| Key | Description |
|-----|-------------|
| `<leader>pov` | Print vector (C++) |
| `<leader>mod` | Mod inverse (C++) |
| `<leader>dio` | Diophantine equation (C++) |
| `<leader>sfor` | For loop (C / C++ / Rust; filetype-aware) |
| `<leader>swh` | While loop (C / C++ / Rust; filetype-aware) |
| `<leader>sdo` | Do-while loop (C / C++; filetype-aware) |
| `<leader>srange` | Range-based for (C++) or for-in (Rust); filetype-aware |

#### Commands (insert at cursor)

| Command | Description |
|---------|-------------|
| `:Sieve` | Sieve / SPF (primes) snippet |
| `:PBDS` | Policy-based data structures (C++) |
| `:Pow` | Pow (exponent mod M) snippet |

### 🦀 Rust Development

This configuration includes a comprehensive Rust development setup with specialized plugins for enhanced development experience.

#### **ferris.nvim** - Rust Analyzer Extensions

Powerful Rust analyzer extensions for viewing macros, HIR/MIR, memory layout, and more.

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>rm` | `FerrisExpandMacro` | Expand macro under cursor |
| `<leader>rj` | `FerrisJoinLines` | Join lines (normal & visual mode) |
| `<leader>rh` | `FerrisViewHIR` | View HIR representation |
| `<leader>rl` | `FerrisViewMIR` | View MIR representation |
| `<leader>rs` | `FerrisViewMemoryLayout` | Show memory layout of struct/enum |
| `<leader>rt` | `FerrisViewSyntaxTree` | Display syntax tree (normal & visual) |
| `<leader>ri` | `FerrisViewItemTree` | Show item tree of current document |
| `<leader>rc` | `FerrisOpenCargoToml` | Open project's Cargo.toml |
| `<leader>rp` | `FerrisOpenParentModule` | Open parent module file |
| `<leader>rd` | `FerrisOpenDocumentation` | Open documentation for symbol |
| `<leader>rw` | `FerrisReloadWorkspace` | Reload project workspace |
| `<leader>rb` | `FerrisRebuildMacros` | Rebuild procedural macros |

#### **crates.nvim** - Cargo Dependency Manager

Interactive Cargo.toml management with version checking, dependency exploration, and one-click updates.

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ct` | `crates.toggle` | Toggle crates info (virtual text) |
| `<leader>cr` | `crates.reload` | Reload crates data |
| `<leader>cv` | `crates.show_versions_popup` | Show available versions |
| `<leader>cf` | `crates.show_features_popup` | Show available features |
| `<leader>cd` | `crates.show_dependencies_popup` | Show crate dependencies |
| `<leader>cu` | `crates.update_crate` | Update crate on current line |
| `<leader>cu` (visual) | `crates.update_crates` | Update selected crates |
| `<leader>cpa` | `crates.update_all_crates` | Update all crates in buffer |
| `<leader>cU` | `crates.upgrade_crate` | Upgrade crate to latest |
| `<leader>cU` (visual) | `crates.upgrade_crates` | Upgrade selected crates |
| `<leader>cA` | `crates.upgrade_all_crates` | Upgrade all crates to latest |
| `<leader>cx` | `crates.expand_plain_crate_to_inline_table` | Expand crate to inline table |
| `<leader>cX` | `crates.extract_crate_into_table` | Extract crate into table format |
| `<leader>cH` | `crates.open_homepage` | Open crate's homepage |
| `<leader>cR` | `crates.open_repository` | Open crate's repository |
| `<leader>cD` | `crates.open_documentation` | Open crate's documentation |
| `<leader>cC` | `crates.open_crates_io` | Open on crates.io |
| `<leader>cL` | `crates.open_lib_rs` | Open on lib.rs |

**Features:**
- Smart version handling with semantic versioning
- Feature popup with full feature list
- Dependency visualization
- One-click update/upgrade to latest versions
- Automatic Cargo.toml formatting
- LSP completions and hover support

#### **cord.nvim** - Discord Rich Presence

Display your current Neovim activity on Discord with workspace and file information.

**Features:**
- Real-time activity broadcast to Discord
- Shows current file being edited
- Displays workspace name
- Custom button linking to your GitHub repository
- Idle detection with customizable timeout
- Markdown rendering in Discord profile

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

**Bufferline** provides a modern tabline/bufferline for managing open buffers with LazyVim-style functionality.

**Navigation:**

| Key | Command | Description |
|-----|---------|-------------|
| `<S-h>` or `[b` | `:BufferLineCyclePrev` | Navigate to previous buffer |
| `<S-l>` or `]b` | `:BufferLineCycleNext` | Navigate to next buffer |

**Buffer Management:**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>bd` | `:bdelete` | Delete current buffer |
| `<leader>bp` | `:BufferLineTogglePin` | Pin/unpin current buffer |
| `<leader>bP` | `:BufferLineGroupClose ungrouped` | Delete all non-pinned buffers |
| `<leader>bo` | `:BufferLineCloseOthers` | Close all other buffers |
| `<leader>br` | `:BufferLineCloseRight` | Close all buffers to the right |
| `<leader>bl` | `:BufferLineCloseLeft` | Close all buffers to the left |
| `<leader>bm` | `:BufferLineMoveNext` | Move buffer to the right |
| `<leader>bM` | `:BufferLineMovePrev` | Move buffer to the left |

**Features:**
- Always visible tabline (even with single file)
- LSP diagnostics integration (shows errors/warnings)
- Git status icons
- File type icons
- Pin important buffers
- Mouse support (click to switch, right-click to close)
- Hover tooltips

### ⌨️ Keymap Quick Reference (All `<leader>` Mappings)

**Navigation & Files:**
- `ff` - Find files | `fg` - Live grep | `fb` - Buffers | `fh` - Help
- `fs` - Grep string | `fr` - Recent files | `fR` - Recent files (cwd) | `fd` - Diagnostics
- `e` - Toggle explorer | `ef` - Find file in explorer

**Buffers:**
- `<S-h>` / `[b` - Previous buffer | `<S-l>` / `]b` - Next buffer
- `bd` - Delete buffer | `bp` - Pin/unpin buffer | `bP` - Delete non-pinned
- `bo` - Close others | `br` - Close right | `bl` - Close left
- `bm` - Move buffer right | `bM` - Move buffer left

**Themes & UI:**
- `tH` - Themery picker | `mt/mo/mc/mf/mr/ms` - Mini map controls

**Terminal/Tabs:**
- `<C-\>` - Toggle default terminal (float) | `th` - Horizontal | `tv` - Vertical | `tf` - Float
- `tn` - New tab | `tN` - Node REPL | `t1`–`t4` - Terminals 1–4 | `T1`–`T9` - Go to tab

**Rust Development:** *(Only in Rust files)*
- `rm` - Expand macro | `rh` - View HIR | `rl` - View MIR | `rs` - Memory layout
- `rt` - Syntax tree | `ri` - Item tree | `rc` - Open Cargo.toml | `rp` - Parent module
- `rd` - Documentation | `rw` - Reload workspace | `rb` - Rebuild macros | `rj` - Join lines
- `ct` - Toggle crates | `cr` - Reload crates | `cv` - Versions | `cf` - Features | `cd` - Dependencies
- `cu/cU` - Update/upgrade crate | `cpa/cA` - Update/upgrade all | `cx/cX` - Expand/extract
- `cH` - Homepage | `cR` - Repository | `cD` - Docs | `cC` - Crates.io | `cL` - Lib.rs

**LeetCode:** `L` - Open | `Lr` - Run | `Ls` - Submit | `Ll` - List | `Ld` - Daily | `LR` - Reset

**Compiler:** `mb` - Build | `mr` - Build & run | `mT` - Toggle results | `mx` - Run (F5–F8)

**Utils (Boilerplates & Snippets):**
- Boilerplates: `blp` - C++ | `blc` - C | `got` - Go | `rst` - Rust | `plc` - LeetCode C++ | `cse` - CSES C++
- Snippets: `pov` - Print vector | `mod` - Mod inverse | `dio` - Diophantine
- Loops (filetype-aware): `sfor` - For | `swh` - While | `sdo` - Do-while (C/C++) | `srange` - Range-for (C++) / for-in (Rust)
- Commands: `:Sieve` | `:PBDS` | `:Pow`

**Plugins & Tools:**
- `ll` - Lazy menu | `ls` - Lazy sync | `lu` - Lazy update
- `li` - Lazy install | `lc` - Lazy check | `lx` - Lazy clean
- `M` - Mason packages

**Git Operations:**
- `]c` / `[c` - Navigate diff hunks | `hs` - Stage hunk | `hr` - Reset hunk | `gb` - Full buffer blame

**Code & Diagnostics:**
- `gd` - Definition | `gr` - References | `ca` - Code action | `d` - Show diagnostics
- `fm` - Format file/range | `xx` - Trouble diagnostics | `xX` - Buffer diagnostics

**Buffers:**
- `bp` - Pin buffer | `bP` - Delete unpinned | `bo` - Delete others
- `br` - Delete right | `bl` - Delete left

**Oil (File Editor):**
- `o` - Oil explorer | `O` - Oil floating

### ✨ Code Completion (nvim-cmp)

| Key / CMD       | Mode | Purpose                                   |
|-----------------|------|-------------------------------------------|
| `<C-n>`         | Insert | Select next completion item               |
| `<C-p>`         | Insert | Select previous completion item           |
| `<C-n>`         | Insert | Select next completion item               |
| `<C-p>`         | Insert | Select previous completion item           |
| `<C-y>`         | Insert | Confirm completion selection              |
| `<Tab>`         | Insert | Expand snippet                            |
| `<S-Tab>`       | Insert | Previous snippet node                     |

**Features:**
- **Auto-completion** - Intelligent completion menu appears as you type
- **LSP Integration** - Full language server protocol support
- **Snippet Support** - LuaSnip integration for code snippets
- **Multiple Sources** - LSP, LuaSnip, buffer, and path completions
- **Bordered UI** - Clean bordered completion and documentation windows
- **Smart Selection** - Auto-select first item, manual navigation available

**Configuration:**
- **Documentation Delay:** 500ms (auto-shows after hovering completion item)
- **Menu Auto-show:** Enabled (completion menu appears automatically)
- **Signature Help:** Enabled for function parameters
- **Menu Layout:** Kind icons, labels, descriptions, and kind columns

### 🩺 Diagnostics & Troubleshooting (Trouble.nvim)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `<leader>xx`    | Toggle Diagnostics (all)                  |
| `<leader>xX`    | Toggle Buffer Diagnostics                 |
| `<leader>cs`    | Toggle Symbols (Trouble)                  |
| `<leader>cl`    | Toggle LSP Definitions/References (Trouble) |
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

### 🏷️ Auto Tag (nvim-ts-autotag)

**Features:**
- **Auto-close tags** - Automatically closes HTML/JSX/TSX tags when typing `>`
- **Auto-rename tags** - Automatically renames paired tags (e.g., `<div></div>` → `<span></span>`)
- **Treesitter-powered** - Uses treesitter for accurate tag detection
- **Multi-language support** - Works with HTML, JSX, TSX, Vue, Svelte, and more

**How it works:**
- Type `<div>` and press `>` → Automatically becomes `<div></div>`
- Change `<div></div>` to `<span></span>` by typing `ciwspan<esc>` → Both tags update
- Works automatically in supported filetypes - no keymaps needed!

**Supported Filetypes:**
- HTML, JavaScript, JSX, TypeScript, TSX
- Vue, Svelte, Astro
- Markdown, PHP, XML
- Handlebars, Liquid, Twig, Glimmer, Rescript

**Configuration:**
- **Auto-close:** Enabled (closes tags on `>`)
- **Auto-rename:** Enabled (renames paired tags)
- **Close on slash:** Disabled (doesn't auto-close on trailing `</`)

**Note:** Requires treesitter parsers to be installed for the filetype. The plugin automatically works once treesitter is set up.

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

###  Dashboard (dashboard-nvim)

| Key / CMD       | Purpose                                   |
|-----------------|-------------------------------------------|
| `u`             | 🔄 Update plugins (`:Lazy update`)        |
| `f`             | 🔍 Find file using Telescope (`<leader>ff`) |
| `n`             | ➕ Create a new empty buffer              |
| `r`             | 📂 Open recent files (Telescope)          |
| `g`             | 🔍 Find text (`<leader>fg`)               |
| `c`             | ⚙️ Open Neovim config files               |
| `M`             | 📦 Open Mason menu (`<leader>M`)           |
| `l`             | ⚡ Open Lazy plugin manager (`<leader>ll`) |
| `q`             | 🚪 Quit Neovim (`<leader>q`)              |

**Features:**
- **Modern Design** - Clean, hyper-themed dashboard with shortcuts
- **Plugin Updates** - Direct access to update plugins
- **Quick Actions** - Fast access to common Neovim operations
- **Theme Support** - Adapts to your current colorscheme

### Plugin Shortcuts
- `:Dashboard` → Open dashboard
  - `:Lazy` → Open Lazy plugin manager
  - `:Lazy update` → Update all installed plugins
  - `:Mason` → Open Mason package manager
  - `:Telescope find_files` → Search files
  - `:Telescope oldfiles` → Open recent files

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
- Uses Neovim 0.11+ native LSP API with Mason for tool installation.
- Enhanced with diagnostic signs, hover on cursor, and better UI.
- Configured LSPs: `lua_ls`, `ts_ls`, `rust_analyzer`, `pylsp`, `clangd`, `gopls`, `tailwindcss`, `phpactor`, `dartls`, `ocamllsp`, `ruby-lsp`, `zls`, `sourcekit`.
- Integrated with **nvim-cmp** for intelligent LSP completion.
- Auto-formatting via conform.nvim with LSP fallback.

### 👁️ Numb.nvim (Line Peeking)

**numb.nvim** peeks buffer lines when you enter `:{number}` commands, making it easy to see where you're jumping to.

#### **Features**
- **Visual Preview** - See the target line before jumping
- **Centered Peeking** - Peeked line is centered in the window
- **Non-Intrusive** - Only activates when typing line numbers in command mode
- **Smart Display** - Shows line numbers and cursorline while peeking

#### **Usage**
Simply type `:{number}` in command mode (e.g., `:42`) and the plugin will:
1. Show a preview of that line
2. Center it in the window
3. Highlight it with cursorline
4. Display line numbers for context

**Example:**
- Type `:25` to see line 25 before jumping
- Type `:100` to preview line 100
- Works with any number command like `:42d` (delete line 42)

**Configuration:**
- `show_numbers = true` - Show line numbers while peeking
- `show_cursorline = true` - Highlight the peeked line
- `hide_relativenumbers = true` - Hide relative numbers during peek
- `number_only = false` - Peek when command starts with number (e.g., `:42d`)
- `centered_peeking = true` - Center the peeked line in window

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
- **nvim-cmp** - Powerful completion engine with LSP integration
- **LSP Integration** - Full LSP completion support
- **Snippet Support** - Integrated with LuaSnip
- **Multiple Sources** - LSP, snippets, buffer, and path completions

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

#### Performance
- Lazy loading for better startup time
- Disabled unused rtp plugins
- Plugin update checker (runs hourly)
- Modern completion engine (blink.cmp) with auto-suggestions  

---

## 📌 Notes

* Built & tested on **Linux** (compatible with Windows/macOS).
* **Enhanced Configuration:** Now includes completion, diagnostics, formatting, Git integration, and modern LSP setup.
* **Performance Optimized:** Lazy loading, optimized settings, stable completion engine.
* **Well Organized:** Proper directory structure following Neovim best practices.
* **Telescope Integration:** Streamlined configuration with optimal performance.
* **Theme Integration:** Dashboard and UI adapt to your current colorscheme.
* **Auto-Formatting:** Configured for multiple languages with LSP fallback.
* **Modern LSP:** Using Neovim 0.11+ native API with Mason for tool management.
* **Completion:** nvim-cmp with LSP and snippet support.

## 🚀 Getting Started

1. **Install dependencies:** Mason will handle most tools, but ensure you have:
    - Node.js (for some LSPs and tools)
    - Language toolchains (Rust, Go, Python, etc.) for respective LSPs

2. **First launch:** Run `:Lazy sync` to install all plugins.

3. **Mason Setup:** Run `:Mason` to install LSP servers and tools. The config will auto-install essential ones.

4. **LSP Setup:** LSP servers are configured automatically. Use `<C-i>` for definition, `K` for hover.

5. **Completion:** nvim-cmp provides intelligent auto-completion. Start typing and the menu appears automatically. Use `<C-n>`/`<C-p>` to navigate items, `<C-y>` to confirm selection.

6. **Diagnostics:** Use `<leader>xx` to open Trouble diagnostics panel, or `<leader>d` for inline diagnostics.

7. **Formatting:** Code auto-formats on save via conform.nvim. Use `<leader>fm` to format manually.

## 📚 Keymap Reference Summary

- **General:** `<Esc>` (clear highlights), `<C-h/j/k/l>` (window nav), `<C-s>` (save), `<leader>q` (quit)
- **Telescope:** `<C-p>` (files), `<leader>ff/fr/fR/fg/fs/fb/fh/fd` (find/search)
- **File Explorer:** `<leader>e` (toggle), `<leader>ef` (find file)
- **LSP:** `K` (hover), `<C-i>` (definition), `<leader>gr` (references), `<leader>ca` (code action), `<leader>d` (diagnostics)
- **Completion:** `<C-n/p>` (navigate), `<C-y>` (confirm), `<Tab>/<S-Tab>` (snippets)
- **Diagnostics:** `<leader>xx/xX` (trouble), `[d`/`]d` (navigate), `<leader>cs/cl` (Trouble symbols/LSP)
- **Formatting:** `<leader>fm` (format), auto-format on save
- **Git:** `]c/[c` (hunks), `<leader>hs/hr/hS/hR` (stage/reset), `<leader>hp` (preview), `<leader>hb` (blame)
- **Terminal:** `<C-\>` (default), `<leader>th/tv/tf` (horizontal/vertical/float)
- **Themes:** `<leader>tH` (themery)
- **Mini Map:** `<leader>mt/mo/mc/mf/mr/ms` (map controls)
- **Bufferline:** `<S-h/l>` (prev/next), `<leader>bp/bP/bo/br/bl` (buffer ops)
- **Trouble:** `<leader>xx/xX/xL/xQ` (diagnostics lists)
- **Lazy:** `<leader>ll/ls/lu/li/lc/lx` (plugin management)
- **Mason:** `<leader>M` (package manager)
- **Utils:** Boilerplates `blp/blc/got/rst/plc/cse` | Snippets `pov/mod/dio` | Loops `sfor/swh/sdo/srange` | Commands `:Sieve` `:PBDS` `:Pow`

