return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "classic",
    delay = 200,
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 20 },
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
    icons = {
      mappings = true,
    },
    win = {
      padding = { 1, 2 },
    },
    layout = {
      height = { min = 10, max = 25 },
      width = { min = 20, max = 60 },
      spacing = 3,
      align = "left",
    },
    sort = { "local", "order", "group", "alphanum" },
    -- Spec registers groups and extra labels for your existing leader mappings
    spec = {
      -- groups
      { "<leader>l", group = "+lazy" },
      { "<leader>t", group = "+theme" },
      { "<leader>s", group = "+showkeys" },
      { "<leader>e", group = "+explorer" },
      { "<leader>c", group = "+code" },
      { "<leader>ca", desc = "Code Action" },
      { "<leader>cf", desc = "Format Buffer" },
      { "<leader>f", group = "+telescope" },
      { "<leader>fg", group = "+git" },
      { "<leader>n", group = "+config" },
      { "<leader>nc", desc = "Edit Neovim Config" },
      { "<leader>x", group = "+diagnostics" },
      { "<leader>r", group = "+rename" },
      { "<leader>rn", desc = "Rename Symbol" },
      { "<leader>w", group = "+workspace" },
      { "<leader>wa", desc = "Add Workspace Folder" },
      { "<leader>wr", desc = "Remove Workspace Folder" },
      { "<leader>wl", desc = "List Workspace Folders" },
      { "<leader>ws", desc = "Workspace Symbol" },

      -- single keys without explicit `desc` in mappings
      { "<leader>ex", desc = "File Explorer" },
    },
  },
  config = function(_, opts)
    -- ensure timeouts so which-key can capture leader sequences
    vim.o.timeout = true
    vim.o.timeoutlen = opts.delay or 300

    local wk = require("which-key")
    wk.setup(opts)
    if opts.spec then
      wk.add(opts.spec)
    end
  end,
}


