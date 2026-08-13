-- Bottom statusline (globalstatus, single) + top winbar per window.
-- All icons use nf-md-* (4-byte) which the user's nerd font renders reliably.
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local diag_icons = {
			error = "󰅚 ",
			warn = "󰀪 ",
			info = "󰋽 ",
			hint = "󰌶 ",
		}
		local diff_icons = {
			added = "󰐕 ",
			modified = "󰆗 ",
			removed = "󰍶 ",
		}
		local file_symbols = { modified = "󰆓 ", readonly = "󰌾 ", unnamed = "[No Name]", newfile = "󰝒 " }
		local hidden_ft = { "dashboard", "snacks_dashboard", "neo-tree", "TelescopePrompt", "lazy", "mason", "help" }

		return {
			options = {
				theme = "auto",
				globalstatus = true, -- one statusline for the whole editor
				section_separators = { left = "", right = "" },
				component_separators = { left = "│", right = "│" },
				disabled_filetypes = {
					statusline = { "dashboard", "snacks_dashboard" },
					winbar = hidden_ft,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch", icon = "󰊢" },
					{ "diff", symbols = diff_icons },
				},
				lualine_c = {
					{ "diagnostics", symbols = diag_icons },
					{ "filename", path = 1, symbols = file_symbols },
				},
				lualine_x = {
					{ "filetype", colored = true, icon_only = false },
					"encoding",
					"fileformat",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			winbar = {
				lualine_c = {
					{ "filename", path = 3, symbols = file_symbols },
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = diag_icons,
						sections = { "error", "warn" },
					},
				},
			},
			inactive_winbar = {
				lualine_c = {
					{ "filename", path = 1, symbols = file_symbols },
				},
			},
			extensions = { "neo-tree", "lazy", "mason", "trouble" },
		}
	end,
}
