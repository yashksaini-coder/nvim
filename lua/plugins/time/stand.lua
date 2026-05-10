-- NOTE: samharju/stand.nvim does not exist on GitHub; disabled until a
-- working RSI-reminder plugin is identified.
return {
  "samharju/stand.nvim",
  enabled = false,
  event = "VeryLazy",
  opts = {
    minute_interval = 50,
    startup_notification = false,
  },
}
