return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
    local keys = {
      {
        "<leader>ja",
        function()
          harpoon:list():add()
        end,
        desc = "Harpoon: add file",
      },
      {
        "<leader>jj",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon: menu",
      },
    }
    for i = 1, 5 do
      table.insert(keys, {
        "<leader>j" .. i,
        function()
          harpoon:list():select(i)
        end,
        desc = "Harpoon to file " .. i,
      })
    end
    return keys
  end,
}
