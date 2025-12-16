-- ShowKeys Toggle keymap
vim.keymap.set("n", "<leader>sk", "<cmd>ShowkeysToggle<CR>", {
    desc = "Toggle ShowKeys"
})

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
    desc = "Clear search highlights"
})

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {
    desc = "Move to left window"
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
    desc = "Move to lower window"
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
    desc = "Move to upper window"
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
    desc = "Move to right window"
})

-- Autopairs Keymap
vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", {
    noremap = true,
    silent = true,
    desc = "Toggle comment"
})

-- Save file
vim.keymap.set({"i", "x", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", {
    desc = "Save file"
})

-- Quit                                                                                                             
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", {
    desc = "Quit all"
})
