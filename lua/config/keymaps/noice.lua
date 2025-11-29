-- Noice keymaps
-- Prefix: <leader>n

-- Toggle Noice history
vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "Noice History" })

-- Show last message
vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<CR>", { desc = "Noice Last Message" })

-- Show errors
vim.keymap.set("n", "<leader>ne", "<cmd>Noice errors<CR>", { desc = "Noice Errors" })

-- Dismiss all notifications
vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<CR>", { desc = "Dismiss Notifications" })

-- Pick (Telescope integration if available, or native)
vim.keymap.set("n", "<leader>np", "<cmd>Noice pick<CR>", { desc = "Noice Picker" })

-- Stats
vim.keymap.set("n", "<leader>ns", "<cmd>Noice stats<CR>", { desc = "Noice Stats" })
