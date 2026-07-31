-- When init.lua flagged `_nvim_dir_open` (nvim launched with a directory arg
-- like `nvim .`), open neo-tree in a side panel once the UI is ready.
-- Dashboard auto-shows on its own because init.lua cleared argv before lazy ran.
if vim.g._nvim_dir_open then
	vim.api.nvim_create_autocmd("UIEnter", {
		once = true,
		group = vim.api.nvim_create_augroup("nvim_dir_open_tree", { clear = true }),
		callback = function()
			vim.schedule(function()
				pcall(vim.cmd, "Neotree show")
			end)
		end,
	})
end

-- Re-open the dashboard when the last real buffer is closed (e.g. <leader>bd
-- on the sole open file). Fires only when we land on an empty [No Name] with
-- no other listed buffers alive.
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Dashboard on empty last-buffer state",
	group = vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true }),
	callback = function()
		if vim.v.vim_did_enter ~= 1 then
			return
		end
		local buf = vim.api.nvim_get_current_buf()
		if vim.bo[buf].filetype == "snacks_dashboard" then
			return
		end
		if vim.api.nvim_buf_get_name(buf) ~= "" then
			return
		end
		if vim.bo[buf].buftype ~= "" then
			return
		end
		if vim.api.nvim_buf_line_count(buf) > 1 then
			return
		end
		if (vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or "") ~= "" then
			return
		end
		for _, b in ipairs(vim.api.nvim_list_bufs()) do
			if b ~= buf and vim.bo[b].buflisted and vim.bo[b].filetype ~= "snacks_dashboard" then
				return
			end
		end
		vim.schedule(function()
			pcall(function()
				require("snacks").dashboard({ buf = buf, win = vim.api.nvim_get_current_win() })
			end)
		end)
	end,
})
