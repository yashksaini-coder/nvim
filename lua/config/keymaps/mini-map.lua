-- Keymaps for mini-tabline plugin
-- Note: <leader>t1-t4 reserved for terminal 1-4; use <leader>T1-T9 for go-to-tab.

-- Tab navigation
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Tab switching
vim.keymap.set("n", "gt", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "gT", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Tab movement — under `<leader>T` (tabs) instead of `<leader>tm` to avoid
-- shadowing `<leader>tm` (System Monitor) in terminal.lua.
vim.keymap.set("n", "<leader>Tmr", "<cmd>tabmove +1<cr>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>Tml", "<cmd>tabmove -1<cr>", { desc = "Move tab left" })

-- Go to specific tab (T1-T9 to avoid conflict with terminal t1-t4)
for i = 1, 9 do
	vim.keymap.set("n", "<leader>T" .. i, "<cmd>tabnext " .. i .. "<cr>", { desc = "Go to tab " .. i })
end
