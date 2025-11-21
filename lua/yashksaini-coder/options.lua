-- Core UI & Editing Behavior
local opt = vim.opt

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = -1 -- logical shiftwidth
opt.expandtab = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Colors
opt.termguicolors = true

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Window splitting
opt.splitbelow = true
opt.splitright = true

-- UI
opt.showmode = false -- don't show mode (handled by lualine)
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes" -- always show sign column (for LSP diagnostics)
opt.cursorline = true -- highlight current line
opt.cursorcolumn = false

-- Wildmenu (command completion)
opt.wildmode = "longest:full,full"
opt.wildmenu = true

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Timeout
opt.timeout = true
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete
opt.updatetime = 250 -- faster completion (default 4000ms is quite slow)
opt.ttimeoutlen = 10 -- key code delays

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Short messages
opt.shortmess:append("c") -- don't give |ins-completion-menu| messages

-- Performance
opt.lazyredraw = false -- don't lazy redraw (can cause visual glitches)
opt.synmaxcol = 240 -- max syntax columns

-- Mouse
opt.mouse = "a" -- enable mouse in all modes

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Folding
opt.foldmethod = "manual"
opt.foldlevel = 99

-- List chars (for showing whitespace if needed)
opt.listchars = "tab:→ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»"

-- Status line
opt.laststatus = 3 -- global statusline

-- Command line
opt.cmdheight = 1

-- Window title
opt.title = true

-- Line break
opt.linebreak = true -- wrap lines at word boundaries when wrap is enabled
opt.breakindent = true -- indent wrapped lines

-- Conceal
opt.conceallevel = 0 -- don't conceal anything

-- Spelling
opt.spelllang = "en_us"
opt.spell = false -- disabled by default, enabled per filetype in autocmds

