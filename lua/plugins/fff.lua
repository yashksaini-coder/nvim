return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  -- The plugin handles its own lazy loading for indexing
  lazy = false,
  opts = {
    -- You can add custom configuration here
    prompt = "🪿 ",
  },
}
