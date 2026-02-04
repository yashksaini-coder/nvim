-- It's a LSP manager for all kinds of stuff
-- LSP
-- DAP
-- Linter
-- Formatter

return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					-- LSP servers
					"lua-language-server", -- Lua language server
					"rust-analyzer", -- Rust LSP
					"typescript-language-server", -- TypeScript/JavaScript LSP
					"clangd", -- C/C++ LSP
					"omnisharp", -- C# LSP
					-- Linters
					"luacheck", -- Lua linter
					"ruff", -- Python linter
					-- Formatters
					"stylua", -- Lua formatter
					"csharpier", -- C# formatter
					"prettier", -- Web development formatter (JS/TS/CSS/HTML/JSON)
					"prettierd", -- Prettier daemon (faster, optional)
					-- DAP
					"codelldb", -- Rust/C++ debugger (lldb)
				},
			})
		end,
	},
}
