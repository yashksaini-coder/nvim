-- Custom highlights
-- This file contains custom highlight groups for better visual experience

local function setup_highlights()
  -- Better search highlighting
  vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5C6370", fg = "#ABB2BF" })

  -- Better visual selection
  vim.api.nvim_set_hl(0, "Visual", { bg = "#3E4452", fg = nil })

  -- Better cursor line
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2C313C", fg = nil })

  -- Better line numbers
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#5C6370", bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#61AFEF", bg = "none", bold = true })

  -- Better sign column (for diagnostics)
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

  -- Better status line
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "none", fg = "#ABB2BF" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", fg = "#5C6370" })

  -- Better floating windows
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5C6370", bg = "none" })

  -- Better Pmenu (completion menu)
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#21252B", fg = "#ABB2BF" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3E4452", fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#21252B" })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#5C6370" })

  -- Better diagnostics
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#56B6C2" })

  -- Better virtual text
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#E06C75", bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#E5C07B", bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#61AFEF", bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#56B6C2", bg = "none" })

  -- Better diff
  vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#98C379", bg = "#2E3B2E" })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = "#61AFEF", bg = "#2E3B3E" })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#E06C75", bg = "#3E2E2E" })
  vim.api.nvim_set_hl(0, "DiffText", { fg = "#61AFEF", bg = "#2E3B3E", bold = true })

  -- Better Git signs
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#E06C75" })
end

-- Apply highlights on startup and when colorscheme changes
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  pattern = "*",
  callback = setup_highlights,
})

-- Apply immediately
setup_highlights()

