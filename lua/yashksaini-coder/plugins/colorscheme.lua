return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "storm", -- or "night" / "moon"
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    })
    vim.cmd("colorscheme tokyonight")
  end
}

