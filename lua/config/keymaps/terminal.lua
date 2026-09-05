-- Plain `:terminal`, no plugin. toggleterm and its ~218 lines of bindings went
-- in e3f4303; the built-in was never broken, it just had no way in or out.

-- `:terminal` converts the buffer in the CURRENT window in place, so it fails
-- outright when that window holds a special buffer -- the explorer, help,
-- quickfix, a picker:
--
--   jobstart(...,{term=true}) requires unmodified buffer
--
-- (the message is misleading: such a buffer reports modified=false, what stops
-- it is buftype=nofile / nomodifiable.)
--
-- `:split` is no escape either, because it clones that same buffer into the new
-- window. `:new` and `:vnew` open a window on a fresh empty buffer, which is
-- what a terminal needs, and botright keeps placement predictable no matter
-- which window happened to be focused.
local function terminal(opener)
	if opener then
		vim.cmd(opener)
	elseif vim.bo.buftype ~= "" then
		-- Current window is a special one; open elsewhere rather than commandeer it.
		vim.cmd("botright new")
	end
	vim.cmd("terminal")
end

-- <leader>tH (Themery) already lives under this prefix, so the terminal keys
-- take lowercase letters beside it.
vim.keymap.set("n", "<leader>tt", function()
	terminal()
end, { desc = "Terminal (this window)" })
vim.keymap.set("n", "<leader>ts", function()
	terminal("botright new")
end, { desc = "Terminal (split)" })
vim.keymap.set("n", "<leader>tv", function()
	terminal("botright vnew")
end, { desc = "Terminal (vsplit)" })

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
