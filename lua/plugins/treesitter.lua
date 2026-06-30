-- nvim-treesitter configuration
-- File: ~/.config/nvim/lua/plugins/treesitter.lua (if using lazy.nvim)
-- or add to your init.lua/init.vim

return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- The legacy `nvim-treesitter.configs` module (highlight/indent/incremental_selection)
		-- lives on `master`. `main` is the v1.0+ rewrite that removed it.
		branch = "master",
		build = ":TSUpdate",
		lazy = false,
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
					"markdown",
					"markdown_inline",
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

			-- Patch nvim-treesitter's `set-lang-from-info-string!` predicate. In
			-- Neovim 0.11+, query-directive `match` values became TSNode[] lists
			-- (quantifier support), so the upstream code's `get_node_text(nodes, bufnr)`
			-- call crashes on `node:range()` when fed a list. The master branch is
			-- archived and won't ship this fix; re-register the directive with the
			-- correct unwrap. Without this, render-markdown errors on every parse.
			local ts_query = require("vim.treesitter.query")
			local lang_aliases = {
				ex = "elixir",
				pl = "perl",
				sh = "bash",
				uxn = "uxntal",
				ts = "typescript",
			}
			ts_query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
				local nodes = match[pred[2]]
				local node = type(nodes) == "table" and nodes[1] or nodes
				if not node then
					return
				end
				local alias = vim.treesitter.get_node_text(node, bufnr):lower()
				local ft = vim.filetype.match({ filename = "a." .. alias })
				metadata["injection.language"] = ft or lang_aliases[alias] or alias
			end, { force = true, all = false })
		end,
	},
}
