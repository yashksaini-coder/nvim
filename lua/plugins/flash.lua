-- Label-based jumping: `s` plus a couple of characters puts a label on every
-- match; type the label to land there. `S` labels the treesitter nodes around the
-- cursor instead, and `r`/`R` make either usable as an operator-pending motion.
--
-- `s` takes over the built-in substitute-character; `cl` does the same thing.
--
-- VeryLazy rather than key-only: setup() is what installs the labelled f/t/F/T
-- motions, so lazy-loading on `s` alone would leave f/t stock until the first `s`.
-- <c-s> here is cmdline mode only — the i/x/n/s save mapping in
-- config/keymaps/general.lua is untouched.
--
-- LazyVim also binds <c-space> for incremental selection. Skipped:
-- plugins/treesitter.lua already provides that with <CR>/<BS> via
-- vim.treesitter.select().
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter search",
		},
		{
			"<c-s>",
			mode = "c",
			function()
				require("flash").toggle()
			end,
			desc = "Toggle flash search",
		},
	},
}
