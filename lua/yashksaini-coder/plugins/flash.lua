return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    -- Labels for jump targets
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      -- Search mode: "exact" | "smart" | "fuzzy" | "regex"
      mode = "exact",
      -- Exclude certain window types
      exclude = {
        "notify",
        "cmp_menu",
        "noice",
        "flash_prompt",
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "alpha"
        end,
      },
    },
    jump = {
      -- Automatically jump when there's only one match
      autojump = false,
      -- Jump to the first match if no label is provided
      nohlsearch = false,
      -- Position to jump to: "start" | "end" | "range"
      pos = "start",
    },
    label = {
      -- Show uppercase labels for better visibility
      uppercase = true,
      -- Show labels after the match
      after = { 0, 0 },
      -- Show labels before the match
      before = false,
      -- Style of the label: "overlay" | "inline" | "right_pos" | "after_cursor"
      style = "overlay",
      -- Flash the label when jumping
      flash = {
        jump = { enabled = true },
        search = { enabled = true },
        remote = { enabled = false },
      },
    },
    highlight = {
      -- Highlight backdrop (dim other text)
      backdrop = true,
      -- Highlight matches
      matches = true,
      -- Highlight groups
      groups = {
        FlashBackdrop = "Comment",
        FlashMatch = "Search",
        FlashCurrent = "IncSearch",
        FlashLabel = "Substitute",
      },
    },
    modes = {
      -- Character search mode (f, t, F, T)
      char = {
        enabled = true,
        -- Show jump labels for f/t/F/T
        jump_labels = true,
        -- Multi-window search
        multi_window = false,
        -- Highlight backdrop
        highlight = { backdrop = true },
        -- Flash the label when jumping
        flash = { jump = { enabled = true } },
      },
      -- Operator pending mode
      operator = {
        enabled = true,
      },
      -- Treesitter mode
      treesitter = {
        enabled = true,
        -- Jump to Treesitter nodes
        jump = { pos = "range" },
      },
      -- Treesitter search mode
      treesitter_search = {
        enabled = true,
        -- Jump to Treesitter nodes
        jump = { pos = "range" },
        -- Search mode
        search = { multi_window = true, wrap = true },
      },
      -- Remote flash (for operators)
      remote = {
        enabled = true,
      },
    },
    -- Prompt configuration
    prompt = {
      enabled = true,
      prefix = { { "⚡ ", "FlashPromptIcon" } },
      -- Position: "top" | "bottom" | "center"
      win_config = {
        relative = "editor",
        width = 1,
        height = 1,
        row = -1,
        col = 0,
        zindex = 1000,
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}