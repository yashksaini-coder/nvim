-- Buffer tabs at the top. romgrk/barbar.nvim replaces akinsho/bufferline.nvim.
local keys = {
	-- switch
	{ "<S-h>", "<Cmd>BufferPrevious<CR>", desc = "Prev buffer" },
	{ "<S-l>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
	{ "[b", "<Cmd>BufferPrevious<CR>", desc = "Prev buffer" },
	{ "]b", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
	-- reorder
	{ "<leader>bm", "<Cmd>BufferMoveNext<CR>", desc = "Move buffer next" },
	{ "<leader>bM", "<Cmd>BufferMovePrevious<CR>", desc = "Move buffer prev" },
	-- close
	{ "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close other buffers" },
	{ "<leader>br", "<Cmd>BufferCloseBuffersRight<CR>", desc = "Close buffers right" },
	{ "<leader>bl", "<Cmd>BufferCloseBuffersLeft<CR>", desc = "Close buffers left" },
	-- pin
	{ "<leader>bp", "<Cmd>BufferPin<CR>", desc = "Toggle pin" },
	{ "<leader>bP", "<Cmd>BufferCloseAllButPinned<CR>", desc = "Close non-pinned" },
	-- letter-pick
	{ "<leader>bb", "<Cmd>BufferPick<CR>", desc = "Pick buffer (letter)" },
}
-- Direct jump: <leader>b1..b9 → position in the barbar strip
for i = 1, 9 do
	table.insert(keys, {
		"<leader>b" .. i,
		"<Cmd>BufferGoto " .. i .. "<CR>",
		desc = "Go to buffer " .. i,
	})
end

return {
	"romgrk/barbar.nvim",
	event = "VeryLazy",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		animation = true,
		auto_hide = false,
		tabpages = true,
		clickable = true,
		focus_on_close = "left",
		hide = { extensions = false, inactive = false },
		highlight_visible = true,
		icons = {
			buffer_index = false,
			buffer_number = false,
			button = "",
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "󰅚 " },
				[vim.diagnostic.severity.WARN] = { enabled = true, icon = "󰀪 " },
				[vim.diagnostic.severity.INFO] = { enabled = false },
				[vim.diagnostic.severity.HINT] = { enabled = false },
			},
			filetype = { enabled = true, custom_colors = false },
			modified = { button = "●" },
			pinned = { button = "󰐃", filename = true },
			separator = { left = "▎", right = "" },
			separator_at_end = true,
			inactive = { separator = { left = "▎", right = "" } },
		},
		maximum_padding = 1,
		minimum_padding = 1,
		maximum_length = 30,
		semantic_letters = true,
		-- Leave room for neo-tree pane on the left
		sidebar_filetypes = {
			["neo-tree"] = { event = "BufWipeout", text = "" },
		},
	},
	keys = keys,
}
