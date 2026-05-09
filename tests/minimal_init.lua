-- Minimal init for plenary.busted headless tests.
-- Mirrors enough of the runtimepath for the modules under test.
local config_dir = vim.fn.fnamemodify(vim.fn.expand("<sfile>"), ":p:h:h")
vim.opt.runtimepath:prepend(config_dir)

local plenary = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
if vim.fn.isdirectory(plenary) == 0 then
    vim.fn.system({
        "git", "clone", "--depth=1",
        "https://github.com/nvim-lua/plenary.nvim",
        plenary,
    })
end
vim.opt.runtimepath:prepend(plenary)
vim.cmd("runtime plugin/plenary.vim")
