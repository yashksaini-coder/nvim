-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlights",
})

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {
  desc = "Move to left window",
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
  desc = "Move to lower window",
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
  desc = "Move to upper window",
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
  desc = "Move to right window",
})

-- Cellular Automation animations
vim.keymap.set("n", "<leader>ar", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set("n", "<leader>ag", "<cmd>CellularAutomaton game_of_life<CR>")

-- Autopairs Keymap
vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", {
  noremap = true,
  silent = true,
  desc = "Toggle comment",
})

-- Save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", {
  desc = "Save file",
})

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", {
  desc = "Quit all",
})

-- Better buffer delete
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", {
  desc = "Delete buffer",
})

-- Man pages (:Man is built-in)
vim.keymap.set("n", "<leader>km", function()
  local word = vim.fn.input("Man page: ")
  if word ~= "" then
    vim.cmd("Man " .. word)
  end
end, { desc = "Open man page" })

vim.keymap.set("n", "<leader>kw", function()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    vim.cmd("Man " .. word)
  end
end, { desc = "Man page for word under cursor" })

-- Window resize
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
