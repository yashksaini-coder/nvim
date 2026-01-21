-- ============================================================================
-- LSP Configuration - Compatible with Neovim 0.10
-- ============================================================================

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			-- Setup Mason first
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"pyright",
					"lua_ls",
					"ts_ls",
				},
			})

			-- Setup handlers for LSP servers
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						-- Server-specific settings
						["lua_ls"] = {
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim", "require" } },
									workspace = { library = vim.api.nvim_get_runtime_file("", true) },
									telemetry = { enable = false },
								},
							},
						},
						["ts_ls"] = {
							settings = {
								typescript = { inlayHints = { enabled = true } },
								javascript = { inlayHints = { enabled = true } },
							},
						},
					})
				end,
			})

			-- Keymaps
			vim.keymap.set("n", "<C-i>", vim.lsp.buf.definition, { desc = "Goto definition" })
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" })
		end,
	},
}
