return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		-- Suppress session management in these directories
		suppressed_dirs = {
			"~/",
			"~/Projects",
			"~/Downloads",
			"/",
		},

		-- Bypass save for dashboard and other special filetypes
		bypass_save_filetypes = {
			"alpha",
			"dashboard",
			"snacks_dashboard",
		},

		-- Auto-save and restore settings
		auto_save = true,
		auto_restore = true,

		-- Session lens (Telescope integration)
		session_lens = {
			buftypes_to_ignore = {},
			load_on_setup = true,
		},

		-- Pre-save commands: close nvim-tree before saving
		pre_save_cmds = {
			"tabdo NvimTreeClose",
		},

		-- Post-restore commands: reopen nvim-tree after restoring
		post_restore_cmds = {
			function()
				-- Restore nvim-tree if it was open
				local nvim_tree_api = require("nvim-tree.api")
				nvim_tree_api.tree.open()
				nvim_tree_api.tree.change_root(vim.fn.getcwd())
			end,
		},

		-- Log level (set to 'debug' for troubleshooting)
		-- log_level = 'info',
	},
	config = function(_, opts)
		local auto_session = require("auto-session")
		auto_session.setup(opts)

		-- Load Telescope extension for session picker (if available)
		local ok, _ = pcall(require("telescope").load_extension, "session-lens")
		if not ok then
			-- Try alternative extension name
			pcall(require("telescope").load_extension, "auto_session")
		end
	end,
	keys = {
		-- Session management keymaps (using 's' prefix to avoid conflicts with Telescope)
		{ "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save session" },
		{ "<leader>sr", "<cmd>SessionRestore<cr>", desc = "Restore session" },
		{ "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
		{
			"<leader>sS",
			function()
				-- Use Telescope session-lens if available
				local ok = pcall(function()
					require("telescope").extensions["session-lens"].search_session()
				end)
				if not ok then
					-- Fallback: use vim.ui.select
					require("auto-session").list_sessions()
				end
			end,
			desc = "Search sessions",
		},
	},
}
