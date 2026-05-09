-- fff.nvim keymaps (Search Fast File Finder)
-- These are mapped to <leader>s (Search) to distinguish from Telescope (<leader>f)

vim.keymap.set("n", "<leader>sf", function()
  require("fff").find_files()
end, {
  desc = "Search: find files (fff)",
})

vim.keymap.set("n", "<leader>sg", function()
  require("fff").live_grep()
end, {
  desc = "Search: live grep (fff)",
})

vim.keymap.set("n", "<leader>sh", function()
  require("fff").help()
end, {
  desc = "Search: help (fff)",
})
