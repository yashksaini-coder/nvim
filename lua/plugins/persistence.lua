return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- Start session saving when an actual file is opened
  opts = {
    -- Directory where session files are saved
    dir = vim.fn.stdpath("state") .. "/sessions/",
    
    -- Minimum number of file buffers that need to be open to save
    -- Set to 0 to always save, 1 is default (at least one file buffer)
    need = 1,
    
    -- Use git branch to save session (creates separate sessions per branch)
    branch = true,
  },
  keys = {
    -- Load the session for the current directory
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    
    -- Select a session to load (shows picker)
    { "<leader>qS", function() require("persistence").select() end, desc = "Select Session" },
    
    -- Load the last session
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    
    -- Stop Persistence => session won't be saved on exit
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}
