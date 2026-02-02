-- Kanagawa: Japanese-inspired theme (wave, dragon, lotus)
-- https://github.com/rebelot/kanagawa.nvim
return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	opts = {
		compile = false,
		undercurl = true,
		commentStyle = { italic = true },
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		transparent = false,
		dimInactive = false,
		terminalColors = true,
		theme = "wave",
		background = { dark = "wave", light = "lotus" },
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		-- Don't set colorscheme here; Themery will set wave/dragon/lotus
	end,
}
