return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      -- A list of parser names, or "all"
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "markdown", "markdown_inline",
        "rust", "go", "python",
        "javascript", "typescript", "tsx", "json", "yaml",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        enable = true,

        -- Optionally disable for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Not recommended unless necessary.
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}

