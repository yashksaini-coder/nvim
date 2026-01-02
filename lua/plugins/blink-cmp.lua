return {
	"Saghen/blink.cmp",
	version = "1.*", -- Use stable version tag to avoid build issues
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")

		-- Load friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Setup blink.cmp with optimized configuration
		require("blink.cmp").setup({
			-- Fuzzy matching configuration
			-- Use Lua implementation to avoid Rust build requirements
			fuzzy = {
				implementation = "lua", -- Use Lua implementation (no Rust needed)
			},

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

		-- IDE-like keymaps for completion
		-- Tab: Accept completion or expand/jump snippet
		vim.keymap.set("i", "<Tab>", function()
			-- Check if snippet can be expanded or jumped first
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			-- Check if completion menu is visible (using vim's pumvisible)
			elseif vim.fn.pumvisible() == 1 then
				-- Accept the currently selected completion
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-y>", true, false, true), "n", false)
			-- Otherwise, insert a tab
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
			end
		end, { desc = "Accept completion or expand snippet" })

		-- Shift-Tab: Previous completion item or previous snippet node
		vim.keymap.set("i", "<S-Tab>", function()
			-- Check if we can jump to previous snippet node
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			-- Check if completion menu is visible
			elseif vim.fn.pumvisible() == 1 then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, false, true), "n", false)
			-- Otherwise, insert shift-tab
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
			end
		end, { desc = "Previous completion item or snippet node" })

		-- Enter: Normal behavior (no special keymap)
		-- Enter will work as normal newline, Tab is used to accept completion

		-- Esc: Close completion menu
		vim.keymap.set("i", "<Esc>", function()
			-- If completion menu is visible, close it
			if vim.fn.pumvisible() == 1 then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-e>", true, false, true), "n", false)
			-- If snippet is active, exit snippet mode
			elseif luasnip.choice_active() then
				luasnip.unlink_current()
			-- Otherwise, normal escape
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			end
		end, { desc = "Close completion menu or exit snippet" })

		-- Keep existing snippet keymaps for consistency
		-- C-l: Expand or jump to next snippet node
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { desc = "Expand or jump to next snippet node" })

		-- C-h: Jump to previous snippet node
		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { desc = "Jump to previous snippet node" })

		-- C-j: Change snippet choice
		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, { desc = "Change snippet choice" })
	end,
}

