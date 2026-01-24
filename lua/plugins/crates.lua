return {
	"saecki/crates.nvim",
	tag = "stable",
	event = { "BufRead Cargo.toml", "BufNewFile Cargo.toml" },
	config = function()
		require("crates").setup({
			-- Smart insert is enabled by default
			smart_insert = true,
			-- Automatically reload workspace when Cargo.toml is edited
			autoload = true,
			-- Virtual text configuration
			text = {
				loading = "  Loading...",
				version = "  %s",
				prerelease = "  %s",
				yanked = "  %s yanked",
				nomatch = "  Not found",
				upgrade = "  %s",
				error = "  Error fetching crate",
			},
			-- Highlight configuration
			highlight = {
				searching = "CratesNvimSearching",
				loading = "CratesNvimLoading",
				version = "CratesNvimVersion",
				prerelease = "CratesNvimPreRelease",
				yanked = "CratesNvimYanked",
				nomatch = "CratesNvimNoMatch",
				upgrade = "CratesNvimUpgrade",
				error = "CratesNvimError",
			},
			-- Popup configuration
			popup = {
				autofocus = false,
				hide_on_select = false,
				copy_register = '"',
				style = "minimal",
				border = "none",
				show_version_date = false,
				show_dependency_version = true,
				max_height = 30,
				min_width = 20,
			},
			-- Completion configuration
			completion = {
				insert_closing_quote = true,
				text = {
					prerelease = "  pre-release ",
					yanked = "  yanked ",
				},
			},
			-- LSP configuration (in-process language server)
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		})
	end,
}
