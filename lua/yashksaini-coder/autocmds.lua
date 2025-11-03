-- Autocmds configuration
-- These are loaded immediately as they need to be set up early

-- Create augroups
local transparent_bg = vim.api.nvim_create_augroup("TransparentBG", { clear = true })
local highlight_yank = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
local restore_cursor = vim.api.nvim_create_augroup("RestoreCursor", { clear = true })
local resize_splits = vim.api.nvim_create_augroup("ResizeSplits", { clear = true })
local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
local file_type_specific = vim.api.nvim_create_augroup("FileTypeSpecific", { clear = true })

-- Transparent background
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = transparent_bg,
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = restore_cursor,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = resize_splits,
  pattern = "*",
  command = "wincmd =",
})

-- Format on save is handled by conform.nvim plugin configuration
-- No need for separate autocmd here as conform handles it

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
  group = file_type_specific,
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Enable spell checking for git commits
vim.api.nvim_create_autocmd("FileType", {
  group = file_type_specific,
  pattern = { "gitcommit", "gitrebase" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = file_type_specific,
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Make it easier to close quickfix, location list and other windows
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = file_type_specific,
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
  end,
})

