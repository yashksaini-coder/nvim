-- Rosé Pine: soho/minimalist theme, 3 variants (main, moon, dawn)
-- https://github.com/rose-pine/neovim
return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	opts = {
		variant = "auto",
		dark_variant = "main",
		dim_inactive_windows = false,
		extend_background_behind_borders = true,
		enable = { terminal = true },
		styles = { bold = true, italic = true, transparency = false },
	},
	config = function(_, opts)
		require("rose-pine").setup(opts)
		-- Don't set colorscheme here; Themery will set main/moon/dawn
	end,
}
