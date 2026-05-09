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
				{ "<leader>db", desc = "Toggle breakpoint" },
				{ "<leader>dB", desc = "Conditional breakpoint" },
				{ "<leader>dc", desc = "Continue / Start" },
				{ "<leader>di", desc = "Step into" },
				{ "<leader>do", desc = "Step over" },
				{ "<leader>dO", desc = "Step out" },
				{ "<leader>dr", desc = "Toggle REPL" },
				{ "<leader>dl", desc = "Run last" },
				{ "<leader>du", desc = "Toggle DAP UI" },
				{ "<leader>dt", desc = "Terminate" },
				{ "<leader>dh", desc = "DAP hover variable" },
				{ "<leader>dS", desc = "DAP scopes (float)" },
				{ "<leader>df", desc = "DAP frames (float)" },
				{ "<leader>de", desc = "DAP evaluate expression" },
				{ "<leader>e", desc = "Toggle Explorer" },
				{ "<leader>o", desc = "Toggle outline" },
				{ "<leader>f", group = "file/find" },
				{ "<leader>g", group = "git/goto" },
				{ "<leader>h", group = "git hunks" },
				{ "<leader>k", group = "man/docs" },
				{ "<leader>l", group = "lazy" },
				{ "<leader>m", group = "markdown/make/minimap" },
				{ "<leader>q", desc = "Quit all" },
				{ "<leader>r", group = "rust (ferris)" },
				{ "<leader>s", group = "search/snippets" },
				{ "<leader>t", group = "terminal/tabs" },
				{ "<leader>T", group = "go to tab (T1-T9)" },
				{ "<leader>tm", group = "tab move" },
				{ "<leader>x", group = "trouble/diagnostics" },
				{ "<leader>L", group = "leetcode" },
				{ "<leader>D", group = "docs (online)" },
				{ "<leader>G", group = "go" },
				{ "<leader>Gt", "<cmd>GoTest<cr>", desc = "go: test" },
				{ "<leader>GT", "<cmd>GoTestFunc<cr>", desc = "go: test func" },
				{ "<leader>Gi", "<cmd>GoIfErr<cr>", desc = "go: insert if err" },
				{ "<leader>Gs", "<cmd>GoFillStruct<cr>", desc = "go: fill struct" },
				{ "<leader>GI", "<cmd>GoImpl<cr>", desc = "go: implement interface" },

				-- Buffer operations
				{ "<leader>bd", desc = "Delete buffer" },
				{ "<leader>bp", desc = "Toggle pin" },
				{ "<leader>bP", desc = "Delete non-pinned" },
				{ "<leader>bo", desc = "Close other buffers" },
				{ "<leader>br", desc = "Close buffers right" },
				{ "<leader>bl", desc = "Close buffers left" },
				{ "<leader>bm", desc = "Move buffer next" },
				{ "<leader>bM", desc = "Move buffer prev" },
				{ "<leader>blp", desc = "Boilerplate: C++ (utils)" },
				{ "<leader>blc", desc = "Boilerplate: C (utils)" },

				-- Utils: boilerplates & snippets (separate)
				{ "<leader>got", desc = "Boilerplate: Go (utils)" },
				{ "<leader>rst", desc = "Boilerplate: Rust (utils)" },
				{ "<leader>plc", desc = "Boilerplate: LeetCode C++ (utils)" },
				{ "<leader>cse", desc = "Boilerplate: CSES C++ (utils)" },
				{ "<leader>csh", desc = "Boilerplate: C# (utils)" },
				{ "<leader>pov", desc = "Snippet: print vector (utils)" },
				{ "<leader>mod", desc = "Snippet: mod inverse (utils)" },
				{ "<leader>dio", desc = "Snippet: diophantine (utils)" },
				{ "<leader>sf", desc = "Search: find files (fff)" },
				{ "<leader>sg", desc = "Search: live grep (fff)" },
				{ "<leader>sh", desc = "Search: help (fff)" },
				{ "<leader>sfor", desc = "Snippet: for loop (C/C++/Rust)" },
				{ "<leader>swh", desc = "Snippet: while loop (C/C++/Rust)" },
				{ "<leader>sdo", desc = "Snippet: do-while (C/C++)" },
				{ "<leader>srange", desc = "Snippet: range-for (C++) / for-in (Rust)" },

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
				{ "<leader>cpa", desc = "Update all crates" },
				{ "<leader>cA", desc = "Upgrade all crates" },
				{ "<leader>cx", desc = "Expand crate to inline table" },
				{ "<leader>cX", desc = "Extract crate to table" },
				{ "<leader>cH", desc = "Open crate homepage" },
				{ "<leader>cR", desc = "Crates: open repository" },
				{ "<leader>cD", desc = "Open crate documentation" },
				{ "<leader>cC", desc = "Open crate on crates.io" },
				{ "<leader>cL", desc = "Open crate on lib.rs" },

				-- Native make (C/C++)
				{ "<leader>mb", desc = "Make: build" },
				{ "<leader>mr", desc = "Make: build & run" },
				{ "<leader>mT", desc = "Make: toggle results" },
				{ "<leader>mx", desc = "Make: run" },
				-- LeetCode (L prefix)
				{ "<leader>L", desc = "LeetCode" },
				{ "<leader>Lr", desc = "LeetCode run" },
				{ "<leader>Ls", desc = "LeetCode submit" },
				{ "<leader>Ll", desc = "LeetCode list" },
				{ "<leader>Ld", desc = "LeetCode daily" },
				{ "<leader>LR", desc = "LeetCode reset" },

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
				{ "<leader>r", group = "refactor/rust" },
				{ "<leader>rn", desc = "Rename symbol (LSP)" },
				{ "<leader>u", group = "ui/toggles" },
				{ "<leader>uh", desc = "Toggle inlay hints" },
				{ "<leader>gi", desc = "Goto implementation" },
				{ "<leader>gt", desc = "Goto type definition" },
				{ "<leader>gD", desc = "Goto declaration" },
				{ "<leader>gci", desc = "Incoming calls" },
				{ "<leader>gco", desc = "Outgoing calls" },
				{ "<leader>fS", desc = "Document symbols (LSP)" },
				{ "<leader>fW", desc = "Workspace symbols (LSP)" },
				{ "<leader>cf", desc = "Format buffer (LSP)" },

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
				{ "<leader>is", desc = "Show image at cursor" },

				-- AI assistants (claude/copilot/opencode)
				{ "<leader>p", group = "pomo (timer/clock)" },
				{ "<leader>i", group = "ai (claude/copilot/opencode)" },
				{ "<leader>j", group = "harpoon" },
				{ "<leader>R", group = "Refactor (refactoring.nvim)" },
				{ "<leader>ic", desc = "Claude Code" },
				{ "<leader>iC", desc = "Claude continue" },
				{ "<leader>iR", desc = "Claude resume" },
				{ "<leader>iv", desc = "Claude verbose" },
				{ "<leader>iX", desc = "Copilot Chat" },
				{ "<leader>ie", desc = "Copilot explain" },
				{ "<leader>ir", desc = "Copilot review" },
				{ "<leader>iF", desc = "Copilot fix" },
				{ "<leader>iO", desc = "Copilot optimize" },
				{ "<leader>iD", desc = "Copilot docs" },
				{ "<leader>iT", desc = "Copilot tests" },
				{ "<leader>io", desc = "OpenCode toggle" },
				{ "<leader>ia", desc = "OpenCode ask buffer" },
				{ "<leader>iA", desc = "OpenCode ask selection" },
				{ "<leader>iN", desc = "OpenCode new session" },

				-- Man pages / docs
				{ "<leader>km", desc = "Open man page" },
				{ "<leader>kw", desc = "Man page for word under cursor" },

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
				{ "<leader>tN", desc = "Node REPL" },
				{ "<leader>tn", desc = "New tab" },
				{ "<leader>tm", desc = "System Monitor" },
				{ "<leader>tH", desc = "Themery" },
				{ "<leader>ta", desc = "Toggle all terminals" },
				{ "<leader>ts", desc = "Select terminal / Send to terminal" },
				{ "<leader>t1", desc = "Terminal 1" },
				{ "<leader>t2", desc = "Terminal 2" },
				{ "<leader>t3", desc = "Terminal 3" },
				{ "<leader>t4", desc = "Terminal 4" },

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
				{ "<C-Up>", desc = "Increase window height" },
				{ "<C-Down>", desc = "Decrease window height" },
				{ "<C-Left>", desc = "Decrease window width" },
				{ "<C-Right>", desc = "Increase window width" },
				{ "<C-h>", desc = "Move to left window" },
				{ "<C-j>", desc = "Move to lower window" },
				{ "<C-k>", desc = "Move to upper window" },
				{ "<C-l>", desc = "Move to right window" },
				{ "<S-h>", desc = "Prev buffer" },
				{ "<S-l>", desc = "Next buffer (bufferline)" },

				-- Function Keys (C/C++ Compiler)
				{ "<F5>", desc = "Build C/C++ program" },
				{ "<F6>", desc = "Build & run C/C++ program" },
				{ "<F7>", desc = "Toggle compilation results" },
				{ "<F8>", desc = "Run C/C++ program" },

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
