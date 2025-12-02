-- Theme switcher keymaps

-- Osmium Theme
vim.keymap.set("n", "<leader>co", "<cmd>colorscheme osmium<CR>", { desc = "Theme: Osmium" })

-- Tokyonight Variants
vim.keymap.set("n", "<leader>ct", "<cmd>colorscheme tokyonight<CR>", { desc = "Theme: Tokyonight (Default)" })
vim.keymap.set("n", "<leader>cts", "<cmd>colorscheme tokyonight-storm<CR>", { desc = "Theme: Tokyonight Storm" })
vim.keymap.set("n", "<leader>ctn", "<cmd>colorscheme tokyonight-night<CR>", { desc = "Theme: Tokyonight Night" })
vim.keymap.set("n", "<leader>ctm", "<cmd>colorscheme tokyonight-moon<CR>", { desc = "Theme: Tokyonight Moon" })
vim.keymap.set("n", "<leader>ctd", "<cmd>colorscheme tokyonight-day<CR>", { desc = "Theme: Tokyonight Day" })

-- Chai Theme
vim.keymap.set("n", "<leader>cc", "<cmd>colorscheme chai<CR>", { desc =  "Theme: Shobhit's Chai" })

-- Themery
vim.keymap.set("n", "<leader>th", "<cmd>Themery<CR>", { desc = "Theme: Open Themery" })
