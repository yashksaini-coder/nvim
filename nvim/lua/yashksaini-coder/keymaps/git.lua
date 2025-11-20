-- Git keymaps (using gitsigns and telescope)
-- Git signs keymaps are set up in the gitsigns plugin config
-- These are additional git-related keymaps

-- Git status
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git Status" })

-- Git commits
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git Commits" })

-- Git branches
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git Branches" })

