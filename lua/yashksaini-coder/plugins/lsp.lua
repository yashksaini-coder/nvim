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

      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",          -- Lua
          "pyright",         -- Python
          "rust_analyzer",   -- Rust
          "gopls",           -- Go
          "ts_ls",           -- TypeScript/JavaScript (replaces tsserver)
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            local opts = servers[server_name] or {}
            -- Use vim.lsp.config if available (Neovim 0.12+), otherwise use lspconfig
            -- In Neovim 0.12+, vim.lsp.config is populated by nvim-lspconfig
            local config = vim.lsp.config or require("lspconfig")
            if config[server_name] and config[server_name].setup then
              config[server_name].setup(opts)
            elseif config.server then
              -- Alternative API structure
              config.server(server_name, opts)
            else
              -- Final fallback
              require("lspconfig")[server_name].setup(opts)
            end
          end,
        },
      }

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
