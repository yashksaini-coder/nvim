return {
  "alexpasmantier/krust.nvim",
  ft = "rust",
  opts = {
    keymap = "<leader>kd", -- Toggle Krust diagnostic window
    float_win = {
      border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
      auto_focus = false, -- Auto-focus float window (default: false)
    },
  },
}
