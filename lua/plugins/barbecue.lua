return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    attach_navic = true,
    exclude_filetypes = { "alpha", "dashboard", "NvimTree", "toggleterm", "Trouble" },
  },
}
