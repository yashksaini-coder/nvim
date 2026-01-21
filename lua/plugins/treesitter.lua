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
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					require("nvim-treesitter.configs").setup({
						-- A list of parser names, or "all"
						ensure_installed = {
							"rust",
							"python",
							"typescript",
							"javascript",
							"c",
							"cpp", -- Added C++
						},

						-- Install parsers synchronously (only applied to `ensure_installed`)
						sync_install = false,

						-- Automatically install missing parsers when entering buffer
						auto_install = true,

						-- List of parsers to ignore installing (for "all")
						ignore_install = {},

						highlight = {
							enable = true,

							-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
							-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
							-- Using this option may slow down your editor, and you may see some duplicate highlights.
							-- Instead of true it can also be a list of languages
							additional_vim_regex_highlighting = false,
						},

						indent = {
							enable = true,
							-- Disable for certain languages if needed
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
			})
		end,
	},
}
