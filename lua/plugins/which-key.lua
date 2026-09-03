-- which-key helps you remember key bindings by showing a popup
-- with the active keybindings of the command you started typing.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		defaults = {},
		spec = {
			{
				mode = { "n", "x" },
				-- Main groups
				{ "<leader><tab>", group = "tabs" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code/crates" },
				{ "<leader>e", desc = "File Explorer" },
				{ "<leader>o", desc = "Toggle outline" },
				{ "<leader>f", group = "file/find" },
				{ "<leader>g", group = "git/goto" },
				{ "<leader>h", group = "git hunks" },
				{ "<leader>k", group = "man/docs" },
				{ "<leader>l", group = "lazy" },
				{ "<leader>m", group = "markdown/compile" },
				{ "<leader>n", group = "noice" },
				{ "<leader>q", desc = "Quit all" },
				{ "<leader>r", group = "rust" },
				{ "<leader>t", group = "theme" },
				{ "<leader>x", group = "trouble/diagnostics" },

				-- Buffer operations
				{ "<leader>bd", desc = "Delete buffer" },
				{ "<leader>bp", desc = "Toggle pin" },
				{ "<leader>bP", desc = "Delete non-pinned" },
				{ "<leader>bo", desc = "Close other buffers" },
				{ "<leader>br", desc = "Close buffers right" },
				{ "<leader>bl", desc = "Close buffers left" },
				{ "<leader>bm", desc = "Move buffer next" },
				{ "<leader>bM", desc = "Move buffer prev" },

				-- Crates.nvim (Rust Cargo.toml)
				{ "<leader>ct", desc = "Toggle crates info" },
				{ "<leader>cr", desc = "Reload crates" },
				{ "<leader>cv", desc = "Show crate versions" },
				{ "<leader>cf", desc = "Show crate features" },
				{ "<leader>cd", desc = "Show crate dependencies" },
				{ "<leader>cu", desc = "Update crate/crates" },
				{ "<leader>cU", desc = "Upgrade crate/crates" },
				{ "<leader>cpa", desc = "Update all crates" },
				{ "<leader>cA", desc = "Upgrade all crates" },
				{ "<leader>cx", desc = "Expand crate to inline table" },
				{ "<leader>cX", desc = "Extract crate to table" },
				{ "<leader>cH", desc = "Open crate homepage" },
				{ "<leader>cR", desc = "Crates: open repository" },
				{ "<leader>cD", desc = "Open crate documentation" },
				{ "<leader>cC", desc = "Open crate on crates.io" },
				{ "<leader>cL", desc = "Open crate on lib.rs" },

				-- compile-mode (default command is per-filetype)
				{ "<leader>mm", desc = "Compile (prompt)" },
				{ "<leader>mr", desc = "Recompile (last command)" },
				{ "<leader>mh", desc = "Compile history" },
				{ "<leader>mq", desc = "Compile errors to quickfix" },
				{ "<leader>mx", desc = "Run last build (no rebuild)" },

				-- Rust (rustaceanvim; rM/rI are ferris)
				{ "<leader>rr", desc = "Runnables" },
				{ "<leader>rR", desc = "Re-run last runnable" },
				{ "<leader>rE", desc = "Explain error" },
				{ "<leader>rm", desc = "Expand macro" },
				{ "<leader>rj", desc = "Join lines" },
				{ "<leader>rh", desc = "View HIR" },
				{ "<leader>rl", desc = "View MIR" },
				{ "<leader>rt", desc = "View syntax tree" },
				{ "<leader>rc", desc = "Open Cargo.toml" },
				{ "<leader>rp", desc = "Parent module" },
				{ "<leader>rd", desc = "Open documentation" },
				{ "<leader>rw", desc = "Reload workspace" },
				{ "<leader>rb", desc = "Rebuild proc macros" },
				{ "<leader>rM", desc = "View memory layout" },
				{ "<leader>rI", desc = "View item tree" },

				-- File operations
				{ "<leader>ff", desc = "Find files" },
				{ "<leader>fr", desc = "Recent files" },
				{ "<leader>fR", desc = "Recent files (cwd)" },
				{ "<leader>fg", desc = "Live grep" },
				{ "<leader>fs", desc = "Grep string" },
				{ "<leader>fb", desc = "Find buffers" },
				{ "<leader>fh", desc = "Help tags" },
				{ "<leader>fd", desc = "Diagnostics" },
				{ "<leader>fp", desc = "Recent Projects" },
				{ "<leader>fm", desc = "Format file/range" },
				{ "<leader>ft", desc = "Todo comments" },
				{ "<leader>fS", desc = "Search & replace (project-wide)" },

				-- Git hunks (gitsigns)
				{ "<leader>hs", desc = "Stage hunk" },
				{ "<leader>hr", desc = "Reset hunk" },
				{ "<leader>hS", desc = "Stage buffer" },
				{ "<leader>hR", desc = "Reset buffer" },
				{ "<leader>hp", desc = "Preview hunk" },
				{ "<leader>hi", desc = "Preview hunk inline" },
				{ "<leader>hb", desc = "Blame line" },
				{ "<leader>hd", desc = "Diff this" },

				-- LSP / Code actions
				{ "<leader>gg", desc = "Lazygit (snacks)" },
				{ "<leader>gd", desc = "Go to definition" },
				{ "<leader>gr", desc = "Go to references" },
				{ "<leader>ca", desc = "Code action" },

				-- Diffs (diffview) / GitHub (octo)
				{ "<leader>gv", desc = "Diffview: changed files" },
				{ "<leader>gV", desc = "Diffview: close" },
				{ "<leader>gh", desc = "Diffview: repo history" },
				{ "<leader>gf", desc = "Diffview: current file history" },
				{ "<leader>go", desc = "Octo: command palette" },
				{ "<leader>gp", desc = "Octo: pull requests" },
				{ "<leader>gi", desc = "Octo: issues" },

				-- Lazy plugin manager
				{ "<leader>ll", desc = "Open Lazy" },
				{ "<leader>ls", desc = "Sync plugins" },
				{ "<leader>lu", desc = "Update plugins" },
				{ "<leader>li", desc = "Install plugins" },
				{ "<leader>lc", desc = "Check plugins" },
				{ "<leader>lx", desc = "Clean plugins" },

				-- Markdown
				{ "<leader>mp", desc = "Toggle markdown preview" },

				-- Man pages / docs
				{ "<leader>kk", desc = "Open keymap reference site" },
				{ "<leader>km", desc = "Open man page" },
				{ "<leader>kw", desc = "Man page for word under cursor" },

				-- Mason
				{ "<leader>M", desc = "Open Mason" },

				-- Tabs / themes
				{ "<leader>tH", desc = "Themery" },

				-- Trouble
				{ "<leader>xx", desc = "Diagnostics (Trouble)" },
				{ "<leader>xX", desc = "Buffer diagnostics (Trouble)" },
				{ "<leader>xL", desc = "Location list (Trouble)" },
				{ "<leader>xQ", desc = "Quickfix list (Trouble)" },
				{ "<leader>xt", desc = "Todo comments (Trouble)" },
				{ "<leader>xd", desc = "Show line diagnostics" },
				{ "<leader>xv", desc = "Toggle inline virtual diagnostic" },

				-- Noice
				{ "<leader>nh", desc = "Noice history" },
				{ "<leader>nl", desc = "Noice last message" },
				{ "<leader>ne", desc = "Noice errors" },
				{ "<leader>nd", desc = "Dismiss notifications" },
				{ "<leader>np", desc = "Noice picker" },
				{ "<leader>ns", desc = "Noice stats" },

				-- Navigation
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "[b", desc = "Prev buffer" },
				{ "]b", desc = "Next buffer" },
				{ "[c", desc = "Prev git hunk" },
				{ "]c", desc = "Next git hunk" },
				{ "[t", desc = "Prev todo comment" },
				{ "]t", desc = "Next todo comment" },

				-- Goto
				{ "g", group = "goto" },
				{ "gx", desc = "Open with system app" },
				{ "gs", group = "surround" },
				{ "gsa", desc = "Add surrounding" },
				{ "gsd", desc = "Delete surrounding" },
				{ "gsf", desc = "Find right surrounding" },
				{ "gsF", desc = "Find left surrounding" },
				{ "gsh", desc = "Highlight surrounding" },
				{ "gsr", desc = "Replace surrounding" },
				{ "gsn", desc = "Update n_lines" },
				{ "gt", desc = "Next tab" },
				{ "gT", desc = "Previous tab" },

				-- Other
				{ "z", group = "fold" },
				{ "K", desc = "LSP hover" },
				{ "<C-s>", desc = "Save file" },
				{ "<C-p>", desc = "Find files" },
				{ "<C-Up>", desc = "Increase window height" },
				{ "<C-Down>", desc = "Decrease window height" },
				{ "<C-Left>", desc = "Decrease window width" },
				{ "<C-Right>", desc = "Increase window width" },
				{ "<C-h>", desc = "Move to left window" },
				{ "<C-j>", desc = "Move to lower window" },
				{ "<C-k>", desc = "Move to upper window" },
				{ "<C-l>", desc = "Move to right window" },
				{ "<S-h>", desc = "Prev buffer" },
				{ "<S-l>", desc = "Next buffer (barbar)" },
				{ "s", desc = "Flash jump" },
				{ "S", desc = "Flash treesitter" },

				-- Function keys (compile-mode)
				{ "<F5>", desc = "Recompile" },
				{ "<F6>", desc = "Compile (prompt)" },
				{ "<F8>", desc = "Run last build (no rebuild)" },

				-- Windows
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		if not vim.tbl_isempty(opts.defaults) then
			wk.register(opts.defaults)
		end
	end,
}
