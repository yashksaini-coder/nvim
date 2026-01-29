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
				{ "<leader>a", group = "animations" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code/crates/leetcode" },
				{ "<leader>d", group = "debug" },
				{ "<leader>e", desc = "Toggle Explorer" },
				{ "<leader>f", group = "file/find" },
				{ "<leader>g", group = "git/goto" },
				{ "<leader>h", group = "git hunks" },
				{ "<leader>l", group = "lazy" },
				{ "<leader>m", group = "markdown/minimap" },
				{ "<leader>q", desc = "Quit all" },
				{ "<leader>r", group = "rust (ferris)" },
				{ "<leader>t", group = "terminal/tabs" },
				{ "<leader>tm", group = "tab move" },
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

				-- Animations
				{ "<leader>ar", desc = "Cellular automation: make it rain" },
				{ "<leader>ag", desc = "Cellular automation: game of life" },

				-- Crates.nvim (Rust Cargo.toml)
				{ "<leader>ct", desc = "Toggle crates info" },
				{ "<leader>cr", desc = "Reload crates" },
				{ "<leader>cv", desc = "Show crate versions" },
				{ "<leader>cf", desc = "Show crate features" },
				{ "<leader>cd", desc = "Show crate dependencies" },
				{ "<leader>cu", desc = "Update crate/crates" },
				{ "<leader>cU", desc = "Upgrade crate/crates" },
				{ "<leader>ca", desc = "Update all crates" },
				{ "<leader>cA", desc = "Upgrade all crates" },
				{ "<leader>cx", desc = "Expand crate to inline table" },
				{ "<leader>cX", desc = "Extract crate to table" },
				{ "<leader>cH", desc = "Open crate homepage" },
				{ "<leader>cR", desc = "Open crate repository" },
				{ "<leader>cD", desc = "Open crate documentation" },
				{ "<leader>cC", desc = "Open crate on crates.io" },
				{ "<leader>cL", desc = "Open crate on lib.rs" },

				-- LeetCode (using 'c' prefix as well)
				{ "<leader>c", desc = "LeetCode/Code actions" },
				{ "<leader>cs", desc = "Trouble symbols / LeetCode submit" },
				{ "<leader>cl", desc = "Trouble LSP / LeetCode list" },
				{ "<leader>cR", desc = "LeetCode reset" },

				-- File operations
				{ "<leader>ff", desc = "Find files" },
				{ "<leader>fr", desc = "Recent files" },
				{ "<leader>fR", desc = "Recent files (cwd)" },
				{ "<leader>fg", desc = "Live grep" },
				{ "<leader>fs", desc = "Grep string" },
				{ "<leader>fb", desc = "Find buffers" },
				{ "<leader>fh", desc = "Help tags" },
				{ "<leader>fd", desc = "Diagnostics" },
				{ "<leader>fp", desc = "Projects" },
				{ "<leader>fm", desc = "Format file/range" },

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
				{ "<leader>gd", desc = "Go to definition" },
				{ "<leader>gr", desc = "Go to references" },
				{ "<leader>ca", desc = "Code action" },

				-- Lazy plugin manager
				{ "<leader>ll", desc = "Open Lazy" },
				{ "<leader>ls", desc = "Sync plugins" },
				{ "<leader>lu", desc = "Update plugins" },
				{ "<leader>li", desc = "Install plugins" },
				{ "<leader>lc", desc = "Check plugins" },
				{ "<leader>lx", desc = "Clean plugins" },

				-- Markdown
				{ "<leader>mp", desc = "Toggle markdown preview" },

				-- Image (snacks.nvim)
				{ "<leader>i", group = "image" },
				{ "<leader>is", desc = "Show image at cursor" },

				-- Mason
				{ "<leader>M", desc = "Open Mason" },

				-- Rust / Ferris
				{ "<leader>rm", desc = "Expand macro" },
				{ "<leader>rj", desc = "Join lines" },
				{ "<leader>rh", desc = "View HIR" },
				{ "<leader>rl", desc = "View MIR" },
				{ "<leader>rs", desc = "View memory layout" },
				{ "<leader>rt", desc = "View syntax tree" },
				{ "<leader>ri", desc = "View item tree" },
				{ "<leader>rc", desc = "Open Cargo.toml" },
				{ "<leader>rp", desc = "Open parent module" },
				{ "<leader>rd", desc = "Open documentation" },
				{ "<leader>rw", desc = "Reload workspace" },
				{ "<leader>rb", desc = "Rebuild macros" },

				-- Terminal (LazyVim style)
				{ "<leader>tf", desc = "Terminal (float)" },
				{ "<leader>th", desc = "Terminal (horizontal)" },
				{ "<leader>tv", desc = "Terminal (vertical)" },
				{ "<leader>gg", desc = "LazyGit" },
				{ "<leader>tp", desc = "Python REPL" },
				{ "<leader>tn", desc = "Node REPL" },
				{ "<leader>tm", desc = "System Monitor" },
				{ "<leader>ta", desc = "Toggle all terminals" },
				{ "<leader>ts", desc = "Select terminal / Send to terminal" },
				{ "<leader>t1", desc = "Terminal 1" },
				{ "<leader>t2", desc = "Terminal 2" },
				{ "<leader>t3", desc = "Terminal 3" },
				{ "<leader>t4", desc = "Terminal 4" },

				-- Theme
				{ "<leader>th", desc = "Open Themery" },

				-- Trouble
				{ "<leader>xx", desc = "Diagnostics (Trouble)" },
				{ "<leader>xX", desc = "Buffer diagnostics (Trouble)" },
				{ "<leader>xL", desc = "Location list (Trouble)" },
				{ "<leader>xQ", desc = "Quickfix list (Trouble)" },

				-- Navigation
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "[b", desc = "Prev buffer" },
				{ "]b", desc = "Next buffer" },
				{ "[c", desc = "Prev git hunk" },
				{ "]c", desc = "Next git hunk" },

				-- Goto
				{ "g", group = "goto" },
				{ "gx", desc = "Open with system app" },
				{ "gs", group = "surround" },
				{ "gt", desc = "Next tab" },
				{ "gT", desc = "Previous tab" },

				-- Other
				{ "z", group = "fold" },
				{ "K", desc = "LSP hover" },
				{ "<C-s>", desc = "Save file" },
				{ "<C-p>", desc = "Find files" },
				{ "<C-\\>", desc = "Toggle terminal" },
				{ "<C-h>", desc = "Move to left window" },
				{ "<C-j>", desc = "Move to lower window" },
				{ "<C-k>", desc = "Move to upper window" },
				{ "<C-l>", desc = "Move to right window" },
				{ "<S-h>", desc = "Prev buffer" },
				{ "<S-l>", desc = "Next buffer" },

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
