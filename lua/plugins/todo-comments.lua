-- Highlights TODO/FIXME/HACK/NOTE/PERF/WARN and makes them searchable.
-- ]t/[t jump between them; the two list keys mirror the existing split between
-- <leader>f* (telescope) and <leader>x* (trouble).
return {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Prev todo comment",
		},
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo comments" },
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo comments (Trouble)" },
	},
}
