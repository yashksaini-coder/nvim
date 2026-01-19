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
					"lua_ls", -- Lua language server
					-- Formatters
					"stylua", -- Lua formatter
					"prettier", -- Web development formatter (JS/TS/CSS/HTML/JSON)
					"prettierd", -- Prettier daemon (faster, optional)
					-- DAP
					"codelldb", -- Rust/C++ debugger (lldb)
				},
			})
		end,
	},
}
