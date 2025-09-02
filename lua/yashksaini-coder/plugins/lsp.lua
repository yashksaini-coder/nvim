return {
  -- Mason for managing LSP/DAP/Linters/Formatters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between mason & lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",          -- Lua
          "pyright",         -- Python
          "rust_analyzer",   -- Rust
          "gopls",           -- Go
          "ts_ls",           -- TypeScript/JavaScript (replaces tsserver)
        },
        automatic_installation = true,
      }

      -- Setup LSP servers
      local lspconfig = require("lspconfig")

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Ignore 'vim' as undefined global
              },
            },
          },
        },
        pyright = {},
        rust_analyzer = {},
        gopls = {},
        ts_ls = {},
      }

      for name, opts in pairs(servers) do
        lspconfig[name].setup(opts)
      end

      -- Global keymaps for LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
      end, { desc = "Format Buffer" })
    end,
  },
}
