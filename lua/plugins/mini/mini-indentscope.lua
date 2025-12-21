return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      char = "│",
      only_scope = false,
      only_current = false,
      hl = "SnacksIndent",
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = {
          step = 20,
          total = 500,
        },
      },
      scope = {
        enabled = true,
        char = "│",
        underline = false,
        only_current = false,
        hl = "SnacksIndentScope",
      },
      chunk = {
        enabled = false,
      },
      filter = function(buf)
        local exclude_ft = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "nvim-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        }
        local ft = vim.bo[buf].filetype
        for _, exclude in ipairs(exclude_ft) do
          if ft == exclude then
            return false
          end
        end
        return vim.g.snacks_indent ~= false
          and vim.b[buf].snacks_indent ~= false
          and vim.bo[buf].buftype == ""
      end,
    },
  },
}
