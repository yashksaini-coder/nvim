-- ============================================================================
-- LSP Configuration - Using Neovim 0.11+ native vim.lsp.config API
-- ============================================================================

return {
	{
		"neovim/nvim-lspconfig", -- Still required!
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Setup Mason first
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "rust_analyzer", "pyright", "lua_ls" },
			})

			-- Configure servers using NEW API
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.config("rust_analyzer", {})
			vim.lsp.config("pyright", {})

			-- Enable servers
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("pyright")

			-- Keymaps
			vim.keymap.set("n", "<C-i>", vim.lsp.buf.definition, { desc = "Goto definition" })
			vim.keymap.set("n", "<S-l>", vim.lsp.buf.hover, { desc = "Hover" })
		end,
	},
}
