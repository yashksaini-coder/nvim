return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- Icon provider for code block language icons
  },
  config = function()
    require("render-markdown").setup({
      -- File types to enable rendering for
      file_types = { "markdown" },
    })
  end,
  keys = {
    -- Toggle markdown rendering
    { "<leader>mp", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown rendering" },
  },
}
