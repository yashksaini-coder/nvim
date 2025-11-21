return {
  "Shobhit-Nagpal/chai.nvim",
  dependencies = { "tjdevries/colorbuddy.nvim" }, -- REQUIRED for chai.nvim
  opts = {
    transparent = false,
    dim_inactive = true,
    italics = {
      comments = true,
      keywords = true,
      functions = false,
      variables = false,
    },
  },
  config = function(_, opts)
    require("chai").setup(opts)
    vim.cmd("colorscheme chai")
  end,
}

