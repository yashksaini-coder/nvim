return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Main branch setup - minimal config
		require("nvim-treesitter").setup()
		
		-- Install parsers
		require("nvim-treesitter").install({ "lua", "javascript", "html", "python", "rust", "json", "yaml", "markdown" })
		
		-- Enable highlighting via autocommand
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "javascript", "html", "python", "rust", "json", "yaml", "markdown" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
