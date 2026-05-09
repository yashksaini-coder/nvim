return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit (magit)" },
	},
	opts = {
		graph_style = "unicode",
		integrations = { telescope = true, diffview = true },
	},
}
