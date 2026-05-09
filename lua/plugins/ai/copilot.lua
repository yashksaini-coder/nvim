return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>", -- Alt-l accept full suggestion
          accept_word = "<M-w>",
          accept_line = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
        gitrebase = true,
        ["."] = false,
      },
    },
  },
  -- Copilot Chat UI
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatReview" },
    opts = {
      window = { layout = "vertical", width = 0.4, border = "rounded" },
    },
    keys = {
      { "<leader>iX", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
      {
        "<leader>ie",
        "<cmd>CopilotChatExplain<cr>",
        mode = { "n", "v" },
        desc = "Copilot explain",
      },
      { "<leader>ir", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "Copilot review" },
      { "<leader>iF", "<cmd>CopilotChatFix<cr>", mode = { "n", "v" }, desc = "Copilot fix" },
      {
        "<leader>iO",
        "<cmd>CopilotChatOptimize<cr>",
        mode = { "n", "v" },
        desc = "Copilot optimize",
      },
      { "<leader>iD", "<cmd>CopilotChatDocs<cr>", mode = { "n", "v" }, desc = "Copilot docs" },
      { "<leader>iT", "<cmd>CopilotChatTests<cr>", mode = { "n", "v" }, desc = "Copilot tests" },
    },
  },
}
