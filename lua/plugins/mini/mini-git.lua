return {
  "nvim-mini/mini-git",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Git job configuration
    job = {
      git_executable = "git",
      timeout = 30000,
    },

    -- :Git command configuration
    command = {
      split = "auto", -- 'auto', 'horizontal', or 'vertical'
    },
  },
  config = function(_, opts)
    require("mini.git").setup(opts)
  end,
}
