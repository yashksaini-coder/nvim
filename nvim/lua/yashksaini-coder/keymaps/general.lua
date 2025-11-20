-- General keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Clear search highlights
vim.keymap.set("n", "<leader><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- File explorer
vim.keymap.set("n", "<leader>ex", "<cmd>Ex<CR>", { desc = "File Explorer" })

-- Edit Neovim configuration
vim.keymap.set("n", "<leader>nc", function()
  local ok, telescope = pcall(require, "telescope.builtin")
  if ok then
    telescope.find_files({
      cwd = vim.fn.stdpath("config"),
      prompt_title = "Neovim Config Files",
      hidden = true,
    })
  else
    vim.notify("Telescope not loaded yet", vim.log.levels.WARN)
  end
end, { desc = "Edit Neovim Config" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<Up>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<Down>", "<cmd>resize +2<CR>", { desc = "Increase window height" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up and down
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ShowKeys Toggle keymap
vim.keymap.set("n", "<leader>sk", "<cmd>ShowkeysToggle<CR>", { desc = "Toggle ShowKeys" })

