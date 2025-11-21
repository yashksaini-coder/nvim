return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
  opts = {
    use_diagnostic_signs = true,
    action_keys = {
      close = { "q", "<esc>" },
      cancel = "<c-e>",
      refresh = "r",
      jump = { "<cr>", "<tab>", "<2-leftmouse>" },
      jump_close = { "o" },
      toggle_mode = "m",
      switch_severity = "s",
      toggle_preview = "P",
      hover = "K",
      preview = "p",
      close_folds = { "zM", "zm" },
      open_folds = { "zR", "zr" },
      toggle_fold = { "zA", "za" },
      previous = "k",
      next = "j",
      help = "?",
    },
    modes = {
      diagnostics = {
        auto_open = 0,
        auto_preview = true,
        auto_jump = {},
        auto_fold = false,
        signs = {
          icons = {
            error = "✗",
            warning = "⚠",
            hint = "H",
            information = "i",
          },
          -- icons only, no text
          text = "",
        },
        filter = {},
        win = {
          position = "bottom",
          size = { height = 10 },
        },
      },
      workspace_diagnostics = {
        mode = "workspace",
        win = {
          position = "bottom",
          size = { height = 10 },
        },
      },
      document_diagnostics = {
        mode = "document",
        win = {
          position = "bottom",
          size = { height = 10 },
        },
      },
      quickfix = {
        mode = "quickfix",
        win = {
          position = "bottom",
          size = { height = 10 },
        },
      },
      loclist = {
        mode = "loclist",
        win = {
          position = "bottom",
          size = { height = 10 },
        },
      },
    },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
  end,
}

