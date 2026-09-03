-- When init.lua flagged `_nvim_dir_open` (nvim launched with a directory arg
-- like `nvim .`), open the snacks explorer in a side panel once the UI is ready.
-- Dashboard auto-shows on its own because init.lua cleared argv before lazy ran.
if vim.g._nvim_dir_open then
	vim.api.nvim_create_autocmd("UIEnter", {
		once = true,
		group = vim.api.nvim_create_augroup("nvim_dir_open_tree", { clear = true }),
		callback = function()
			vim.schedule(function()
				pcall(function()
					require("snacks").explorer()
				end)
			end)
		end,
	})
end
