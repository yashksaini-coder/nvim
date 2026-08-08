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

-- Autopairs Keymap
vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", {
	noremap = true,
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

-- Delete current buffer. When it's the last real one, re-open the dashboard
-- in place of the auto-created [No Name] scratch buffer.
vim.keymap.set("n", "<leader>bd", function()
	local cur = vim.api.nvim_get_current_buf()
	local others = 0
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if b ~= cur and vim.bo[b].buflisted and vim.bo[b].filetype ~= "snacks_dashboard" then
			others = others + 1
		end
	end
	vim.cmd("silent! BufferClose")
	if others == 0 then
		vim.schedule(function()
			pcall(function()
				require("snacks").dashboard({
					buf = vim.api.nvim_get_current_buf(),
					win = vim.api.nvim_get_current_win(),
				})
			end)
		end)
	end
end, { desc = "Delete buffer" })

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
