return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false, -- needed when starting with `nvim <dir>`
	opts = {
		default_file_explorer = false, -- coexist with nvim-tree
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		view_options = { show_hidden = true },
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-v>"] = "actions.select_vsplit",
			["<C-x>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["-"] = "actions.parent",
			["g."] = "actions.toggle_hidden",
		},
	},
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Oil: open parent directory" },
	},
}
