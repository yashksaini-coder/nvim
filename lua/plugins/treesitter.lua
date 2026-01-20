return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"javascript",
					"html",
					"python",
					"rust",
					"json",
					"yaml",
					"markdown",
				},
				sync_install = false,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				auto_install = true,
			})
		end,
	},
}
