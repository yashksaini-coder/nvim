return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require("go").setup({
      -- We let Mason manage gopls; go.nvim only adds commands and helpers.
      disable_defaults = false,
      lsp_cfg = false,
      lsp_keymaps = false,
      lsp_inlay_hints = { enable = false }, -- already covered by gopls settings
      dap_debug = true,
      test_runner = "go",
      run_in_floaterm = true,
    })

    -- Format + import organize on save
    local fmt = vim.api.nvim_create_augroup("go-format", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      group = fmt,
      callback = function()
        require("go.format").goimports()
      end,
    })
  end,
}
