return {
	"Saghen/blink.cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	event = "InsertEnter",
	config = function()
		-- Load friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Setup blink.cmp with optimized configuration
		require("blink.cmp").setup({
			-- Signature help configuration
			signature = {
				enabled = true,
			},

			-- Completion menu configuration
			completion = {
				-- Documentation window
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500, -- Show docs after 500ms
				},

				-- Completion menu
				menu = {
					auto_show = true, -- Auto-show completion menu
					draw = {
						-- Treesitter sources
						treesitter = { "lsp" },
						-- Menu columns layout
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
			},
		})
	end,
}

