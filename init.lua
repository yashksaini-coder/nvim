-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.clipboard = "unnamedplus"

require("config.options")
require("config.lazy")
require("config.nvim-diagnostics")
require("config.keymaps")
require("config.autocmds")
