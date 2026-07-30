-- `nvim .` (or `nvim <dir>`) → open the dashboard in the main window
-- and neo-tree in a side split, instead of the default empty scratch buffer.
vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Open dashboard + neo-tree when nvim starts on a directory",
	group = vim.api.nvim_create_augroup("nvim_dir_open", { clear = true }),
	callback = function()
		if vim.fn.argc() ~= 1 then
			return
		end
		local arg = vim.fn.argv(0)
		if vim.fn.isdirectory(arg) ~= 1 then
			return
		end

		vim.cmd("cd " .. vim.fn.fnameescape(arg))
		local dir_buf = vim.api.nvim_get_current_buf()

		vim.schedule(function()
			pcall(vim.cmd, "Dashboard")
			-- Wipe the directory buffer nvim auto-created (dashboard now owns the main window)
			if vim.api.nvim_buf_is_valid(dir_buf) then
				pcall(vim.api.nvim_buf_delete, dir_buf, { force = true })
			end
			pcall(vim.cmd, "Neotree show")
		end)
	end,
})
