-- nvim-treesitter configuration
-- File: ~/.config/nvim/lua/plugins/treesitter.lua (if using lazy.nvim)
-- or add to your init.lua/init.vim

return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = "0.9.*", -- Use 0.9.x series for Neovim 0.10 compatibility
		build = ":TSUpdate",
		lazy = false, -- Treesitter does not support lazy loading
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"rust",
					"python",
					"typescript",
					"javascript",
					"c",
					"cpp",
					"c_sharp",
				},
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = { "python" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = "<S-CR>",
						node_decremental = "<BS>",
					},
				},
			})
		end,
	},
}
