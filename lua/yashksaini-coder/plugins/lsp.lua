return {
  -- Mason for managing LSP/DAP/Linters/Formatters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  -- Bridge between mason & lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "pyright", -- Python
          "rust_analyzer", -- Rust
          "gopls", -- Go
          "tsserver", -- TypeScript/JavaScript (fixed from deprecated ts_ls)
        },
        automatic_installation = true,
      })

      -- Setup LSP servers
      local lspconfig = require("lspconfig")

      -- Load on_attach function from keymaps
      local on_attach = require("yashksaini-coder.keymaps.lsp")

      -- Enhanced capabilities for better LSP features
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Safely load cmp_nvim_lsp if available (for better completion integration)
      local cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_nvim_lsp then
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      end
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Ignore 'vim' as undefined global
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
              },
            },
          },
        },
        pyright = {},
        rust_analyzer = {},
        gopls = {},
        tsserver = {},
      }

      -- Setup each server
      for name, opts in pairs(servers) do
        opts = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, opts or {})
        lspconfig[name].setup(opts)
      end

      -- Diagnostic configuration
      local signs = {
        { name = "DiagnosticSignError", text = "✗" },
        { name = "DiagnosticSignWarn", text = "⚠" },
        { name = "DiagnosticSignHint", text = "H" },
        { name = "DiagnosticSignInfo", text = "i" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
          texthl = sign.name,
          text = sign.text,
          numhl = "",
        })
      end

      local config = {
        virtual_text = true,
        signs = {
          active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }

      vim.diagnostic.config(config)

      -- Show diagnostics on hover
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = 0,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, opts)
        end,
      })
    end,
  },
}
