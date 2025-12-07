-- It's a LSP manager for all kinds of stuff 
-- LSP
-- DAP
-- Linter
-- Formatter


return {
    {
        "williamboman/mason.nvim",
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
                    "stylua", -- lua formatter
                    "isort", -- python formatter
                    "black", -- python formatter
                    "prettierd", -- js/ts formatter
                    "eslint_d", -- js/ts linter
                },
            })
        end,
    },
}
