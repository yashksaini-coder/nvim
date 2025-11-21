return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
  },
  opts = {
    options = {
      -- Mode: "buffers" | "tabs"
      mode = "buffers",
      -- Style: "slant" | "slope" | "thick" | "thin" | nil
      style_preset = nil,
      -- Show buffer close icons
      themable = true,
      numbers = "none", -- "none" | "ordinal" | "buffer_id" | function
      close_command = "bdelete! %d", -- can be a string | function
      right_mouse_command = "bdelete! %d", -- can be a string | function
      left_mouse_command = "buffer %d", -- can be a string | function
      middle_mouse_command = nil, -- can be a string | function
      indicator = {
        icon = "▎",
        style = "icon",
      },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "󰅖",
      left_trunc_marker = "",
      right_trunc_marker = "",
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use with caution at your own risk.
      name_formatter = function(buf) -- buf contains:
        -- name                | str        | the basename of the active file
        -- path                | str        | the full path of the active file
        -- bufnr (buffer only) | int        | the number of the active buffer
        -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
        -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        return buf.name
      end,
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 18,
      diagnostics = "nvim_lsp", -- "nvim_lsp" | "coc" | false
      diagnostics_update_in_insert = false,
      -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "alpha" then
          return true
        end
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        },
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        },
      },
      color_icons = true, -- whether or not to add the filetype icon highlights
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      sort_by = "insert_after_current", -- "insert_at_end" | "insert_after_current" | "id" | "extension" | "relative_directory" | "directory" | "tabs" | function
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}

