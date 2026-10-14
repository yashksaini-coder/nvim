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
					-- Oxocarbon. ONE colorscheme whose face is chosen by `background`, so both
					-- entries name `oxocarbon` and differ only in `before` — same shape as the
					-- two Gruvbox entries at the end of this list.
					{
						name = "Oxocarbon Dark",
						colorscheme = "oxocarbon",
						before = [[
							vim.opt.background = "dark"
						]],
					},
					{
						name = "Oxocarbon Light",
						colorscheme = "oxocarbon",
						before = [[
							vim.opt.background = "light"
						]],
					},
					-- Nightfox. Seven distinct colorschemes, and each one sets `background`
					-- itself (verified: loading dayfox from a dark session flips it to light),
					-- so none of them needs a `before`.
					{ name = "Nightfox", colorscheme = "nightfox" },
					{ name = "Duskfox", colorscheme = "duskfox" },
					{ name = "Nordfox", colorscheme = "nordfox" },
					{ name = "Terafox", colorscheme = "terafox" },
					{ name = "Carbonfox", colorscheme = "carbonfox" },
					-- dayfox/dawnfox are the two light members of the same family.
					{ name = "Dayfox", colorscheme = "dayfox" },
					{ name = "Dawnfox", colorscheme = "dawnfox" },
					-- Soviet. Also sets `background` itself, so no `before`.
					{ name = "Soviet Dark", colorscheme = "soviet-dark" },
					{ name = "Soviet Light", colorscheme = "soviet-light" },
					-- Koda. Each named variant pins its own palette regardless of `background`,
					-- but NONE of them sets `background` — leaving it stale misreports the theme
					-- to everything that keys off it (statusline, diagnostics, other plugins), so
					-- every entry sets it explicitly. The bare `koda` colorscheme is deliberately
					-- absent: it just follows `background` and resolves to output byte-identical
					-- to koda-dark or koda-light, so listing it would only duplicate those two.
					{
						name = "Koda Dark",
						colorscheme = "koda-dark",
						before = [[
							vim.opt.background = "dark"
						]],
					},
					{
						name = "Koda Moss",
						colorscheme = "koda-moss",
						before = [[
							vim.opt.background = "dark"
						]],
					},
					{
						name = "Koda Light",
						colorscheme = "koda-light",
						before = [[
							vim.opt.background = "light"
						]],
					},
					{
						name = "Koda Glade",
						colorscheme = "koda-glade",
						before = [[
							vim.opt.background = "light"
						]],
					},
					-- Cobalt. Single variant, pins its dark palette but does not set `background`.
					{
						name = "Cobalt",
						colorscheme = "cobalt",
						before = [[
							vim.opt.background = "dark"
						]],
					},
					-- Cyberdream. Three genuinely distinct colorschemes — `cyberdream` and
					-- `cyberdream-muted` share a background (#16181a) but not a palette
					-- (Keyword #ffbd5e vs #e3a875) — and not one of the three sets
					-- `background`, so all three set it here.
					{
						name = "Cyberdream",
						colorscheme = "cyberdream",
						before = [[
							vim.opt.background = "dark"
						]],
					},
					{
						name = "Cyberdream Muted",
						colorscheme = "cyberdream-muted",
						before = [[
							vim.opt.background = "dark"
						]],
					},
					{
						name = "Cyberdream Light",
						colorscheme = "cyberdream-light",
						before = [[
							vim.opt.background = "light"
						]],
					},
					-- VS Code. One colorscheme, both faces, chosen by `background` — the
					-- oxocarbon/gruvbox shape, not the cyberdream one.
					{
						name = "VS Code Dark",
						colorscheme = "vscode",
						before = [[
							vim.opt.background = "dark"
						]],
					},
					{
						name = "VS Code Light",
						colorscheme = "vscode",
						before = [[
							vim.opt.background = "light"
						]],
					},
					-- Kanagawa
					{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
					{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
					-- Lotus is Kanagawa's light member and, unlike wave/dragon, does not set
					-- `background` when loaded by name — it painted a light palette while
					-- `background` still said dark. Pre-existing; same fix as Koda/Cobalt.
					{
						name = "Kanagawa Lotus",
						colorscheme = "kanagawa-lotus",
						before = [[
							vim.opt.background = "light"
						]],
					},
					-- Other themes
					{ name = "Osmium", colorscheme = "osmium" },
					{ name = "Chai", colorscheme = "chai" },
					-- Gruvbox is one colorscheme whose face follows `background`, so this
					-- `before` is what makes it dark. It matters MORE now that the Light
					-- entry is gone, not less: pick Dayfox or Koda Light (or any other
					-- light entry above) and then Gruvbox, and without this line gruvbox
					-- would inherit `background=light` and render as the variant that was
					-- just removed from this list.
					{
						name = "Gruvbox Dark",
						colorscheme = "gruvbox",
						before = [[
							vim.opt.background = "dark"
						]],
					},
				},
				livePreview = true,
			})

			-- First-run default only: once you pick with <leader>tH, themery persists
			-- it to ~/.local/share/nvim/themery/state.json and this never fires
			-- again. Wave over Dragon because Dragon has the narrowest spread of
			-- every entry in this list between Comment/Keyword/String/Function/
			-- @variable — 108, against Wave's 175 and the widest, Cobalt, at 375
			-- — and on keyword-dense code such as Python that reads as
			-- "treesitter is broken" when it is working perfectly. Deliberately
			-- no entry count here: it went stale twice in one sitting. Dragon has
			-- held the floor through every theme added or removed so far, with
			-- Soviet Light (110) the only close second.
			vim.api.nvim_create_autocmd("VimEnter", {
				once = true,
				callback = function()
					vim.schedule(function()
						local themery = require("themery")
						local current = themery.getCurrentTheme()
						if not current then
							themery.setThemeByName("Kanagawa Wave", true)
						end
					end)
				end,
			})
		end,
	},
}
