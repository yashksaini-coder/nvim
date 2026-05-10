return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- refactoring.nvim 1.x (Neovim 0.12+) requires lewis6991/async.nvim at runtime;
    -- without this dep, `require("async")` at refactoring.lua:45 fails on first load.
    "lewis6991/async.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  keys = {
    {
      "<leader>Re",
      function()
        require("refactoring").refactor("Extract Function")
      end,
      mode = "x",
      desc = "Extract function",
    },
    {
      "<leader>Rf",
      function()
        require("refactoring").refactor("Extract Function To File")
      end,
      mode = "x",
      desc = "Extract to file",
    },
    {
      "<leader>Rv",
      function()
        require("refactoring").refactor("Extract Variable")
      end,
      mode = "x",
      desc = "Extract variable",
    },
    {
      "<leader>Ri",
      function()
        require("refactoring").refactor("Inline Variable")
      end,
      mode = { "n", "x" },
      desc = "Inline variable",
    },
    {
      "<leader>RI",
      function()
        require("refactoring").refactor("Inline Function")
      end,
      mode = "n",
      desc = "Inline function",
    },
    {
      "<leader>RB",
      function()
        require("refactoring").refactor("Extract Block")
      end,
      mode = "n",
      desc = "Extract block",
    },
    {
      "<leader>Rr",
      function()
        require("refactoring").select_refactor()
      end,
      mode = { "n", "x" },
      desc = "Select refactor",
    },
  },
}
