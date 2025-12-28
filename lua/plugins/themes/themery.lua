return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "blue",
        "tokyonight",
        "tokyonight-storm",
        "tokyonight-night",
        "osmium",
        "chai",
        "gruvbox",
        "gruvbuddy",
        "oxocarbon",
      },
      livePreview = true, -- Apply theme while picking
    })
  end,
}
