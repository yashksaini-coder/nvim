return {
  "greggh/claude-code.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume", "ClaudeCodeVerbose" },
  opts = {
    window = {
      split_ratio = 0.4,
      position = "vertical",
      enter_insert = true,
      hide_numbers = true,
      hide_signcolumn = true,
    },
    refresh = { enable = true, updatetime = 100, timer_interval = 1000 },
    git = { use_git_root = true },
    shell = { separator = "&&", pushd_cmd = "pushd", popd_cmd = "popd" },
    command = "claude",
    command_variants = {
      continue = "--continue",
      resume = "--resume",
      verbose = "--verbose",
    },
    keymaps = {
      toggle = { normal = false, terminal = false }, -- we set our own below
      window_navigation = true,
      scrolling = true,
    },
  },
  keys = {
    { "<leader>ic", "<cmd>ClaudeCode<cr>", desc = "Claude Code: toggle" },
    { "<leader>iC", "<cmd>ClaudeCodeContinue<cr>", desc = "Claude Code: continue" },
    { "<leader>iR", "<cmd>ClaudeCodeResume<cr>", desc = "Claude Code: resume" },
    { "<leader>iv", "<cmd>ClaudeCodeVerbose<cr>", desc = "Claude Code: verbose" },
  },
}
