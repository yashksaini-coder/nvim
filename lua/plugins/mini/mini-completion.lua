return {
  "echasnovski/mini.completion",
  version = "*",
  event = "InsertEnter",
  config = function()
    require("mini.completion").setup({
      -- Completion delays (ms)
      delay = {
        completion = 100,
        signature = 50,
      },

      -- Disable info window, keep signature help for function parameters
      window = {
        info = nil,
        signature = { height = 25, width = 80, border = nil },
      },

      -- LSP code completion only
      lsp_completion = {
        source_func = "completefunc",
        auto_setup = true,
      },

      -- Essential mappings
      mappings = {
        force_twostep = "<C-Space>",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
    })
  end,
}
