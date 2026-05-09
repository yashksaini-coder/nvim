return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Adapters
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-plenary",
  },
  cmd = { "Neotest" },
  keys = {
    {
      "<leader>nt",
      function()
        require("neotest").run.run()
      end,
      desc = "Test nearest",
    },
    {
      "<leader>nf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Test file",
    },
    {
      "<leader>nd",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest",
    },
    {
      "<leader>nl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Test last",
    },
    {
      "<leader>ns",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle summary",
    },
    {
      "<leader>no",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Test output",
    },
    {
      "<leader>nO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>nx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop test",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({ dap = { justMyCode = false } }),
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-jest"),
        require("neotest-plenary"),
      },
      output = { open_on_run = false },
      quickfix = { enabled = false, open = false },
      status = { virtual_text = true },
    })
  end,
}
