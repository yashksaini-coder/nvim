-- Clipboard policy.
--
-- This used to be `clipboard = "unnamedplus"`, which aliases the unnamed
-- register to the system clipboard. Vim's d/x/c are CUT, not delete — they have
-- always written to the unnamed register — so under that option every deletion
-- overwrote whatever you had copied from the browser. Not a bug, but not what
-- anyone wants.
--
-- So: leave the registers alone and mirror only yanks outward.
--
--   y          → unnamed AND the system clipboard
--   d x c      → unnamed only; the clipboard is untouched
--   p          → unnamed, so `dd` then `p` still moves a line
--   <leader>p  → paste from the system clipboard

vim.opt.clipboard = ""

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("clipboard_mirror", { clear = true }),
	desc = "Mirror yanks (not deletes) to the system clipboard",
	callback = function()
		-- operator is "y" for a yank and "d"/"c" for a cut, so this is the whole
		-- fix. regname guards `"ayy`: an explicit register is not a yank you meant
		-- to send outside.
		if vim.v.event.operator == "y" and vim.v.event.regname == "" then
			vim.fn.setreg("+", vim.fn.getreg('"'), vim.fn.getregtype('"'))
		end
	end,
})

-- Plain `p` means the unnamed register again, so reaching the clipboard needs
-- its own key.
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste from clipboard (before)" })
