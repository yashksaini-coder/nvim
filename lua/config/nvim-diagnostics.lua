-- Diagnostic Configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  severity_sort = true,
  update_in_insert = false, -- Disabled: re-computing on every keystroke is expensive
  float = {
    border = "rounded",
    focusable = true,
    source = true,
  },
})

-- Override floating preview to ensure borders and size
local _open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded" -- Using rounded instead of double for consistency
  opts.max_width = opts.max_width or 80
  opts.max_height = opts.max_height or 20
  return _open_floating_preview(contents, syntax, opts, ...)
end

-- NOTE: vim.lsp.handlers["textDocument/hover"] with vim.lsp.with() is deprecated.
-- The open_floating_preview override above already handles borders for all LSP floats.

-- NOTE: CursorHold auto-diagnostic float removed — it fires every 300ms (updatetime),
-- overlaps with noice.nvim hover/signature floats, and fights with manual <leader>d.
-- Use <leader>d to show diagnostics on demand instead.

-- Keymap to show diagnostics
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "Show diagnostics" })
