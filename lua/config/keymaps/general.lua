-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
	desc = "Clear search highlights",
})

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {
	desc = "Move to left window",
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
	desc = "Move to lower window",
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
	desc = "Move to upper window",
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
	desc = "Move to right window",
})

-- Toggle comment in visual mode. Must be recursive: the built-in `gc` is itself a
-- Lua mapping, so noremap would bypass it. Mode is "x", not "v" — the built-in only
-- maps x, and firing an operator from select mode is wrong anyway.
vim.keymap.set("x", "<C-/>", "gc", {
	remap = true,
	silent = true,
	desc = "Toggle comment",
})

-- Save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", {
	desc = "Save file",
})

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", {
	desc = "Quit all",
})

-- Close the buffer you are on. When it was the last real one, put the dashboard
-- in the window instead of leaving an empty [No Name].
--
-- Snacks.bufdelete rather than `silent! BufferClose`: it asks "Save changes to
-- X?" on a modified buffer instead of refusing without a word, and it keeps the
-- window layout. The old version paired that silent refusal with an
-- unconditional dashboard render into nvim_get_current_buf() -- which, when the
-- close had just been refused, was still the modified file. It painted the
-- dashboard over the unsaved edit that caused the refusal.
vim.keymap.set("n", "<leader>bd", function()
	local buf = vim.api.nvim_get_current_buf()

	-- Nothing to close on the dashboard, and no empty window to rescue.
	if vim.bo[buf].filetype == "snacks_dashboard" then
		return
	end

	-- Count the survivors before deleting; the dashboard itself is not one.
	local others = 0
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if b ~= buf and vim.bo[b].buflisted and vim.bo[b].filetype ~= "snacks_dashboard" then
			others = others + 1
		end
	end

	local ok = pcall(function()
		require("snacks").bufdelete({ buf = buf })
	end)
	if not ok then
		vim.cmd("silent! bdelete")
	end

	if others > 0 then
		return
	end

	vim.schedule(function()
		-- Still loaded means the delete was declined at the save prompt. Leave the
		-- buffer alone -- rendering over it is what destroyed the edit before.
		-- nvim_buf_is_valid is no use here: bufdelete ends in `bdelete!`, which
		-- unloads and unlists but leaves the buffer number valid either way.
		if vim.api.nvim_buf_is_loaded(buf) then
			return
		end
		pcall(function()
			require("snacks").dashboard({
				buf = vim.api.nvim_get_current_buf(),
				win = vim.api.nvim_get_current_win(),
			})
		end)
	end)
end, { desc = "Close buffer" })

-- Man pages (:Man is built-in)
vim.keymap.set("n", "<leader>km", function()
	local word = vim.fn.input("Man page: ")
	if word ~= "" then
		vim.cmd("Man " .. word)
	end
end, { desc = "Open man page" })

vim.keymap.set("n", "<leader>kw", function()
	local word = vim.fn.expand("<cword>")
	if word ~= "" then
		vim.cmd("Man " .. word)
	end
end, { desc = "Man page for word under cursor" })

-- Open the deployed keymap-reference site in the system browser.
-- Site source lives in site/, deployed via .github/workflows/pages.yml.
vim.keymap.set("n", "<leader>kk", function()
	vim.ui.open("https://yashksaini-coder.github.io/nvim/")
end, { desc = "Open keymap reference site" })

-- Window resize
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
