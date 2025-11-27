return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
    "folke/tokyonight.nvim"
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Cyberpunk ASCII Header
    dashboard.section.header.val = {
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "",
    [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗██╗]],
    [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║██║]],
    [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║██║]],
    [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║╚═╝]],
    [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║██╗]],
    [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝]],
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "",
    }

    -- Buttons with cyberpunk icons
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "󰄉  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
      dashboard.button("l", "󰒲  Lazy Plugins", ":Lazy<CR>"),
      dashboard.button("u", "  Update Plugins", ":Lazy update<CR>"),
      dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
    }

    -- Footer
    dashboard.section.footer.val = {
      "",
    }

    -- Apply theme highlights
    dashboard.section.header.opts.hl = "Type"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Comment"

    alpha.setup(dashboard.opts)

    -- Configure dashboard buffer to prevent scrolling and hide tildes
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      desc = "Disable status and tablines for alpha",
      callback = function()
        -- Hide statusline and tabline for alpha buffer
        vim.opt.laststatus = 0
        vim.opt.showtabline = 0
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          callback = function()
            vim.opt.laststatus = 3  -- Restore global statusline
            vim.opt.showtabline = 2  -- Restore tabline
          end,
        })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      desc = "Configure alpha buffer settings",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local win = vim.api.nvim_get_current_win()
        
        -- Buffer options
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].modifiable = false
        vim.bo[buf].filetype = "alpha"
        
        -- Window options - prevent scrolling
        vim.wo[win].number = false
        vim.wo[win].relativenumber = false
        vim.wo[win].wrap = false
        vim.wo[win].scrolloff = 0
        vim.wo[win].sidescrolloff = 0
        vim.wo[win].foldcolumn = "0"
        vim.wo[win].signcolumn = "no"
        
        -- Hide EndOfBuffer (tildes) by making them match the background
        local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
        local bg_color = normal_hl.bg or "NONE"
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg_color, bg = bg_color, default = false })
        
        -- Set fillchars to replace tilde with space
        vim.opt_local.fillchars = { eob = " " }
      end,
    })
  end,
}
