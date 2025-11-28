return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 200,
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>c", group = "colors" },
        { "<leader>e", group = "explorer" },
        { "<leader>ex", desc = "File Explorer" },
        { "<leader>f", group = "telescope" },
        { "<leader>fg", group = "git" },
        { "<leader>l", group = "lazy" },
        { "<leader>s", group = "showkeys" },
        { "<leader>t", group = "theme" },
      },
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      no_overlap = false,
      zindex = 1000,
      anchor = "NE",
      row = 1,
      col = -1, -- Align to the right edge
      width = { min = 20, max = 50 },
    },
    layout = {
      spacing = 3,
      align = "left",
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
      ellipsis = "…",
      colors = true,
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    -- Dynamically set col to the right edge
    opts.win.col = vim.o.columns
    wk.setup(opts)
  end,
}