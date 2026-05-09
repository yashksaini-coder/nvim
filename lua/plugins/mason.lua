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
          "lua-language-server",
          "rust-analyzer",
          "typescript-language-server",
          "clangd",
          "omnisharp",
          "pyright", -- Python LSP (replaces bare pylsp default)
          "gopls", -- Go LSP
          "tailwindcss-language-server",

          -- Linters
          "luacheck",
          "ruff", -- Python linter+formatter
          "golangci-lint", -- Go linter
          "eslint_d", -- JS/TS linter

          -- Formatters
          "stylua",
          "csharpier",
          "prettier",
          "prettierd",
          "gofumpt", -- stricter gofmt
          "goimports", -- Go import organizer
          "black", -- Python formatter
          "isort", -- Python import sort
          "clang-format", -- C/C++ formatter

          -- DAP adapters
          "codelldb", -- already present
          "debugpy", -- Python debugger
          "delve", -- Go debugger
          "js-debug-adapter", -- JS/TS debugger (Chrome DevTools protocol)
        },
      })
    end,
  },
}
