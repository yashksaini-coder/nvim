-- ============================================================================
-- ToggleTerm - Integrated Terminal Management
-- ============================================================================

-- Constants
local HORIZONTAL_SIZE = 15
local VERTICAL_SIZE_RATIO = 0.4

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    -- Size configuration
    size = function(term)
      if term.direction == "horizontal" then
        return HORIZONTAL_SIZE
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * VERTICAL_SIZE_RATIO)
      end
      return nil
    end,

    -- General settings
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,

    -- Float window options
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },

    -- Winbar configuration
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}