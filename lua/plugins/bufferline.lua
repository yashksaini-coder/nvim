local keys = {
	{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
	{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
	{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
	{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
	{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	{ "<leader>bm", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer next" },
	{ "<leader>bM", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer prev" },
}
-- Jump to buffer by ordinal position in the bufferline: <leader>b1..b9
for i = 1, 9 do
	table.insert(keys, {
		"<leader>b" .. i,
		"<cmd>BufferLineGoToBuffer " .. i .. "<cr>",
		desc = "Go to buffer " .. i,
	})
end

return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = keys,
	opts = {
		options = {
			close_command = function(n)
				vim.cmd("bdelete " .. n)
			end,
			right_mouse_command = function(n)
				vim.cmd("bdelete " .. n)
			end,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			diagnostics_indicator = function(_, _, diag)
				local icons = {
					Error = " ",
					Warn = " ",
					Hint = " ",
					Info = " ",
				}
				local ret = (diag.error and icons.Error .. diag.error .. " " or "")
					.. (diag.warning and icons.Warn .. diag.warning or "")
				return vim.trim(ret)
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "left",
					separator = true,
				},
			},
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			separator_style = "slant",
			mode = "buffers",
			themable = true,
			numbers = "none",
			buffer_close_icon = "",
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 18,
			max_prefix_length = 15,
			tab_size = 20,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			persist_buffer_sort = true,
			enforce_regular_tabs = false,
			color_icons = true,
			get_element_icon = function(element)
				local icon, hl =
					require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
				return icon, hl
			end,
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd("BufAdd", {
			callback = function()
				vim.schedule(function()
					pcall(require("bufferline").refresh)
				end)
			end,
		})
	end,
}
