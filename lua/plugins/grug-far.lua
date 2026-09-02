-- Project-wide find and replace in a buffer you can edit before applying.
-- <leader>fS rather than LazyVim's <leader>sr: <leader>f is this config's
-- find/search prefix, and <leader>s has no other leaves.
return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	opts = {},
	keys = {
		{
			"<leader>fS",
			function()
				require("grug-far").open({ transient = true })
			end,
			mode = { "n", "v" },
			desc = "Search & replace (project-wide)",
		},
	},
}
