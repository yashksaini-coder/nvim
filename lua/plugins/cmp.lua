return {
	"hrsh7th/nvim-cmp",
	-- Nothing needs cmp before you start typing. lsp.lua pulls cmp-nvim-lsp in as
	-- its own dependency for capabilities, so the LSP side does not wait on this.
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP source
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		-- LuaSnip is the snippet engine nvim-cmp needs to accept LSP snippet
		-- completions at all. It now also carries the C/C++ starters, which is why
		-- cmp_luasnip is back: it was dropped when no snippets existed anywhere in
		-- this config, so its source could only ever return nothing.
		{
			"L3MON4D3/LuaSnip",
			config = function()
				local ls = require("luasnip")
				local templates = require("config.templates")
				for _, ft in ipairs({ "c", "cpp" }) do
					ls.add_snippets(ft, {
						ls.snippet({ trig = "cp", desc = ft:upper() .. " starter" }, ls.text_node(templates[ft])),
					})
				end
			end,
		},
		"saadparwaiz1/cmp_luasnip",
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
						luasnip = "[Snip]",
						lazydev = "[Lua]",
						buffer = "[Buf]",
						path = "[Path]",
					},
				}),
			},
			sources = cmp.config.sources({
				{ name = "luasnip" },
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
