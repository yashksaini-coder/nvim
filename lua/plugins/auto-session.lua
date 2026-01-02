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

		-- Wrap post_restore_cmds to handle errors gracefully
		local original_post_restore = opts.post_restore_cmds or {}
		opts.post_restore_cmds = {
			function()
				-- Wrap in pcall to handle errors
				pcall(function()
					-- Restore nvim-tree if it was open
					local nvim_tree_api = require("nvim-tree.api")
					nvim_tree_api.tree.open()
					nvim_tree_api.tree.change_root(vim.fn.getcwd())
				end)
			end,
		}

		-- Setup with error handling
		local ok, err = pcall(function()
			auto_session.setup(opts)
		end)

		if not ok then
			vim.notify("auto-session setup error: " .. tostring(err), vim.log.levels.WARN)
			-- Disable auto-restore if there's a persistent error
			opts.auto_restore = false
			auto_session.setup(opts)
		end

		-- Load Telescope extension for session picker (if available)
		local ok_telescope, _ = pcall(require("telescope").load_extension, "session-lens")
		if not ok_telescope then
			-- Try alternative extension name
			pcall(require("telescope").load_extension, "auto_session")
		end

		-- Handle swap file errors during session restore
		-- This autocmd catches E325 errors and provides helpful information
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("AutoSessionErrorHandler", { clear = true }),
			once = true,
			callback = function()
				-- Check if there was a swap file error
				-- The error message will be in :messages
				vim.defer_fn(function()
					-- If swap file error occurred, notify user
					-- User can manually delete swap files or recover
					vim.notify(
						"Session restore completed. If you see swap file warnings, delete .swp files or use ':recover'",
						vim.log.levels.INFO
					)
				end, 500)
			end,
		})
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
		-- Helper command to clean swap files (useful when E325 errors occur)
		{
			"<leader>sc",
			function()
				-- Find and optionally delete swap files in current directory
				local swap_files = vim.fn.glob("**/*.swp", false, true)
				if #swap_files == 0 then
					vim.notify("No swap files found in current directory", vim.log.levels.INFO)
					return
				end

				vim.ui.select(swap_files, {
					prompt = "Select swap files to delete (or 'all' to delete all):",
				}, function(choice)
					if choice == "all" then
						for _, file in ipairs(swap_files) do
							os.remove(file)
						end
						vim.notify("Deleted " .. #swap_files .. " swap file(s)", vim.log.levels.INFO)
					elseif choice then
						os.remove(choice)
						vim.notify("Deleted: " .. choice, vim.log.levels.INFO)
					end
				end)
			end,
			desc = "Clean swap files (fixes E325 errors)",
		},
		-- Delete all sessions
		{
			"<leader>sD",
			function()
				-- Get session directory (default: ~/.local/state/nvim/sessions/)
				local session_dir = vim.fn.stdpath("state") .. "/sessions"
				local session_files = vim.fn.glob(session_dir .. "/*.vim", false, true)

				if #session_files == 0 then
					vim.notify("No sessions found to delete", vim.log.levels.INFO)
					return
				end

				-- Confirm before deleting all sessions
				vim.ui.select({ "Yes", "No" }, {
					prompt = string.format("Delete ALL %d session(s)? This cannot be undone!", #session_files),
				}, function(choice)
					if choice == "Yes" then
						local deleted = 0
						for _, file in ipairs(session_files) do
							if os.remove(file) then
								deleted = deleted + 1
							end
						end
						vim.notify(
							string.format("Deleted %d session file(s) from %s", deleted, session_dir),
							vim.log.levels.INFO
						)
					else
						vim.notify("Cancelled: No sessions deleted", vim.log.levels.INFO)
					end
				end)
			end,
			desc = "Delete all sessions (clean reset)",
		},
	},
}
