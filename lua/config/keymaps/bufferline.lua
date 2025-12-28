-- Bufferline keymaps

vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
vim.keymap.set(
  "n",
  "<leader>bP",
  "<Cmd>BufferLineGroupClose ungrouped<CR>",
  { desc = "Delete Non-Pinned Buffers" }
)
vim.keymap.set(
  "n",
  "<leader>bo",
  "<Cmd>BufferLineCloseOthers<CR>",
  { desc = "Delete Other Buffers" }
)
vim.keymap.set(
  "n",
  "<leader>br",
  "<Cmd>BufferLineCloseRight<CR>",
  { desc = "Delete Buffers to the Right" }
)
vim.keymap.set(
  "n",
  "<leader>bl",
  "<Cmd>BufferLineCloseLeft<CR>",
  { desc = "Delete Buffers to the Left" }
)
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
