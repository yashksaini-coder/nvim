return {
  "echasnovski/mini.bufremove",
  keys = {
    {
      "<leader>bD",
      function()
        require("mini.bufremove").delete(0, true)
      end,
      desc = "Delete buffer (force, keep window)",
    },
    {
      "<leader>bx",
      function()
        require("mini.bufremove").delete(0, false)
      end,
      desc = "Delete buffer (keep window)",
    },
  },
}
