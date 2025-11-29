local function map(cmd)
  return function()
    local ok, minimap = pcall(require, "mini.map")
    if not ok then
      vim.notify("mini.map not found. Is the plugin installed?", vim.log.levels.ERROR)
      return
    end
    if minimap[cmd] then
      minimap[cmd]()
    else
      vim.notify("mini.map function '" .. cmd .. "' not found.", vim.log.levels.ERROR)
    end
  end
end

vim.keymap.set("n", "<Leader>mt", map("toggle"), { desc = "Toggle Mini Map" })
vim.keymap.set("n", "<Leader>mo", map("open"), { desc = "Open Mini Map" })
vim.keymap.set("n", "<Leader>mc", map("close"), { desc = "Close Mini Map" })
vim.keymap.set("n", "<Leader>mf", map("toggle_focus"), { desc = "Focus Mini Map" })
vim.keymap.set("n", "<Leader>mr", map("refresh"), { desc = "Refresh Mini Map" })
vim.keymap.set("n", "<Leader>ms", map("toggle_side"), { desc = "Toggle Mini Map Side" })
