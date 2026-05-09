return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
  },
  opts = {
    window = { width = 0.85, options = { number = false, relativenumber = false } },
    plugins = {
      twilight = { enabled = true },
      tmux = { enabled = false },
      gitsigns = { enabled = false },
    },
  },
}
