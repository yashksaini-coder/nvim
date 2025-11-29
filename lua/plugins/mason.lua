-- It's a LSP manager for all kinds of stuff 
-- LSP
-- DAP
-- Linter
-- Formatter


return {{
    "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
}}
