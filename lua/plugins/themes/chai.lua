return {
  {
    "Shobhit-Nagpal/chai.nvim",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      require("chai").setup({
        transparent_background = true,
      })
    end,
  },
}
