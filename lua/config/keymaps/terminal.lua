-- Plain `:terminal`, no plugin. toggleterm and its ~218 lines of bindings went
-- in e3f4303; the built-in was never broken, it just had no way in or out.

-- Open. <leader>tH (Themery) already lives under this prefix, so the terminal
-- keys take lowercase letters beside it.
vim.keymap.set("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "Terminal (this window)" })
vim.keymap.set("n", "<leader>ts", "<cmd>split | terminal<cr>", { desc = "Terminal (split)" })
vim.keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal (vsplit)" })

-- Leave terminal mode. <C-\><C-n> is Neovim's built-in and still works; this
-- adds a double-Esc as the reachable version. A single <Esc> is deliberately
-- NOT mapped: it has to keep reaching the program running inside the terminal,
-- or vim, less, fzf and any REPL become unusable in there.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- A terminal has no use for line numbers or a sign column, and you almost
-- always want to start typing. Safe to hook TermOpen: compile-mode runs its
-- build on `jobstart{ pty = true }`, which is not a terminal buffer and does
-- not fire this.
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal_ui", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.cmd("startinsert")
	end,
})
