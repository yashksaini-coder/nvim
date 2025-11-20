vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- Edit Neovim configuration
vim.keymap.set("n", "<space>NC", function()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath("config"),
    prompt_title = "Neovim Config Files",
    hidden = true,
}
end, { desc = "Edit Neovim Config" })


-- Custom Keymaps for Lazy plugin manager
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open Lazy menu" })
vim.keymap.set("n", "<leader>ls", "<cmd>Lazy sync<CR>", { desc = "Sync plugins" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<CR>", { desc = "Update plugins" })
vim.keymap.set("n", "<leader>li", "<cmd>Lazy install<CR>", { desc = "Install plugins" })
vim.keymap.set("n", "<leader>lc", "<cmd>Lazy check<CR>", { desc = "Check plugin health" })
vim.keymap.set("n", "<leader>lx", "<cmd>Lazy clean<CR>", { desc = "Remove unused plugins" })

-- ShowKeys Toggle keymap
vim.keymap.set("n", "<leader>sk", "<cmd>ShowkeysToggle<CR>", { desc = "Toggle ShowKeys" })

-- Telescope Keymaps

-- File searching
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fF", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", { desc = "Find all files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fG", "<cmd>Telescope live_grep_args<CR>", { desc = "Live grep with args" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "Grep string" })

-- Buffer and navigation
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Commands" })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme<CR>", { desc = "Colorschemes" })

-- LSP integration
vim.keymap.set("n", "<leader>fl", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementations" })
vim.keymap.set("n", "<leader>fy", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP type definitions" })
vim.keymap.set("n", "<leader>fa", "<cmd>Telescope lsp_diagnostics<CR>", { desc = "LSP diagnostics" })

-- Extensions
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope symbols<CR>", { desc = "Symbols" })

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
