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
