return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Image rendering off: no inline images, no LaTeX/math rendering, no
		-- BufReadCmd hook on image files. snacks defaults image.enabled to true
		-- (snacks/image/init.lua), so deleting this block would switch it back ON.
		image = { enabled = false },
		-- Skips syntax, treesitter and LSP on huge files so opening one doesn't hang.
		bigfile = { enabled = true },
		-- Renders the file from the command line before plugins finish loading.
		quickfile = { enabled = true },
		-- picker powers <leader>fp and the explorer below, which is a picker
		-- underneath.
		picker = { enabled = true },
		-- The file tree (<leader>e). replace_netrw stays off so `nvim .` still
		-- lands on snacks.dashboard rather than the explorer hijacking the
		-- directory buffer; config/autocmds.lua opens the side panel after.
		explorer = { enabled = true, replace_netrw = false },
		-- Minimal start screen — just a handful of key hints. No ASCII logo,
		-- no plugin-load banner, no long button list. Replaces dashboard-nvim.
		dashboard = {
			enabled = true,
			width = 55,
			preset = {
				keys = {
					{ icon = "󰉋 ", key = "e", desc = "File Explorer", action = ":lua Snacks.explorer()" },
					{ icon = "󰈞 ", key = "f", desc = "Find Files", action = ":Telescope find_files" },
					{ icon = "󰭎 ", key = "g", desc = "Live Grep", action = ":Telescope live_grep" },
					{ icon = "󱋢 ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
					{ icon = "󰋚 ", key = "p", desc = "Recent Projects", action = ":lua Snacks.picker.projects()" },
					{
						icon = "󰋖 ",
						key = "k",
						desc = "Keymap Docs",
						action = ":lua vim.ui.open('https://yashksaini-coder.github.io/nvim/')",
					},
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = "󰗼 ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "keys", padding = 4, gap = 1 },
				{
					padding = 2,
					text = {
						{ "leader = ", hl = "SnacksDashboardDir" },
						{ "<Space>", hl = "SnacksDashboardKey" },
						{ "  ·  press ", hl = "SnacksDashboardDir" },
						{ "<leader>?", hl = "SnacksDashboardKey" },
						{ " for the full keymap", hl = "SnacksDashboardDir" },
					},
				},
			},
		},
		-- Indent guides (merged from mini-indentscope — was a separate snacks.nvim spec)
		indent = {
			enabled = true,
			char = "│",
			only_scope = false,
			only_current = false,
			hl = "SnacksIndent",
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				style = "out",
				easing = "linear",
				duration = {
					step = 20,
					total = 500,
				},
			},
			scope = {
				enabled = true,
				char = "│",
				underline = false,
				only_current = false,
				hl = "SnacksIndentScope",
			},
			chunk = {
				enabled = false,
			},
			filter = function(buf)
				local exclude_ft = {
					"help",
					"snacks_dashboard",
					"snacks_picker_list",
					"Trouble",
					"lazy",
					"mason",
					"notify",
				}
				local ft = vim.bo[buf].filetype
				for _, exclude in ipairs(exclude_ft) do
					if ft == exclude then
						return false
					end
				end
				return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
			end,
		},
	},
	keys = {
		{
			"<leader>gg",
			function()
				require("snacks").lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>e",
			function()
				-- Calling it while open closes it, so this is a toggle.
				require("snacks").explorer()
			end,
			desc = "File Explorer (snacks)",
		},
		{
			"<leader>fp",
			function()
				require("snacks").picker.projects()
			end,
			desc = "Recent Projects",
		},
		-- Terminal. The built-in `:terminal` version of these keys lived in
		-- config/keymaps/terminal.lua until 21f98e0 reverted it; snacks replaces
		-- the ~57 lines it needed. Its "terminal" style already gives the
		-- double-<Esc> escape that file hand-rolled, plus `q` to hide,
		-- start-in-insert and stacking, so none of that is repeated here.
		--
		-- The counts are load-bearing. snacks keys a terminal instance by
		-- cmd/cwd/env/count (terminal.lua M.tid) and deliberately NOT by window
		-- position, so without two distinct counts both keys resolve to the same
		-- id and the second one just toggles the first one's window instead of
		-- opening a second terminal beside it.
		{
			"<leader>ts",
			function()
				require("snacks").terminal.toggle(nil, { count = 1, win = { position = "bottom" } })
			end,
			desc = "Terminal (bottom split)",
		},
		{
			"<leader>tv",
			function()
				require("snacks").terminal.toggle(nil, { count = 2, win = { position = "right" } })
			end,
			desc = "Terminal (side split)",
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
	end,
}
