return {
  "epwalsh/pomo.nvim",
  version = "*",
  dependencies = { "rcarriga/nvim-notify" },
  cmd = { "TimerStart", "TimerStop", "TimerRepeat", "TimerHide", "TimerShow" },
  keys = {
    {
      "<leader>pp",
      function()
        vim.cmd("TimerStart " .. (vim.fn.input("Duration (e.g. 25m): ", "25m")))
      end,
      desc = "Pomo: start",
    },
    { "<leader>pP", "<cmd>TimerRepeat 25m Pomodoro<cr>", desc = "Pomo: repeat 25m" },
    { "<leader>ps", "<cmd>TimerStop<cr>", desc = "Pomo: stop" },
    { "<leader>ph", "<cmd>TimerHide<cr>", desc = "Pomo: hide" },
    { "<leader>pS", "<cmd>TimerShow<cr>", desc = "Pomo: show" },
  },
  opts = {
    notifiers = {
      { name = "Default", opts = { sticky = true, title_icon = "🍅", text_icon = "⏳" } },
    },
    sessions = {
      pomodoro = {
        { name = "Work", duration = "25m" },
        { name = "Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "LongBreak", duration = "20m" },
      },
    },
  },
}
