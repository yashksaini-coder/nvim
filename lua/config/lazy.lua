-- Bootstra lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.lazyvim_check_order = false

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.themes" },
		{ import = "plugins.mini" },
	},
	-- NOTE: `defaults = { lazy = true }` is deliberately absent. lazy.nvim resolves
	-- an unset `lazy` as `dep or defaults.lazy or event/keys/ft/cmd`, and none of the
	-- colorscheme specs in plugins/themes/ declares a handler — that one line would
	-- flip all six lazy, including the gruvbox spec whose config() sets the startup
	-- colorscheme. Every non-theme spec carries its own handler instead.
	checker = { enabled = false }, -- Disable auto-update checks (network calls on every startup)
	-- Install missing plugins on startup and restore to lockfile versions.
	-- CI updates lazy-lock.json daily — after git pull, this keeps plugins in sync automatically.
	install = { missing = true },
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	performance = {
		rtp = {
			-- Matched by FILENAME against $VIMRUNTIME/plugin/, which holds 14 files on
			-- Neovim 0.12 — most of avhi's 25-entry list are Vim-era names that match
			-- nothing. Only entries with no feature this config uses are listed.
			--
			-- Deliberately NOT disabled: man (config/options.lua sets man_default_sects
			-- and <leader>km/<leader>kw open :Man), matchit (`%` over if/end and HTML
			-- tags), matchparen, editorconfig, osc52 (clipboard over SSH), shada, net.
			disabled_plugins = {
				"gzip",
				"netrwPlugin", -- neo-tree replaces it; init.lua also sets loaded_netrw
				"rplugin", -- no python3/node remote plugins here; remove first if one breaks
				"spellfile",
				"tarPlugin",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
