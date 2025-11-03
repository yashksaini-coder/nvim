return {
  "goolord/alpha-nvim",
  enabled = true,
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- Disable statusline and tabline on startup if no file is opened
    if vim.fn.argc() == 0 then
      vim.opt.laststatus = 0
      vim.opt.showtabline = 0
    end
  end,
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                                    ",
      "                                                                    ",
      "    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗             ",
      "    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║             ",
      "    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║             ",
      "    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║             ",
      "    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║             ",
      "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝             ",
      "                                                                    ",
      "                    ╭───────────────────────────╮                  ",
      "                    │  yashksaini-coder config  │                  ",
      "                    │    Enhanced Neovim Setup  │                  ",
      "                    ╰───────────────────────────╯                  ",
      "                                                                    ",
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("n", "󰎔  New File", "<cmd>ene <BAR> startinsert<CR>"),
      dashboard.button("r", "󰄉  Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "󰈬  Find Text", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("c", "󰒓  Configuration", "<cmd>lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config'), hidden = true})<CR>"),
      dashboard.button("s", "󰥔  Sessions", "<cmd>Telescope find_files cwd=~/.local/share/nvim/sessions<CR>"),
      dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("q", "󰗼  Quit", "<cmd>qa<CR>"),
    }

    -- Footer with version info
    local function footer()
      local datetime = os.date("  %d-%m-%Y  %H:%M:%S")
      local version = vim.version()
      local nvim_version = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch
      return datetime .. "  ·  פּ Arch Linux" .. nvim_version
    end

    dashboard.section.footer.val = footer()

    -- Highlight groups
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Function"
    dashboard.section.footer.opts.hl = "Type"

    -- Setup with auto-show on startup
    alpha.setup(dashboard.opts)

    -- Show dashboard if no file arguments
    if vim.fn.argc() == 0 then
      alpha.start(false, dashboard.opts)
    end

    -- Disable statusline on dashboard
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      desc = "disable statuslines for alpha",
      callback = function()
        local prev_laststatus = vim.opt.laststatus
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          callback = function()
            vim.opt.laststatus = prev_laststatus
          end,
        })
        vim.opt.laststatus = 0
      end,
    })

    -- Disable tabline on dashboard
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.opt.showtabline = 0
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          callback = function()
            vim.opt.showtabline = 2
          end,
        })
      end,
    })
  end,
}
