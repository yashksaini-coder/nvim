return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeOpen" },
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer" },
		{ "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Explorer" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		-- Auto-open nvim-tree when opening a directory (e.g. `nvim .`)
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function(data)
				if vim.fn.isdirectory(data.file) == 1 then
					vim.cmd.cd(data.file)
					require("nvim-tree.api").tree.open()
				end
			end,
		})
	end,
	config = function()
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})
	end,
}
