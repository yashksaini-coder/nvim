-- Treesitter-aware text objects: `af`/`if` a function, `ac`/`ic` a class, plus
-- smarter versions of the built-in a(/i(, a'/i' and friends.
--
-- nvim-treesitter-textobjects must stay on `branch = "main"` to match
-- plugins/treesitter.lua — its master branch is the legacy module API and would
-- silently do nothing here, with no warning from lazy.nvim.
return {
	"nvim-mini/mini.ai",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	},
	opts = function()
		local ai = require("mini.ai")
		return {
			n_lines = 500,
			custom_textobjects = {
				o = ai.gen_spec.treesitter({
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
			},
		}
	end,
}
