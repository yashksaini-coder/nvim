-- Telescope Keymaps

-- File searching
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fF", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", { desc = "Find all files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fG", "<cmd>Telescope live_grep_args<CR>", { desc = "Live grep with args" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "Grep string" })
vim.keymap.set("n", "<leader>fx", "<cmd>Telescope symbols<CR>", { desc = "Symbols" })

-- Buffer and navigation
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Commands" })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme<CR>", { desc = "Colorschemes" })

-- LSP integration (Telescope)
vim.keymap.set("n", "<leader>fl", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementations" })
vim.keymap.set("n", "<leader>fy", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP type definitions" })
vim.keymap.set("n", "<leader>fa", "<cmd>Telescope lsp_diagnostics<CR>", { desc = "LSP diagnostics" })

-- Quick access
vim.keymap.set("n", "<leader>f.", "<cmd>Telescope find_files cwd=%:p:h<CR>", { desc = "Find files in current dir" })
vim.keymap.set("n", "<leader>f/", "<cmd>Telescope live_grep cwd=%:p:h<CR>", { desc = "Live grep in current dir" })

-- Resume last search
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Resume last search" })

-- Git integration
vim.keymap.set("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
vim.keymap.set("n", "<leader>fgb", "<cmd>Telescope git_bcommits<CR>", { desc = "Git buffer commits" })
vim.keymap.set("n", "<leader>fgr", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })

