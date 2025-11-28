return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "storm", -- or "night" / "moon"
      transparent = false,
      dim_inactive = true, -- dims inactive windows
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    })
    vim.cmd("colorscheme tokyonight")
  end
}

