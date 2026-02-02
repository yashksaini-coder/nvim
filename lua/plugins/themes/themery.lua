-- Themery: colorscheme picker with live preview and persistence
-- <leader>tH to open (Themery)
return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = {
				-- Tokyo Night (already in colorscheme.lua)
				{ name = "Tokyo Night", colorscheme = "tokyonight" },
				{ name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
				{ name = "Tokyo Night Night", colorscheme = "tokyonight-night" },
				-- Catppuccin (catppuccin.lua)
				{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
				{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
				{ name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
				{ name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
				-- Rosé Pine (rose-pine.lua): main, moon, dawn
				{ name = "Rosé Pine Main", colorscheme = "rose-pine-main" },
				{ name = "Rosé Pine Moon", colorscheme = "rose-pine-moon" },
				{ name = "Rosé Pine Dawn", colorscheme = "rose-pine-dawn" },
				-- Kanagawa (kanagawa.lua)
				{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
				{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
				{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
				-- Existing
				{ name = "Osmium", colorscheme = "osmium" },
				{ name = "Chai", colorscheme = "chai" },
				{
					name = "Gruvbox Dark",
					colorscheme = "gruvbox",
					before = [[
						vim.opt.background = "dark"
					]],
				},
				{
					name = "Gruvbox Light",
					colorscheme = "gruvbox",
					before = [[
						vim.opt.background = "light"
					]],
				},
			},
			livePreview = true,
		})
	end,
}
