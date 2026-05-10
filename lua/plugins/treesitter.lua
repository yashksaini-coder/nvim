-- nvim-treesitter on the `main` branch — the modern rewrite recommended for Neovim 0.11+.
-- The legacy `master` branch breaks on Neovim 0.12 because its query predicates use
-- the deprecated match-by-name API; `main` aligns with current core treesitter.
--
-- Trade-off: `main` does not bundle `incremental_selection` or `indent` modules.
-- If you miss the `<CR>` expanding-node selection, install treewalker.nvim or use
-- vim.treesitter.* APIs directly.
--
-- IMPORTANT: requires the `tree-sitter` CLI binary on $PATH to compile parsers.
-- On Arch the package is `tree-sitter-cli` (NOT `tree-sitter` — that's only the
-- C library). Alternatives: `cargo install tree-sitter-cli` or `npm i -g tree-sitter-cli`.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    -- `:TSUpdate` is a plugin-defined user command — invoked AFTER the plugin
    -- loads, unlike a function `build` which would run before module require.
    -- Requires the `tree-sitter` CLI on $PATH (Arch: `sudo pacman -S tree-sitter-cli`,
    -- cargo: `cargo install tree-sitter-cli`, npm: `npm i -g tree-sitter-cli`).
    build = ":TSUpdate",
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter")
      if not ok then
        return
      end

      -- Gate install on tree-sitter CLI presence. Without the CLI, `ts.install`
      -- prints noisy ENOENT errors on every startup. With it, install is
      -- idempotent — parsers already on disk are skipped.
      if vim.fn.executable("tree-sitter") ~= 1 then
        vim.schedule(function()
          vim.notify(
            "[nvim-treesitter] tree-sitter CLI missing — parsers won't auto-install. Install one of:\n"
              .. "  Arch:  sudo pacman -S tree-sitter-cli   (NOT 'tree-sitter' — that's only the C library)\n"
              .. "  cargo: cargo install tree-sitter-cli\n"
              .. "  npm:   npm i -g tree-sitter-cli",
            vim.log.levels.WARN
          )
        end)
        return
      end

      pcall(ts.install, {
        "bash",
        "c",
        "c_sharp",
        "cpp",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      })

      -- Enable treesitter highlighting on FileType. pcall'd so missing parsers
      -- (filetypes outside the list above) silently fall back to vim regex.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
