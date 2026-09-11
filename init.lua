-- Disable netrw (the snacks explorer replaces it)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- If launched with a single directory arg (e.g. `nvim .`), cd there and set
-- a flag. Do NOT wipe the arg buffer — snacks.dashboard renders into it
-- (its guard requires the first buffer to still be alive), and having
-- `explorer.enabled = true` in snacks bypasses the arg/name checks.
if vim.fn.argc(-1) == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
	vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.argv(0)))
	vim.g._nvim_dir_open = true
end

require("config.options")
require("config.lazy")
-- After config.lazy: that is where mapleader is set, and a <leader> mapping
-- resolves the leader when it is DEFINED, not when it is pressed.
require("config.clipboard")
require("config.templates")
require("config.nvim-diagnostics")
require("config.keymaps")
require("config.autocmds")
-- :KeymapExport (or `make site`) regenerates site/index.html from the live keymaps.
require("config.keymap-export")
