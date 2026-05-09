return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "alpha", "dashboard" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					{
						function()
							return require("dap").status()
						end,
						cond = function()
							return package.loaded["dap"] and require("dap").status() ~= ""
						end,
						icon = { "", color = { fg = "#e7c664" } },
					},
					"aerial",
					"encoding",
					"fileformat",
					"filetype",
					{
						function()
							local ok, pomo = pcall(require, "pomo")
							if not ok then
								return ""
							end
							local timer = pomo.get_first_to_finish()
							if timer == nil then
								return ""
							end
							return "🍅 " .. tostring(timer)
						end,
					},
					{
						function()
							return os.date("%H:%M")
						end,
						icon = "🕐",
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "nvim-tree", "lazy", "toggleterm", "aerial" },
		})
	end,
}
