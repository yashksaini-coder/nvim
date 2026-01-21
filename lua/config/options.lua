-----------------------------------------------------------
-- General
-----------------------------------------------------------

-- Number of spaces a tab represents
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Use appropriate when using indent command
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

-- Indenting correctly after { etc
vim.opt.smartindent = true

-- Copy indent from current line when starting new line
vim.opt.autoindent = true

-- Prevent line wrapping
vim.opt.breakindent = true

-- Disable text wrap
vim.opt.wrap = false

-- Speeds up plugin wait time
vim.opt.updatetime = 300

-- Persistant undo file history
vim.opt.undofile = true
-----------------------------------------------------------
-- UI Config
-----------------------------------------------------------
-- Enable line numbers
vim.opt.nu = true

-- Enable relative line numbers
vim.opt.rnu = true

-- Disable showing the mode below the statusline
vim.opt.showmode = false

-- Better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }
vim.opt.pumheight = 10 -- Limit popup menu height

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Enable blinking block cursor in all modes
vim.o.guicursor = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 8

-- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable confirmation dialogs for unsaved buffers
vim.opt.confirm = false

-- Highlight yank
vim.api.nvim_create_autocmd("textyankpost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-----------------------------------------------------------
-- Search Config
-----------------------------------------------------------
-- Enable highlighting search in progress
vim.opt.incsearch = true

-- Ignore case for searches
vim.opt.ignorecase = true
vim.opt.smartcase = true

-----------------------------------------------------------
-- Background Options
-----------------------------------------------------------
-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

-----------------------------------------------------------
-- Diagnostic Options
-----------------------------------------------------------
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
})
