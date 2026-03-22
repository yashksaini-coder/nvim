return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
		{ "{", "<cmd>AerialPrev<CR>", desc = "Prev symbol (aerial)" },
		{ "}", "<cmd>AerialNext<CR>", desc = "Next symbol (aerial)" },
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "man" },
		layout = {
			default_direction = "right",
			min_width = 30,
			max_width = { 40, 0.2 },
		},
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Module",
			"Method",
			"Struct",
		},
		show_guides = true,
		guides = {
			mid_item = "├─",
			last_item = "└─",
			nested_top = "│ ",
			whitespace = "  ",
		},
	},
}
