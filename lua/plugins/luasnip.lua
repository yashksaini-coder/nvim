return {
	"L3MON4D3/LuaSnip",
	version = "*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local luasnip = require("luasnip")

		-- Load friendly-snippets (vscode-style snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Key mappings for snippet navigation
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { desc = "Expand or jump to next snippet node" })

		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { desc = "Jump to previous snippet node" })

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, { desc = "Change snippet choice" })
	end,
}

