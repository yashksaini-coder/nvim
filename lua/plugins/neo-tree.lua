-- Persistent side-panel file tree. Modern successor to nvim-tree.
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer (Neo-tree)" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = true,
		filesystem = {
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			-- Don't hijack directory buffers: on `nvim .` we want snacks.dashboard
			-- to own the main window; neo-tree opens on the side via an autocmd.
			hijack_netrw_behavior = "disabled",
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		},
		window = {
			width = 32,
			mappings = {
				["<space>"] = "none", -- free up <leader> inside the tree
			},
		},
		default_component_configs = {
			indent = { with_markers = true, indent_marker = "│", last_indent_marker = "└" },
			git_status = { symbols = { added = "+", modified = "~", deleted = "-", renamed = "→" } },
		},
	},
}
