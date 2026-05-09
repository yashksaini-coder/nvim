return {
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end,
  },
}
