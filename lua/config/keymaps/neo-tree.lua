-- Toggle the file explorer
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })

-- Focus the file explorer (opens if closed, moves cursor to it)
vim.keymap.set("n", "<leader>eo", "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" })

-- Reveal the current file in the explorer
vim.keymap.set("n", "<leader>er", "<cmd>Neotree reveal<cr>", { desc = "Reveal File in Explorer" })

-- Show the filesystem (default view)
vim.keymap.set("n", "<leader>ef", "<cmd>Neotree filesystem reveal left<cr>", { desc = "Filesystem Explorer" })

-- Show the buffers list
vim.keymap.set("n", "<leader>eb", "<cmd>Neotree buffers reveal float<cr>", { desc = "Buffer Explorer" })

-- Show the git status
vim.keymap.set("n", "<leader>eg", "<cmd>Neotree git_status reveal float<cr>", { desc = "Git Status Explorer" })
