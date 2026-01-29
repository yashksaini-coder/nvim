return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = function()
		local logo = [[
       ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
       ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
       ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
       ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
       ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
       ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
				-- stylua: ignore
				center = {
					{ action = "lua require('telescope.builtin').find_files()",           desc = " Find File",       icon = "🔍 ", key = "f" },
					{ action = "enew",                                                    desc = " New File",        icon = "📄 ", key = "n" },
					{ action = "lua require('telescope.builtin').oldfiles()",             desc = " Recent Files",    icon = "🕐 ", key = "r" },
					{ action = "lua require('telescope.builtin').live_grep()",            desc = " Find Text",       icon = "🔎 ", key = "g" },
					{ action = "lua require('telescope').extensions.project.project()",   desc = " Projects",        icon = "📂 ", key = "p" },
					{ action = "lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})", desc = " Config",          icon = "⚙️ ", key = "c" },
					{ action = "lua require('telescope.builtin').buffers()",         	  desc = " Buffers",         icon = "📋 ", key = "b" },
					{ action = "Lazy",                                                    desc = " Lazy",            icon = "💤 ", key = "l" },
					-- { action = "Lazy update",                                             desc = " Update Plugins",  icon = "⬇️ ", key = "u" },
					{ action = "Mason",                                                   desc = " Mason",           icon = "💤 ", key = "M" },
					-- { action = "Trouble diagnostics toggle",                              desc = " Diagnostics",     icon = "🐛 ", key = "d" },
					-- { action = "ToggleTerm",                                              desc = " Terminal",        icon = "💻 ", key = ";" },
					{ action = "qa",                                                      desc = " Quit",            icon = "⏻  ", key = "q" },
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		-- close Netrw and replace with dashboard
		-- open dashboard after closing lazy
		if vim.o.filetype == "lazy" then
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(vim.api.nvim_get_current_win()),
				once = true,
				callback = function()
					vim.schedule(function()
						vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
					end)
				end,
			})
		end

		return opts
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
