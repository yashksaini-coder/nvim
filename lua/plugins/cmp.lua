return {
	"hrsh7th/nvim-cmp",
	-- Nothing needs cmp before you start typing. lsp.lua pulls cmp-nvim-lsp in as
	-- its own dependency for capabilities, so the LSP side does not wait on this.
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP source
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		-- LuaSnip is the snippet ENGINE, not a source: nvim-cmp requires a
		-- snippet.expand implementation to accept LSP snippet completions at all.
		-- cmp_luasnip and its `luasnip` source are gone — no snippets are defined
		-- anywhere in this config, so that source could only ever return nothing.
		"L3MON4D3/LuaSnip",
		"onsails/lspkind.nvim", -- completion icons
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
				keyword_pattern = [[\k\+]],
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				-- <CR> only confirms if you've explicitly selected an item —
				-- lets you press Enter to insert a real newline without picking
				-- whatever ghost-suggestion happens to be highlighted.
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					menu = {
						nvim_lsp = "[LSP]",
						lazydev = "[Lua]",
						buffer = "[Buf]",
						path = "[Path]",
					},
				}),
			},
			sources = cmp.config.sources({
				-- Its own leading group: cmp.config.sources overwrites group_index with
				-- the group's position, so a leading group is the only way to let
				-- lazydev's require("…") module names beat lua_ls's path guesses.
				{ name = "lazydev" },
			}, {
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
