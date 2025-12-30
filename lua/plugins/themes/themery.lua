return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = {
				"tokyonight",
				"tokyonight-storm",
				"tokyonight-night",
				"osmium",
				"chai",
				"gruvbox",
			},
			livePreview = true, -- Apply theme while picking
		})
	end,
}
