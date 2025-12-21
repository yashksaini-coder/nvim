return {
  "nvim-mini/mini.diff",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Options for computing diff
    options = {
      algorithm = "histogram",
      indent_heuristic = true,
      linematch = 60, -- Threshold for linematch (number of lines)
      word_diff = false,
    },

    -- Module mappings
    mappings = {
      apply = "gha",
      reset = "ghr",
      textobject = "h",
    },

    -- Highlight groups
    highlight = {
      add = "DiffAdd",
      change = "DiffChange",
      delete = "DiffDelete",
      text = "DiffText",
    },

    -- View options
    view = {
      style = "sign",
      priority = 200,
    },
  },
  config = function(_, opts)
    local diff = require("mini.diff")
    -- Generate proper source functions
    opts.source = diff.gen_source.git()
    diff.setup(opts)
  end,
}
