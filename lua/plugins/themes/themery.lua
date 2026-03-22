-- Themery: colorscheme picker with live preview and persistence
-- <leader>tH to open (Themery)
return {
	-- Tokyo Night theme plugin
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	-- Themery: manages theme switching and persistence
	{
		"zaldih/themery.nvim",
		lazy = false,
		priority = 100,
		config = function()
			require("themery").setup({
				themes = {
					-- Tokyo Night
					{ name = "Tokyo Night", colorscheme = "tokyonight" },
					{ name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
					{ name = "Tokyo Night Night", colorscheme = "tokyonight-night" },
					-- Catppuccin
					{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
					{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
					{ name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
					{ name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
					-- Rosé Pine
					{ name = "Rosé Pine Main", colorscheme = "rose-pine-main" },
					{ name = "Rosé Pine Moon", colorscheme = "rose-pine-moon" },
					{ name = "Rosé Pine Dawn", colorscheme = "rose-pine-dawn" },
					-- Kanagawa
					{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
					{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
					{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
					-- Other themes
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

			-- Set default theme to Kanagawa Dragon only on first run (when no theme is persisted)
			vim.api.nvim_create_autocmd("VimEnter", {
				once = true,
				callback = function()
					vim.schedule(function()
						local themery = require("themery")
						local current = themery.getCurrentTheme()
						if not current then
							themery.setThemeByName("Kanagawa Dragon", true)
						end
					end)
				end,
			})
		end,
	},
}
