-- Disable netrw (neo-tree replaces it)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.clipboard = "unnamedplus"

-- If launched with a single directory arg (e.g. `nvim .`), cd there, clear
-- the arg-list and wipe the auto-created directory buffer. This makes
-- dashboard-nvim's own UIEnter check (`argc() == 0` and empty buf name)
-- pass, so the dashboard auto-shows. A follow-up UIEnter autocmd in
-- config/autocmds.lua opens neo-tree on the side.
if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
	vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.argv(0)))
	vim.cmd("silent! %argdelete")
	vim.cmd("silent! bwipeout!")
	vim.g._nvim_dir_open = true
end

require("config.options")
require("config.lazy")
require("config.nvim-diagnostics")
require("config.keymaps")
require("config.autocmds")
