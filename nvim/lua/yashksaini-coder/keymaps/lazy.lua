-- Custom Keymaps for Lazy plugin manager
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open Lazy menu" })
vim.keymap.set("n", "<leader>ls", "<cmd>Lazy sync<CR>", { desc = "Sync plugins" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<CR>", { desc = "Update plugins" })
vim.keymap.set("n", "<leader>li", "<cmd>Lazy install<CR>", { desc = "Install plugins" })
vim.keymap.set("n", "<leader>lc", "<cmd>Lazy check<CR>", { desc = "Check plugin health" })
vim.keymap.set("n", "<leader>lx", "<cmd>Lazy clean<CR>", { desc = "Remove unused plugins" })

