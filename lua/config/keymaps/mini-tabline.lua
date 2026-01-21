-- Keymaps for mini-tabline plugin

-- Tab navigation
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Tab switching (these are default Neovim, but adding for completeness)
vim.keymap.set("n", "gt", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "gT", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Tab movement
vim.keymap.set("n", "<leader>tmr", "<cmd>tabmove +1<cr>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>tml", "<cmd>tabmove -1<cr>", { desc = "Move tab left" })

-- Go to specific tab (1-9)
for i = 1, 9 do
	vim.keymap.set("n", "<leader>t" .. i, "<cmd>tabnext " .. i .. "<cr>", { desc = "Go to tab " .. i })
end