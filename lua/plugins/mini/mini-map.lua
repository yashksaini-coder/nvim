return {
  "echasnovski/mini.map",
  version = "*",
  lazy = false,
  config = function()
    local map = require("mini.map")
    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diff(),
        map.gen_integration.diagnostic(),
      },

      symbols = {
        encode = nil,

        -- Scrollbar parts for view and line. Use empty string to disable any.
        scroll_line = "█",
        scroll_view = "┃",
        -- encode = map.gen_encode_symbols.dot("4x2")
      },
      window = {
        side = "right",
        width = 10, -- set to 1 for a pure scrollbar-like view
        winblend = 15,
        show_integration_count = false,
      },
    })
  end,
}
